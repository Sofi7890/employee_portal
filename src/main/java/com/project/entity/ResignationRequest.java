package com.project.entity;
import javax.persistence.*; import java.time.LocalDate;
@Entity @Table(name="resignation_requests")
public class ResignationRequest {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="employee_id", nullable=false) private Employee employee;
 @Column(length=1500, nullable=false) private String reason; @Column(nullable=false) private String status="PENDING";
 private LocalDate submittedDate; private LocalDate lastWorkingDate; private LocalDate processedDate; private String adminComment;
 public ResignationRequest(){}
 public Long getId(){return id;} public void setId(Long v){id=v;} public Employee getEmployee(){return employee;} public void setEmployee(Employee v){employee=v;}
 public String getReason(){return reason;} public void setReason(String v){reason=v;} public String getStatus(){return status;} public void setStatus(String v){status=v;}
 public LocalDate getSubmittedDate(){return submittedDate;} public void setSubmittedDate(LocalDate v){submittedDate=v;} public LocalDate getLastWorkingDate(){return lastWorkingDate;} public void setLastWorkingDate(LocalDate v){lastWorkingDate=v;}
 public LocalDate getProcessedDate(){return processedDate;} public void setProcessedDate(LocalDate v){processedDate=v;} public String getAdminComment(){return adminComment;} public void setAdminComment(String v){adminComment=v;}
}