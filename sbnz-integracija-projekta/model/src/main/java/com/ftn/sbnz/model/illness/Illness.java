package com.ftn.sbnz.model.illness;

import org.kie.api.definition.type.Position;

public class Illness {
    private Long id;
    @Position(0)
    private String symptom;
    @Position(1)
    private String name;
    @Position(2)
    private String parentSymptom;

    public Illness() {
    }

    public Illness(Long id, String name, String symptom, String parentSymptom) {
        this.id = id;
        this.name = name;
        this.symptom = symptom;
        this.parentSymptom = parentSymptom;
    }

}
