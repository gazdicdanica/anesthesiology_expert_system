package com.ftn.sbnz.service.iservice;

import java.security.Principal;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.model.procedure.Procedure;

public interface IProcedureService {

    Procedure addProcedure(AddProcedureDTO addProcedureDTO, Principal u);
    
} 
