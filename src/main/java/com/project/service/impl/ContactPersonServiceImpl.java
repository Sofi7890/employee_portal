
package com.project.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.ContactPersonDao;
import com.project.entity.ContactPerson;
import com.project.service.ContactPersonService;

@Service
public class ContactPersonServiceImpl implements ContactPersonService {

    private final ContactPersonDao contactPersonDao;

    @Autowired
    public ContactPersonServiceImpl(ContactPersonDao contactPersonDao) {
        this.contactPersonDao = contactPersonDao;
    }

    @Override
    @Transactional
    public ContactPerson create(ContactPerson cp) {
        if (cp == null) throw new IllegalArgumentException("contact person required");
        contactPersonDao.save(cp);
        return cp;
    }

    @Override
    @Transactional
    public ContactPerson update(ContactPerson cp) {
        if (cp == null || cp.getId() == null) throw new IllegalArgumentException("id required");
        contactPersonDao.update(cp);
        return cp;
    }

    @Override
    @Transactional
    public void delete(Long id) {
        contactPersonDao.findById(id).ifPresent(contactPersonDao::delete);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ContactPerson> findByClientId(String clientId) {
        return contactPersonDao.findByClientId(clientId);
    }
    @Override
    @Transactional(readOnly = true)
    public Optional<ContactPerson> findById(Long id) {
        return contactPersonDao.findById(id);
    }
}

