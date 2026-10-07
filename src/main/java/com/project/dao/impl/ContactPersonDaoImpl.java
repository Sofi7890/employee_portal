package com.project.dao.impl;

import com.project.dao.ContactPersonDao;
import com.project.entity.ContactPerson;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Repository
public class ContactPersonDaoImpl implements ContactPersonDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public ContactPersonDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session current() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(ContactPerson contactPerson) {
        current().save(contactPerson);
    }

    @Override
    public void update(ContactPerson contactPerson) {
        current().update(contactPerson);
    }

    @Override
    public void delete(ContactPerson contactPerson) {
        current().delete(contactPerson);
    }

    @Override
    public Optional<ContactPerson> findById(Long id) {
        return Optional.ofNullable(current().get(ContactPerson.class, id));
    }

    @Override
    public List<ContactPerson> findByClientId(String clientId) {
        Query<ContactPerson> q = current().createQuery(
                "from ContactPerson where client.clientId = :clientId", ContactPerson.class);
        q.setParameter("clientId", clientId);
        return q.getResultList();
    }

    @Override
    public List<ContactPerson> findAll() {
        List<ContactPerson> list = current().createQuery("from ContactPerson", ContactPerson.class).getResultList();
        // example Java 8: sort by name before returning
        return list.stream()
                .sorted((a, b) -> a.getName().compareToIgnoreCase(b.getName()))
                .collect(Collectors.toList());
    }
}
