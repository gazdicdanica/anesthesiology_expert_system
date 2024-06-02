package com.ftn.sbnz.model.illness;

import java.util.List;

import javax.persistence.*;

import com.ftn.sbnz.model.events.SymptomEvent;

@Entity
@Table(name = "illnesses")
public class Illness {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long id;
    public Long patientId;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    public List<SymptomEvent> symptoms;
    
}
