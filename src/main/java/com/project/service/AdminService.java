package com.project.service;

import com.project.entity.Admin;

import java.util.List;
import java.util.Optional;

public interface AdminService {
    void createAdmin(Admin admin);
    void updateAdmin(Admin admin);
    void deleteAdmin(Admin admin);
    Optional<Admin> findById(Long id);
    Optional<Admin> findByUsername(String username);
    Optional<Admin> findByEmail(String email);
    List<Admin> findAll();
}
