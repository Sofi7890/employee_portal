
package com.project.dao.impl;

import com.project.dao.EmployeeDao;
import com.project.entity.Employee;
import com.project.entity.Project;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public EmployeeDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session current() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Employee save(Employee employee) {
        current().save(employee);
        return employee;
    }

    @Override
    public void update(Employee employee) {
        current().update(employee);
    }

    @Override
    public void delete(Employee employee) {
        current().delete(employee);
    }

    @Override
    public Optional<Employee> findById(String employeeId) {
        return Optional.ofNullable(
                current().get(Employee.class, employeeId)
        );
    }

    @Override
    public Optional<Employee> findByEmail(String email) {

        Query<Employee> q = current().createQuery(
                "from Employee " +
                "where (active = true or active is null) " +
                "and employeeEmail = :email",
                Employee.class
        );

        q.setParameter("email", email);

        return q.uniqueResultOptional();
    }

    @Override
    public List<Employee> findAll() {

        List<Employee> list = current().createQuery(
                "from Employee " +
                "where active = true or active is null",
                Employee.class
        ).getResultList();

        return list.stream()
                .collect(Collectors.toList());
    }

    @Override
    public List<Employee> findAllOrderByDojDesc() {

        return current().createQuery(
                "from Employee " +
                "where active = true or active is null " +
                "order by dateOfJoining desc",
                Employee.class
        ).getResultList();
    }

    @Override
    public List<Employee> findByJoiningDateRange(
            LocalDate from, LocalDate to) {

        Query<Employee> q = current().createQuery(
                "from Employee " +
                "where (active = true or active is null) " +
                "and dateOfJoining between :fromDate and :toDate " +
                "order by dateOfJoining desc",
                Employee.class
        );

        q.setParameter("fromDate", from);
        q.setParameter("toDate", to);

        return q.getResultList();
    }

    @Override
    public List<Employee> findBenchEmployees() {

        Query<Employee> q = current().createQuery(
                "from Employee " +
                "where (active = true or active is null) " +
                "and project is null " +
                "order by dateOfJoining desc",
                Employee.class
        );

        return q.getResultList();
    }

    // IMPORTANT:
    // Do not filter inactive employees here.
    // Their IDs must not be reused.
    @Override
    public List<String> findAllEmployeeIds() {

        return current().createQuery(
                "select employeeId from Employee",
                String.class
        ).getResultList();
    }

    @Override
    public void assignProject(
            String employeeId, String projectId) {

        Employee emp = current().get(
                Employee.class, employeeId
        );

        if (emp == null) {
            throw new IllegalArgumentException(
                    "Employee not found: " + employeeId
            );
        }

        Project project = current().get(
                Project.class, projectId
        );

        if (project == null) {
            throw new IllegalArgumentException(
                    "Project not found: " + projectId
            );
        }

        emp.setProject(project);
        current().update(emp);
    }

    @Override
    public void releaseProject(String employeeId) {

        Employee emp = current().get(
                Employee.class, employeeId
        );

        if (emp == null) {
            throw new IllegalArgumentException(
                    "Employee not found: " + employeeId
            );
        }

        emp.setProject(null);
        current().update(emp);
    }
}
