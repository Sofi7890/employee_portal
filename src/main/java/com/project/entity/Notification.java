package com.project.entity;
import javax.persistence.*; import java.time.LocalDateTime;
@Entity @Table(name="notifications")
public class Notification {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 @Column(nullable=false) private String recipient; @Column(nullable=false) private String role; @Column(nullable=false) private String type;
 @Column(length=1000, nullable=false) private String message; @Column(nullable=false) private boolean readFlag=false; private LocalDateTime createdAt;
 public Notification(){}
 public Long getId(){return id;} public void setId(Long v){id=v;} public String getRecipient(){return recipient;} public void setRecipient(String v){recipient=v;}
 public String getRole(){return role;} public void setRole(String v){role=v;} public String getType(){return type;} public void setType(String v){type=v;}
 public String getMessage(){return message;} public void setMessage(String v){message=v;} public boolean isReadFlag(){return readFlag;} public void setReadFlag(boolean v){readFlag=v;}
 public LocalDateTime getCreatedAt(){return createdAt;} public void setCreatedAt(LocalDateTime v){createdAt=v;}
}