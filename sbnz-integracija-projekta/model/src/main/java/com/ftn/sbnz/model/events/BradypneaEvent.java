package com.ftn.sbnz.model.events;

import java.io.Serializable;

public class BradypneaEvent implements Serializable{

    private static final long serialVersionUID = 1L;

    private Long patientId;

    public BradypneaEvent() {
        super();
    }

    public BradypneaEvent(Long patientId) {
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
