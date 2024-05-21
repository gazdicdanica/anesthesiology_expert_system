package com.ftn.sbnz.model.events;

import java.io.Serializable;

public class CyanosisEvent implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long patientId;

    public CyanosisEvent() {
    }

    public CyanosisEvent(Long patientId) {
        this.patientId = patientId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

}
