package com.ftn.sbnz.model.procedure;

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
@Table(name = "post_operative_procedures")
public class PostOperative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private boolean isReleased = false;
    private double pulseOximetry;

    
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<Alarm> alarms = new java.util.HashSet<>();

    public PostOperative() {
        this.isReleased = false;
    }

    public PostOperative(boolean isReleased, double pulseOximetry) {
        this.isReleased = isReleased;
        this.pulseOximetry = pulseOximetry;
    }

    public boolean isReleased() {
        return isReleased;
    }

    public void setReleased(boolean released) {
        isReleased = released;
    }

    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }

    public double getPulseOximetry() {
        return pulseOximetry;
    }

    public void setPulseOximetry(double pulseOximetry) {
        this.pulseOximetry = pulseOximetry;
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

    @Override
    public String toString() {
        return "PostOperative{" +
                "id=" + id +
                ", isReleased=" + isReleased +
                ", alarms=" + alarms +
                '}';
    }
}
