package com.project.dao.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.dao.ClientDao;
import com.project.entity.Client;
import com.project.entity.Project;

@Repository
public class ClientDaoImpl implements ClientDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public ClientDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session current() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(Client client) {
        current().save(client);
    }

    @Override
    public void update(Client client) {
        current().update(client);
    }

    @Override
    public void delete(Client client) {
        current().delete(client);
    }

    @Override
    public Optional<Client> findById(String clientId) {
        return Optional.ofNullable(current().get(Client.class, clientId));
    }

    @Override
    public Optional<Client> findByName(String clientName) {
        Query<Client> q = current().createQuery("from Client where clientName = :name", Client.class);
        q.setParameter("name", clientName);
        return q.uniqueResultOptional();
    }

    /*@Override
    public List<Client> findAll() {
        List<Client> list = current().createQuery("from Client where active = true or active is null", Client.class).getResultList();
        return list; // already a List, use streams in service if need sorting/filtering
    }*/

@Override
public List<Client> findAll() {
    return current()
            .createQuery("from Client", Client.class)
            .getResultList();
}

    @Override
    public List<Project> getProjectsByClientId(String clientId) {
        Client client = current().get(Client.class, clientId);  // fetch Client
        if (client != null && client.getProjects() != null) {
            return new ArrayList<>(client.getProjects());       // convert Set<Project> to List<Project>
        } else {
            return Collections.emptyList();                     // return empty list if null
        }
    }

    

    

    }


