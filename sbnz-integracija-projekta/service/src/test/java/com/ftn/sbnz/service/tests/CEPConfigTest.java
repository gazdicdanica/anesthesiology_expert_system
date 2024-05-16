package com.ftn.sbnz.service.tests;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.PreOperative;
import com.ftn.sbnz.model.procedure.Procedure;

public class CEPConfigTest {

    @Test
    public void test() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setHasDiabetes(true);

        Procedure procedure = new Procedure();
        procedure.setPatientId(1L);
        PreOperative preOperative = new PreOperative();
        preOperative.setSIB(10);
        procedure.setPreOperative(preOperative);

        ksession.insert(patient);
        ksession.insert(procedure);

        int rules = ksession.fireAllRules();
        System.out.println("Rules fired: " + rules);

        assertFalse(patient.isDMControlled());

        System.out.println(patient.isDMControlled());
    }
}
