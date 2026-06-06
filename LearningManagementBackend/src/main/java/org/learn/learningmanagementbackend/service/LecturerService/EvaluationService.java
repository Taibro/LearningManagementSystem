package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.EvaluationDashboardResponse;
import org.learn.learningmanagementbackend.model.Semester;
import org.learn.learningmanagementbackend.model.TeacherEvaluation;
import org.learn.learningmanagementbackend.repository.LecturerRepository.TeacherEvaluationRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.SemesterRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class EvaluationService {

    private final TeacherEvaluationRepository evaluationRepository;
    private final SemesterRepository semesterRepository;

    public EvaluationDashboardResponse getDashboardData(String teacherCode) {

        // Tự động lấy Học kỳ mới nhất
        Semester latestSemester = semesterRepository.findTopByOrderByStartDateDesc()
                .orElseThrow(() -> new RuntimeException("Chưa có dữ liệu Học kỳ"));

        // Lấy toàn bộ phiếu khảo sát
        List<TeacherEvaluation> evaluations = evaluationRepository
                .findEvaluationsByTeacherAndSemester(teacherCode, latestSemester.getId());

        if (evaluations.isEmpty()) {
            return EvaluationDashboardResponse.builder().comments(new ArrayList<>()).build();
        }

        int totalResponses = evaluations.size();
        long surveyedClasses = evaluations.stream().map(e -> e.getClasses().getId()).distinct().count();

        double sumKnowledge = 0, sumMethod = 0, sumInteraction = 0, sumMaterials = 0, sumPunctuality = 0;
        int satisfiedCount = 0; // Số phiếu có điểm TB >= 4.0

        List<EvaluationDashboardResponse.StudentComment> comments = new ArrayList<>();

        // Duyệt và tính toán
        for (TeacherEvaluation eval : evaluations) {
            sumKnowledge += eval.getScoreKnowledge();
            sumMethod += eval.getScoreMethod();
            sumInteraction += eval.getScoreInteraction();
            sumMaterials += eval.getScoreMaterials();
            sumPunctuality += eval.getScorePunctuality();

            // Điểm TB của 1 phiếu
            double avgSingle = (eval.getScoreKnowledge() + eval.getScoreMethod() +
                    eval.getScoreInteraction() + eval.getScoreMaterials() +
                    eval.getScorePunctuality()) / 5.0;
            if (avgSingle >= 4.0) {
                satisfiedCount++;
            }

            // Ghi nhận Comment
            if (eval.getComment() != null && !eval.getComment().trim().isEmpty()) {
                comments.add(EvaluationDashboardResponse.StudentComment.builder()
                        .classCode(eval.getClasses().getCode())
                        .author("ẩn danh") // STRICTLY ANONYMOUS
                        .content(eval.getComment())
                        .build());
            }
        }

        // Tính Điểm TB cho từng tiêu chí
        double avgKnowledge = roundTo1Decimals(sumKnowledge / totalResponses);
        double avgMethod = roundTo1Decimals(sumMethod / totalResponses);
        double avgInteraction = roundTo1Decimals(sumInteraction / totalResponses);
        double avgMaterials = roundTo1Decimals(sumMaterials / totalResponses);
        double avgPunctuality = roundTo1Decimals(sumPunctuality / totalResponses);

        // Tính Điểm TB Tổng & % Hài lòng
        double averageScore = roundTo1Decimals(
                (avgKnowledge + avgMethod + avgInteraction + avgMaterials + avgPunctuality) / 5.0);
        int satisfactionRate = (int) Math.round((double) satisfiedCount / totalResponses * 100);

        return EvaluationDashboardResponse.builder()
                .averageScore(averageScore)
                .satisfactionRate(satisfactionRate)
                .surveyedClasses((int) surveyedClasses)
                .totalResponses(totalResponses)
                .criteriaKnowledge(avgKnowledge)
                .criteriaMethod(avgMethod)
                .criteriaInteraction(avgInteraction)
                .criteriaMaterials(avgMaterials)
                .criteriaPunctuality(avgPunctuality)
                .comments(comments)
                .build();
    }

    private double roundTo1Decimals(double value) {
        return Math.round(value * 10.0) / 10.0;
    }
}