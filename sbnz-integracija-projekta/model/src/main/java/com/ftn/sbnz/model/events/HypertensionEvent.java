package com.ftn.sbnz.model.events;

import java.io.Serializable;

import org.kie.api.definition.type.Expires;
import org.kie.api.definition.type.Role;

@Role(Role.Type.EVENT)
@Expires("1d")
public class HypertensionEvent implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long patientId;

    public HypertensionEvent() {
        super();
    }

    public HypertensionEvent(Long patientId) {
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
