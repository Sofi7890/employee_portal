package com.project.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.AdminDao;
import com.project.entity.Admin;
import com.project.exception.DuplicateEntityException;
import com.project.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {

    private final AdminDao adminDao;
   // private final BCryptPasswordEncoder passwordEncoder;
    private  BCryptPasswordEncoder passwordEncoder;

    /*@Autowired
    public AdminServiceImpl(AdminDao adminDao, BCryptPasswordEncoder passwordEncoder) {
        this.adminDao = adminDao;
        this.passwordEncoder = passwordEncoder;
    }*/
    @Autowired
    public AdminServiceImpl(AdminDao adminDao) { // Keep constructor injection for AdminDao
        this.adminDao = adminDao;
    }

    @Autowired // Add a setter method with @Autowired
    public void setPasswordEncoder(BCryptPasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void createAdmin(Admin admin) {
        if (admin == null) throw new IllegalArgumentException("admin is required");
        if (admin.getUsername() == null || admin.getUsername().trim().isEmpty()) throw new IllegalArgumentException("username required");
        if (admin.getPassword() == null || admin.getPassword().trim().isEmpty()) throw new IllegalArgumentException("password required");
        if (admin.getRole() == null || admin.getRole().trim().isEmpty()) {
            admin.setRole("ROLE_ADMIN");
        }
        if (adminDao.findByUsername(admin.getUsername()).isPresent()) {
            throw new DuplicateEntityException("username already exists");
        }

        admin.setPassword(passwordEncoder.encode(admin.getPassword()));
        adminDao.save(admin);
    }

   /* @Override
    @Transactional
    public void updateAdmin(Admin admin) {
        if (admin == null || admin.getAdminId() == null) throw new IllegalArgumentException("admin.adminId required");
        if (admin.getPassword() == null || admin.getPassword().trim().isEmpty()) {
            adminDao.findById(admin.getAdminId()).ifPresent(existing -> admin.setPassword(existing.getPassword()));
        } else {
            admin.setPassword(passwordEncoder.encode(admin.getPassword()));
        }
        adminDao.update(admin);
    }*/
    @Override
    @Transactional
    public void updateAdmin(Admin admin) {

        if (admin == null || admin.getAdminId() == null) {
            throw new IllegalArgumentException("admin.adminId required");
        }

        Optional<Admin> existingOpt = adminDao.findById(admin.getAdminId());

        if (!existingOpt.isPresent()) {
            throw new IllegalArgumentException("Admin not found: " + admin.getAdminId());
        }

        Admin existing = existingOpt.get();

        existing.setUsername(admin.getUsername());
        existing.setEmail(admin.getEmail());
        existing.setRole(admin.getRole());

        if (admin.getPassword() != null && !admin.getPassword().trim().isEmpty()) {
            existing.setPassword(passwordEncoder.encode(admin.getPassword()));
        }

        adminDao.update(existing);
    }

    @Override
    @Transactional
    public void deleteAdmin(Admin admin) {
        if (admin == null || admin.getAdminId() == null) throw new IllegalArgumentException("admin.adminId required");
        adminDao.delete(admin);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Admin> findById(Long id) {
        return adminDao.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Admin> findByUsername(String username) {
        return adminDao.findByUsername(username);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Admin> findByEmail(String email) {
        return adminDao.findByEmail(email);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Admin> findAll() {
        return adminDao.findAll();
    }


}
