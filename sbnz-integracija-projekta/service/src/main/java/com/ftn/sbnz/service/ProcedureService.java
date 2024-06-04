package com.ftn.sbnz.service;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.rule.FactHandle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.dto.BaseRulesDTO;
import com.ftn.sbnz.dto.PreoperativeDTO;
import com.ftn.sbnz.exception.EntityNotFoundException;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.IntraOperative;
import com.ftn.sbnz.model.procedure.PreOperative;
import com.ftn.sbnz.model.procedure.Procedure;
import com.ftn.sbnz.model.user.User;
import com.ftn.sbnz.repository.ProcedureRepository;
import com.ftn.sbnz.service.iservice.IKieService;
import com.ftn.sbnz.service.iservice.IPatientService;
import com.ftn.sbnz.service.iservice.IProcedureService;
import com.ftn.sbnz.service.iservice.IUserService;

@Service
public class ProcedureService implements IProcedureService {

        @Autowired
        private ProcedureRepository procedureRepository;

        @Autowired
        private IUserService userService;

        @Autowired
        private IPatientService patientService;

        @Autowired
        private IKieService kieService;

        @Override
        public Procedure addProcedure(AddProcedureDTO addProcedureDTO, Principal u) {
                User user = userService.findByUsername(u.getName())
                                .orElseThrow(() -> new EntityNotFoundException("Not authenticated"));
                Procedure procedure = new Procedure();
                procedure.setPatientId(addProcedureDTO.getPatientId());
                procedure.setName(addProcedureDTO.getName());
                procedure.setMedicalStaffId(user.getId());
                procedure.setRisk(addProcedureDTO.getRisk());
                procedure.setUrgency(addProcedureDTO.getUrgency());
                procedure.setPreOperative(new PreOperative());

                return procedureRepository.save(procedure);
        }

        @Override
        public List<Procedure> getCurrentProcedures(Principal u) {
                User doctor = userService.findByUsername(u.getName())
                                .orElseThrow(() -> new EntityNotFoundException("Not authenticated"));
                List<Procedure> allProcedures = procedureRepository.findByMedicalStaffId(doctor.getId());
                return allProcedures.stream()
                                .filter(p -> (p.getPreOperative().isShouldContinueProcedure() || (!p.getPreOperative().isShouldContinueProcedure() && p.getPreOperative().isDoBnp()))
                                                && !(p.getPostOperative() != null && p.getPostOperative().isReleased()))
                                .collect(Collectors.toList());
        }

        @Override
        public Patient getPatientByProcedure(Long id) {
                Procedure procedure = procedureRepository.findById(id)
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));
                return patientService.findById(procedure.getPatientId());
        }

        @Override
        public BaseRulesDTO updatePreoperative(Long id, PreoperativeDTO preoperativeDTO) {
                Procedure procedure = fetchAndUpdateProcedure(id, preoperativeDTO);
                Patient patient = fetchAndUpdatePatient(procedure.getPatientId(), preoperativeDTO);

                KieSession kieSession = kieService.createKieSession("baseKsession");

                kieSession = kieService.insertKieSession(patient, procedure, procedure.getPreOperative(), kieSession);
                FactHandle handle = kieSession.getFactHandle(procedure);
                FactHandle preOpHandle = kieSession.getFactHandle(procedure.getPreOperative());

                kieService.fireAgendaGroupRules(kieSession, "RCRI");

                KieSession templateSession = kieService.createKieSessionFromTemplate(patient, procedure,
                                procedure.getPreOperative(), "/templatetable/RiskAssesment.drt", 7, 6,
                                "/templatetable/patient_risk_cutoff.xlsx");
                templateSession = kieService.insertKieSession(patient, procedure, procedure.getPreOperative(),
                                templateSession);
                kieService.fireAllRules(templateSession);

                patient = patientService.save(patient);
                procedure = procedureRepository.save(procedure);

                BaseRulesDTO dto = new BaseRulesDTO(patient, procedure);

                if(!procedure.getPreOperative().isShouldContinueProcedure()){
                        kieSession.delete(handle);
                        kieSession.delete(preOpHandle);
                }

                kieSession.dispose();
                templateSession.dispose();

                return dto;
        }

        private Procedure fetchAndUpdateProcedure(Long id, PreoperativeDTO preoperativeDTO) {
                Procedure procedure = procedureRepository.findById(id)
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));
                PreOperative preOperative = procedure.getPreOperative();
                preOperative.setSIB(preoperativeDTO.getSIB());
                preOperative.setHBA1C(preoperativeDTO.getHBA1C());
                preOperative.setCreatinine(preoperativeDTO.getCreatinine());
                procedure.setPreOperative(preOperative);
                return procedure;
        }

        private Patient fetchAndUpdatePatient(Long patientId, PreoperativeDTO preoperativeDTO) {
                Patient patient = patientService.findById(patientId);
                patient.setBasalSAP(preoperativeDTO.getSAP());
                return patient;
        }

        @Override
        public BaseRulesDTO updateBnp(Long id, double bnpValue) {
                Procedure procedure = procedureRepository.findById(id)
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));
                PreOperative preOperative = procedure.getPreOperative();
                preOperative.setBnpValue(bnpValue);
                preOperative.setDoBnp(false);
                procedure.setPreOperative(preOperative);

                Patient patient = patientService.findById(procedure.getPatientId());


                KieSession templateSession = kieService.createKieSessionFromTemplate(patient, procedure,
                                procedure.getPreOperative(), "/templatetable/B_TypeNatriuretic.drt", 9, 10,
                                "/templatetable/b_natriuretic_results.XLSX");
                templateSession = kieService.insertKieSession(patient, procedure, procedure.getPreOperative(),
                                templateSession);
                kieService.fireAllRules(templateSession);

                patient = patientService.save(patient);
                procedure = procedureRepository.save(procedure);

                BaseRulesDTO dto = new BaseRulesDTO(patient, procedure);

                templateSession.dispose();

                return dto;
        }

        @Override
        public Procedure startOperation(Long id) {
                Procedure procedure = procedureRepository.findById(id)
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));
                PreOperative preOperative = procedure.getPreOperative();
                Patient patient = patientService.findById(procedure.getPatientId());

                procedure.setIntraOperative(new IntraOperative());
                procedure = procedureRepository.save(procedure);

                KieSession kieSession = kieService.createKieSession("monitoringKsession");
                kieSession = kieService.insertKieSession(patient, procedure, preOperative, kieSession);
                kieSession.insert(procedure.getIntraOperative());

                kieService.fireAgendaGroupRules(kieSession, "monitoring");
                kieService.fireAllRules(kieSession);

                kieSession.dispose();

                return procedureRepository.save(procedure);

        }

}
