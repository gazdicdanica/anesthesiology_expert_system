package com.ftn.sbnz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.kie.api.runtime.KieSession;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.dto.AddPatientDTO;
import com.ftn.sbnz.dto.AncestorHeartProblemsDTO;
import com.ftn.sbnz.exception.BadRequestException;
import com.ftn.sbnz.exception.EntityNotFoundException;
import com.ftn.sbnz.model.illness.PatientHistory;
import com.ftn.sbnz.model.patient.Patient;
import com.ftn.sbnz.repository.PatientHistoryRepository;
import com.ftn.sbnz.repository.PatientRepository;
import com.ftn.sbnz.service.iservice.IKieService;
import com.ftn.sbnz.service.iservice.IPatientService;

@Service
public class PatientService implements IPatientService{

    @Autowired private PatientRepository patientRepository;
    @Autowired private PatientHistoryRepository patientHistoryRepository;
    @Autowired private ModelMapper modelMapper;
    @Autowired private IKieService kieService;
    
    private Random random = new Random();

    @Override
    public Patient findByJmbg(String jmbg) {
        Patient patient = patientRepository.findByJmbg(jmbg).orElseThrow(() -> new EntityNotFoundException("Pacijent nije pronadjen"));
        System.out.println(patient);
        return patient;
    }

    public Patient findById(Long id){
        return patientRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Pacijent nije pronadjen"));
    }

    @Override
    public Patient addPatient(AddPatientDTO addPatientDTO) {
        if(patientRepository.findByJmbg(addPatientDTO.getJmbg()).isPresent()){
            throw new BadRequestException("Pacijent sa datim JMBG-om vec postoji");
        }
        Patient patient = modelMapper.map(addPatientDTO, Patient.class);
        patient.calculateBMI();
        patient = patientRepository.save(patient);
        if(patient.getId() == 1) {
            generatePatientHistory(1L, 3);
        }
        return patient;
    }

    @Override
    public Patient updatePatient(AddPatientDTO patient) {
        Patient oldPatient = patientRepository.findByJmbg(patient.getJmbg()).orElseThrow(() -> new EntityNotFoundException("Pacijent nije pronadjen"));
        oldPatient.setAge(patient.getAge());
        oldPatient.setFullname(patient.getFullname());
        oldPatient.setHeight(patient.getHeight());
        oldPatient.setWeight(patient.getWeight());
        oldPatient.calculateBMI();
        oldPatient.setPregnant(patient.isPregnant());
        oldPatient.setHasDiabetes(patient.isHasDiabetes());
        oldPatient.setAddictions(patient.isAddictions());
        oldPatient.setSmokerOrAlcoholic(patient.isSmokerOrAlcoholic());
        oldPatient.setHasHypertension(patient.isHasHypertension());
        oldPatient.setControlledHypertension(patient.isControlledHypertension());
        oldPatient.setHadHearthAttack(patient.isHadHearthAttack());
        oldPatient.setHadStroke(patient.isHadStroke());
        oldPatient.setHasHearthFailure(patient.isHasHearthFailure());
        oldPatient.setHasRenalFailure(patient.isHasRenalFailure());
        return patientRepository.save(oldPatient);
    }

    @Override
    public Patient save(Patient patient) {
        return patientRepository.save(patient);
    }
    
    @Override
    public void generatePatientHistory(Long idPatient, int depth) {
        if (depth < 0) return;

        boolean hasHeartIssues = random.nextBoolean();
        Long motherId = idPatient * 2;
        Long fatherId = idPatient * 2 + 1;

        PatientHistory patientHistory = new PatientHistory();
        patientHistory.setIdPatient(idPatient);
        patientHistory.setMotherId(depth > 0 ? motherId : null);
        patientHistory.setFatherId(depth > 0 ? fatherId : null);
        patientHistory.setHasHeartIssues(hasHeartIssues);

        patientHistoryRepository.save(patientHistory);

        if (depth > 0) {
            generatePatientHistory(motherId, depth - 1);
            generatePatientHistory(fatherId, depth - 1);
        }
    }

    @Override
    public AncestorHeartProblemsDTO ancestorHadhartProbles(Long patientId) {
        KieSession ks = kieService.createKieSession("bwKsession");

        Patient patient = findById(patientId);
        ks.insert(patient);

        List<PatientHistory> ancestorIds = findAncestorIds(patientId);
        for (PatientHistory ph : ancestorIds) {
            ks.insert(ph);
        }

        kieService.fireAllRules(ks);

        AncestorHeartProblemsDTO dto = new AncestorHeartProblemsDTO();
        dto.setAnyoneHadHearthProblems(patient.isHasCVSFamilyHistory());
        return dto;
    }

    public List<PatientHistory> findAncestorIds(Long patientId) {
        List<PatientHistory> patientHistories = new ArrayList<>();
        findAncestors(patientId, patientHistories);
        return patientHistories;
    }

    private void findAncestors(Long patientId, List<PatientHistory> patientHistories) {
        PatientHistory patientHistory = patientHistoryRepository.findByIdPatient(patientId);
        if (patientHistory != null) {
            patientHistories.add(patientHistory);
            Long motherId = patientHistory.getMotherId();
            Long fatherId = patientHistory.getFatherId();
            if (motherId != null) {
                findAncestors(motherId, patientHistories);
            }
            if (fatherId != null) {
                findAncestors(fatherId, patientHistories);
            }
        }
    }
}
