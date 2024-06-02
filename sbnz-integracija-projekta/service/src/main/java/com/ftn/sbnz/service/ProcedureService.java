package com.ftn.sbnz.service;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.exception.EntityNotFoundException;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.PreOperative;
import com.ftn.sbnz.model.procedure.Procedure;
import com.ftn.sbnz.model.user.User;
import com.ftn.sbnz.repository.ProcedureRepository;
import com.ftn.sbnz.service.iservice.IPatientService;
import com.ftn.sbnz.service.iservice.IProcedureService;
import com.ftn.sbnz.service.iservice.IUserService;

@Service
public class ProcedureService implements IProcedureService {

        @Autowired
        private ProcedureRepository procedureRepository;

        @Autowired
        private IUserService userService;

        @Autowired
        private IPatientService patientService;

        @Override
        public Procedure addProcedure(AddProcedureDTO addProcedureDTO, Principal u) {
                User user = userService.findByUsername(u.getName())
                                .orElseThrow(() -> new EntityNotFoundException("Not authenticated"));
                Procedure procedure = new Procedure();
                procedure.setPatientId(addProcedureDTO.getPatientId());
                procedure.setName(addProcedureDTO.getName());
                procedure.setMedicalStaffId(user.getId());
                procedure.setRisk(addProcedureDTO.getRisk());
                procedure.setUrgency(addProcedureDTO.getUrgency());
                procedure.setPreOperative(new PreOperative());

                return procedureRepository.save(procedure);
        }

        @Override
        public List<Procedure> getCurrentProcedures(Principal u) {
                User doctor = userService.findByUsername(u.getName())
                                .orElseThrow(() -> new EntityNotFoundException("Not authenticated"));
                List<Procedure> allProcedures = procedureRepository.findByMedicalStaffId(doctor.getId());
                return allProcedures.stream()
                                .filter(p -> p.getPreOperative().isShouldContinueProcedure()
                                                && !(p.getPostOperative() != null && p.getPostOperative().isReleased()))
                                .collect(Collectors.toList());
        }

        @Override
        public Patient getPatientByProcedure(Long id) {
                Procedure procedure = procedureRepository.findById(id)
                                .orElseThrow(() -> new EntityNotFoundException("Procedura nije pronadjena"));
                return patientService.findById(procedure.getPatientId());
        }

}
