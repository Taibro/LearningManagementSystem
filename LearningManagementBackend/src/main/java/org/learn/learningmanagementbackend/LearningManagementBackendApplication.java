package org.learn.learningmanagementbackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;


@SpringBootApplication
@EnableScheduling
public class LearningManagementBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(LearningManagementBackendApplication.class, args);
    }



}
