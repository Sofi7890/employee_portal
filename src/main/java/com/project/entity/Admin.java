package com.project.entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "admins")
public class Admin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long adminId;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String role;

    /*
     * Account status
     * ACTIVE / INACTIVE
     */
    @Column(nullable = false)
    private String status = "ACTIVE";

    /*
     * Date on which admin account was created
     */
    @Column(nullable = false)
    private LocalDate createdDate;

    /*
     * Last successful login time
     */
    private LocalDateTime lastLogin;

    public Admin() {
    }

    @PrePersist
    protected void onCreate() {

        if (createdDate == null) {
            createdDate = LocalDate.now();
        }

        if (status == null || status.trim().isEmpty()) {
            status = "ACTIVE";
        }

        if (role == null || role.trim().isEmpty()) {
            role = "ROLE_ADMIN";
        }
    }

    public Long getAdminId() {
        return adminId;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDate createdDate) {
        this.createdDate = createdDate;
    }

    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }
}