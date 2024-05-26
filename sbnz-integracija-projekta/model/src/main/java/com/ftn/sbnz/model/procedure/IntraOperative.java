package com.ftn.sbnz.model.procedure;

import javax.persistence.*;

@Entity
@Table(name = "intra_operative_procedures")
public class IntraOperative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    public IntraOperative() {
    }
}
