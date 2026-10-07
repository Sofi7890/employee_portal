
package com.project.dao;

import com.project.entity.Employee;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface EmployeeDao {

    Employee save(Employee employee);

    void update(Employee employee);

    void delete(Employee employee);

    Optional<Employee> findById(String employeeId);

    Optional<Employee> findByEmail(String email);

    List<Employee> findAll();

    List<Employee> findAllOrderByDojDesc();

    List<Employee> findByJoiningDateRange(
            LocalDate from, LocalDate to);

    List<Employee> findBenchEmployees();

    // Fetch IDs of ALL employees, including inactive employees
    List<String> findAllEmployeeIds();

    void assignProject(String employeeId, String projectId);

    void releaseProject(String employeeId);
}