package com.project.entity;
import javax.persistence.*; import java.math.BigDecimal; import java.time.LocalDateTime;
@Entity @Table(name="expense_claims")
public class ExpenseClaim {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 @ManyToOne(fetch=FetchType.EAGER) @JoinColumn(name="employee_id", nullable=false) private Employee employee;
 @Column(nullable=false) private String expenseType; @Column(nullable=false, precision=12, scale=2) private BigDecimal amount;
 @Column(length=1500) private String description; private String receiptFile; @Column(nullable=false) private String status="PENDING";
 private String adminComment; private LocalDateTime submittedAt;
 public ExpenseClaim(){}
 public Long getId(){return id;} public void setId(Long v){id=v;} public Employee getEmployee(){return employee;} public void setEmployee(Employee v){employee=v;}
 public String getExpenseType(){return expenseType;} public void setExpenseType(String v){expenseType=v;} public BigDecimal getAmount(){return amount;} public void setAmount(BigDecimal v){amount=v;}
 public String getDescription(){return description;} public void setDescription(String v){description=v;} public String getReceiptFile(){return receiptFile;} public void setReceiptFile(String v){receiptFile=v;}
 public String getStatus(){return status;} public void setStatus(String v){status=v;} public String getAdminComment(){return adminComment;} public void setAdminComment(String v){adminComment=v;}
 public LocalDateTime getSubmittedAt(){return submittedAt;} public void setSubmittedAt(LocalDateTime v){submittedAt=v;}
}