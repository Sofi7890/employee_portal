
package com.project.service.impl;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.EmployeeDao;
import com.project.dao.ProjectDao;
import com.project.entity.Employee;
import com.project.entity.Project;
import com.project.exception.DuplicateEntityException;
import com.project.service.EmployeeService;
import com.project.utils.IDGeneratorUtil;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    private final EmployeeDao employeeDao;
    private final ProjectDao projectDao;

    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    public EmployeeServiceImpl(
            EmployeeDao employeeDao,
            ProjectDao projectDao) {

        this.employeeDao = employeeDao;
        this.projectDao = projectDao;
    }

    @Autowired
    public void setPasswordEncoder(
            BCryptPasswordEncoder passwordEncoder) {

        this.passwordEncoder = passwordEncoder;
    }

    // CREATE EMPLOYEE
    @Override
    @Transactional
    public Employee createEmployee(Employee employee) {

        Optional.ofNullable(employee)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "employee required"
                        )
                );

        Optional.ofNullable(employee.getEmployeeName())
                .filter(name -> !name.trim().isEmpty())
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "employee name required"
                        )
                );

        Optional.ofNullable(employee.getEmployeeEmail())
                .filter(email -> !email.trim().isEmpty())
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "employee email required"
                        )
                );

        // Check duplicate email
        employeeDao.findByEmail(employee.getEmployeeEmail())
                .ifPresent(e -> {
                    throw new DuplicateEntityException(
                            "email already in use"
                    );
                });

        // Default role
        employee.setRole(
                Optional.ofNullable(employee.getRole())
                        .filter(role -> !role.trim().isEmpty())
                        .orElse("ROLE_EMPLOYEE")
        );

        // Default joining date
        employee.setDateOfJoining(
                Optional.ofNullable(
                        employee.getDateOfJoining()
                ).orElse(LocalDate.now())
        );

        // Encode password if provided
        Optional.ofNullable(employee.getPassword())
                .filter(pwd -> !pwd.trim().isEmpty())
                .map(passwordEncoder::encode)
                .ifPresent(employee::setPassword);

        // ------------------------------------------------
        // FIX: Fetch ALL employee IDs, including inactive
        // ------------------------------------------------

        List<String> existingIds =
                employeeDao.findAllEmployeeIds();

        String nextId = IDGeneratorUtil.nextId(
                existingIds,
                "JTC-",
                3
        );

        employee.setEmployeeId(nextId);

        System.out.println(
                "Generated Employee ID: " + nextId
        );

        // Save employee
        return employeeDao.save(employee);
    }

    // UPDATE EMPLOYEE
    @Override
    @Transactional
    public Employee updateEmployee(Employee employee) {

        Optional.ofNullable(employee)
                .map(Employee::getEmployeeId)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "employeeId required"
                        )
                );

        Employee existing = employeeDao.findById(
                employee.getEmployeeId()
        ).orElseThrow(() ->
                new IllegalArgumentException(
                        "Employee not found"
                )
        );

        // Preserve immutable fields
        employee.setEmployeeId(
                existing.getEmployeeId()
        );

        employee.setEmployeeEmail(
                existing.getEmployeeEmail()
        );

        // Preserve old password if no new password provided
        employee.setPassword(
                Optional.ofNullable(employee.getPassword())
                        .filter(pwd -> !pwd.trim().isEmpty())
                        .map(passwordEncoder::encode)
                        .orElse(existing.getPassword())
        );

        existing.setEmployeeName(
                employee.getEmployeeName()
        );

        existing.setEmployeeDept(
                employee.getEmployeeDept()
        );

        existing.setEmployeePhone(
                employee.getEmployeePhone()
        );

        existing.setDateOfJoining(
                Optional.ofNullable(
                        employee.getDateOfJoining()
                ).orElse(existing.getDateOfJoining())
        );

        if (employee.getImagePath() != null
                && !employee.getImagePath().trim().isEmpty()) {

            existing.setImagePath(
                    employee.getImagePath()
            );
        }

        employeeDao.update(existing);

        return existing;
    }

    // UPDATE EMPLOYEE PHOTO
    @Override
    @Transactional
    public void updateImagePath(
            String employeeId, String imagePath) {

        Employee e = employeeDao.findById(employeeId)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Employee not found"
                        )
                );

        e.setImagePath(imagePath);

        employeeDao.update(e);
    }

    // SOFT DELETE EMPLOYEE
    @Override
    @Transactional
    public void deleteEmployee(String employeeId) {

        employeeDao.findById(employeeId)
                .ifPresent(e -> {
                    e.setActive(false);
                    e.setEmploymentStatus("INACTIVE");
                    employeeDao.update(e);
                });
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Employee> findById(String employeeId) {

        return employeeDao.findById(employeeId);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Employee> findByEmail(String email) {

        return employeeDao.findByEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Employee> findAll() {

        return employeeDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Employee> findAllOrderByDojDesc() {

        return employeeDao.findAllOrderByDojDesc();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Employee> findByJoiningDateRange(
            LocalDate from, LocalDate to) {

        return employeeDao.findByJoiningDateRange(
                from, to
        );
    }

    @Override
    @Transactional(readOnly = true)
    public List<Employee> findBenchEmployees() {

        return employeeDao.findBenchEmployees();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Project> getProjectByEmployeeId(
            String employeeId) {

        return employeeDao.findById(employeeId)
                .map(Employee::getProject);
    }

    @Override
    @Transactional
    public void assignProject(
            String employeeId, String projectId) {

        Employee employee = employeeDao.findById(
                employeeId
        ).orElseThrow(() ->
                new IllegalArgumentException(
                        "Employee not found"
                )
        );

        Project project = projectDao.findById(
                projectId
        ).orElseThrow(() ->
                new IllegalArgumentException(
                        "Project not found"
                )
        );

        employee.setProject(project);

        employeeDao.update(employee);
    }

    @Override
    @Transactional
    public void releaseProject(String employeeId) {

        Employee e = employeeDao.findById(employeeId)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Employee not found"
                        )
                );

        e.setProject(null);

        employeeDao.update(e);
    }
}
