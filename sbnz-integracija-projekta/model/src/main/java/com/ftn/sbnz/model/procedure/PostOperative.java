package com.ftn.sbnz.model.procedure;

import javax.persistence.*;

@Entity
@Table(name = "post_operative_procedures")
public class PostOperative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int hemoglobin;


    public PostOperative() {
    }

    public PostOperative(int hemoglobinValue) {
        this.hemoglobin = hemoglobinValue;
    }

    public int getHemoglobin() {
        return hemoglobin;
    }

    public void setHemoglobin(int hemoglobinValue) {
        this.hemoglobin = hemoglobinValue;
    }
}
