package com.project.dto;

import java.time.LocalDate;

public class ProjectUpdateResult {
    private String projectId;
    private LocalDate oldEndDate;
    private LocalDate newEndDate;
    private boolean extended;

    public ProjectUpdateResult(String projectId, LocalDate oldEndDate, LocalDate newEndDate, boolean extended) {
        this.projectId = projectId;
        this.oldEndDate = oldEndDate;
        this.newEndDate = newEndDate;
        this.extended = extended;
    }

  
    public String getProjectId() { return projectId; }
    public void setProjectId(String projectId) { this.projectId = projectId; }

    public LocalDate getOldEndDate() { return oldEndDate; }
    public void setOldEndDate(LocalDate oldEndDate) { this.oldEndDate = oldEndDate; }

    public LocalDate getNewEndDate() { return newEndDate; }
    public void setNewEndDate(LocalDate newEndDate) { this.newEndDate = newEndDate; }

    public boolean isExtended() { return extended; }
    public void setExtended(boolean extended) { this.extended = extended; }
}
