package com.ftn.sbnz.model.procedure;

import java.time.LocalDateTime;

public class PostponedOperation {
    private Long id;
    private Long procedureId;
    private LocalDateTime date;
    private String reason;

    public PostponedOperation() {
    }

    public PostponedOperation(Long id, Long procedureId, LocalDateTime date, String reason) {
        this.id = id;
        this.procedureId = procedureId;
        this.date = date;
        this.reason = reason;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProcedureId() {
        return procedureId;
    }

    public void setProcedureId(Long procedureId) {
        this.procedureId = procedureId;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
