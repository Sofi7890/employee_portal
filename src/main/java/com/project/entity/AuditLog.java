package com.project.entity;
import javax.persistence.*; import java.time.LocalDateTime;
@Entity @Table(name="audit_logs")
public class AuditLog {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 private String actor; private String action; private String entityType; private String entityId;
 @Column(length=1500) private String details; private LocalDateTime createdAt;
 public AuditLog(){} public Long getId(){return id;} public void setId(Long v){id=v;} public String getActor(){return actor;} public void setActor(String v){actor=v;}
 public String getAction(){return action;} public void setAction(String v){action=v;} public String getEntityType(){return entityType;} public void setEntityType(String v){entityType=v;}
 public String getEntityId(){return entityId;} public void setEntityId(String v){entityId=v;} public String getDetails(){return details;} public void setDetails(String v){details=v;}
 public LocalDateTime getCreatedAt(){return createdAt;} public void setCreatedAt(LocalDateTime v){createdAt=v;}
}