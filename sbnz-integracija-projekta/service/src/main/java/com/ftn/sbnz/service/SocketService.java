package com.ftn.sbnz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.dto.IntraDTO;
import com.ftn.sbnz.dto.StatusDTO;
import com.ftn.sbnz.model.events.SymptomEvent.Symptom;

@Service
public class SocketService {
    @Autowired
    private SimpMessagingTemplate template;


    public void sendBpm(int bpm, Long procedureId) {
        this.template.convertAndSend("/heartbeat/" + procedureId, new IntraDTO(bpm, 0));
    }

    public void sendSap(int sap, Long procedureId) {
        this.template.convertAndSend("/sap/" + procedureId, new IntraDTO(0, sap));
    }

    public void sendCardioAlarm(Long procedureId, Symptom symptom) {
        if(symptom != null) this.template.convertAndSend("/alarm/cardio/" + procedureId, new StatusDTO(symptom));
        else this.template.convertAndSend("/alarm/cardio/" + procedureId, new StatusDTO());
    }

    public void sendSapAlarm(Long procedureId, Symptom symptom) {
        if(symptom != null) this.template.convertAndSend("/alarm/sap/" + procedureId, new StatusDTO(symptom));
        else this.template.convertAndSend("/alarm/sap/" + procedureId, new StatusDTO());
    }

    public void sendExtraAlarm(Long procedureId, Symptom symptom) {
        this.template.convertAndSend("/alarm/extrasystole/" + procedureId, new StatusDTO(symptom));
    }

    public void sendBpmPostOp(int bpm, Long procedureId) {
        this.template.convertAndSend("/heartbeat/post/" + procedureId, new IntraDTO(bpm, 0));
    }

    public void sendSapPostOp(int sap, Long procedureId) {
        this.template.convertAndSend("/sap/post/" + procedureId, new IntraDTO(0, sap));
    }
}
