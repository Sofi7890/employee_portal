package com.project.service;

import com.project.entity.Employee;
import com.project.entity.Project;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface EmployeeService {
    Employee createEmployee(Employee employee);
    Employee updateEmployee(Employee employee);
    void deleteEmployee(String employeeId);
    void updateImagePath(String employeeId, String imagePath);

    Optional<Employee> findById(String employeeId);
    Optional<Employee> findByEmail(String email);
    
    List<Employee> findAll();  

    List<Employee> findAllOrderByDojDesc();
    List<Employee> findByJoiningDateRange(LocalDate from, LocalDate to);
    List<Employee> findBenchEmployees();

    Optional<Project> getProjectByEmployeeId(String employeeId);
    void assignProject(String employeeId, String projectId);
    void releaseProject(String employeeId);
}
