package com.ftn.sbnz.model.procedure;

import javax.persistence.*;

@Entity
@Table(name = "post_operative_procedures")
public class PostOperative {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int hemoglobin;
    private boolean isReleased;


    public PostOperative() {
    }

    public PostOperative(int hemoglobinValue, boolean isReleased) {
        this.hemoglobin = hemoglobinValue;
        this.isReleased = isReleased;
    }

    public int getHemoglobin() {
        return hemoglobin;
    }

    public void setHemoglobin(int hemoglobinValue) {
        this.hemoglobin = hemoglobinValue;
    }

    public boolean isReleased() {
        return isReleased;
    }

    public void setReleased(boolean released) {
        isReleased = released;
    }

    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "PostOperative{" +
                "id=" + id +
                ", hemoglobin=" + hemoglobin +
                ", isReleased=" + isReleased +
                '}';
    }
}
