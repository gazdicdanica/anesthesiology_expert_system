package com.ftn.sbnz.model.illness;

import java.time.LocalDateTime;

import javax.persistence.*;


@Entity
@Table(name = "illnesses")
public class Illness {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;

    private LocalDateTime date;

    private IllnessName name;


    public Illness() {
    }

    public Illness(LocalDateTime date, IllnessName name) {
        this.date = date;
        this.name = name;
    }

    public Illness(Long id, LocalDateTime date, IllnessName name) {
        this.id = id;
        this.date = date;
        this.name = name;
    }

    public IllnessName getName() {
        return name;
    }

    public void setName(IllnessName name) {
        this.name = name;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public enum IllnessName {
        BRONCHOSPASM,
        PNEUMONIA,
        TENSION_PNEUMOTHORAX,
        PULMONARY_TROMBOEMBOLISM,
        RESPIRATORY_INSUFICIENCY,
        HEART_FAILURE,
        MYOCARDIAL_INFARCTION
    }
    
}
