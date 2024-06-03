package com.ftn.sbnz.service.iservice;

import org.kie.api.runtime.KieSession;

import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.PreOperative;
import com.ftn.sbnz.model.procedure.Procedure;

public interface IKieService {
    KieSession insertKieSession(Patient patient, Procedure procedure, PreOperative preOperative,
            KieSession kieSession);

    void fireAgendaGroupRules(KieSession kieSession, String agendaGroup);

    KieSession createKieSessionFromTemplate(Patient patient, Procedure procedure,
            PreOperative preOperative, String drtFile, int row, int column, String resourceFile);

    void fireAllRules(KieSession ksession);

    KieSession createKieSessionFromDRL(String drl);

    KieSession createKieSession(String name);
}
