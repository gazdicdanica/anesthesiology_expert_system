package com.ftn.sbnz.dto;

import com.ftn.sbnz.model.events.SymptomEvent.Symptom;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StatusDTO {
    private Symptom symptom;
}
