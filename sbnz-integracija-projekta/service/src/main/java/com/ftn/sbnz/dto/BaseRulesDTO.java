package com.ftn.sbnz.dto;

import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.Procedure;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BaseRulesDTO {
    private Patient patient;
    private Procedure procedure;
}
