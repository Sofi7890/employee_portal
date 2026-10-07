package com.project.entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Set;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "projects")
public class Project {

    @Id
    @Column(name = "project_id", length = 20)  // Format: project-001
    private String projectId;

    @Column(name = "project_name", nullable = false)
    private String projectName;

    @Column(name = "project_start_date", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")  // Fix for Spring date binding
    private LocalDate projectStartDate;

    @Column(name = "project_end_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")  // Fix for Spring date binding
    private LocalDate projectEndDate;

    // Client is an object (many projects can belong to one client)
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "client_id")
    private Client client;

    // Employees assigned to this project
    // Since each employee has only one project, this is OneToMany
    @OneToMany(mappedBy = "project", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Set<Employee> employees;

        @Column private Boolean active = true;
    public boolean isActive(){ return Boolean.TRUE.equals(active); }
    public void setActive(boolean active){ this.active=active; }

public Project() {}

    // ------------------ Getters & Setters ------------------

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public LocalDate getProjectStartDate() {
        return projectStartDate;
    }

    public void setProjectStartDate(LocalDate projectStartDate) {
        this.projectStartDate = projectStartDate;
    }

    public LocalDate getProjectEndDate() {
        return projectEndDate;
    }

    public void setProjectEndDate(LocalDate projectEndDate) {
        this.projectEndDate = projectEndDate;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public Set<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(Set<Employee> employees) {
        this.employees = employees;
    }
}
