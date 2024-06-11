package com.ftn.sbnz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PreoperativeDTO {
    private double SIB;
    private double HBA1C;
    private double creatinine;
    private int SAP;
}
