package com.ftn.sbnz.model.procedure;
import javax.persistence.*;

@Entity
@Table(name = "procedures")
public class Procedure {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private Long patientId;
    private Long doctorId;
    private Long nurseId;

    private long start;
    private OperationRisk risk;
    private ProcedureUrgency urgency;

    @OneToOne(cascade = CascadeType.ALL)
    private PreOperative preOperative;
    @OneToOne(cascade = CascadeType.ALL)
    private IntraOperative intraOperative;
    @OneToOne(cascade = CascadeType.ALL)
    private PostOperative postOperative;

    public Procedure() {
    }

    public Procedure(Long patientId, Long medicalStaffId, 
    Long nurseId,
    String name,
    long date,
     OperationRisk risk, ProcedureUrgency urget,
            PreOperative preOperative, IntraOperative intraOperative, PostOperative postOperative) {
        this.patientId = patientId;
        this.doctorId = medicalStaffId;
        this.nurseId = nurseId;
        this.name = name;
        this.start = date;
        this.risk = risk;
        this.urgency = urget;
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

    public Long getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(Long medicalStaffId) {
        this.doctorId = medicalStaffId;
    }

    public Long getNurseId() {
        return nurseId;
    }

    public void setNurseId(Long nurseId) {
        this.nurseId = nurseId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getStart() {
        return start;
    }

    public void setStart(long date) {
        this.start = date;
    }

    public OperationRisk getRisk() {
        return risk;
    }

    public void setRisk(OperationRisk risk) {
        this.risk = risk;
    }

    public ProcedureUrgency getUrgency() {
        return urgency;
    }

    public void setUrgency(ProcedureUrgency urget) {
        this.urgency = urget;
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

    public enum ProcedureUrgency {
        IMMEDIATE,
        URGENT,
        TIME_SENSITIVE,
        ELECTIVE,
    }

    @Override
    public String toString() {
        return "Procedure [id=" + id + ", medicalStaffId=" + doctorId + ", nurseId=" + nurseId + ", name=" + name + ", patientId="
                + patientId + ", postOperative=" + postOperative + ", preOperative=" + preOperative + ", intraoperative=" + intraOperative + ", risk=" + risk
                + ", urgency=" + urgency + "]";
    }
}
