package com.ftn.sbnz.model.procedure;

public class Alarm {
    private Long patientId;
    private Long doctorId;
    private String message;

    public Alarm() {
    }

    public Alarm(Long patientId, Long doctorId, String message) {
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.message = message;
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Alarm{" +
                "patientId=" + patientId +
                ", doctorId=" + doctorId +
                ", message='" + message + '\'' +
                '}';
    }

}
