package com.project.entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name="attendance_records",
       uniqueConstraints=@UniqueConstraint(columnNames={"employee_id","attendance_date"}))
public class Attendance {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="employee_id", nullable=false)
    private Employee employee;

    @Column(name="attendance_date", nullable=false)
    private LocalDate attendanceDate;

    private LocalDateTime checkIn;
    private LocalDateTime checkOut;

    @Column(nullable=false)
    private String status="PRESENT";

    private Long workedMinutes=0L;
    private boolean late;

    // OFFICE or HOME, determined from live GPS distance.
    @Column(name="attendance_type")
    private String attendanceType;

    private Double latitude;
    private Double longitude;

    public Attendance(){}

    public Long getId(){return id;}
    public void setId(Long v){id=v;}
    public Employee getEmployee(){return employee;}
    public void setEmployee(Employee v){employee=v;}
    public LocalDate getAttendanceDate(){return attendanceDate;}
    public void setAttendanceDate(LocalDate v){attendanceDate=v;}
    public LocalDateTime getCheckIn(){return checkIn;}
    public void setCheckIn(LocalDateTime v){checkIn=v;}
    public LocalDateTime getCheckOut(){return checkOut;}
    public void setCheckOut(LocalDateTime v){checkOut=v;}
    public String getStatus(){return status;}
    public void setStatus(String v){status=v;}
    public Long getWorkedMinutes(){return workedMinutes;}
    public void setWorkedMinutes(Long v){workedMinutes=v;}
    public boolean isLate(){return late;}
    public void setLate(boolean v){late=v;}
    public String getAttendanceType(){return attendanceType;}
    public void setAttendanceType(String v){attendanceType=v;}
    public Double getLatitude(){return latitude;}
    public void setLatitude(Double v){latitude=v;}
    public Double getLongitude(){return longitude;}
    public void setLongitude(Double v){longitude=v;}
}
