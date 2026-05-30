package org.learn.learningmanagementbackend;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HashGenController {
    @GetMapping("/api/auth/hash")
    public String getHash() {
        return new BCryptPasswordEncoder().encode("Admin@123");
    }
}
