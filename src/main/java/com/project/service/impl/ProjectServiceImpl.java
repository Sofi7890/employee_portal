package com.project.service.impl;

import com.project.dao.ProjectDao;
import com.project.dao.ClientDao;
import com.project.entity.Client;
import com.project.entity.Employee;
import com.project.entity.Project;
import com.project.dto.ProjectUpdateResult;
import com.project.service.ProjectService;
import com.project.utils.IDGeneratorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProjectServiceImpl implements ProjectService {

    private final ProjectDao projectDao;
    private final ClientDao clientDao;

    @Autowired
    public ProjectServiceImpl(ProjectDao projectDao, ClientDao clientDao) {
        this.projectDao = projectDao;
        this.clientDao = clientDao;
    }

    @Override
    @Transactional
    public Project createProject(Project project) {
        if (project == null) throw new IllegalArgumentException("project required");
        if (project.getProjectName() == null || project.getProjectName().trim().isEmpty())
            throw new IllegalArgumentException("project name required");
        // generate id
        List<String> existingIds = projectDao.findAll().stream()
                .map(Project::getProjectId)
                .collect(Collectors.toList());
        String nextId = IDGeneratorUtil.nextId(existingIds, "PROJECT-", 3);
        project.setProjectId(nextId);
        projectDao.save(project);
        return project;
    }

    @Override
    @Transactional
    public ProjectUpdateResult updateProject(Project project) {
        if (project == null || project.getProjectId() == null)
            throw new IllegalArgumentException("projectId required");

        Project existing = projectDao.findById(project.getProjectId())
                .orElseThrow(() -> new IllegalArgumentException("Project not found"));

        LocalDate oldEnd = existing.getProjectEndDate();
        LocalDate newEnd = project.getProjectEndDate();

        // update other fields except projectId
        existing.setProjectName(project.getProjectName());
        existing.setProjectStartDate(project.getProjectStartDate());
        existing.setProjectEndDate(project.getProjectEndDate());
        existing.setClient(project.getClient());

        projectDao.update(existing);

        boolean extended = false;
        if (oldEnd != null && newEnd != null && newEnd.isAfter(oldEnd)) extended = true;

        return new ProjectUpdateResult(existing.getProjectId(), oldEnd, newEnd, extended);
    }

    @Override
    @Transactional
    public void deleteProject(String projectId) {
        projectDao.findById(projectId).ifPresent(p -> { p.setActive(false); projectDao.update(p); });
    }

    @Override
    @Transactional(readOnly = true)
    public java.util.Optional<Project> findById(String projectId) {
        return projectDao.findById(projectId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Project> findAll() {
        return projectDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public java.util.Optional<Client> findClientByProjectId(String projectId) {
        return projectDao.findById(projectId).map(Project::getClient);
    }
    @Override
    @Transactional(readOnly = true)
    public List<Employee> findEmployeesByProjectId(String projectId) {
        return projectDao.findEmployeesByProjectId(projectId);
    }
}
