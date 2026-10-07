<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KPI / OKR Performance - Enterprise HR</title>

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
            max-width: 1250px;
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

        /* Panels */
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
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Form Controls */
        form {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        input, select {
            height: 44px;
            padding: 0 16px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            background: rgba(11, 15, 25, 0.6);
            color: var(--text-main);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            outline: none;
            transition: var(--transition);
            flex: 1;
            min-width: 140px;
        }

        select {
            cursor: pointer;
            padding-right: 32px;
        }

        input:hover, select:hover {
            border-color: var(--border-hover);
        }

        input:focus, select:focus {
            border-color: var(--accent-primary);
            background: rgba(11, 15, 25, 0.8);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        select option {
            background: var(--bg-secondary);
            color: var(--text-main);
        }

        input[type="date"] {
            font-family: 'JetBrains Mono', monospace;
            font-size: 12px;
        }

        button {
            height: 44px;
            padding: 0 24px;
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
            white-space: nowrap;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        /* Table Wrapper & Styling */
        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 950px;
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

        .type-badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            border-radius: 6px;
            background: rgba(99, 102, 241, 0.1);
            color: #818cf8;
            border: 1px solid rgba(99, 102, 241, 0.2);
            font-size: 11px;
            font-weight: 700;
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

        .progress-bar-container {
            width: 100%;
            background: rgba(255, 255, 255, 0.06);
            border-radius: 10px;
            height: 8px;
            overflow: hidden;
            margin-top: 4px;
        }

        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
            border-radius: 10px;
        }

        @media (max-width: 850px) {
            body { padding: 20px 10px; }
            .top-header { flex-direction: column; align-items: flex-start; gap: 16px; padding: 20px; }
            .back-link { width: 100%; justify-content: center; }
            form { flex-direction: column; align-items: stretch; }
            input, select, button { width: 100%; min-width: 0; }
            .panel { padding: 20px; }
        }
    </style>
</head>

<body>

<div class="wrap">

    <!-- Top Header Bar -->
    <div class="top-header">
        <div>
            <h1>KPI / OKR Performance</h1>
            <p class="muted">Set performance goals, track progress metrics, and evaluate employee targets.</p>
        </div>
        <a class="back-link" href="${pageContext.request.contextPath}/enterprise">
            <i class="fa-solid fa-arrow-left"></i> Enterprise Center
        </a>
    </div>

    <!-- Add Goal Form Panel -->
    <div class="panel">
        <div class="panel-title">
            <i class="fa-solid fa-bullseye" style="color: var(--accent-secondary);"></i> Assign New Performance Goal
        </div>
        <form method="post" action="${pageContext.request.contextPath}/enterprise/performance/save">
            <select name="employeeId" required>
                <option value="">Select Employee</option>
                <c:forEach var="e" items="${employees}">
                    <option value="${e.employeeId}">${e.employeeId} - ${e.employeeName}</option>
                </c:forEach>
            </select>
            <select name="goalType">
                <option value="KPI">KPI</option>
                <option value="OKR">OKR</option>
            </select>
            <input name="title" placeholder="Goal Title" required>
            <input name="description" placeholder="Description">
            <input name="target" type="number" min="1" max="100" value="100" title="Target %">
            <input name="dueDate" type="date" title="Due Date">
            <button type="submit">
                <i class="fa-solid fa-plus"></i> Add Goal
            </button>
        </form>
    </div>

    <!-- Goals Table Panel -->
    <div class="panel">
        <div class="panel-title">
            <i class="fa-solid fa-chart-line" style="color: var(--accent-primary);"></i> Workforce Goals Repository
        </div>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Employee</th>
                        <th>Type</th>
                        <th>Goal Title</th>
                        <th>Target</th>
                        <th>Progress</th>
                        <th>Status</th>
                        <th>Update Progress</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="g" items="${goals}">
                        <tr>
                            <td>${g.employee.employeeId} - ${g.employee.employeeName}</td>
                            <td><span class="type-badge">${g.goalType}</span></td>
                            <td style="font-weight: 600; color: #fff;">${g.title}</td>
                            <td style="font-family: 'JetBrains Mono', monospace; font-size: 12px;">${g.targetPercent}%</td>
                            <td style="width: 150px;">
                                <div style="font-family: 'JetBrains Mono', monospace; font-size: 11px; margin-bottom: 3px; color: #22d3ee;">${g.progressPercent}%</div>
                                <div class="progress-bar-container">
                                    <div class="progress-bar-fill" style="width: ${g.progressPercent}%;"></div>
                                </div>
                            </td>
                            <td>
                                <span class="status-badge">${g.status}</span>
                            </td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/enterprise/performance/${g.id}/progress" style="display: flex; gap: 8px; align-items: center;">
                                    <input name="progress" type="number" min="0" max="100" value="${g.progressPercent}" style="width: 80px; height: 36px; padding: 0 8px;">
                                    <button type="submit" style="height: 36px; padding: 0 14px; font-size: 12px;">
                                        <i class="fa-solid fa-check"></i>
                                    </button>
                                </form>
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