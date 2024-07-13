package com.ftn.sbnz.service.tests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.drools.core.time.SessionPseudoClock;
import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import com.ftn.sbnz.model.events.BreathEvent;
import com.ftn.sbnz.model.events.PulseOximetryEvent;
import com.ftn.sbnz.model.events.SAPEvent;
import com.ftn.sbnz.model.events.SymptomEvent;
import com.ftn.sbnz.model.illness.Illness.IllnessName;
import com.ftn.sbnz.model.illness.PatientHistory;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.patient.Patient.PatientRisk;
import com.ftn.sbnz.model.procedure.IntraOperative;
import com.ftn.sbnz.model.procedure.PreOperative;
import com.ftn.sbnz.model.procedure.Procedure;
import com.ftn.sbnz.model.procedure.Procedure.OperationRisk;

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
        ksession.dispose();

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
        ksession.dispose();

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
        ksession.dispose();

    }

    @Test
    public void TestAsa3Echocardiography() {
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

        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(2L);
        procedure.setUrgency(Procedure.ProcedureUrgency.ELECTIVE);
        procedure.setRisk(Procedure.OperationRisk.HIGH);
        PreOperative preOperative = new PreOperative();
        preOperative.setShouldContinueProcedure(true);
        procedure.setPreOperative(preOperative);

        ksession.insert(patient);
        ksession.insert(procedure);
        ksession.insert(preOperative);

        int rules = ksession.fireAllRules();
        System.out.println("Rules fired: " + rules);

        assertEquals(patient.getAsa(), Patient.ASA.III);
        ksession.dispose();

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
        ksession.dispose();

    }

    @Test
    public void MonitoringRule() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("monitoringKsession");
        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setRisk(PatientRisk.LOW);

        PreOperative preOperative = new PreOperative();
        preOperative.setShouldContinueProcedure(true);
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPreOperative(preOperative);
        procedure.setPatientId(1L);
        procedure.setRisk(OperationRisk.LOW);
        IntraOperative intraOperative = new IntraOperative();
        procedure.setIntraOperative(intraOperative);

        ksession.insert(patient);
        ksession.insert(procedure);
        ksession.insert(preOperative);
        ksession.insert(intraOperative);

        ksession.getAgenda().getAgendaGroup("monitoring").setFocus();

        int rules = ksession.fireAllRules();
        System.out.println("Rules fired: " + rules);
        assertEquals(procedure.getIntraOperative().getMonitoring(), IntraOperative.Monitoring.NON_INVASIVE);
        ;

    }

    @Test
    public void TestPostOpSap1() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("cepKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(100);
        patient.setDMControlled(false);
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(2L);

        SAPEvent ev1 = new SAPEvent(1L, 65);
        SAPEvent ev2 = new SAPEvent(1L, 66);
        SAPEvent ev3 = new SAPEvent(1L, 62);
        SAPEvent ev4 = new SAPEvent(1L, 64);

        ksession.insert(patient);
        ksession.insert(procedure);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int rulesFired = ksession.fireAllRules();
        System.err.println("Rules triggered " + rulesFired);
        ksession.dispose();

    }

    @Test
    public void TestPostOpSap2() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("cepKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(140);
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(2L);

        SAPEvent ev1 = new SAPEvent(1L, 75);
        SAPEvent ev2 = new SAPEvent(1L, 76);
        SAPEvent ev3 = new SAPEvent(1L, 72);
        SAPEvent ev4 = new SAPEvent(1L, 74);

        ksession.insert(patient);
        ksession.insert(procedure);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
        ksession.dispose();

    }

    @Test
    public void TestPostOpSap3() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("cepKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(140);
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(2L);

        SAPEvent ev1 = new SAPEvent(1L, 165);
        SAPEvent ev2 = new SAPEvent(1L, 164);
        SAPEvent ev3 = new SAPEvent(1L, 162);
        SAPEvent ev4 = new SAPEvent(1L, 164);

        ksession.insert(patient);
        ksession.insert(procedure);
        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
        ksession.dispose();

    }

    @Test
    public void TestPostOpSap4() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("cepKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(100);
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(2L);

        SAPEvent ev1 = new SAPEvent(1L, 175);
        SAPEvent ev2 = new SAPEvent(1L, 176);
        SAPEvent ev3 = new SAPEvent(1L, 172);
        SAPEvent ev4 = new SAPEvent(1L, 174);

        ksession.insert(patient);
        ksession.insert(procedure);

        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
        ksession.dispose();

    }

    @Test
    public void TestPulseOxi1() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("cepKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(100);
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(2L);

        PulseOximetryEvent ev1 = new PulseOximetryEvent(1L, 75);
        PulseOximetryEvent ev2 = new PulseOximetryEvent(1L, 76);
        PulseOximetryEvent ev3 = new PulseOximetryEvent(1L, 72);
        PulseOximetryEvent ev4 = new PulseOximetryEvent(1L, 74);

        ksession.insert(patient);
        ksession.insert(procedure);

        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
        ksession.dispose();

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
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(2L);

        PulseOximetryEvent ev1 = new PulseOximetryEvent(1L, 65);
        PulseOximetryEvent ev2 = new PulseOximetryEvent(1L, 68);
        PulseOximetryEvent ev3 = new PulseOximetryEvent(1L, 62);
        PulseOximetryEvent ev4 = new PulseOximetryEvent(1L, 64);

        ksession.insert(patient);
        ksession.insert(procedure);

        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
        ksession.dispose();

    }

    @Test
    public void TestBradypneaEvent() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession ksession = kContainer.newKieSession("cepKsession");

        assertNotNull(ksession);

        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("Danica Gazdic");
        patient.setBasalSAP(100);
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(2L);

        BreathEvent ev1 = new BreathEvent(1L);
        BreathEvent ev2 = new BreathEvent(1L);
        BreathEvent ev3 = new BreathEvent(1L);
        BreathEvent ev4 = new BreathEvent(1L);
        BreathEvent ev5 = new BreathEvent(1L);

        ksession.insert(patient);
        ksession.insert(procedure);

        ksession.insert(ev1);
        ksession.insert(ev2);
        ksession.insert(ev3);
        ksession.insert(ev4);
        ksession.insert(ev5);

        int temp = ksession.fireAllRules();
        System.err.println("Rules triggered " + temp);
        ksession.dispose();

    }

    @Test
    public void testVasopressorsInfusion() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession kSession = kContainer.newKieSession("cepKsession");
        SessionPseudoClock clock = kSession.getSessionClock();
        assertNotNull(kSession);

        // Create and set up patient
        Patient patient = new Patient();
        patient.setId(1L);
        patient.setFullname("John Doe");
        patient.setBasalSAP(120);

        // Create and set up procedure
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);
        procedure.setDoctorId(101L);

        // Insert initial facts into the session
        kSession.insert(patient);
        kSession.insert(procedure);

        SAPEvent ev1 = new SAPEvent(1L, 60);
        SAPEvent ev2 = new SAPEvent(1L, 62);
        SAPEvent ev3 = new SAPEvent(1L, 61);
        SAPEvent ev4 = new SAPEvent(1L, 59);

        kSession.insert(ev1);
        kSession.insert(ev2);
        kSession.insert(ev3);
        kSession.insert(ev4);

        kSession.fireAllRules();

        clock.advanceTime(16, TimeUnit.MINUTES);
        SAPEvent ev5 = new SAPEvent(1L, 59);

        kSession.insert(ev5);

        int rules = kSession.fireAllRules();

        // Fire the rules

        System.out.println("Rules fired: " + rules);
        // Clean up the session
        kSession.dispose();
    }

    @Test
    public void testBackward() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession kSession = kContainer.newKieSession("bwKsession");
        assertNotNull(kSession);

        Patient patient = new Patient();
        patient.setId(1L);
        kSession.insert(patient);
        List<PatientHistory> patientHistories = new ArrayList<>();
        patientHistories.add(new PatientHistory(1L, 2L, 3L, false));
        patientHistories.add(new PatientHistory(2L, 4L, 5L, true)); // Mother with heart problems
        patientHistories.add(new PatientHistory(3L, 6L, 7L, false));
        patientHistories.add(new PatientHistory(4L, 8L, 9L, true)); // Grandmother with heart problems
        patientHistories.add(new PatientHistory(5L, 10L, 11L, false));

        for (PatientHistory ph : patientHistories) {
            kSession.insert(ph);
        }

        kSession.insert("1");
        kSession.fireAllRules();

        kSession.dispose();
        assertTrue(patient.isHasCVSFamilyHistory());
    }

    @Test
    public void testDiagnosis() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession kSession = kContainer.newKieSession("diagnosisKsession");
        assertNotNull(kSession);

        Patient patient = new Patient();
        patient.setId(1L);
        Procedure procedure = new Procedure();
        procedure.setId(1L);
        procedure.setPatientId(1L);

        SymptomEvent ev1 = new SymptomEvent(1L, 1L, SymptomEvent.Symptom.Dyspnea);
        SymptomEvent ev2 = new SymptomEvent(1L, 1L, SymptomEvent.Symptom.Tachypnea);
        SymptomEvent ev3 = new SymptomEvent(1L, 1L, SymptomEvent.Symptom.Wheezing);

        kSession.insert(patient);
        kSession.insert(procedure);
        kSession.insert(ev1);
        kSession.insert(ev2);
        kSession.insert(ev3);
        // kSession.insert(ev4);
        // kSession.insert(ev5);
        // kSession.insert(ev6);

        int rules = kSession.fireAllRules();
        System.out.println("Rules fired: " + rules);
        assertEquals(IllnessName.BRONCHOSPASM, patient.getIllnesses().get(0).getName());
        kSession.dispose();
    }

}
