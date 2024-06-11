package com.ftn.sbnz.dto;

public class IntraOperativeDataDTO {
    private Long patientId;
    private Long procedureId;
    private int sap;
    private boolean exstrasystole;

    public IntraOperativeDataDTO() {
    }

    public IntraOperativeDataDTO(Long patientId, Long procedureId, int sap, boolean exstrasystole) {
        this.patientId = patientId;
        this.procedureId = procedureId;
        this.sap = sap;
        this.exstrasystole = exstrasystole;
    }

    public Long getPatientId() {
        return patientId;
    }

    public void setPatientId(Long patientId) {
        this.patientId = patientId;
    }

    public Long getProcedureId() {
        return procedureId;
    }

    public void setProcedureId(Long procedureId) {
        this.procedureId = procedureId;
    }

    public int getSap() {
        return sap;
    }

    public void setSap(int sap) {
        this.sap = sap;
    }

    public boolean isExstrasystole() {
        return exstrasystole;
    }

    public void setExstrasystole(boolean exstrasystole) {
        this.exstrasystole = exstrasystole;
    }

}
