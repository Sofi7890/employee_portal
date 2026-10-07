package com.project.controller;

import com.project.entity.Client;
import com.project.entity.ContactPerson;
import com.project.entity.Project;
import com.project.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/clients")
public class ClientController {

    private final ClientService clientService;

    @Autowired
    public ClientController(ClientService clientService) {
        this.clientService = clientService;
    }

    @PostMapping
    public ResponseEntity<Client> createClient(@RequestBody Client client) {
        Client created = clientService.createClient(client);
        return new ResponseEntity<>(created, HttpStatus.CREATED);
    }

    @PutMapping("/{clientId}")
    public ResponseEntity<Client> updateClient(@PathVariable String clientId, @RequestBody Client client) {
        client.setClientId(clientId); // ensure id is set
        Client updated = clientService.updateClient(client);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{clientId}")
    public ResponseEntity<Void> deleteClient(@PathVariable String clientId) {
        clientService.deleteClient(clientId);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{clientId}")
    public ResponseEntity<Client> getClientById(@PathVariable String clientId) {
        return clientService.findById(clientId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping
    public ResponseEntity<List<Client>> getAllClients() {
        List<Client> clients = clientService.findAll();
        return ResponseEntity.ok(clients);
    }

    @GetMapping("/{clientId}/projects")
    public ResponseEntity<List<Project>> getProjectsByClient(@PathVariable String clientId) {
        List<Project> projects = clientService.getProjectsByClientId(clientId);
        return ResponseEntity.ok(projects);
    }

    @GetMapping("/{clientId}/contacts")
    public ResponseEntity<List<ContactPerson>> getContactPersonsByClient(@PathVariable String clientId) {
        List<ContactPerson> contacts = clientService.getContactPersonsByClientId(clientId);
        return ResponseEntity.ok(contacts);
    }
}
