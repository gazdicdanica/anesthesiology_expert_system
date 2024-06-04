package com.ftn.sbnz.model.procedure;

import javax.persistence.*;

@Entity
@Table(name = "intra_operative_procedures")
public class IntraOperative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Monitoring monitoring;

    public IntraOperative() {
    }

    public IntraOperative(Monitoring monitoring) {
        this.monitoring = monitoring;
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

    public enum Monitoring {
        INVASIVE, NON_INVASIVE
    }
}
