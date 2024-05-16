package com.ftn.sbnz.model.patient;

import javax.persistence.*;

@Entity
@Table(name = "Patients")
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String fullname;
    private int age;
    private double weight;
    private double height;

    private int basalSAP;

    private int RCRIScore;
    private PatientRisk risk;
    private boolean hasDiabetes;
    private boolean isDMControlled;
    private boolean hadHearthAttack;
    private boolean hasHearthFailure;
    private boolean hasHypertension;
    private boolean controlledHypertension;
    private boolean hadStroke;
    private boolean hasRenalFailure;

    private boolean addictions;
    private boolean smokerOrAlcoholic;

    private boolean pregnant;

    private ASA asa;

    public enum ASA {
        I, II, III, IV, V
    }

    public enum PatientRisk {
        LOW, MEDIUM, HIGH
    }

    public Patient() {
    }

    public Patient(Long id, String fullname, int age, double weight, double height, double BMI, int basalSAP,
            double SIB, double HBA1C, double kreatinin, boolean hasDiabetes, boolean isDMControlled,
            boolean hadHearthAttack, boolean hasHearhFailure, boolean hasHyperTension, boolean controlledHyperTension,
            boolean hadStroke, boolean hasRenalFailure, boolean addictions, boolean smokerOrAlcoholic,
            boolean pregnant) {
        this.id = id;
        this.fullname = fullname;
        this.age = age;
        this.weight = weight;
        this.height = height;
        this.basalSAP = basalSAP;
        this.hasDiabetes = hasDiabetes;
        this.isDMControlled = isDMControlled;
        this.hadHearthAttack = hadHearthAttack;
        this.hasHearthFailure = hasHearhFailure;
        this.hasHypertension = hasHyperTension;
        this.controlledHypertension = controlledHyperTension;
        this.hadStroke = hadStroke;
        this.hasRenalFailure = hasRenalFailure;
        this.addictions = addictions;
        this.smokerOrAlcoholic = smokerOrAlcoholic;
        this.pregnant = pregnant;

    }

    public int getRCRIScore() {
        return RCRIScore;
    }

    public void setRCRIScore(int RCRIScore) {
        this.RCRIScore = RCRIScore;
    }

    public PatientRisk getRisk() {
        return risk;
    }

    public void setRisk(PatientRisk risk) {
        this.risk = risk;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public int getBasalSAP() {
        return basalSAP;
    }

    public void setBasalSAP(int basalSAP) {
        this.basalSAP = basalSAP;
    }

    public boolean isHasDiabetes() {
        return hasDiabetes;
    }

    public void setHasDiabetes(boolean hasDiabetes) {
        this.hasDiabetes = hasDiabetes;
    }

    public boolean isDMControlled() {
        return isDMControlled;
    }

    public void setDMControlled(boolean DMControlled) {
        isDMControlled = DMControlled;
    }

    public boolean isHadHearthAttack() {
        return hadHearthAttack;
    }

    public void setHadHearthAttack(boolean hadHearthAttack) {
        this.hadHearthAttack = hadHearthAttack;
    }

    public boolean isHasHearthFailure() {
        return hasHearthFailure;
    }

    public void setHasHearthFailure(boolean hasHearhFailure) {
        this.hasHearthFailure = hasHearhFailure;
    }

    public boolean isHasHypertension() {
        return hasHypertension;
    }

    public void setHasHypertension(boolean hasHyperTension) {
        this.hasHypertension = hasHyperTension;
    }

    public boolean isControlledHypertension() {
        return controlledHypertension;
    }

    public void setControlledHypertension(boolean controlledHyperTension) {
        this.controlledHypertension = controlledHyperTension;
    }

    public boolean isHadStroke() {
        return hadStroke;
    }

    public void setHadStroke(boolean hadStroke) {
        this.hadStroke = hadStroke;
    }

    public boolean isHasRenalFailure() {
        return hasRenalFailure;
    }

    public void setHasRenalFailure(boolean hasRenalFailure) {
        this.hasRenalFailure = hasRenalFailure;
    }

    public boolean isAddictions() {
        return addictions;
    }

    public void setAddictions(boolean addictions) {
        this.addictions = addictions;
    }

    public boolean isSmokerOrAlcoholic() {
        return smokerOrAlcoholic;
    }

    public void setSmokerOrAlcoholic(boolean smokerOrAlcoholic) {
        this.smokerOrAlcoholic = smokerOrAlcoholic;
    }

    public boolean isPregnant() {
        return pregnant;
    }

    public void setPregnant(boolean pregnant) {
        this.pregnant = pregnant;
    }

    public ASA getAsa() {
        return asa;
    }

    public void setAsa(ASA asa) {
        this.asa = asa;
    }
}
