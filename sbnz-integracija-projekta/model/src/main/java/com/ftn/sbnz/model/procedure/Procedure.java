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
