package com.project.dto;

/**
 * Result of the local AI-style attendance analysis.
 * This is intentionally dependency-free so the project remains easy to deploy.
 */
public class AttendanceAiAnalysis {
    private int records;
    private int officeDays;
    private int homeDays;
    private int lateDays;
    private int completedDays;
    private long totalWorkedMinutes;
    private double averageWorkedHours;
    private double attendanceScore;
    private String riskLevel;
    private String summary;
    private String recommendation;

    public int getRecords(){ return records; }
    public void setRecords(int records){ this.records=records; }
    public int getOfficeDays(){ return officeDays; }
    public void setOfficeDays(int officeDays){ this.officeDays=officeDays; }
    public int getHomeDays(){ return homeDays; }
    public void setHomeDays(int homeDays){ this.homeDays=homeDays; }
    public int getLateDays(){ return lateDays; }
    public void setLateDays(int lateDays){ this.lateDays=lateDays; }
    public int getCompletedDays(){ return completedDays; }
    public void setCompletedDays(int completedDays){ this.completedDays=completedDays; }
    public long getTotalWorkedMinutes(){ return totalWorkedMinutes; }
    public void setTotalWorkedMinutes(long totalWorkedMinutes){ this.totalWorkedMinutes=totalWorkedMinutes; }
    public double getAverageWorkedHours(){ return averageWorkedHours; }
    public void setAverageWorkedHours(double averageWorkedHours){ this.averageWorkedHours=averageWorkedHours; }
    public double getAttendanceScore(){ return attendanceScore; }
    public void setAttendanceScore(double attendanceScore){ this.attendanceScore=attendanceScore; }
    public String getRiskLevel(){ return riskLevel; }
    public void setRiskLevel(String riskLevel){ this.riskLevel=riskLevel; }
    public String getSummary(){ return summary; }
    public void setSummary(String summary){ this.summary=summary; }
    public String getRecommendation(){ return recommendation; }
    public void setRecommendation(String recommendation){ this.recommendation=recommendation; }
}
