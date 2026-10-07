package com.project.dao;

import com.project.entity.ContactPerson;
import java.util.List;
import java.util.Optional;

public interface ContactPersonDao {
    void save(ContactPerson contactPerson);
    void update(ContactPerson contactPerson);
    void delete(ContactPerson contactPerson);

    Optional<ContactPerson> findById(Long id);
    List<ContactPerson> findByClientId(String clientId);
    List<ContactPerson> findAll();
}

