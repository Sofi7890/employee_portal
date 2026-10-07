package com.project.dao;

import com.project.entity.Project;
import com.project.entity.Employee;
import java.util.List;
import java.util.Optional;

public interface ProjectDao {
    void save(Project project);
    void update(Project project);
    void delete(Project project);

    Optional<Project> findById(String projectId);
    List<Project> findAll();

    // relation helpers
    List<Employee> findEmployeesByProjectId(String projectId);
    List<Project> findByClientId(String clientId);
}
