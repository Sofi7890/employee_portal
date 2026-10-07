package com.project.service.impl;

import com.project.dao.ClientDao;
import com.project.dao.ContactPersonDao;
import com.project.entity.Client;
import com.project.entity.ContactPerson;
import com.project.entity.Project;
import com.project.service.ClientService;
import com.project.utils.IDGeneratorUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ClientServiceImpl implements ClientService {

    private final ClientDao clientDao;
    private final ContactPersonDao contactPersonDao;
    private  BCryptPasswordEncoder passwordEncoder;

    @Autowired
    public ClientServiceImpl(ClientDao clientDao,
                             ContactPersonDao contactPersonDao) {
        this.clientDao = clientDao;
        this.contactPersonDao = contactPersonDao;
        
    }
    @Autowired //  Add a setter method with @Autowired
    public void setPasswordEncoder(BCryptPasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public Client createClient(Client client) {
        if (client == null) throw new IllegalArgumentException("client required");
        if (client.getClientName() == null || client.getClientName().trim().isEmpty())
            throw new IllegalArgumentException("client name required");

        if (client.getPassword() != null && !client.getPassword().trim().isEmpty())
            client.setPassword(passwordEncoder.encode(client.getPassword()));
        
        if (client.getRole() == null || client.getRole().trim().isEmpty()) {
            client.setRole("ROLE_CLIENT");
        }

        List<String> existingIds = clientDao.findAll().stream()
                .map(Client::getClientId)
                .collect(Collectors.toList());
        String nextId = IDGeneratorUtil.nextId(existingIds, "CLIENT-", 3);
        client.setClientId(nextId);

        clientDao.save(client);
        return client;
    }

    @Override
    @Transactional
    public Client updateClient(Client client) {
        if (client == null || client.getClientId() == null) throw new IllegalArgumentException("clientId required");
        Client existing = clientDao.findById(client.getClientId()).orElseThrow(() -> new IllegalArgumentException("Client not found"));

        // preserve id, handle password if present
        if (client.getPassword() == null || client.getPassword().trim().isEmpty()) {
            client.setPassword(existing.getPassword());
        } else {
            client.setPassword(passwordEncoder.encode(client.getPassword()));
        }

        existing.setClientName(client.getClientName());
        existing.setClientRelationshipDate(client.getClientRelationshipDate());
        existing.setPassword(client.getPassword());
        // contact persons and projects managed via separate APIs
        clientDao.update(existing);
        return existing;
    }

    @Override
    @Transactional
    public void deleteClient(String clientId) {
        clientDao.findById(clientId).ifPresent(c -> { c.setActive(false); clientDao.update(c); });
    }

    @Override
    @Transactional(readOnly = true)
    public java.util.Optional<Client> findById(String clientId) {
        return clientDao.findById(clientId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Client> findAll() {
        return clientDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Project> getProjectsByClientId(String clientId) {
        return clientDao.getProjectsByClientId(clientId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ContactPerson> getContactPersonsByClientId(String clientId) {
        return contactPersonDao.findByClientId(clientId);
    }
}
