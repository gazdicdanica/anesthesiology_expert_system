package com.ftn.sbnz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddPatientDTO {
    private String jmbg;
    private String fullname;
    private int age;
    private double weight;
    private double height;
    private boolean hasDiabetes;
    private boolean hadHearthAttack;
    private boolean hasHearthFailure;
    private boolean hasHypertension;
    private boolean controlledHypertension;
    private boolean hadStroke;
    private boolean hasRenalFailure;
    private boolean hasCVSFamilyHistory;

    private boolean addictions;
    private boolean smokerOrAlcoholic;

    private boolean pregnant;

    
    
}
