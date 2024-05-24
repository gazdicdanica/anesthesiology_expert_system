package com.ftn.sbnz.model.events;

import org.kie.api.definition.type.Role;

@Role(Role.Type.EVENT)
public class SymptomEvent {
    private Long patientId;
    private Long procedureId;
    private Symptom symptom;

    public SymptomEvent() {
    }

    public SymptomEvent(Long patientId, Long procedureId, Symptom symptom) {
        this.patientId = patientId;
        this.procedureId = procedureId;
        this.symptom = symptom;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public Long getProcedureId() {
        return procedureId;
    }

    public void setProcedureId(Long procedureId) {
        this.procedureId = procedureId;
    }

    public Symptom getSymptom() {
        return symptom;
    }

    public void setSymptom(Symptom symptom) {
        this.symptom = symptom;
    }

    public enum Symptom{
        Arythima, Bradycardia, Bradypnea, Cyanosis, Dyspnea, Exstrasystole, Hypertension, Hypotension, Hypoxemia, Tachycardia, Tachypnea, Wheezing, Fever, AbsentBreathSounds, PulmonaryEdema, ChestPain
    }
}
