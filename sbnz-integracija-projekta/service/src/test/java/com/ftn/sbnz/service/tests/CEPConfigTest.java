package com.ftn.sbnz.service.tests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import com.ftn.sbnz.model.patient.Patient;

public class CEPConfigTest {

    @Test
    public void TestAsa1() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setHasDiabetes(false);
        patient.setSmokerOrAlcoholic(false);
        patient.setPregnant(false);
        patient.setAddictions(false);
        patient.setHasRenalFailure(false);
        patient.setHadStroke(false);
        patient.setHasHypertension(false);
        patient.setHasHearthFailure(false);
        patient.setHadHearthAttack(false);

        // Procedure procedure = new Procedure();
        // procedure.setPatientId(1L);
        // PreOperative preOperative = new PreOperative();
        // preOperative.setSIB(10);
        // procedure.setPreOperative(preOperative);

        ksession.insert(patient);
        // ksession.insert(procedure);

        int rules = ksession.fireAllRules();
        System.out.println("Rules fired: " + rules);

        assertEquals(patient.getAsa(), Patient.ASA.I);

    }

    @Test
    public void TestAsa2() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setHasDiabetes(false);
        patient.setSmokerOrAlcoholic(false);
        patient.setPregnant(false);
        patient.setAddictions(false);
        patient.setHasRenalFailure(false);
        patient.setHadStroke(false);
        patient.setHasHypertension(false);
        patient.setHasHearthFailure(false);
        patient.setHadHearthAttack(false);
        patient.setHasHypertension(true);
        patient.setControlledHypertension(true);
        patient.setHasDiabetes(true);
        patient.setDMControlled(true);
        patient.setSmokerOrAlcoholic(true);
        patient.setBMI(35);

        ksession.insert(patient);

        ksession.fireAllRules();

        assertEquals(patient.getAsa(), Patient.ASA.II);

    }

    @Test
    public void TestAsa3() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setHasDiabetes(true);
        patient.setPregnant(false);
        patient.setAddictions(true);
        patient.setHasHypertension(true);
        patient.setHasHypertension(true);
        patient.setControlledHypertension(false);
        patient.setHasDiabetes(true);
        patient.setDMControlled(false);
        patient.setBMI(45);

        ksession.insert(patient);

        ksession.fireAllRules();

        assertEquals(patient.getAsa(), Patient.ASA.III);

    }

    @Test
    public void TestAsa4() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setHasDiabetes(true);
        patient.setSmokerOrAlcoholic(false);
        patient.setPregnant(false);
        patient.setAddictions(true);
        patient.setHasRenalFailure(true);
        patient.setHadStroke(true);
        patient.setHasHypertension(true);
        patient.setHasHearthFailure(true);
        patient.setHadHearthAttack(true);
        patient.setHasHypertension(true);
        patient.setControlledHypertension(false);
        patient.setHasDiabetes(true);
        patient.setDMControlled(false);
        patient.setSmokerOrAlcoholic(true);
        patient.setBMI(45);

        ksession.insert(patient);

        ksession.fireAllRules();

        assertEquals(patient.getAsa(), Patient.ASA.IV);

    }
}
