package com.ftn.sbnz.dto;

public class PostOperativeDataDTO {
    private Long patientId;
    private Long procedureId;
    private int sap;
    private int pulseOximetry;
    private boolean breathEvent;
    private boolean heartBeatEvent;

    public PostOperativeDataDTO() {
    }

    public PostOperativeDataDTO(Long patientId, Long procedureId, int sap, int pulseOximetry, boolean breathEvent, boolean heartBeatEvent) {
        this.patientId = patientId;
        this.procedureId = procedureId;
        this.sap = sap;
        this.pulseOximetry = pulseOximetry;
        this.breathEvent = breathEvent;
        this.heartBeatEvent = heartBeatEvent;
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

    public int getPulseOximetry() {
        return pulseOximetry;
    }

    public void setPulseOximetry(int pulseOximetry) {
        this.pulseOximetry = pulseOximetry;
    }

    public boolean isBreathEvent() {
        return breathEvent;
    }

    public void setBreathEvent(boolean breathEvent) {
        this.breathEvent = breathEvent;
    }

    public boolean isHeartBeatEvent() {
        return heartBeatEvent;
    }

    public void setHeartBeatEvent(boolean heartBeatEvent) {
        this.heartBeatEvent = heartBeatEvent;
    }

    @Override
    public String toString() {
        return "PostOperativeDataDTO{" +
                "patientId=" + patientId +
                ", procedureId=" + procedureId +
                ", sap=" + sap +
                ", pulseOximetry=" + pulseOximetry +
                ", breathEvent=" + breathEvent +
                ", heartBeatEvent=" + heartBeatEvent +
                '}';
    }
}
