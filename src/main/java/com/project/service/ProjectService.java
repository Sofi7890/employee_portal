package com.project.service;

import com.project.entity.Client;
import com.project.entity.Employee;
import com.project.entity.Project;
import com.project.dto.ProjectUpdateResult;

import java.util.List;
import java.util.Optional;

public interface ProjectService {
    Project createProject(Project project);
    ProjectUpdateResult updateProject(Project project); // returns old/new end dates info
    void deleteProject(String projectId);

    Optional<Project> findById(String projectId);
    List<Project> findAll();

    Optional<Client> findClientByProjectId(String projectId);
    List<Employee> findEmployeesByProjectId(String projectId);
}
