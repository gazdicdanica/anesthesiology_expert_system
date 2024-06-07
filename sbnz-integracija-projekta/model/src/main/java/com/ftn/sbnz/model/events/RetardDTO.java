package com.ftn.sbnz.model.events;

public class RetardDTO {
    public Long procedureId;
    public long unixTime;

    public RetardDTO() {
    }

    public RetardDTO(Long procedureId, long unixTime) {
        this.procedureId = procedureId;
        this.unixTime = unixTime;
    }

    public Long getId() {
        return procedureId;
    }

    public void setId(Long id) {
        this.procedureId = id;
    }

    public long getUnixTime() {
        return unixTime;
    }

    public void setUnixTime(long unixTime) {
        this.unixTime = unixTime;
    }
    
}
