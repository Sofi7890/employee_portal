<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced Time Tracking - Enterprise HR</title>

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

        .wrap {
            max-width: 1100px;
            margin: auto;
        }

        /* Top Header */
        .top-header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 36px;
            margin-bottom: 28px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .top-header::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .top-header h1 {
            margin: 0;
            color: #fff;
            font-size: 26px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .muted {
            color: var(--text-muted);
            font-size: 13px;
            margin-top: 6px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: var(--text-main);
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 12px 20px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            white-space: nowrap;
        }

        .back-link:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        /* Hero Highlight Banner */
        .banner-card {
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.15), rgba(6, 182, 212, 0.1));
            border: 1px solid rgba(99, 102, 241, 0.3);
            border-radius: 20px;
            padding: 20px 24px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .banner-card i {
            font-size: 24px;
            color: var(--accent-secondary);
        }

        .banner-card p {
            margin: 0;
            font-size: 13px;
            color: var(--text-main);
            line-height: 1.5;
        }

        /* Panel Styling */
        .panel {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 32px;
            margin-bottom: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            position: relative;
            overflow: hidden;
        }

        .panel::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .panel-title {
            font-size: 16px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Table Wrapper & Styling */
        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 850px;
            border-collapse: collapse;
        }

        th {
            background: rgba(17, 24, 39, 0.8);
            color: var(--text-muted);
            padding: 16px 18px;
            text-align: left;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            border-bottom: 1px solid var(--border-color);
        }

        td {
            padding: 16px 18px;
            border-bottom: 1px solid var(--border-color);
            font-size: 13px;
            color: var(--text-main);
        }

        td:first-child {
            font-weight: 600;
            color: #fff;
        }

        tbody tr {
            transition: var(--transition);
        }

        tbody tr:hover {
            background: rgba(99, 102, 241, 0.04);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .hours-badge {
            font-family: 'JetBrains Mono', monospace;
            font-size: 12px;
            font-weight: 700;
            color: #22d3ee;
        }

        .overtime-badge {
            font-family: 'JetBrains Mono', monospace;
            font-size: 12px;
            font-weight: 700;
            color: #f59e0b;
        }

        @media (max-width: 850px) {
            body { padding: 20px 10px; }
            .top-header { flex-direction: column; align-items: flex-start; gap: 16px; padding: 20px; }
            .back-link { width: 100%; justify-content: center; }
            .banner-card { flex-direction: column; align-items: flex-start; }
            .panel { padding: 20px; }
        }
    </style>
</head>

<body>

<div class="wrap">

    <!-- Top Header Bar -->
    <div class="top-header">
        <div>
            <h1>Advanced Time Tracking</h1>
            <p class="muted">Monitor workforce work hours, regular distribution, and calculated overtime metrics.</p>
        </div>
        <a class="back-link" href="${pageContext.request.contextPath}/enterprise">
            <i class="fa-solid fa-arrow-left"></i> Enterprise Center
        </a>
    </div>

    <!-- Explanatory Banner -->
    <div class="banner-card">
        <i class="fa-solid fa-business-time"></i>
        <p>Completed attendance records are dynamically parsed and converted into standard regular hours alongside automated overtime calculations (calculated for hours exceeding 8 hours per shift/day).</p>
    </div>

    <!-- Timesheets Table Panel -->
    <div class="panel">
        <div class="panel-title">
            <i class="fa-solid fa-clock-rotate-left" style="color: var(--accent-primary);"></i> Timesheets & Working Hours Repository
        </div>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Employee</th>
                        <th>Work Date</th>
                        <th>Regular Hours</th>
                        <th>Overtime Hours</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${timesheets}">
                        <tr>
                            <td>${t.employee.employeeId} - ${t.employee.employeeName}</td>
                            <td style="font-family: 'JetBrains Mono', monospace; font-size: 12px; color: var(--text-muted);">${t.workDate}</td>
                            <td><span class="hours-badge">${t.regularMinutes / 60.0} hrs</span></td>
                            <td><span class="overtime-badge">${t.overtimeMinutes / 60.0} hrs</span></td>
                            <td>
                                <span class="status-badge">${t.status}</span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>