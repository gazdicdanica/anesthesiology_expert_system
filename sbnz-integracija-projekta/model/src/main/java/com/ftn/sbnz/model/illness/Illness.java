package com.ftn.sbnz.model.illness;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Illness {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private IllnessName name;
    private Long patientId;
    private Long procedureId;

    public Illness() {
    }

    public Illness(IllnessName name, Long patientId, Long procedureId) {
        this.name = name;
        this.patientId = patientId;
        this.procedureId = procedureId;
    }

    public Long getId(){
        return id;
    }

    public IllnessName getName() {
        return name;
    }

    public void setName(IllnessName name) {
        this.name = name;
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



    public enum IllnessName{
        Bronchospasm, Pneumonia, TensionPneumothorax, PulmonaryTromboembolism, HeartFailure, MyocardialInfarction, RespiratoryInsufficiency
    }
}
