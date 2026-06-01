package org.learn.learningmanagementbackend.service;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.SchoolOptionResponse;
import org.learn.learningmanagementbackend.repository.SaasAdminRepository.SchoolRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PublicSchoolService {

    private final SchoolRepository schoolRepository;

    public List<SchoolOptionResponse> getActiveSchools() {
        return schoolRepository.findAll()
                .stream()
                .filter(school -> school.getIsActive() == null || school.getIsActive())
                .map(school -> new SchoolOptionResponse(school.getShortName(), school.getName()))
                .collect(Collectors.toList());
    }
}
