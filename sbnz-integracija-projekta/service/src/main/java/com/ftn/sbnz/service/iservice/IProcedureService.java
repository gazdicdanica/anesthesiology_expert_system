package com.ftn.sbnz.service.iservice;

import java.security.Principal;
import java.util.List;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.dto.BaseRulesDTO;
import com.ftn.sbnz.dto.PreoperativeDTO;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.Procedure;

public interface IProcedureService {

    Procedure addProcedure(AddProcedureDTO addProcedureDTO, Principal u);

    List<Procedure> getCurrentProcedures(Principal u);

    Patient getPatientByProcedure(Long id);

    BaseRulesDTO updatePreoperative(Long id, PreoperativeDTO preoperativeDTO);

    BaseRulesDTO updateBnp(Long id, double bnpValue);

}
