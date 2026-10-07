
package com.project.controller1;

import com.project.entity.Admin;
import com.project.entity.Client;
import com.project.entity.Employee;
import com.project.service.AdminService;
import com.project.service.AuthService;
import com.project.service.ClientService;
import com.project.service.EmployeeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Collections;

@Controller
@RequestMapping("/auth")
public class AuthMvcController {

    private final AdminService adminService;
    private final EmployeeService employeeService;
    private final ClientService clientService;
    private final AuthService authService;

    @Autowired
    public AuthMvcController(AdminService adminService,
                             EmployeeService employeeService,
                             ClientService clientService,
                             AuthService authService) {
        this.adminService = adminService;
        this.employeeService = employeeService;
        this.clientService = clientService;
        this.authService = authService;
    }

    // Show login page
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("username", "");
        return "login";
    }

    // Process login
    @PostMapping({"/login", "/"})
    public String login(
            @RequestParam(value = "username", required = false)
            String username,

            @RequestParam(value = "password", required = false)
            String password,

            Model model,
            HttpSession session) {

        // 1. Validate empty inputs
        if (username == null || username.trim().isEmpty()) {
            model.addAttribute("error",
                    "Please enter your username, email, or client ID.");
            return returnLogin(model, username);
        }

        if (password == null || password.trim().isEmpty()) {
            model.addAttribute("error",
                    "Please enter your password.");
            return returnLogin(model, username);
        }

        username = username.trim();

        // 2. Find account and identify role
        String role = null;
        String displayName = null;
        boolean accountFound = false;

        Admin admin = adminService
                .findByUsername(username)
                .orElse(null);

        if (admin != null) {
            accountFound = true;
            role = admin.getRole();
            displayName = admin.getUsername();

        } else {

            Employee employee = employeeService
                    .findByEmail(username)
                    .orElse(null);

            if (employee != null) {
                accountFound = true;
                role = employee.getRole();
                displayName = employee.getEmployeeName();

            } else {

                Client client = clientService
                        .findById(username)
                        .orElse(null);

                if (client != null) {
                    accountFound = true;
                    role = client.getRole();
                    displayName = client.getClientName();
                }
            }
        }

        // 3. Account does not exist
        if (!accountFound) {
            model.addAttribute("error",
                    "No account found. Please check your login details.");

            return returnLogin(model, username);
        }

        // 4. Verify role
        if (role == null || role.trim().isEmpty()) {
            model.addAttribute("error",
                    "Your account role is not configured. Contact the administrator.");

            return returnLogin(model, username);
        }

        try {
            // 5. Verify password using existing AuthService
            String token = authService.login(username, password);

            if (token == null || token.trim().isEmpty()) {
                model.addAttribute("error",
                        "Invalid username or password.");

                return returnLogin(model, username);
            }

            // 6. Create Spring Security authentication
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(
                            username,
                            null,
                            Collections.singletonList(
                                    new SimpleGrantedAuthority(role)
                            )
                    );

            SecurityContextHolder.getContext()
                    .setAuthentication(authentication);

            // 7. Store login information in session
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("displayName", displayName);
            session.setAttribute("jwt", token);

            // 8. Redirect after successful login
            return "redirect:/dashboard";

        } catch (Exception e) {

            // Invalid credentials or authentication failure
            SecurityContextHolder.clearContext();

            model.addAttribute("error",
                    "Invalid username or password.");

            return returnLogin(model, username);
        }
    }

    // Reusable login page response
    private String returnLogin(Model model, String username) {
        model.addAttribute("username",
                username == null ? "" : username);
        return "login";
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {

        session.invalidate();

        SecurityContextHolder.clearContext();

        return "redirect:/auth/login";
    }
}
