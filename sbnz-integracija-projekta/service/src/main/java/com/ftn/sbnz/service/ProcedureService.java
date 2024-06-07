package com.ftn.sbnz.service;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.rule.FactHandle;
import org.kie.api.runtime.rule.QueryResults;
import org.kie.api.runtime.rule.QueryResultsRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.dto.BaseRulesDTO;
import com.ftn.sbnz.dto.IntraOperativeDataDTO;
import com.ftn.sbnz.dto.PreoperativeDTO;
import com.ftn.sbnz.dto.IntraDTO;
import com.ftn.sbnz.exception.EntityNotFoundException;
import com.ftn.sbnz.model.events.ExtrasystoleEvent;
import com.ftn.sbnz.model.events.HeartBeatEvent;
import com.ftn.sbnz.model.events.SAPEvent;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.IntraOperative;
import com.ftn.sbnz.model.procedure.PostOperative;
import com.ftn.sbnz.model.procedure.Alarm;
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

        @Autowired
        public SimpMessagingTemplate simpMessagingTemplate;

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

        @Override
        public Procedure endOperation(Long id) {
                Procedure procedure = procedureRepository.findById(id)
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));
                procedure.setPostOperative(new PostOperative());

                return procedureRepository.save(procedure);
        }

        public List<Alarm> updateIntraOperativeData(Long patientId, IntraOperativeDataDTO intraOperativeData, int eventType) {
                if (eventType == 1) {
                        return updateIntraOperativeBPMData(patientId, intraOperativeData);
                } else if (eventType == 2) {
                        return updateIntraOperativeSAPData(patientId, intraOperativeData);
                } else if (eventType == 3) {
                        return updateIntraOperativeExtrasystoleData(patientId, intraOperativeData);
                } else {
                        throw new EntityNotFoundException("Invalid event type");
                }
        }

        private List<Alarm> updateIntraOperativeBPMData(Long patientId, IntraOperativeDataDTO intraOperativeData) {
                Patient patient = patientService.findById(patientId);
                Procedure procedure = procedureRepository.findById(intraOperativeData.getProcedureId())
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));

                boolean alreadyContains = kieService.alreadyContainsKieSession(intraOperativeData.getProcedureId());
                KieSession kieSession = kieService.getOrCreateKieSession(intraOperativeData.getProcedureId(), "cepKsession");
                if (!alreadyContains) {
                        kieSession.insert(patient);
                        kieSession.insert(procedure);
                        kieSession.insert(procedure.getIntraOperative());
                }


                HeartBeatEvent event = new HeartBeatEvent(patientId);
                kieSession.insert(event);
                kieSession.fireAllRules();

                simpMessagingTemplate.convertAndSend("/heartbeat/" + procedure.getId(), new IntraDTO(procedure.getIntraOperative().getBpm(), 0));

                return null;
        }

        private List<Alarm> updateIntraOperativeSAPData(Long patientId, IntraOperativeDataDTO intraOperativeData) {
                Patient patient = patientService.findById(patientId);
                Procedure procedure = procedureRepository.findById(intraOperativeData.getProcedureId())
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));

                boolean alreadyContains = kieService.alreadyContainsKieSession(intraOperativeData.getProcedureId());
                KieSession kieSession = kieService.getOrCreateKieSession(intraOperativeData.getProcedureId(), "cepKsession");
                if (!alreadyContains) {
                        kieSession.insert(patient);
                        kieSession.insert(procedure);
                        kieSession.insert(procedure.getIntraOperative());
                }

                SAPEvent event = new SAPEvent(patientId, intraOperativeData.getSap());
                kieSession.insert(event);
                
                kieSession.fireAllRules();

                simpMessagingTemplate.convertAndSend("/sap/" + procedure.getId(), new IntraDTO(0, procedure.getIntraOperative().getSap()));
                return null;
        }
        
        private List<Alarm> updateIntraOperativeExtrasystoleData(Long patientId, IntraOperativeDataDTO intraOperativeData) {
                Patient patient = patientService.findById(patientId);
                Procedure procedure = procedureRepository.findById(intraOperativeData.getProcedureId())
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));

                boolean alreadyContains = kieService.alreadyContainsKieSession(intraOperativeData.getProcedureId());
                KieSession kieSession = kieService.getOrCreateKieSession(intraOperativeData.getProcedureId(), "cepKsession");
                if (!alreadyContains) {
                        kieSession.insert(patient);
                        kieSession.insert(procedure);
                        kieSession.insert(procedure.getIntraOperative());
                }

                if (intraOperativeData.isExstrasystole()) {
                        System.out.println("Extrasystole detected");
                        ExtrasystoleEvent event = new ExtrasystoleEvent(patientId);
                        kieSession.insert(event);
                }
                
                kieSession.fireAllRules();
                return null;               
        }

        private List<Alarm> getAlarmData(KieSession kieSession) {
                List<Alarm> alarms = new ArrayList<>();
                QueryResults results = kieSession.getQueryResults("getAlarms");
                if (results.size() > 0) {
                        
                        for (QueryResultsRow row : results) {
                                System.out.println(row);
                                Alarm alarm = (Alarm) row.get("Alarm");
                                alarms.add(alarm);
                        }
                        return alarms;
                        
                } else {
                        return null;
                } 
        }

        @Override
        public void disposeIntraOperativeKieSession(Long procedureId) {
                kieService.disposeKieSession(procedureId);
        }


        @Scheduled(fixedRate = 5000)
        public void sendHeartBeat() {
                int bpm = (int) ((Math.random() * (80 - 60)) + 60);
                IntraDTO dto = new IntraDTO(bpm, 0);
                simpMessagingTemplate.convertAndSend("/heartbeat/1", dto);
        }
        
        
        @Scheduled(fixedRate = 7000)
        public void sendSAP() {
                int sap  = (int) ((Math.random() * (130 - 80)) + 80);
                IntraDTO dto = new IntraDTO(0, sap);
                simpMessagingTemplate.convertAndSend("/sap/1", dto);
        }
}
