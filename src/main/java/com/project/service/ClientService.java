package com.project.service;

import com.project.entity.Client;
import com.project.entity.ContactPerson;
import com.project.entity.Project;

import java.util.List;
import java.util.Optional;

public interface ClientService {
    Client createClient(Client client);
    Client updateClient(Client client);
    void deleteClient(String clientId);

    Optional<Client> findById(String clientId);
    List<Client> findAll();

    List<Project> getProjectsByClientId(String clientId);
    List<ContactPerson> getContactPersonsByClientId(String clientId);
}
