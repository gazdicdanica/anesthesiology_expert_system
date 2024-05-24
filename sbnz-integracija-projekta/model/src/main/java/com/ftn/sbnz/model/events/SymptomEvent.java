package com.ftn.sbnz.model.events;

import org.kie.api.definition.type.Expires;
import org.kie.api.definition.type.Role;

@Role(Role.Type.EVENT)
@Expires("60m")
public class SymptomEvent {
    private Long patientId;
    private Symptom symptom;

    public SymptomEvent() {
    }

    public SymptomEvent(Long patientId, Symptom symptom) {
        this.patientId = patientId;
        this.symptom = symptom;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public Symptom getSymptom() {
        return symptom;
    }

    public void setSymptom(Symptom symptom) {
        this.symptom = symptom;
    }

    public enum Symptom{
        Bradycardia, Bradypnea, Cyanosis, Dyspnea, Exstrasystole, Hypertension, Hypotension, Hypoxemia, Tachycardia, Tachypnea
    }
}
