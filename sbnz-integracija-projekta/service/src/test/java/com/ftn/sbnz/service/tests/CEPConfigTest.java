package com.ftn.sbnz.service.tests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.rule.QueryResults;
import org.kie.api.runtime.rule.QueryResultsRow;

import com.ftn.sbnz.model.events.CyanosisEvent;
import com.ftn.sbnz.model.events.PulseOximetryEvent;
import com.ftn.sbnz.model.events.SAPEvent;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.PreOperative;
import com.ftn.sbnz.model.procedure.Procedure;

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

    @Test
    public void TestPostOpSap1() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(100);
        patient.setDMControlled(false);

        SAPEvent ev1 = new SAPEvent(1L, 75);
        SAPEvent ev2 = new SAPEvent(1L, 76);
        SAPEvent ev3 = new SAPEvent(1L, 72);
        SAPEvent ev4 = new SAPEvent(1L, 74);

        ksession.insert(patient);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        ksession.fireAllRules();
        assertTrue(patient.isDMControlled());
    }

    @Test
    public void TestPostOpSap2() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(140);

        SAPEvent ev1 = new SAPEvent(1L, 75);
        SAPEvent ev2 = new SAPEvent(1L, 76);
        SAPEvent ev3 = new SAPEvent(1L, 72);
        SAPEvent ev4 = new SAPEvent(1L, 74);

        ksession.insert(patient);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
    }

    @Test
    public void TestPostOpSap3() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(140);

        SAPEvent ev1 = new SAPEvent(1L, 165);
        SAPEvent ev2 = new SAPEvent(1L, 164);
        SAPEvent ev3 = new SAPEvent(1L, 162);
        SAPEvent ev4 = new SAPEvent(1L, 164);

        ksession.insert(patient);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
    }

    @Test
    public void TestPostOpSap4() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(100);

        SAPEvent ev1 = new SAPEvent(1L, 175);
        SAPEvent ev2 = new SAPEvent(1L, 176);
        SAPEvent ev3 = new SAPEvent(1L, 172);
        SAPEvent ev4 = new SAPEvent(1L, 174);

        ksession.insert(patient);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
    }

    @Test
    public void TestPulseOxi1() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("baseKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(100);

        PulseOximetryEvent ev1 = new PulseOximetryEvent(1L, 75);
        PulseOximetryEvent ev2 = new PulseOximetryEvent(1L, 76);
        PulseOximetryEvent ev3 = new PulseOximetryEvent(1L, 72);
        PulseOximetryEvent ev4 = new PulseOximetryEvent(1L, 74);

        ksession.insert(patient);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
    }

    @Test
    public void TestPulseOxi2() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("cepKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(100);

        PulseOximetryEvent ev1 = new PulseOximetryEvent(1L, 65);
        PulseOximetryEvent ev2 = new PulseOximetryEvent(1L, 68);
        PulseOximetryEvent ev3 = new PulseOximetryEvent(1L, 62);
        PulseOximetryEvent ev4 = new PulseOximetryEvent(1L, 64);

        ksession.insert(patient);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);

    }
}
