package com.project.service;

import com.project.dao.AdminDao;
import com.project.dao.ClientDao;
import com.project.dao.EmployeeDao;
import com.project.entity.Admin;
import com.project.entity.Client;
import com.project.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired private AdminDao adminDao;
    @Autowired private EmployeeDao employeeDao;
    @Autowired private ClientDao clientDao;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Try Admin first
        Admin admin = adminDao.findByUsername(username).orElse(null);
        if (admin != null) {
            GrantedAuthority authority = new SimpleGrantedAuthority(admin.getRole());
            return new User(admin.getUsername(), admin.getPassword(), Collections.singletonList(authority));
        }

        // Try Employee (by email)
        Employee employee = employeeDao.findByEmail(username).orElse(null);
        if (employee != null) {
            GrantedAuthority authority = new SimpleGrantedAuthority(employee.getRole());
            return new User(employee.getEmployeeEmail(), employee.getPassword(), Collections.singletonList(authority));
        }

        // Try Client (by clientId for login OR we can also add email)
        Client client = clientDao.findById(username).orElse(null);
        if (client != null) {
            GrantedAuthority authority = new SimpleGrantedAuthority(client.getRole());
            return new User(client.getClientId(), client.getPassword(), Collections.singletonList(authority));
        }

        throw new UsernameNotFoundException("User not found: " + username);
    }
}

