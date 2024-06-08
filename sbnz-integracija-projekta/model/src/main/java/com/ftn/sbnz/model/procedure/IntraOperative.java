package com.ftn.sbnz.model.procedure;

import java.util.Set;

import javax.persistence.*;

import com.ftn.sbnz.model.events.SymptomEvent.Symptom;

@Entity
@Table(name = "intra_operative_procedures")
public class IntraOperative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Monitoring monitoring;

    private int bpm;
    private int sap;
    private int extrasystoleCounter;

    @ElementCollection(targetClass = Symptom.class, fetch = FetchType.EAGER)
    @Enumerated(EnumType.STRING)
    @CollectionTable
    private Set<Symptom> symptoms;

    public IntraOperative() {
    }

    public IntraOperative(Monitoring monitoring, int bpm, int sap, Set<Symptom> symptoms) {
        this.monitoring = monitoring;
        this.bpm = bpm;
        this.sap = sap;
        this.extrasystoleCounter = 0;
        this.symptoms = symptoms;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Monitoring getMonitoring() {
        return monitoring;
    }

    public void setMonitoring(Monitoring monitoring) {
        this.monitoring = monitoring;
    }

    public int getBpm() {
        return bpm;
    }

    public void setBpm(int bpm) {
        this.bpm = bpm;
    }

    public int getSap() {
        return sap;
    }

    public void setSap(double sap) {
        this.sap =(int) sap;
    }

    public int getExtrasystoleCounter() {
        return extrasystoleCounter;
    }

    public void setExtrasystoleCounter(int extrasystoleCounter) {
        this.extrasystoleCounter = extrasystoleCounter;
    }

    public Set<Symptom> getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(Set<Symptom> symptoms) {
        this.symptoms = symptoms;
    }

    public void addSymptom(Symptom symptom) {
        this.symptoms.add(symptom);
    }

    public enum Monitoring {
        INVASIVE, NON_INVASIVE
    }


    @Override
    public String toString() {
        return "IntraOperative{" +
                "id=" + id +
                ", monitoring=" + monitoring +
                ", bpm=" + bpm +
                ", sap=" + sap +
                ", extrasystoleCounter=" + extrasystoleCounter +
                ", symptoms=" + symptoms +
                '}';
    }
}
