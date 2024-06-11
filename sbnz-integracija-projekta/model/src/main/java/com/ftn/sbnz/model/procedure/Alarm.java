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

    // public Alarm(Long patientId, Long doctorId, Symptom message, long timestamp) {
    //     this.patientId = patientId;
    //     this.doctorId = doctorId;
    //     this.symptom = message;
    //     this.timestamp = timestamp;
    // }

    public Alarm(Long id, Long patientId, Long doctorId, Symptom message, long timestamp) {
        this.id = id;
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

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        result = prime * result + ((patientId == null) ? 0 : patientId.hashCode());
        result = prime * result + ((doctorId == null) ? 0 : doctorId.hashCode());
        result = prime * result + ((symptom == null) ? 0 : symptom.hashCode());
        result = prime * result + (int) (timestamp ^ (timestamp >>> 32));
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Alarm other = (Alarm) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        if (patientId == null) {
            if (other.patientId != null)
                return false;
        } else if (!patientId.equals(other.patientId))
            return false;
        if (doctorId == null) {
            if (other.doctorId != null)
                return false;
        } else if (!doctorId.equals(other.doctorId))
            return false;
        if (symptom != other.symptom)
            return false;
        if (timestamp != other.timestamp)
            return false;
        return true;
    }


    
}
