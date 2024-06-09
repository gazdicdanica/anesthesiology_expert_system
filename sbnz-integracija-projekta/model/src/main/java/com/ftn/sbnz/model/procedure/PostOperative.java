package com.ftn.sbnz.model.procedure;

import java.util.List;
import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "post_operative_procedures")
public class PostOperative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int hemoglobin;
    private boolean isReleased;

    
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<Alarm> alarms;

    public PostOperative() {
    }

    public PostOperative(int hemoglobinValue, boolean isReleased) {
        this.hemoglobin = hemoglobinValue;
        this.isReleased = isReleased;
    }

    public int getHemoglobin() {
        return hemoglobin;
    }

    public void setHemoglobin(int hemoglobinValue) {
        this.hemoglobin = hemoglobinValue;
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
                ", hemoglobin=" + hemoglobin +
                ", isReleased=" + isReleased +
                ", alarms=" + alarms +
                '}';
    }
}
