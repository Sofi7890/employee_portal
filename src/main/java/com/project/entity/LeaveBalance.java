package com.project.entity;
import javax.persistence.*;
@Entity @Table(name="leave_balances")
public class LeaveBalance {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 @OneToOne(fetch=FetchType.EAGER) @JoinColumn(name="employee_id", unique=true, nullable=false) private Employee employee;
 private int allocatedDays=24; private int usedDays=0;
 public LeaveBalance(){}
 public Long getId(){return id;} public void setId(Long v){id=v;}
 public Employee getEmployee(){return employee;} public void setEmployee(Employee v){employee=v;}
 public int getAllocatedDays(){return allocatedDays;} public void setAllocatedDays(int v){allocatedDays=v;}
 public int getUsedDays(){return usedDays;} public void setUsedDays(int v){usedDays=v;}
 public int getRemainingDays(){return Math.max(0, allocatedDays-usedDays);}
}