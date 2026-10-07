package com.project.dao.impl;

import com.project.dao.ProjectDao;
import com.project.entity.Project;
import com.project.entity.Employee;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class ProjectDaoImpl implements ProjectDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public ProjectDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session current() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(Project project) {
        current().save(project);
    }

    @Override
    public void update(Project project) {
        current().update(project);
    }

    @Override
    public void delete(Project project) {
        current().delete(project);
    }

    @Override
    public Optional<Project> findById(String projectId) {
        return Optional.ofNullable(current().get(Project.class, projectId));
    }

    @Override
    public List<Project> findAll() {
        Query<Project> q = current().createQuery("from Project where active = true or active is null order by projectStartDate desc", Project.class);
        return q.getResultList();
    }

    @Override
    public List<Employee> findEmployeesByProjectId(String projectId) {
        Query<Employee> q = current().createQuery("from Employee where project.projectId = :pid", Employee.class);
        q.setParameter("pid", projectId);
        return q.getResultList();
    }

    @Override
    public List<Project> findByClientId(String clientId) {
        Query<Project> q = current().createQuery("from Project where client.clientId = :cid", Project.class);
        q.setParameter("cid", clientId);
        return q.getResultList();
    }
}

