package org.learn.learningmanagementbackend.service.LecturerService;

import lombok.RequiredArgsConstructor;
import org.learn.learningmanagementbackend.dto.response.TeachingStatisticResponse;
import org.learn.learningmanagementbackend.enums.ScheduleType;
import org.learn.learningmanagementbackend.model.Classes;
import org.learn.learningmanagementbackend.model.Schedule;
import org.learn.learningmanagementbackend.model.Semester;
import org.learn.learningmanagementbackend.repository.LecturerRepository.ClassRepository;
import org.learn.learningmanagementbackend.repository.LecturerRepository.SemesterRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TeachingStatisticService {

    private final ClassRepository classRepository;
    private final SemesterRepository semesterRepository;

    // Đã xóa tham số semesterId
    public TeachingStatisticResponse getDashboardStatistics(String teacherCode) {

        // Tự động lấy Học kỳ mới nhất
        Semester semester = semesterRepository.findTopByOrderByStartDateDesc()
                .orElseThrow(() -> new RuntimeException("Hệ thống chưa có dữ liệu Học kỳ"));

        String semesterLabel = semester.getName() + " - " + semester.getAcademicYear().getName();

        // Lấy dữ liệu Lớp học & Lịch học theo học kỳ mới nhất
        List<Classes> classes = classRepository.findClassesWithSchedulesByTeacherAndSemester(teacherCode, semester.getId());

        int totalTheory = 0, totalLab = 0, totalExam = 0, upcomingExam = 0;
        int totalCompletedPeriods = 0, totalAllPeriods = 0;
        LocalDate today = LocalDate.now();

        List<TeachingStatisticResponse.ClassTeachingDetail> classDetails = new ArrayList<>();
        Map<Integer, Integer> monthlyPeriodsMap = new TreeMap<>(); // Dùng TreeMap để tự động sắp xếp Tháng tăng dần

        // Xử lý logic từng Lớp học
        for (Classes cls : classes) {
            int classTotalPeriods = 0;
            int classCompletedPeriods = 0;

            for (Schedule schedule : cls.getSchedules()) {
                int start = schedule.getStartPeriod() != null ? schedule.getStartPeriod() : 0;
                int end = schedule.getEndPeriod() != null ? schedule.getEndPeriod() : 0;
                int periodsPerSession = (start > 0 && end > 0) ? (end - start + 1) : 0;

                LocalDate loopDate = schedule.getStartDate();
                while (loopDate != null && schedule.getEndDate() != null && !loopDate.isAfter(schedule.getEndDate())) {
                    
                    // Chuyển đổi DayOfWeek của Java (1=Mon, 7=Sun) sang kiểu của DB (2=Mon, 8=Sun)
                    int javaDow = loopDate.getDayOfWeek().getValue();
                    int vietnameseDow = (javaDow == 7) ? 8 : (javaDow + 1); // Giả sử Chủ nhật là 8 trong DB, nếu Chủ nhật là 1 thì dùng javaDow == 7 ? 1 : javaDow + 1

                    if (schedule.getDayOfWeek() != null && 
                       (vietnameseDow == schedule.getDayOfWeek() || (javaDow == 7 && schedule.getDayOfWeek() == 1))) {

                        // Phân loại đếm tổng số tiết
                        if (schedule.getType() == ScheduleType.REGULAR || schedule.getType() == ScheduleType.SEMINAR) {
                            totalTheory += periodsPerSession;
                        } else if (schedule.getType() == ScheduleType.LAB) {
                            totalLab += periodsPerSession;
                        }

                        // Xử lý coi thi
                        if (schedule.getType() == ScheduleType.EXAM) {
                            totalExam += 1; // Coi thi đếm theo ca
                            if (loopDate.isAfter(today)) upcomingExam += 1;
                        } else {
                            // Cập nhật số liệu cho lớp và tổng thể
                            classTotalPeriods += periodsPerSession;
                            if (!loopDate.isAfter(today)) {
                                classCompletedPeriods += periodsPerSession;
                            }

                            // Ghi nhận dữ liệu thực tế cho Biểu đồ
                            int month = loopDate.getMonthValue();
                            monthlyPeriodsMap.put(month, monthlyPeriodsMap.getOrDefault(month, 0) + periodsPerSession);
                        }
                    }
                    loopDate = loopDate.plusDays(1); // Sang ngày tiếp theo
                }
            }

            // Ghi nhận chi tiết từng môn cho Bảng dữ liệu
            if (classTotalPeriods > 0) {
                int progress = (int) Math.round((double) classCompletedPeriods / classTotalPeriods * 100);
                
                String courseName = cls.getCourse() != null ? cls.getCourse().getName() : "Không rõ môn học";

                classDetails.add(TeachingStatisticResponse.ClassTeachingDetail.builder()
                        .subjectName(courseName + (cls.getSchedules().stream().anyMatch(s -> s.getType() == ScheduleType.LAB) ? " (TH)" : " (LT)"))
                        .classCode(cls.getCode())
                        .completedPeriods(classCompletedPeriods)
                        .totalPeriods(classTotalPeriods)
                        .progressPercentage(progress)
                        .build());

                totalCompletedPeriods += classCompletedPeriods;
                totalAllPeriods += classTotalPeriods;
            }
        }

        // Tổng hợp số liệu Top Cards
        int totalPeriods = totalTheory + totalLab;
        int theoryPct = totalPeriods == 0 ? 0 : (int) Math.round((double) totalTheory / totalPeriods * 100);
        int labPct = totalPeriods == 0 ? 0 : (100 - theoryPct);
        int overallProgress = totalAllPeriods == 0 ? 0 : (int) Math.round((double) totalCompletedPeriods / totalAllPeriods * 100);

        // Chuyển đổi Map thành List cho Biểu đồ
        List<TeachingStatisticResponse.MonthlyChartData> chartData = monthlyPeriodsMap.entrySet().stream()
                .map(entry -> TeachingStatisticResponse.MonthlyChartData.builder()
                        .month("T" + entry.getKey()) // Hiển thị "T1", "T2"...
                        .periods(entry.getValue())
                        .build())
                .collect(Collectors.toList());

        // Nhắc nhở tự động
        List<String> reminders = new ArrayList<>();
        reminders.add("Đã hoàn thành " + overallProgress + "% kế hoạch học kỳ.");
        if (upcomingExam > 0) {
            reminders.add("Có " + upcomingExam + " ca coi thi sắp tới.");
        }

        // Đóng gói trả về
        return TeachingStatisticResponse.builder()
                .currentSemesterLabel(semesterLabel)
                .totalPeriods(totalPeriods)
                .theoryPeriods(totalTheory)
                .theoryPercentage(theoryPct)
                .labPeriods(totalLab)
                .labPercentage(labPct)
                .examShifts(totalExam)
                .upcomingExamShifts(upcomingExam)
                .chartData(chartData) // Dữ liệu thật 100%
                .overallProgress(overallProgress)
                .reminders(reminders)
                .classDetails(classDetails)
                .build();
    }
}