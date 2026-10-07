package com.project.dao;

import com.project.entity.Client;
import com.project.entity.Project;
import java.util.List;
import java.util.Optional;

public interface ClientDao {
    void save(Client client);
    void update(Client client);
    void delete(Client client);

    Optional<Client> findById(String clientId);
    Optional<Client> findByName(String clientName);
    List<Client> findAll();

    // relation helper
    List<Project> getProjectsByClientId(String clientId);
}
