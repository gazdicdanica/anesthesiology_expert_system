package com.ftn.sbnz.model.procedure;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

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

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<Alarm> alarms = new HashSet<>();

    public IntraOperative() {
    }

    public IntraOperative(Monitoring monitoring, int bpm, int sap, Set<Alarm> alarms) {
        this.monitoring = monitoring;
        this.bpm = bpm;
        this.sap = sap;
        this.extrasystoleCounter = 0;
        this.alarms = alarms;
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
        this.sap = (int) sap;
    }

    public int getExtrasystoleCounter() {
        return extrasystoleCounter;
    }

    public void setExtrasystoleCounter(int extrasystoleCounter) {
        this.extrasystoleCounter = extrasystoleCounter;
    }

    public Set<Alarm> getAlarms() {
        return alarms;
    }

    public void setAlarms(Set<Alarm> alarms) {
        this.alarms = alarms;
    }

    public void addAlarm(Alarm alarm) {

        if (!this.alarms.stream()
                .anyMatch(a -> a.getTimestamp() == alarm.getTimestamp())) {
            this.alarms.add(alarm);
        }
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
                ", alarms=" + alarms +
                '}';
    }
}
