package com.ftn.sbnz.model.events;

import org.kie.api.definition.type.Expires;
import org.kie.api.definition.type.Role;

import java.io.Serializable;

@Role(Role.Type.EVENT)
@Expires("1d")
public class PulseOximetryEvent implements Serializable {
    private static final long serialVersionUID = 1L;
    private int value;
    private Long patientId;

    public PulseOximetryEvent() {
    }

    public PulseOximetryEvent(Long patientId, int value) {
        this.value = value;
        this.patientId = patientId;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }
}
