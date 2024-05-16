package com.ftn.sbnz.model.procedure;

import java.time.LocalDateTime;

import javax.persistence.*;

@Entity
@Table(name = "procedures")
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public class Procedure {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long patientId;
    private Long medicalStaffId;

    private LocalDateTime date;
    private OperationRisk risk;
    private ProcedureUrget urget;

    private PreOperative preOperative;
    private IntraOperative intraOperative;
    private PostOperative postOperative;

    public Procedure() {
    }

    public Procedure(Long patientId, Long medicalStaffId, LocalDateTime date, OperationRisk risk, ProcedureUrget urget,
            PreOperative preOperative, IntraOperative intraOperative, PostOperative postOperative) {
        this.patientId = patientId;
        this.medicalStaffId = medicalStaffId;
        this.date = date;
        this.risk = risk;
        this.urget = urget;
        this.preOperative = preOperative;
        this.intraOperative = intraOperative;
        this.postOperative = postOperative;
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

    public Long getMedicalStaffId() {
        return medicalStaffId;
    }

    public void setMedicalStaffId(Long medicalStaffId) {
        this.medicalStaffId = medicalStaffId;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public OperationRisk getRisk() {
        return risk;
    }

    public void setRisk(OperationRisk risk) {
        this.risk = risk;
    }

    public ProcedureUrget getUrget() {
        return urget;
    }

    public void setUrget(ProcedureUrget urget) {
        this.urget = urget;
    }

    public PreOperative getPreOperative() {
        return preOperative;
    }

    public void setPreOperative(PreOperative preOperative) {
        this.preOperative = preOperative;
    }

    public IntraOperative getIntraOperative() {
        return intraOperative;
    }

    public void setIntraOperative(IntraOperative intraOperative) {
        this.intraOperative = intraOperative;
    }

    public PostOperative getPostOperative() {
        return postOperative;
    }

    public void setPostOperative(PostOperative postOperative) {
        this.postOperative = postOperative;
    }

    public enum OperationRisk {
        LOW,
        MEDIUM,
        HIGH
    }

    public enum ProcedureUrget {
        IMMEDIATE,
        URGENT,
        TIME_SENSITIVE,
        ELECTIVE,
    }
}
