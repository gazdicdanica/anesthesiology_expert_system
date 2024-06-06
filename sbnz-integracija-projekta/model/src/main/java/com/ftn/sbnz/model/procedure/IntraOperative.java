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

    public IntraOperative() {
    }

    public IntraOperative(Monitoring monitoring, int bpm) {
        this.monitoring = monitoring;
        this.bpm = bpm;
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

    public enum Monitoring {
        INVASIVE, NON_INVASIVE
    }


    @Override
    public String toString() {
        return "IntraOperative{" +
                "id=" + id +
                ", monitoring=" + monitoring +
                ", bpm=" + bpm +
                '}';
    }
}
