package com.project.controller;

import com.project.entity.ContactPerson;
import com.project.service.ContactPersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/contact-persons")
public class ContactPersonController {

    private final ContactPersonService contactPersonService;

    @Autowired
    public ContactPersonController(ContactPersonService contactPersonService) {
        this.contactPersonService = contactPersonService;
    }

    @PostMapping
    public ResponseEntity<ContactPerson> create(@RequestBody ContactPerson cp) {
        ContactPerson created = contactPersonService.create(cp);
        return ResponseEntity.ok(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ContactPerson> update(@PathVariable Long id, @RequestBody ContactPerson cp) {
        cp.setId(id);  // ensures correct id is set
        ContactPerson updated = contactPersonService.update(cp);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contactPersonService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/by-client/{clientId}")
    public ResponseEntity<List<ContactPerson>> getByClientId(@PathVariable String clientId) {
        List<ContactPerson> cps = contactPersonService.findByClientId(clientId);
        return ResponseEntity.ok(cps);
    }
}
