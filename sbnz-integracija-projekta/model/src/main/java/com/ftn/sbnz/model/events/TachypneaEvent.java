package com.ftn.sbnz.model.events;

import java.io.Serializable;

public class TachypneaEvent implements Serializable{

    private static final long serialVersionUID = 1L;

    private Long patientId;

    public TachypneaEvent() {
        super();
    }

    public TachypneaEvent(Long patientId) {
        super();
        this.patientId = patientId;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }
    
}
