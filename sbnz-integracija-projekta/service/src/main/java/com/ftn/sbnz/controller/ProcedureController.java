package com.ftn.sbnz.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.dto.IntraOperativeDataDTO;
import com.ftn.sbnz.dto.PostOperativeDataDTO;
import com.ftn.sbnz.dto.PreoperativeDTO;
import com.ftn.sbnz.model.procedure.Procedure;
import com.ftn.sbnz.service.iservice.IProcedureService;

@RestController
@RequestMapping(value = "/api/procedure", produces = MediaType.APPLICATION_JSON_VALUE)
public class ProcedureController {

    @Autowired private IProcedureService procedureService;

    @PostMapping
    public ResponseEntity<?> addProcedure(@RequestBody AddProcedureDTO addProcedureDTO, Principal u) {
        return ResponseEntity.ok(procedureService.addProcedure(addProcedureDTO, u));
    }

    @GetMapping(value = "/current")
    public ResponseEntity<?> getCurrentProcedures(Principal u) {
        return ResponseEntity.ok(procedureService.getCurrentProcedures(u));
    }

    @GetMapping(value = "/{id}/patient")
    public ResponseEntity<?> getPatientByProcedure(@PathVariable Long id) {
        return ResponseEntity.ok(procedureService.getPatientByProcedure(id));
    }

    @PutMapping(value = "/{id}/preoperative")
    public ResponseEntity<?> updatePreoperative(@PathVariable Long id, @RequestBody PreoperativeDTO preoperativeDTO) {
        return ResponseEntity.ok(procedureService.updatePreoperative(id, preoperativeDTO));
    }

    @PutMapping(value = "/{id}/bnp")
    public ResponseEntity<?> updateBnp(@PathVariable Long id, @RequestParam(name="bnp") double bnpValue) {
        return ResponseEntity.ok(procedureService.updateBnp(id, bnpValue));
    }

    @PutMapping(value = "/{id}/start-operation")
    public ResponseEntity<Procedure> startOperation(@PathVariable Long id) {
        return new ResponseEntity<Procedure>(procedureService.startOperation(id), HttpStatus.OK);
    }

    @PutMapping(value = "/{id}/end-operation")
    public ResponseEntity<Procedure> endOperation(@PathVariable Long id) {
        return new ResponseEntity<Procedure>(procedureService.endOperation(id), HttpStatus.OK);
    }
    
    @PutMapping(value = "/{patientId}/heartBeat")
    public ResponseEntity<?> updateIntraOperativeBPMData(@PathVariable Long patientId, @RequestBody IntraOperativeDataDTO intraOperativeData) {
        return ResponseEntity.ok(procedureService.updateIntraOperativeData(patientId, intraOperativeData, 1));
    }

    @PutMapping(value = "/{patientId}/sapEvent")
    public ResponseEntity<?> updateIntraOperativeSAPData(@PathVariable Long patientId, @RequestBody IntraOperativeDataDTO intraOperativeData) {
        return ResponseEntity.ok(procedureService.updateIntraOperativeData(patientId, intraOperativeData, 2));
    }

    @PutMapping(value = "/{patientId}/symptomEvent")
    public ResponseEntity<?> updateIntraOperativeSymptomData(@PathVariable Long patientId, @RequestBody IntraOperativeDataDTO intraOperativeData) {
        return ResponseEntity.ok(procedureService.updateIntraOperativeData(patientId, intraOperativeData, 3));
    }

    @PutMapping(value = "/{procedureId}/dispose")
    public ResponseEntity<?> disposeIntraOperativeKieSession(@PathVariable Long procedureId) {
        procedureService.disposeIntraOperativeKieSession(procedureId);
        return ResponseEntity.ok().build();
    }

    @PutMapping(value = "/{patientId}/postOpData")
    public ResponseEntity<PostOperativeDataDTO> updatePostOperativeData(@PathVariable Long patientId, @RequestBody PostOperativeDataDTO postOperativeDataDTO) {
        return ResponseEntity.ok(procedureService.updatePostOperativeData(patientId, postOperativeDataDTO));
    }

    @GetMapping(value = "/{patientId}/{procedureId}/diagnosis")
    public ResponseEntity<?> getDiagnosis(@PathVariable Long patientId, @PathVariable Long procedureId) {
        return ResponseEntity.ok(procedureService.getDiagnosis(patientId, procedureId));
    }

    @PutMapping(value = "/{id}/discharge")
    public ResponseEntity<Procedure> dischargePatient(@PathVariable Long id) {
        return new ResponseEntity<Procedure>(procedureService.dischargePatinet(id), HttpStatus.OK);
    }

}
