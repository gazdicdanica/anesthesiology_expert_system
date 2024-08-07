package com.ftn.sbnz.service.iservice;

import java.security.Principal;
import java.util.List;

import com.ftn.sbnz.dto.AddProcedureDTO;
import com.ftn.sbnz.dto.AddSymptomsDTO;
import com.ftn.sbnz.dto.BaseRulesDTO;
import com.ftn.sbnz.dto.DiagnosisDTO;
import com.ftn.sbnz.dto.IntraOperativeDataDTO;
import com.ftn.sbnz.dto.PostOperativeDataDTO;
import com.ftn.sbnz.dto.PreoperativeDTO;
import com.ftn.sbnz.dto.StaffDTO;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.model.procedure.Alarm;
import com.ftn.sbnz.model.procedure.Procedure;

public interface IProcedureService {

    Procedure addProcedure(AddProcedureDTO addProcedureDTO, Principal u);

    List<Procedure> getCurrentProcedures(Principal u);

    Patient getPatientByProcedure(Long id);

    BaseRulesDTO updatePreoperative(Long id, PreoperativeDTO preoperativeDTO);

    BaseRulesDTO updateBnp(Long id, double bnpValue);

    List<Alarm> updateIntraOperativeData(Long id, IntraOperativeDataDTO intraOperativeData, int eventType);

    void disposeIntraOperativeKieSession(Long procedureId);
    
    Procedure startOperation(Long id);

    Procedure endOperation(Long id);

    PostOperativeDataDTO updatePostOperativeData(Long patientId, PostOperativeDataDTO postOperativeDataDTO);
    
    Object getDiagnosis(Long patientId, Long procedureId);

    Procedure dischargePatinet(Long id);

    DiagnosisDTO addSymptom(Long procedureId, AddSymptomsDTO symptoms, Principal u);
    List<Alarm> getAllAlarmsForProcedure(Long procedureId);

    StaffDTO getStaff(Long procedureId);
}
