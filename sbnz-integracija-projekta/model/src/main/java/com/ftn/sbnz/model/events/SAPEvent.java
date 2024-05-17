package com.ftn.sbnz.model.events;

import java.io.Serializable;

import org.kie.api.definition.type.Expires;
import org.kie.api.definition.type.Role;

@Role(Role.Type.EVENT)
@Expires("10m")
public class SAPEvent implements Serializable{

    private static final long serialVersionUID = 1L;
    private Long patientId;
    private int value;

    public SAPEvent() {
        super();
    }

    public SAPEvent(Long patientId, int value) {
        super();
        this.patientId = patientId;
        this.value = value;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }
    
    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
