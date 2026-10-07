package com.project.controller1;

import com.project.entity.Admin;
import com.project.service.AdminService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminMvcController {

    private final AdminService adminService;

    @Autowired
    public AdminMvcController(AdminService adminService) {
        this.adminService = adminService;
    }

    /*
     * ============================================================
     * ADMIN LIST
     * ============================================================
     */
    @GetMapping("/list")
    public String listAdmins(Model model) {

        List<Admin> admins = adminService.findAll();

        /*
         * Make sure older records created before the new fields
         * existed still display properly.
         */
        for (Admin admin : admins) {

            if (admin.getStatus() == null ||
                    admin.getStatus().trim().isEmpty()) {

                admin.setStatus("ACTIVE");
            }

            if (admin.getRole() == null ||
                    admin.getRole().trim().isEmpty()) {

                admin.setRole("ROLE_ADMIN");
            }
        }

        long activeCount = admins.stream()
                .filter(a -> "ACTIVE".equalsIgnoreCase(a.getStatus()))
                .count();

        long inactiveCount = admins.stream()
                .filter(a -> "INACTIVE".equalsIgnoreCase(a.getStatus()))
                .count();

        long roleCount = admins.stream()
                .map(Admin::getRole)
                .filter(r -> r != null && !r.trim().isEmpty())
                .distinct()
                .count();

        model.addAttribute("admins", admins);
        model.addAttribute("totalAdmins", admins.size());
        model.addAttribute("activeCount", activeCount);
        model.addAttribute("inactiveCount", inactiveCount);
        model.addAttribute("roleCount", roleCount);

        return "admin-list";
    }


    /*
     * ============================================================
     * CREATE ADMIN
     * ============================================================
     */
    @GetMapping("/create")
    public String showCreateForm(Model model) {

        Admin admin = new Admin();

        admin.setRole("ROLE_ADMIN");
        admin.setStatus("ACTIVE");

        model.addAttribute("admin", admin);

        return "admin-form";
    }


    /*
     * ============================================================
     * SAVE NEW ADMIN
     * ============================================================
     */
    @PostMapping("/create")
    public String createAdmin(
            @ModelAttribute("admin") Admin admin) {

        if (admin.getRole() == null ||
                admin.getRole().trim().isEmpty()) {

            admin.setRole("ROLE_ADMIN");
        }

        if (admin.getStatus() == null ||
                admin.getStatus().trim().isEmpty()) {

            admin.setStatus("ACTIVE");
        }

        adminService.createAdmin(admin);

        return "redirect:/admin/list";
    }


    /*
     * ============================================================
     * EDIT ADMIN
     * ============================================================
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(
            @PathVariable("id") Long id,
            Model model) {

        Admin admin = adminService.findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException("Invalid Admin ID"));

        if (admin.getStatus() == null ||
                admin.getStatus().trim().isEmpty()) {

            admin.setStatus("ACTIVE");
        }

        if (admin.getRole() == null ||
                admin.getRole().trim().isEmpty()) {

            admin.setRole("ROLE_ADMIN");
        }

        model.addAttribute("admin", admin);

        return "admin-form";
    }


    /*
     * ============================================================
     * UPDATE ADMIN
     * ============================================================
     */
    @PostMapping("/update/{id}")
    public String updateAdmin(
            @PathVariable("id") Long id,
            @ModelAttribute("admin") Admin admin) {

        /*
         * Get existing record first so fields that are not present
         * in the form are not accidentally lost.
         */
        Admin existing = adminService.findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException("Invalid Admin ID"));

        admin.setAdminId(id);

        /*
         * Preserve password when edit form does not provide one.
         */
        if (admin.getPassword() == null ||
                admin.getPassword().trim().isEmpty()) {

            admin.setPassword(existing.getPassword());
        }

        /*
         * Preserve created date.
         */
        if (admin.getCreatedDate() == null) {
            admin.setCreatedDate(existing.getCreatedDate());
        }

        /*
         * Preserve last login.
         */
        admin.setLastLogin(existing.getLastLogin());

        /*
         * Default values.
         */
        if (admin.getStatus() == null ||
                admin.getStatus().trim().isEmpty()) {

            admin.setStatus(existing.getStatus());

            if (admin.getStatus() == null ||
                    admin.getStatus().trim().isEmpty()) {

                admin.setStatus("ACTIVE");
            }
        }

        if (admin.getRole() == null ||
                admin.getRole().trim().isEmpty()) {

            admin.setRole(existing.getRole());

            if (admin.getRole() == null ||
                    admin.getRole().trim().isEmpty()) {

                admin.setRole("ROLE_ADMIN");
            }
        }

        adminService.updateAdmin(admin);

        return "redirect:/admin/list";
    }


    /*
     * ============================================================
     * DELETE ADMIN
     * ============================================================
     */
    @GetMapping("/delete/{id}")
    public String deleteAdmin(
            @PathVariable("id") Long id) {

        adminService.findById(id)
                .ifPresent(adminService::deleteAdmin);

        return "redirect:/admin/list";
    }


    /*
     * ============================================================
     * ADMIN 360° DETAILS
     * ============================================================
     */
    @GetMapping("/details/{id}")
    public String adminDetails(
            @PathVariable("id") Long id,
            Model model) {

        Admin admin = adminService.findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException("Invalid Admin ID"));

        if (admin.getStatus() == null ||
                admin.getStatus().trim().isEmpty()) {

            admin.setStatus("ACTIVE");
        }

        if (admin.getRole() == null ||
                admin.getRole().trim().isEmpty()) {

            admin.setRole("ROLE_ADMIN");
        }

        model.addAttribute("admin", admin);

        return "admin-details";
    }


    /*
     * ============================================================
     * FIND ADMIN BY USERNAME
     * ============================================================
     */
    @GetMapping("/username/{username}")
    public String findByUsername(
            @PathVariable("username") String username,
            Model model) {

        Admin admin =
                adminService.findByUsername(username)
                        .orElse(null);

        model.addAttribute("admin", admin);
        model.addAttribute("searchedUsername", username);

        return "admin-search-result";
    }
}