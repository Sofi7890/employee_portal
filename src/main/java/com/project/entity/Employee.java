package com.project.entity;

import javax.persistence.*;
import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "employees")
public class Employee {

    @Id
    @Column(name = "employee_id", length = 8)  // Format: JTC-001
    private String employeeId;

    @Column(name = "employee_name", nullable = false)
    private String employeeName;

    @Column(name = "employee_dept")
    private String employeeDept;

    @Column(name = "employee_email", unique = true, nullable = false)
    private String employeeEmail;

    @Column(name = "employee_phone")
    private String employeePhone;

    @Column(nullable = false)
    private String password;

    @Column(name = "date_of_joining", nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd") // Fix for JSP date input
    private LocalDate dateOfJoining;

    @Column(nullable = false)
    private String role;

    // Employee has one project at a time
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "project_id") // match Project length
    private Project project;

        @Column private Boolean active = true;
    @Column(name="employment_status") private String employmentStatus = "ACTIVE";
    @Column(name="image_path")
    private String imagePath;

    public boolean isActive(){ return Boolean.TRUE.equals(active); }
    public void setActive(boolean active){ this.active=active; }
    public String getEmploymentStatus(){ return employmentStatus; }
    public String getImagePath(){ return imagePath; }
    public void setImagePath(String imagePath){ this.imagePath=imagePath; }
    public void setEmploymentStatus(String employmentStatus){ this.employmentStatus=employmentStatus; }

public Employee() {
    }

    // ------------------ Getters & Setters ------------------

    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getEmployeeDept() {
        return employeeDept;
    }

    public void setEmployeeDept(String employeeDept) {
        this.employeeDept = employeeDept;
    }

    public String getEmployeeEmail() {
        return employeeEmail;
    }

    public void setEmployeeEmail(String employeeEmail) {
        this.employeeEmail = employeeEmail;
    }

    public String getEmployeePhone() {
        return employeePhone;
    }

    public void setEmployeePhone(String employeePhone) {
        this.employeePhone = employeePhone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDate getDateOfJoining() {
        return dateOfJoining;
    }

    public void setDateOfJoining(LocalDate dateOfJoining) {
        this.dateOfJoining = dateOfJoining;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }
}
