package com.project.service;

import com.project.dto.AttendanceAiAnalysis;
import com.project.entity.Attendance;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Local intelligent/rule-based attendance analyzer.
 * It uses historical attendance signals to produce an explainable score.
 */
@Service
public class AttendanceAiService {

    public AttendanceAiAnalysis analyze(List<Attendance> records) {
        AttendanceAiAnalysis r = new AttendanceAiAnalysis();
        if (records == null) records = java.util.Collections.emptyList();

        r.setRecords(records.size());

        long totalMinutes = 0;
        int completed = 0;
        int office = 0;
        int home = 0;
        int late = 0;

        for (Attendance a : records) {
            if ("OFFICE".equalsIgnoreCase(a.getAttendanceType())) office++;
            if ("HOME".equalsIgnoreCase(a.getAttendanceType())) home++;
            if (a.isLate()) late++;
            if (a.getCheckOut() != null) {
                completed++;
                if (a.getWorkedMinutes() != null) totalMinutes += Math.max(0, a.getWorkedMinutes());
            }
        }

        double avgHours = completed == 0 ? 0.0 : (totalMinutes / 60.0) / completed;
        double attendanceRate = Math.min(100.0, records.size() * 100.0 / Math.max(1, records.size()));
        double latePenalty = records.isEmpty() ? 0 : (late * 100.0 / records.size()) * 0.35;
        double hoursScore = completed == 0 ? 50.0 : Math.min(100.0, (avgHours / 8.0) * 100.0);
        double completionRate = records.isEmpty() ? 0 : completed * 100.0 / records.size();

        // Explainable score: regular attendance + completed days + working-hours signal - lateness.
        double score = (attendanceRate * 0.25)
                + (completionRate * 0.25)
                + (hoursScore * 0.35)
                + (Math.max(0, 100 - latePenalty) * 0.15);
        score = Math.max(0, Math.min(100, score));

        String risk;
        if (score >= 85) risk = "LOW RISK";
        else if (score >= 70) risk = "MODERATE RISK";
        else risk = "HIGH RISK";

        String summary;
        if (records.isEmpty()) {
            summary = "No attendance records are available for the selected period.";
        } else {
            summary = String.format(java.util.Locale.US,
                    "Analyzed %d attendance record(s): %d office day(s), %d home day(s), %d late arrival(s), and %d completed checkout(s).",
                    records.size(), office, home, late, completed);
        }

        String recommendation;
        if (records.isEmpty()) {
            recommendation = "Start recording attendance to generate a meaningful analysis.";
        } else if (late >= 3) {
            recommendation = "Monitor punctuality because repeated late arrivals were detected.";
        } else if (avgHours > 0 && avgHours < 7.0) {
            recommendation = "Review working-hour patterns because the average completed day is below 7 hours.";
        } else {
            recommendation = "Attendance pattern is generally healthy; continue regular check-in and check-out.";
        }

        r.setOfficeDays(office);
        r.setHomeDays(home);
        r.setLateDays(late);
        r.setCompletedDays(completed);
        r.setTotalWorkedMinutes(totalMinutes);
        r.setAverageWorkedHours(Math.round(avgHours * 100.0) / 100.0);
        r.setAttendanceScore(Math.round(score * 10.0) / 10.0);
        r.setRiskLevel(risk);
        r.setSummary(summary);
        r.setRecommendation(recommendation);
        return r;
    }
}
