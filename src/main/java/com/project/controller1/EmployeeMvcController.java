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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import com.project.entity.Employee;
import com.project.service.EmployeeService;
import com.project.service.ProjectService;

@Controller
@RequestMapping("/employee")
public class EmployeeMvcController {

    private final EmployeeService employeeService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    public EmployeeMvcController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    private boolean isAdmin(HttpSession session) { return "ROLE_ADMIN".equals(session.getAttribute("role")); }

    // =========================================================
    // EMPLOYEE LIST
    // =========================================================

    @GetMapping("/list")
    public String listEmployees(Model model, HttpSession session) {

        if (!isAdmin(session)) return "redirect:/dashboard";
        List<Employee> employees = employeeService.findAll();

        model.addAttribute("employees", employees);
        model.addAttribute("projects", projectService.findAll());
        model.addAttribute("filterCount", employees.size());
        model.addAttribute("assignedCount", employees.stream().filter(e -> e.getProject() != null).count());
        model.addAttribute("benchCount", employees.stream().filter(e -> e.getProject() == null).count());
        model.addAttribute("departments", employees.stream().map(Employee::getEmployeeDept).filter(java.util.Objects::nonNull).filter(x -> !x.trim().isEmpty()).collect(java.util.stream.Collectors.toCollection(java.util.TreeSet::new)));
        model.addAttribute("roles", employees.stream().map(Employee::getRole).filter(java.util.Objects::nonNull).filter(x -> !x.trim().isEmpty()).collect(java.util.stream.Collectors.toCollection(java.util.TreeSet::new)));
        model.addAttribute("statuses", employees.stream().map(Employee::getEmploymentStatus).filter(java.util.Objects::nonNull).filter(x -> !x.trim().isEmpty()).collect(java.util.stream.Collectors.toCollection(java.util.TreeSet::new)));

        return "employee-list";
    }

    // =========================================================
    // EMPLOYEE SEARCH + SORT
    // =========================================================

    @GetMapping("/search")
    public String searchEmployees(
            @RequestParam(value = "q", required = false, defaultValue = "") String q,
            @RequestParam(value = "sort", required = false, defaultValue = "") String sort,
            @RequestParam(value = "department", required = false, defaultValue = "") String department,
            @RequestParam(value = "status", required = false, defaultValue = "") String status,
            @RequestParam(value = "roleFilter", required = false, defaultValue = "") String roleFilter,
            @RequestParam(value = "project", required = false, defaultValue = "") String project,
            Model model, HttpSession session) {

        if (!isAdmin(session)) return "redirect:/dashboard";

        List<Employee> all = employeeService.findAll();
        List<Employee> employees = new java.util.ArrayList<>(all);

        if (!q.trim().isEmpty()) {
            String search = q.trim().toLowerCase();
            employees.removeIf(emp ->
                !containsIgnoreCase(emp.getEmployeeId(), search)
                && !containsIgnoreCase(emp.getEmployeeName(), search)
                && !containsIgnoreCase(emp.getEmployeeEmail(), search)
                && !containsIgnoreCase(emp.getEmployeeDept(), search));
        }
        if (!department.trim().isEmpty()) employees.removeIf(e -> !department.equalsIgnoreCase(e.getEmployeeDept()));
        if (!status.trim().isEmpty()) employees.removeIf(e -> !status.equalsIgnoreCase(e.getEmploymentStatus()));
        if (!roleFilter.trim().isEmpty()) employees.removeIf(e -> !roleFilter.equalsIgnoreCase(e.getRole()));
        if (!project.trim().isEmpty()) {
            if ("BENCH".equalsIgnoreCase(project)) employees.removeIf(e -> e.getProject() != null);
            else employees.removeIf(e -> e.getProject() == null || !project.equals(e.getProject().getProjectId()));
        }

        if ("name".equalsIgnoreCase(sort)) employees.sort((a,b) -> String.valueOf(a.getEmployeeName()).compareToIgnoreCase(String.valueOf(b.getEmployeeName())));
        else if ("joining".equalsIgnoreCase(sort)) employees.sort((a,b) -> {
            if (a.getDateOfJoining() == null && b.getDateOfJoining() == null) return 0;
            if (a.getDateOfJoining() == null) return 1;
            if (b.getDateOfJoining() == null) return -1;
            return b.getDateOfJoining().compareTo(a.getDateOfJoining());
        });

        model.addAttribute("employees", employees);
        model.addAttribute("projects", projectService.findAll());
        model.addAttribute("q", q);
        model.addAttribute("sort", sort);
        model.addAttribute("department", department);
        model.addAttribute("status", status);
        model.addAttribute("roleFilter", roleFilter);
        model.addAttribute("project", project);
        model.addAttribute("filterCount", employees.size());
        model.addAttribute("assignedCount", employees.stream().filter(e -> e.getProject() != null).count());
        model.addAttribute("benchCount", employees.stream().filter(e -> e.getProject() == null).count());
        model.addAttribute("departments", all.stream().map(Employee::getEmployeeDept).filter(java.util.Objects::nonNull).filter(x -> !x.trim().isEmpty()).collect(java.util.stream.Collectors.toCollection(java.util.TreeSet::new)));
        model.addAttribute("roles", all.stream().map(Employee::getRole).filter(java.util.Objects::nonNull).filter(x -> !x.trim().isEmpty()).collect(java.util.stream.Collectors.toCollection(java.util.TreeSet::new)));
        model.addAttribute("statuses", all.stream().map(Employee::getEmploymentStatus).filter(java.util.Objects::nonNull).filter(x -> !x.trim().isEmpty()).collect(java.util.stream.Collectors.toCollection(java.util.TreeSet::new)));

        return "employee-list";
    }

    // =========================================================
    // HELPER METHOD FOR SEARCH
    // =========================================================

    private boolean containsIgnoreCase(String value, String search) {

        if (value == null || search == null) {
            return false;
        }

        return value.toLowerCase().contains(search);
    }

    // =========================================================
    // CREATE EMPLOYEE
    // =========================================================

    @GetMapping("/create")
    public String showCreateForm(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/dashboard";

        model.addAttribute("employee", new Employee());
        model.addAttribute("projects", projectService.findAll());

        return "employee-form";
    }

    @PostMapping("/create")
    public String createEmployee(
            @ModelAttribute("employee") Employee employee,
            @RequestParam(value = "image", required = false) MultipartFile image,
            HttpSession session) {
        if (!isAdmin(session)) return "redirect:/dashboard";

        Employee saved = employeeService.createEmployee(employee);
        saveEmployeeImage(saved, image);

        return "redirect:/employee/list";
    }

    // =========================================================
    // EDIT EMPLOYEE
    // =========================================================

    @GetMapping("/edit/{id}")
    public String showEditForm(
            @PathVariable("id") String id,
            Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/dashboard";

        Employee employee = employeeService.findById(id)
                .orElseThrow(() ->
                    new IllegalArgumentException(
                        "Invalid Employee ID: " + id
                    )
                );

        model.addAttribute("employee", employee);
        model.addAttribute("projects", projectService.findAll());

        return "employee-form";
    }

    // =========================================================
    // UPDATE EMPLOYEE
    // =========================================================

    @PostMapping("/update/{id}")
    public String updateEmployee(
            @PathVariable("id") String id,
            @ModelAttribute("employee") Employee employee,
            @RequestParam(value = "image", required = false) MultipartFile image,
            HttpSession session) {
        if (!isAdmin(session)) return "redirect:/dashboard";

        employee.setEmployeeId(id);

        employeeService.updateEmployee(employee);
        saveEmployeeImage(employee, image);

        return "redirect:/employee/list";
    }

    // =========================================================
    // DELETE EMPLOYEE
    // =========================================================

    @GetMapping("/delete/{id}")
    public String deleteEmployee(
            @PathVariable("id") String id, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/dashboard";

        employeeService.findById(id)
                .ifPresent(emp ->
                    employeeService.deleteEmployee(
                        emp.getEmployeeId()
                    )
                );

        return "redirect:/employee/list";
    }

    // =========================================================
    // EMPLOYEE IMAGE UPLOAD / DISPLAY
    // =========================================================

    private void saveEmployeeImage(Employee employee, MultipartFile image) {
        if (employee == null || image == null || image.isEmpty()) {
            return;
        }

        String contentType = image.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return;
        }

        try {
            Path dir = Paths.get(System.getProperty("user.home"), "ems-uploads", "employee-images");
            Files.createDirectories(dir);

            String old = employee.getImagePath();
            if (old != null && !old.trim().isEmpty()) {
                Files.deleteIfExists(dir.resolve(Paths.get(old).getFileName().toString()));
            }

            String extension = "";
            String original = image.getOriginalFilename();
            if (original != null && original.lastIndexOf('.') >= 0) {
                extension = original.substring(original.lastIndexOf('.')).toLowerCase();
                if (!extension.matches("\\.(jpg|jpeg|png|gif|webp)")) {
                    extension = ".jpg";
                }
            } else {
                extension = ".jpg";
            }

            String fileName = employee.getEmployeeId() + "-" + UUID.randomUUID() + extension;
            image.transferTo(dir.resolve(fileName).toFile());
            employeeService.updateImagePath(employee.getEmployeeId(), fileName);
        } catch (Exception ignored) {
            // Employee creation/update remains successful even if optional image storage fails.
        }
    }

    @GetMapping("/image/{id}")
    public void employeeImage(@PathVariable("id") String id,
                              HttpServletResponse response) {
        Employee employee = employeeService.findById(id).orElse(null);
        if (employee == null || employee.getImagePath() == null || employee.getImagePath().trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        try {
            Path file = Paths.get(System.getProperty("user.home"), "ems-uploads", "employee-images",
                    Paths.get(employee.getImagePath()).getFileName().toString());

            if (!Files.exists(file)) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            String contentType = Files.probeContentType(file);
            response.setContentType(contentType == null ? MediaType.APPLICATION_OCTET_STREAM_VALUE : contentType);
            Files.copy(file, response.getOutputStream());
        } catch (Exception ex) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // =========================================================
    // GET EMPLOYEE BY EMAIL
    // =========================================================

    @GetMapping("/email/{email}")
    public String getEmployeeByEmail(
            @PathVariable("email") String email,
            Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/dashboard";

        Employee employee = employeeService.findByEmail(email)
                .orElseThrow(() ->
                    new IllegalArgumentException(
                        "Employee not found"
                    )
                );

        model.addAttribute("employee", employee);

        return "employee-detail";
    }
}