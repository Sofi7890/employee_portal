package com.project.controller;

import com.project.dto.ProjectUpdateResult;
import com.project.entity.Client;
import com.project.entity.Employee;
import com.project.entity.Project;
import com.project.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/projects")
public class ProjectController {

    private final ProjectService projectService;

    @Autowired
    public ProjectController(ProjectService projectService) {
        this.projectService = projectService;
    }

    @PostMapping
    public ResponseEntity<Project> createProject(@RequestBody Project project) {
        Project created = projectService.createProject(project);
        return new ResponseEntity<>(created, HttpStatus.CREATED);
    }

    @PutMapping("/{projectId}")
    public ResponseEntity<ProjectUpdateResult> updateProject(@PathVariable String projectId,
                                                             @RequestBody Project project) {
        project.setProjectId(projectId); // ensure ID is set
        ProjectUpdateResult result = projectService.updateProject(project);
        return ResponseEntity.ok(result);
    }

    @DeleteMapping("/{projectId}")
    public ResponseEntity<Void> deleteProject(@PathVariable String projectId) {
        projectService.deleteProject(projectId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{projectId}")
    public ResponseEntity<Project> getProjectById(@PathVariable String projectId) {
        return projectService.findById(projectId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping
    public ResponseEntity<List<Project>> getAllProjects() {
        List<Project> projects = projectService.findAll();
        return ResponseEntity.ok(projects);
    }

    @GetMapping("/{projectId}/client")
    public ResponseEntity<Client> getClientByProject(@PathVariable String projectId) {
        return projectService.findClientByProjectId(projectId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{projectId}/employees")
    public ResponseEntity<List<Employee>> getEmployeesByProject(@PathVariable String projectId) {
        List<Employee> employees = projectService.findEmployeesByProjectId(projectId);
        return ResponseEntity.ok(employees);
    }
}

