package com.project.controller1;

import com.project.entity.Client;
import com.project.entity.ContactPerson;
import com.project.entity.Project;
import com.project.service.ClientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/client")
public class ClientMvcController {

    private final ClientService clientService;

    @Autowired
    public ClientMvcController(ClientService clientService) {
        this.clientService = clientService;
    }

    @GetMapping("/list")
    public String listClients(Model model) {
        List<Client> clients = clientService.findAll();
        model.addAttribute("clients", clients);
        return "client-list"; // client-list.html or JSP
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("client", new Client());
        return "client-form"; // client-form.html or JSP
    }

    @PostMapping("/create")
    public String createClient(@ModelAttribute("client") Client client) {
        clientService.createClient(client);
        return "redirect:/client/list";
    }

    @GetMapping("/edit/{clientId}")
    public String showEditForm(@PathVariable("clientId") String clientId, Model model) {
        Client client = clientService.findById(clientId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid Client ID"));
        model.addAttribute("client", client);
        return "client-form";
    }

    @PostMapping("/update/{clientId}")
    public String updateClient(@PathVariable("clientId") String clientId, @ModelAttribute("client") Client client) {
        client.setClientId(clientId);
        clientService.updateClient(client);
        return "redirect:/client/list";
    }

    @GetMapping("/delete/{clientId}")
    public String deleteClient(@PathVariable("clientId") String clientId) {
        clientService.deleteClient(clientId);
        return "redirect:/client/list";
    }
 // Client can see only THEIR dashboard
    @GetMapping("/dashboard")
    public String showClientDashboard(Model model, HttpSession session) {
        String clientId = (String) session.getAttribute("username"); // Assuming session stores the CLIENT_ID

        Optional<Client> clientOpt = clientService.findById(clientId); 

        if (clientOpt.isPresent()) {
            Client client = clientOpt.get();
            
            // CHANGE: 1. Add the specific client object (not a list)
            model.addAttribute("client", client);
            
            // CHANGE: 2. Fetch and add the client's projects using the service
            List<Project> clientProjects = clientService.getProjectsByClientId(client.getClientId());
            model.addAttribute("projects", clientProjects);
            
            // CHANGE: 3. Fetch and add the client's contact persons using the service
            List<ContactPerson> clientContacts = clientService.getContactPersonsByClientId(client.getClientId());
            model.addAttribute("contacts", clientContacts);

            // CHANGE: Route to a restricted, client-specific dashboard JSP
            return "client-dashboard";
        } else {
            return "redirect:/auth/login?error";
        }
    }
}
