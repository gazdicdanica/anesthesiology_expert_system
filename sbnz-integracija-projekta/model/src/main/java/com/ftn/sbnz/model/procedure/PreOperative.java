package com.ftn.sbnz.model.procedure;

import javax.persistence.*;

@Entity
@Table(name = "pre_operative_procedures")
public class PreOperative {
    private boolean shouldContinueProcedure;

    private double SIB;
    private double HBA1C;
    private double kreatinin;

    public PreOperative() {
    }

    public PreOperative(boolean shouldContinueProcedure, double SIB, double HBA1C, double kreatinin) {
        this.shouldContinueProcedure = shouldContinueProcedure;
        this.SIB = SIB;
        this.HBA1C = HBA1C;
        this.kreatinin = kreatinin;
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

    public double getKreatinin() {
        return kreatinin;
    }

    public void setKreatinin(double kreatinin) {
        this.kreatinin = kreatinin;
    }
}
