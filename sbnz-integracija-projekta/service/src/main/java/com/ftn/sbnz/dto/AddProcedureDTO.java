package com.ftn.sbnz.dto;

import com.ftn.sbnz.model.procedure.Procedure.OperationRisk;
import com.ftn.sbnz.model.procedure.Procedure.ProcedureUrgency;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddProcedureDTO {
    private Long patientId;
    private String name;
    private OperationRisk risk;
    private ProcedureUrgency urgency;
}
