package com.project.dao.impl;

import com.project.dao.AdminDao;
import com.project.entity.Admin;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class AdminDaoImpl implements AdminDao {

    private final SessionFactory sessionFactory;

    @Autowired
    public AdminDaoImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session current() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void save(Admin admin) {
        current().save(admin);
    }

    @Override
    public void update(Admin admin) {
        current().update(admin);
    }

    @Override
    public void delete(Admin admin) {
        current().delete(admin);
    }

    @Override
    public Optional<Admin> findById(Long id) {
        return Optional.ofNullable(current().get(Admin.class, id));
    }

   
    @Override
    public Optional<Admin> findByUsername(String username) {
        // Admin entity field is 'username'
        Query<Admin> q = current().createQuery("from Admin where username = :username", Admin.class);
        q.setParameter("username", username);
        return q.uniqueResultOptional();
    }


    @Override
   public Optional<Admin> findByEmail(String email) {
        // If Admin entity doesn't have email field, return empty to avoid HQL failure.
        // If you add an 'email' column to Admin entity, replace with:
        // Query<Admin> q = current().createQuery("from Admin where email = :email", Admin.class);
        // q.setParameter("email", email); return q.uniqueResultOptional();
        return Optional.empty();
    } 

    @Override
    public List<Admin> findAll() {
        return current().createQuery("from Admin", Admin.class).getResultList();
    }
}
