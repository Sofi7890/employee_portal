package com.project.service;

import com.project.entity.Admin;

public interface AuthService {
    String login(String username, String password);
   // Admin getAdminByUsername(String username);
}
