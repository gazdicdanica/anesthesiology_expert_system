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

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<Alarm> alarms = new HashSet<>();

    public IntraOperative() {
    }

    public IntraOperative(Monitoring monitoring, Set<Alarm> alarms) {
        this.monitoring = monitoring;
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
                ", alarms=" + alarms +
                '}';
    }
}
