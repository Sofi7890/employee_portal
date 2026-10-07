package com.project.controller;

import com.project.entity.Employee;
import com.project.entity.Project;
import com.project.service.EmployeeService;
import com.project.service.ProjectService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/employees")
public class EmployeeController {

    private final EmployeeService employeeService;


    @Autowired
    public EmployeeController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @PostMapping
    public ResponseEntity<Employee> createEmployee(@RequestBody Employee employee) {
        Employee created = employeeService.createEmployee(employee);
        return new ResponseEntity<>(created, HttpStatus.CREATED);
    }

    @PutMapping("/{employeeId}")
    public ResponseEntity<Employee> updateEmployee(@PathVariable String employeeId,
                                                   @RequestBody Employee employee) {
        employee.setEmployeeId(employeeId); // ensure id is set
        Employee updated = employeeService.updateEmployee(employee);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{employeeId}")
    public ResponseEntity<Void> deleteEmployee(@PathVariable String employeeId) {
        employeeService.deleteEmployee(employeeId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{employeeId}")
    public ResponseEntity<Employee> getEmployeeById(@PathVariable String employeeId) {
        return employeeService.findById(employeeId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/email/{email}")
    public ResponseEntity<Employee> getEmployeeByEmail(@PathVariable String email) {
        return employeeService.findByEmail(email)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping
    public ResponseEntity<List<Employee>> getAllEmployees() {
        List<Employee> employees = employeeService.findAllOrderByDojDesc();
        return ResponseEntity.ok(employees);
    }

    @GetMapping("/joining-range")
    public ResponseEntity<List<Employee>> getEmployeesByJoiningDateRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to) {
        List<Employee> employees = employeeService.findByJoiningDateRange(from, to);
        return ResponseEntity.ok(employees);
    }

    @GetMapping("/bench")
    public ResponseEntity<List<Employee>> getBenchEmployees() {
        List<Employee> benchEmployees = employeeService.findBenchEmployees();
        return ResponseEntity.ok(benchEmployees);
    }

    @GetMapping("/{employeeId}/project")
    public ResponseEntity<Project> getProjectByEmployee(@PathVariable String employeeId) {
        return employeeService.getProjectByEmployeeId(employeeId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/{employeeId}/assign-project/{projectId}")
    public ResponseEntity<Void> assignProject(@PathVariable String employeeId,
                                              @PathVariable String projectId) {
        employeeService.assignProject(employeeId, projectId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{employeeId}/release-project")
    public ResponseEntity<Void> releaseProject(@PathVariable String employeeId) {
        employeeService.releaseProject(employeeId);
        return ResponseEntity.ok().build();
    }
}
