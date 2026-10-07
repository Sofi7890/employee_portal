package com.project.controller1;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.entity.Project;
import com.project.service.ClientService;
import com.project.service.ProjectService;

@Controller
@RequestMapping("/project")
public class ProjectMvcController {

    private final ProjectService projectService;
    @Autowired
    private  ClientService clientService;

    @Autowired
    public ProjectMvcController(ProjectService projectService) {
        this.projectService = projectService;
    }

    @GetMapping("/list")
    public String listProjects(Model model) {
        List<Project> projects = projectService.findAll();
        model.addAttribute("projects", projects);
        return "project-list"; // project-list.html or JSP
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("project", new Project());
        model.addAttribute("clients", clientService.findAll());
        return "project-form"; // project-form.html or JSP
    }

    @PostMapping("/create")
    public String createProject(@ModelAttribute("project") Project project) {
        projectService.createProject(project);
        return "redirect:/project/list";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Project project = projectService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid Project ID"));
        model.addAttribute("project", project);
        model.addAttribute("clients", clientService.findAll());
        return "project-form";
    }

    @PostMapping("/update/{id}")
    public String updateProject(@PathVariable("id") String id, @ModelAttribute("project") Project project) {
        project.setProjectId(id);
        projectService.updateProject(project);
        return "redirect:/project/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteProject(@PathVariable("id") String id) {
        projectService.deleteProject(id);
        return "redirect:/project/list";
    }
}
