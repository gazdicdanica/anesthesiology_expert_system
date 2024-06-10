package com.ftn.sbnz.dto;

import java.util.Set;

import com.ftn.sbnz.model.events.SymptomEvent.Symptom;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddSymptomsDTO {
    private Set<Symptom> symptoms;
}
