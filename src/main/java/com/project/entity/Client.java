package com.project.entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Set;
import org.springframework.format.annotation.DateTimeFormat; // ✅ Add this

@Entity
@Table(name = "clients")
public class Client {

    @Id
    @Column(name = "client_id", length = 10)  // Format: client-001
    private String clientId;

    @Column(name = "client_name", nullable = false)
    private String clientName;

    @Column(name = "client_relationship_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd") // ✅ Tell Spring how to parse date from form
    private LocalDate clientRelationshipDate;

    @Column(nullable = false)
    private String password;  

    @Column(nullable = false)
    private String role; 
//change lazy to eager to view contact
    @OneToMany(mappedBy = "client", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
    private Set<ContactPerson> contactPersons;

    @OneToMany(mappedBy = "client", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Project> projects;

        @Column private Boolean active = true;
    public boolean isActive(){ return Boolean.TRUE.equals(active); }
    public void setActive(boolean active){ this.active=active; }

public Client() {}

    // Getters and setters
    public String getClientId() { return clientId; }
    public void setClientId(String clientId) { this.clientId = clientId; }

    public String getClientName() { return clientName; }
    public void setClientName(String clientName) { this.clientName = clientName; }

    public LocalDate getClientRelationshipDate() { return clientRelationshipDate; }
    public void setClientRelationshipDate(LocalDate clientRelationshipDate) { this.clientRelationshipDate = clientRelationshipDate; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Set<ContactPerson> getContactPersons() { return contactPersons; }
    public void setContactPersons(Set<ContactPerson> contactPersons) { this.contactPersons = contactPersons; }

    public Set<Project> getProjects() { return projects; }
    public void setProjects(Set<Project> projects) { this.projects = projects; }
}
