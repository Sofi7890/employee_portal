package com.project.service;

import com.project.entity.ContactPerson;

import java.util.List;
import java.util.Optional;

public interface ContactPersonService {
    ContactPerson create(ContactPerson cp);
    ContactPerson update(ContactPerson cp);
    void delete(Long id);
    Optional<ContactPerson> findById(Long id);
    List<ContactPerson> findByClientId(String clientId);
}
