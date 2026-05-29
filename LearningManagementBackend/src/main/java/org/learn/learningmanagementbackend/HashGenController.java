package org.learn.learningmanagementbackend;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HashGenController {
    @GetMapping("/api/hash")
    public String getHash() {
        return new BCryptPasswordEncoder().encode("hash123");
    }
}
