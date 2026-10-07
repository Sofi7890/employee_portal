package com.project.service.impl;

import com.project.dao.AdminDao;
import com.project.dao.ClientDao;
import com.project.dao.EmployeeDao;
import com.project.entity.Admin;
import com.project.entity.Client;
import com.project.entity.Employee;
import com.project.exception.AuthenticationException;
import com.project.security.JwtUtil;
import com.project.service.AuthService;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    private final AdminDao adminDao;
    private final EmployeeDao employeeDao;
    private final ClientDao clientDao;
    private  BCryptPasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    @Autowired
    public AuthServiceImpl(AdminDao adminDao,
                           EmployeeDao employeeDao,
                           ClientDao clientDao,JwtUtil jwtUtil) {
        this.adminDao = adminDao;
        this.employeeDao = employeeDao;
        this.clientDao = clientDao;
        this.jwtUtil = jwtUtil;
    }
    @Autowired // ✅ Add a setter method with @Autowired
    public void setPasswordEncoder(BCryptPasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public String login(String username, String password) {
        // Check Admin
        Admin admin = adminDao.findByUsername(username).orElse(null);
        if (admin != null && passwordEncoder.matches(password, admin.getPassword())) {
            return jwtUtil.generateToken(username);
        }

        // Check Employee
        Employee employee = employeeDao.findByEmail(username).orElse(null);
        if (employee != null && passwordEncoder.matches(password, employee.getPassword())) {
            return jwtUtil.generateToken(username);
        }

        // Check Client
        Client client = clientDao.findById(username).orElse(null);
        if (client != null && passwordEncoder.matches(password, client.getPassword())) {
            return jwtUtil.generateToken(username);
        }

        // If no match found
        throw new AuthenticationException("Invalid credentials");
    }

  
}
