package com.ftn.sbnz.model.illness;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.kie.api.definition.type.Position;

@Entity
public class PatientHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Position(0)
    private Long idPatient;

    @Position(1)
    private Long motherId;

    @Position(2)
    private Long fatherId;

    @Position(3)
    private boolean hasHeartIssues;

    public PatientHistory() {
    }

    public PatientHistory(Long idPatient, Long motherId, Long fatherId, boolean hasHeartIssues) {
        this.idPatient = idPatient;
        this.motherId = motherId;
        this.fatherId = fatherId;
        this.hasHeartIssues = hasHeartIssues;
    }

    // Getters and setters
    public Long getIdPatient() {
        return idPatient;
    }

    public void setIdPatient(Long id) {
        this.idPatient = id;
    }

    public Long getFatherId() {
        return fatherId;
    }

    public void setFatherId(Long fatherId) {
        this.fatherId = fatherId;
    }

    public Long getMotherId() {
        return motherId;
    }

    public void setMotherId(Long motherId) {
        this.motherId = motherId;
    }

    public boolean isHasHeartIssues() {
        return hasHeartIssues;
    }

    public void setHasHeartIssues(boolean hasHeartIssues) {
        this.hasHeartIssues = hasHeartIssues;
    }
}
