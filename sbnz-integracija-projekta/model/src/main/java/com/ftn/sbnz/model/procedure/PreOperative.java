package com.ftn.sbnz.model.procedure;

import javax.persistence.*;

import org.kie.api.definition.type.PropertyReactive;

@Entity
@Table(name = "pre_operative_procedures")
@PropertyReactive
public class PreOperative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private boolean shouldContinueProcedure = true;

    private double SIB;
    private double HBA1C;
    private double creatinine;
    private double bnpValue; // B-type natriuretic peptide

    public PreOperative() {
    }

    public PreOperative(boolean shouldContinueProcedure, double SIB, double HBA1C, double kreatinin) {
        this.shouldContinueProcedure = shouldContinueProcedure;
        this.SIB = SIB;
        this.HBA1C = HBA1C;
        this.creatinine = kreatinin;
    }

    public double getBnpValue() {
        return bnpValue;
    }

    public void setBnpValue(double bnpValue) {
        this.bnpValue = bnpValue;
    }

    public boolean isShouldContinueProcedure() {
        return shouldContinueProcedure;
    }

    public void setShouldContinueProcedure(boolean shouldContinueProcedure) {
        this.shouldContinueProcedure = shouldContinueProcedure;
    }

    public double getSIB() {
        return SIB;
    }

    public void setSIB(double SIB) {
        this.SIB = SIB;
    }

    public double getHBA1C() {
        return HBA1C;
    }

    public void setHBA1C(double HBA1C) {
        this.HBA1C = HBA1C;
    }

    public double getCreatinine() {
        return creatinine;
    }

    public void setCreatinine(double kreatinin) {
        this.creatinine = kreatinin;
    }
}
