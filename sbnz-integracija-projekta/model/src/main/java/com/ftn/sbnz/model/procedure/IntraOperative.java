package com.ftn.sbnz.model.procedure;

import javax.persistence.*;

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

    public IntraOperative() {
    }

    public IntraOperative(Monitoring monitoring, int bpm, int sap) {
        this.monitoring = monitoring;
        this.bpm = bpm;
        this.sap = sap;
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
                '}';
    }
}
