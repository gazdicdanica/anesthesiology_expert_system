package com.ftn.sbnz.model.procedure;

import javax.persistence.*;

@Entity
@Table(name = "pre_operative_procedures")
public class PreOperative {
    private boolean shouldContinueProcedure;

    private double BMI;

    private double SIB;
    private double HBA1C;
    private double kreatinin;
}
