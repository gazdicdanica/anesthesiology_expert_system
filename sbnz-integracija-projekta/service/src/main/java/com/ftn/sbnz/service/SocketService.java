package com.ftn.sbnz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.ftn.sbnz.dto.IntraDTO;

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
}
