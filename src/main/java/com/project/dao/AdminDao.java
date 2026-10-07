package com.project.dao;

import com.project.entity.Admin;
import java.util.List;
import java.util.Optional;

public interface AdminDao {
    void save(Admin admin);
    void update(Admin admin);
    void delete(Admin admin);

    Optional<Admin> findById(Long id);
    Optional<Admin> findByUsername(String username);
    Optional<Admin> findByEmail(String email);
    List<Admin> findAll();
}