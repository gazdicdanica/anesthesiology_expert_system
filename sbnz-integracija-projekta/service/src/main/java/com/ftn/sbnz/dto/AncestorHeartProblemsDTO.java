package com.ftn.sbnz.dto;


public class AncestorHeartProblemsDTO {
    private boolean anyoneHadHearthProblems;

    public AncestorHeartProblemsDTO() {
    }

    public AncestorHeartProblemsDTO(boolean anyoneHadHearthProblems) {
        this.anyoneHadHearthProblems = anyoneHadHearthProblems;
    }

    public boolean isAnyoneHadHearthProblems() {
        return anyoneHadHearthProblems;
    }

    public void setAnyoneHadHearthProblems(boolean anyoneHadHearthProblems) {
        this.anyoneHadHearthProblems = anyoneHadHearthProblems;
    }
}
