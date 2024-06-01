package com.ftn.sbnz.service;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.exception.EntityNotFoundException;
import com.ftn.sbnz.model.procedure.PreOperative;
import com.ftn.sbnz.model.procedure.Procedure;
import com.ftn.sbnz.model.user.User;
import com.ftn.sbnz.repository.ProcedureRepository;
import com.ftn.sbnz.service.iservice.IProcedureService;
import com.ftn.sbnz.service.iservice.IUserService;

@Service
public class ProcedureService implements IProcedureService {

    @Autowired
    private ProcedureRepository procedureRepository;

    @Autowired
    private IUserService userService;

    @Override
    public Procedure addProcedure(AddProcedureDTO addProcedureDTO, Principal u) {
        User user = userService.findByUsername(u.getName()).orElseThrow(()-> new EntityNotFoundException(""));
        Procedure procedure = new Procedure();
        procedure.setPatientId(addProcedureDTO.getPatientId());
        procedure.setMedicalStaffId(user.getId());
        procedure.setRisk(addProcedureDTO.getRisk());
        procedure.setUrgency(addProcedureDTO.getUrgency());
        procedure.setPreOperative(new PreOperative());

        return procedureRepository.save(procedure);
    }
    
}
