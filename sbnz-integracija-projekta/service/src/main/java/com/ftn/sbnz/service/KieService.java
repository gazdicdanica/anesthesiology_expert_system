package com.ftn.sbnz.service;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.drools.decisiontable.ExternalSpreadsheetCompiler;
import org.kie.api.KieServices;
import org.kie.api.builder.Message;
import org.kie.api.builder.Results;
import org.kie.api.io.ResourceType;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.KieSessionConfiguration;
import org.kie.api.runtime.conf.ClockTypeOption;
import org.kie.internal.utils.KieHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.PreOperative;
import com.ftn.sbnz.model.procedure.Procedure;
import com.ftn.sbnz.service.iservice.IKieService;

@Service
public class KieService implements IKieService {

    @Autowired
    private KieContainer kieContainer;

    private final Map<Long, KieSession> sessionMap = new HashMap<>();

    public KieSession insertKieSession(Patient patient, Procedure procedure, PreOperative preOperative,
            KieSession kieSession) {
        kieSession.insert(patient);
        kieSession.insert(procedure);
        kieSession.insert(preOperative);
        return kieSession;
    }

    public void fireAgendaGroupRules(KieSession kieSession, String agendaGroup) {
        kieSession.getAgenda().getAgendaGroup(agendaGroup).setFocus();
        kieSession.fireAllRules();
    }

    public KieSession createKieSessionFromTemplate(Patient patient, Procedure procedure,
            PreOperative preOperative, String drtFile, int row, int column, String resourceFile) {
        InputStream template = ProcedureService.class.getResourceAsStream(drtFile);
        InputStream data = ProcedureService.class
                .getResourceAsStream(resourceFile);

        ExternalSpreadsheetCompiler converter = new ExternalSpreadsheetCompiler();
        String drl = converter.compile(data, template, row, column);
        return createKieSessionFromDRL(drl);
    }

    @Override
    public KieSession getOrCreateKieSession(Long procedureId, String ksessionName) {
        KieSession kieSession = sessionMap.get(procedureId);
        if (kieSession == null) {
            System.err.print("Sesija je null");
            kieSession = createKieSession(ksessionName);
            sessionMap.put(procedureId, kieSession);
        }
        return kieSession;
    }

    public void fireAllRules(KieSession ksession) {
        ksession.fireAllRules();
    }

    public KieSession createKieSessionFromDRL(String drl) {
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

    @Override
    public KieSession createKieSession(String name) {
        KieSessionConfiguration conf = KieServices.Factory.get().newKieSessionConfiguration();
        conf.setOption(ClockTypeOption.get("realtime"));
        return kieContainer.newKieSession(name, conf);
    }

    @Override
    public void disposeKieSession(Long procedureId) {
        KieSession kieSession = sessionMap.get(procedureId);
        if (kieSession != null) {
            kieSession.dispose();
            sessionMap.remove(procedureId);
        }

        System.out.println(sessionMap);
    }

    @Override
    public boolean alreadyContainsKieSession(Long procedureId) {
        return sessionMap.containsKey(procedureId);
    }

}
