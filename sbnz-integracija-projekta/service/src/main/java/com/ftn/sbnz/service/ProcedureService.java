package com.ftn.sbnz.service;

import java.io.InputStream;
import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import org.kie.api.builder.Message;
import org.kie.api.builder.Results;
import org.kie.api.io.ResourceType;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.kie.internal.utils.KieHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.drools.decisiontable.ExternalSpreadsheetCompiler;

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
        private KieContainer kieContainer;

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
                                .filter(p -> p.getPreOperative().isShouldContinueProcedure()
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
                Procedure procedure = procedureRepository.findById(id)
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));
                PreOperative preOperative = procedure.getPreOperative();
                preOperative.setSIB(preoperativeDTO.getSIB());
                preOperative.setHBA1C(preoperativeDTO.getHBA1C());
                preOperative.setCreatinine(preoperativeDTO.getCreatinine());
                Patient patient = patientService.findById(procedure.getPatientId());
                patient.setBasalSAP(preoperativeDTO.getSAP());
                procedure.setPreOperative(preOperative);

                KieSession kieSession = kieContainer.newKieSession("baseKsession");
                kieSession.insert(patient);
                kieSession.insert(procedure);
                kieSession.insert(preOperative);

                kieSession.getAgenda().getAgendaGroup("RCRI").setFocus();
                int agendaGroupRules = kieSession.fireAllRules();
                // int rules = kieSession.fireAllRules();
                // System.out.println("Rules fired: " + (rules + agendaGroupRules));
                // kieSession.dispose();

                System.err.println(patient + "\n" + procedure + "\n" + preOperative);

                InputStream template = ProcedureService.class.getResourceAsStream("/templatetable/RiskAssesment.drt");
                InputStream data = ProcedureService.class
                                .getResourceAsStream("/templatetable/patient_risk_cutoff.xlsx");

                ExternalSpreadsheetCompiler converter = new ExternalSpreadsheetCompiler();
                String drl = converter.compile(data, template, 7, 6);
                KieSession ksession = this.createKieSessionFromDRL(drl);
                
                ksession.insert(patient);
                ksession.insert(procedure);
                ksession.insert(preOperative);
                ksession.fireAllRules();
                ksession.dispose();

                
                kieSession.fireAllRules();

                patient = patientService.save(patient);
                procedure = procedureRepository.save(procedure);

                BaseRulesDTO dto = new BaseRulesDTO(patient, procedure);

                System.out.println(dto);
                kieSession.dispose();
                return dto;
        }

        private KieSession createKieSessionFromDRL(String drl) {
                KieHelper kieHelper = new KieHelper();
                kieHelper.addContent(drl, ResourceType.DRL);

                Results results = kieHelper.verify();

                if (results.hasMessages(Message.Level.WARNING, Message.Level.ERROR)) {
                        List<Message> messages = results.getMessages(Message.Level.WARNING, Message.Level.ERROR);
                        for (Message message : messages) {
                                System.out.println("Error: " + message.getText());
                        }

                        throw new IllegalStateException("Compilation errors were found. Check the logs.");
                }

                return kieHelper.build().newKieSession();
        }

}
