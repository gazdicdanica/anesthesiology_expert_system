package com.ftn.sbnz.model.procedure;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.ftn.sbnz.model.events.SymptomEvent.Symptom;

@Entity
public class Alarm {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long patientId;
    private Long doctorId;
    private Symptom symptom;
    private long timestamp;

    public Alarm() {
    }

    public Alarm(Long patientId, Long doctorId, Symptom message, long timestamp) {
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.symptom = message;
        this.timestamp = timestamp;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public Long getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(Long doctorId) {
        this.doctorId = doctorId;
    }

    public Symptom getSymptom() {
        return symptom;
    }

    public void setSymptom(Symptom message) {
        this.symptom = message;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "Alarm{" +
                "patientId=" + patientId +
                ", doctorId=" + doctorId +
                ", message='" + symptom + '\'' +
                ", timestamp=" + timestamp +
                '}';
    }

}
