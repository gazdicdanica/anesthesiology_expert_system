package com.ftn.sbnz.model.events;

public class DyspneaEvent {

    private Long patientId;

    public DyspneaEvent() {
    }

    public DyspneaEvent(Long patientId) {
        this.patientId = patientId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }
    
}
