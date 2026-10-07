package com.project.controller1;

import com.project.entity.Client;
import com.project.entity.ContactPerson;
import com.project.service.ClientService;
import com.project.service.ContactPersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/contact-person")
public class ContactPersonMvcController {

    private final ContactPersonService contactPersonService;
    private final ClientService clientService;

    @Autowired
    public ContactPersonMvcController(ContactPersonService contactPersonService,
                                      ClientService clientService) {
        this.contactPersonService = contactPersonService;
        this.clientService = clientService;
    }

    @GetMapping("/list")
    public String listContactPersons(Model model) {
        // For simplicity, you may fetch all contact persons via client list
        List<Client> clients = clientService.findAll();
        model.addAttribute("clients", clients);
        return "contactperson-list";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("contactPerson", new ContactPerson());
        model.addAttribute("clients", clientService.findAll());
        return "contactperson-form";
    }

    @PostMapping("/create")
    public String createContactPerson(@ModelAttribute("contactPerson") ContactPerson contactPerson,
                                      @RequestParam("clientId") String clientId) {
        Client client = clientService.findById(clientId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid Client ID"));
        contactPerson.setClient(client);
        contactPersonService.create(contactPerson);
        return "redirect:/contact-person/list";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        // Fetch contact person by ID directly
        ContactPerson cp = contactPersonService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid ContactPerson ID"));
        List<Client> clients = clientService.findAll();
        model.addAttribute("contactPerson", cp);
        model.addAttribute("clients", clients);
        return "contactperson-form";
    }

    @PostMapping("/update/{id}")
    public String updateContactPerson(@PathVariable("id") Long id,
                                      @ModelAttribute("contactPerson") ContactPerson contactPerson,
                                      @RequestParam("clientId") String clientId) {
        Client client = clientService.findById(clientId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid Client ID"));
        contactPerson.setClient(client);
        contactPerson.setId(id);
        contactPersonService.update(contactPerson);
        return "redirect:/contact-person/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteContactPerson(@PathVariable("id") Long id) {
        contactPersonService.delete(id);
        return "redirect:/contact-person/list";
    }
}
