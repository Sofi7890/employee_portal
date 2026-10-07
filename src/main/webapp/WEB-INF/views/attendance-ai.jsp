<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AI Attendance Analysis</title>

<!-- Google Fonts & Icons -->
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --bg-primary: #0b0f19;
        --bg-secondary: #111827;
        --bg-card: #1f2937;
        --border-color: rgba(255, 255, 255, 0.08);
        --border-hover: rgba(99, 102, 241, 0.4);
        --text-main: #f3f4f6;
        --text-muted: #9ca3af;
        --accent-primary: #6366f1;
        --accent-secondary: #06b6d4;
        --accent-glow: rgba(99, 102, 241, 0.25);
        --success: #10b981;
        --danger: #ef4444;
        --warning: #f59e0b;
        --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    html {
        scroll-behavior: smooth;
    }

    body {
        font-family: 'Plus Jakarta Sans', sans-serif;
        background-color: var(--bg-primary);
        color: var(--text-main);
        min-height: 100vh;
        background-image: 
            radial-gradient(circle at 10% 10%, rgba(99, 102, 241, 0.08) 0%, transparent 40%),
            radial-gradient(circle at 90% 90%, rgba(6, 182, 212, 0.06) 0%, transparent 40%);
        background-attachment: fixed;
        animation: fadeIn 0.8s ease-out;
        padding: 40px 20px;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .container {
        max-width: 1050px;
        margin: auto;
    }

    /* Cards */
    .card {
        background: var(--bg-card);
        border: 1px solid var(--border-color);
        border-radius: 24px;
        padding: 32px;
        margin-bottom: 24px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        position: relative;
        overflow: hidden;
        animation: slideUp 0.6s ease;
    }

    .card::after {
        content: '';
        position: absolute;
        top: 0; left: 0; right: 0;
        height: 2px;
        background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
    }

    h1 {
        margin: 0 0 6px;
        color: #fff;
        font-size: 26px;
        font-weight: 800;
        letter-spacing: -0.5px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    h1 i {
        color: var(--accent-secondary);
    }

    .subtitle {
        color: var(--text-muted);
        font-size: 13px;
        margin-bottom: 24px;
    }

    /* Form Styles */
    form {
        display: flex;
        gap: 16px;
        align-items: flex-end;
        flex-wrap: wrap;
    }

    label {
        font-size: 12px;
        font-weight: 700;
        display: block;
        margin-bottom: 8px;
        color: var(--text-main);
        text-transform: uppercase;
        letter-spacing: 0.8px;
    }

    select {
        padding: 12px 16px;
        border: 1px solid var(--border-color);
        border-radius: 12px;
        background: rgba(11, 15, 25, 0.6);
        color: var(--text-main);
        font-family: 'Plus Jakarta Sans', sans-serif;
        font-size: 14px;
        min-width: 260px;
        outline: none;
        transition: var(--transition);
        cursor: pointer;
    }

    select:hover {
        border-color: var(--border-hover);
    }

    select:focus {
        border-color: var(--accent-primary);
        background: rgba(11, 15, 25, 0.8);
        box-shadow: 0 0 15px var(--accent-glow);
    }

    select option {
        background: var(--bg-secondary);
        color: var(--text-main);
    }

    button {
        padding: 12px 24px;
        border: none;
        border-radius: 12px;
        background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
        color: white;
        font-size: 14px;
        font-weight: 700;
        cursor: pointer;
        transition: var(--transition);
        box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    button:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
    }

    /* Executive AI Summary Badge Row */
    .ai-badge-row {
        display: flex;
        gap: 12px;
        margin-bottom: 24px;
        flex-wrap: wrap;
    }

    .ai-pill {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        background: rgba(99, 102, 241, 0.1);
        border: 1px solid rgba(99, 102, 241, 0.2);
        color: #818cf8;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 700;
    }

    /* Metrics Grid */
    .grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
        margin-top: 20px;
    }

    .metric {
        background: rgba(17, 24, 39, 0.5);
        border: 1px solid var(--border-color);
        border-radius: 16px;
        padding: 20px;
        font-size: 12px;
        font-weight: 700;
        color: var(--text-muted);
        text-transform: uppercase;
        letter-spacing: 0.8px;
        transition: var(--transition);
        position: relative;
        overflow: hidden;
    }

    .metric::before {
        content: '';
        position: absolute;
        bottom: 0; left: 0; right: 0;
        height: 3px;
        background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        opacity: 0.3;
    }

    .metric:hover {
        transform: translateY(-3px);
        border-color: var(--border-hover);
        box-shadow: 0 8px 20px var(--accent-glow);
    }

    .metric:hover::before {
        opacity: 1;
    }

    .metric b {
        font-size: 22px;
        display: block;
        margin-top: 8px;
        color: #fff;
        font-family: 'JetBrains Mono', monospace;
        font-weight: 800;
    }

    .risk {
        font-weight: 800;
        font-size: 18px;
        color: var(--warning);
    }

    /* Analysis Section */
    .analysis {
        font-size: 14px;
        line-height: 1.8;
        color: var(--text-main);
    }

    .analysis h2 {
        color: #fff;
        font-size: 18px;
        font-weight: 700;
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .analysis p {
        margin-bottom: 16px;
        color: var(--text-muted);
    }

    .analysis strong {
        color: #fff;
    }

    /* Back Button */
    .back {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 12px 24px;
        border-radius: 12px;
        background: var(--bg-card);
        color: var(--text-main);
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        border: 1px solid var(--border-color);
        transition: var(--transition);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .back:hover {
        background: rgba(99, 102, 241, 0.1);
        color: #fff;
        border-color: var(--border-hover);
        transform: translateY(-2px);
    }

    @keyframes slideUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @media(max-width: 800px) {
        .grid { grid-template-columns: repeat(2, 1fr); }
        body { padding: 20px 10px; }
        .card { padding: 20px; }
        form { flex-direction: column; align-items: stretch; }
        select { width: 100%; min-width: 0; }
        button { width: 100%; justify-content: center; }
    }
</style>
</head>
<body>
<div class="container">
    <div class="card">
        <h1><i class="fa-solid fa-brain"></i> AI Attendance Analysis</h1>
        <p class="subtitle">Intelligent analysis of historical attendance patterns and employee behavioral consistency metrics.</p>
        <form method="get" action="${pageContext.request.contextPath}/attendance/ai-analysis">
            <div>
                <label>Employee</label>
                <select name="employeeId">
                    <c:forEach var="e" items="${employees}">
                        <option value="${e.employeeId}" ${selectedEmployee != null && e.employeeId eq selectedEmployee.employeeId ? 'selected' : ''}>
                            ${e.employeeId} - ${e.employeeName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label>Period</label>
                <select name="days">
                    <option value="30" ${days == 30 ? 'selected' : ''}>Last 30 days</option>
                    <option value="60" ${days == 60 ? 'selected' : ''}>Last 60 days</option>
                    <option value="90" ${days == 90 ? 'selected' : ''}>Last 90 days</option>
                    <option value="180" ${days == 180 ? 'selected' : ''}>Last 180 days</option>
                </select>
            </div>
            <button type="submit"><i class="fa-solid fa-chart-line"></i> Analyze Attendance</button>
        </form>
    </div>

    <c:if test="${selectedEmployee != null}">
        <div class="card">
            <h2><i class="fa-regular fa-user"></i> ${selectedEmployee.employeeName} <span style="color: var(--text-muted); font-size: 14px; font-family: 'JetBrains Mono', monospace;">(${selectedEmployee.employeeId})</span></h2>
            
            <div class="ai-badge-row">
                <div class="ai-pill"><i class="fa-solid fa-shield-halved"></i> Neural Evaluation Active</div>
                <div class="ai-pill"><i class="fa-solid fa-clock"></i> Timeline: Last ${days} Days</div>
            </div>

            <div class="grid">
                <div class="metric">Records<b data-target="${analysis.records}">${analysis.records}</b></div>
                <div class="metric">Office Days<b data-target="${analysis.officeDays}">${analysis.officeDays}</b></div>
                <div class="metric">Home Days<b data-target="${analysis.homeDays}">${analysis.homeDays}</b></div>
                <div class="metric">Late Days<b data-target="${analysis.lateDays}">${analysis.lateDays}</b></div>
                <div class="metric">Completed Days<b data-target="${analysis.completedDays}">${analysis.completedDays}</b></div>
                <div class="metric">Average Hours<b>${analysis.averageWorkedHours}</b></div>
                <div class="metric">AI Score<b style="color: var(--accent-secondary);" data-target="${analysis.attendanceScore}">${analysis.attendanceScore}</b></div>
                <div class="metric">Risk Level<b class="risk">${analysis.riskLevel}</b></div>
            </div>
        </div>

        <div class="card analysis">
            <h2><i class="fa-solid fa-lightbulb" style="color: var(--warning);"></i> AI Insight & Evaluation</h2>
            <p>${analysis.summary}</p>
            <p><strong>Recommendation:</strong> ${analysis.recommendation}</p>
            <p class="subtitle" style="margin-top: 15px; margin-bottom: 0;">The score is explainable and is calculated strictly from attendance completion, working-hour patterns and late-arrival frequency.</p>
        </div>
    </c:if>

    <a class="back" href="${pageContext.request.contextPath}/attendance/admin">
        <i class="fa-solid fa-arrow-left"></i> Back to Attendance
    </a>
</div>

<!-- Number Count-Up Animation Script -->
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const metrics = document.querySelectorAll('.metric b[data-target]');
        
        metrics.forEach(metric => {
            const target = parseInt(metric.getAttribute('data-target'), 10);
            if (isNaN(target)) return;
            
            let current = 0;
            const duration = 1000;
            const steps = 30;
            const increment = target / steps;
            const stepTime = duration / steps;
            
            const updateCount = () => {
                current += increment;
                if (current < target) {
                    metric.textContent = Math.round(current);
                    setTimeout(updateCount, stepTime);
                } else {
                    metric.textContent = target;
                }
            };
            
            updateCount();
        });
    });
</script>

</body>
</html>