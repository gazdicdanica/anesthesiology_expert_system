package com.ftn.sbnz.model.events;

public class ArythmiaEvent {
    private Long patientId;

    public ArythmiaEvent() {
    }

    public ArythmiaEvent(Long patientId) {
        this.patientId = patientId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }
}
