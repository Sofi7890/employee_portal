package com.project.entity;
import javax.persistence.*; import java.time.LocalDate;
@Entity @Table(name="leave_requests")
public class LeaveRequest {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="employee_id", nullable=false) private Employee employee;
 @Column(nullable=false) private String leaveType; @Column(nullable=false) private LocalDate startDate; @Column(nullable=false) private LocalDate endDate;
 @Column(length=1000, nullable=false) private String reason; @Column(nullable=false) private String status="PENDING";
 private LocalDate appliedDate; private String adminComment;
 public LeaveRequest(){}
 public Long getId(){return id;} public void setId(Long v){id=v;} public Employee getEmployee(){return employee;} public void setEmployee(Employee v){employee=v;}
 public String getLeaveType(){return leaveType;} public void setLeaveType(String v){leaveType=v;} public LocalDate getStartDate(){return startDate;} public void setStartDate(LocalDate v){startDate=v;}
 public LocalDate getEndDate(){return endDate;} public void setEndDate(LocalDate v){endDate=v;} public String getReason(){return reason;} public void setReason(String v){reason=v;}
 public String getStatus(){return status;} public void setStatus(String v){status=v;} public LocalDate getAppliedDate(){return appliedDate;} public void setAppliedDate(LocalDate v){appliedDate=v;}
 public String getAdminComment(){return adminComment;} public void setAdminComment(String v){adminComment=v;}
 public long getDays(){return startDate==null||endDate==null?0:java.time.temporal.ChronoUnit.DAYS.between(startDate,endDate)+1;}
}