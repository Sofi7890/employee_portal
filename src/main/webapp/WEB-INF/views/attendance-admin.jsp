<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Attendance Management</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .app {
            display: flex;
            min-height: 100vh;
        }

        /* SIDEBAR */
        .sidebar {
            width: 260px;
            background: var(--bg-secondary);
            border-right: 1px solid var(--border-color);
            padding: 28px 16px;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            z-index: 20;
            display: flex;
            flex-direction: column;
            box-shadow: 10px 0 30px rgba(0, 0, 0, 0.3);
            animation: sidebarIn 0.65s ease both;
        }

        @keyframes sidebarIn {
            from { opacity: 0; transform: translateX(-18px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .logo {
            padding: 5px 12px 24px;
            border-bottom: 1px solid var(--border-color);
        }

        .logo-title {
            font-size: 16px;
            font-weight: 800;
            letter-spacing: -0.3px;
            color: #fff;
        }

        .logo-subtitle {
            margin-top: 4px;
            font-size: 10px;
            color: var(--text-muted);
            letter-spacing: 1.2px;
            text-transform: uppercase;
        }

        .menu-title {
            margin: 22px 12px 8px;
            font-size: 10px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 700;
        }

        .menu {
            display: flex;
            flex-direction: column;
            gap: 4px;
            overflow-y: auto;
            max-height: calc(100vh - 280px);
            padding-right: 2px;
        }

        .menu::-webkit-scrollbar {
            width: 4px;
        }
        .menu::-webkit-scrollbar-thumb {
            background: rgba(255,255,255,0.1);
            border-radius: 4px;
        }

        .menu a {
            display: flex;
            align-items: center;
            min-height: 40px;
            padding: 10px 12px;
            border-radius: 10px;
            text-decoration: none;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 500;
            transition: var(--transition);
            border: 1px solid transparent;
        }

        .menu a:hover {
            color: #fff;
            background: rgba(99, 102, 241, 0.1);
            border-color: rgba(99, 102, 241, 0.2);
            transform: translateX(4px);
        }

        .menu a.active {
            color: #fff;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.2), rgba(6, 182, 212, 0.1));
            border-color: rgba(99, 102, 241, 0.3);
            font-weight: 700;
        }

        .menu-mark {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--text-muted);
            margin-right: 12px;
            flex-shrink: 0;
            transition: var(--transition);
        }

        .menu a.active .menu-mark,
        .menu a:hover .menu-mark {
            background: var(--accent-primary);
            box-shadow: 0 0 10px var(--accent-primary);
        }

        .sidebar-bottom {
            margin-top: auto;
            padding-top: 16px;
            border-top: 1px solid var(--border-color);
        }

        .logout {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            padding: 12px;
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 12px;
            color: var(--danger);
            font-size: 13px;
            font-weight: 600;
            transition: var(--transition);
            background: rgba(239, 68, 68, 0.05);
        }

        .logout:hover {
            background: rgba(239, 68, 68, 0.15);
            border-color: rgba(239, 68, 68, 0.4);
        }

        /* MAIN CONTENT AREA */
        .main {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 36px 40px 48px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            animation: pageEnter 0.6s ease;
        }

        /* HEADER */

        .header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 36px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            margin-bottom: 25px;
            position: relative;
            overflow: hidden;
        }

        .header::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .header-left h1 {
            margin: 0 0 6px;
            font-size: 26px;
            color: #fff;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .header p {
            margin: 0;
            color: var(--text-muted);
            font-size: 13px;
        }

        /* SEARCH */

        .search-box {
            background: var(--bg-card);
            padding: 24px;
            border-radius: 20px;
            margin-bottom: 25px;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .search-title {
            font-size: 15px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 16px;
        }

        .search-form {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-form input {
            height: 44px;
            padding: 0 16px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            font-size: 14px;
            outline: none;
            background: rgba(11, 15, 25, 0.6);
            color: var(--text-main);
            transition: var(--transition);
        }

        .search-form input:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        .search-form input::placeholder {
            color: var(--text-muted);
        }

        .employee-search {
            width: 300px;
        }

        .date-search {
            width: 180px;
            /* let the native calendar icon sit on its own visible chip
               instead of blending into the dark input background */
            color-scheme: dark;
            padding-right: 12px;
        }

        /* WebKit / Blink (Chrome, Edge, Safari) date input calendar icon:
           default glyph renders near-black and disappears on our dark
           background, so we invert + brighten it and give it its own
           subtle pill so it reads clearly at a glance */
        .date-search::-webkit-calendar-picker-indicator {
            filter: invert(60%) sepia(90%) saturate(1200%) hue-rotate(200deg) brightness(1.15);
            opacity: 1;
            cursor: pointer;
            padding: 4px;
            border-radius: 6px;
            background-color: rgba(99, 102, 241, 0.12);
            transition: var(--transition);
        }

        .date-search::-webkit-calendar-picker-indicator:hover {
            background-color: rgba(99, 102, 241, 0.25);
            transform: scale(1.08);
        }

        /* Firefox draws its own icon that already follows color-scheme,
           but nudge it toward the accent color for consistency */
        .date-search::-moz-calendar-picker-indicator {
            filter: invert(60%) sepia(90%) saturate(1200%) hue-rotate(200deg) brightness(1.15);
        }

        .search-btn {
            height: 44px;
            padding: 0 24px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            color: white;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
            transition: var(--transition);
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        .clear-btn {
            height: 44px;
            padding: 0 20px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: var(--bg-card);
            color: var(--text-main);
            text-decoration: none;
            display: flex;
            align-items: center;
            font-weight: 600;
            font-size: 14px;
            transition: var(--transition);
        }

        .clear-btn:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: var(--border-hover);
        }

        .export-btn {
            height: 44px;
            padding: 0 20px;
            border-radius: 12px;
            background: rgba(6, 182, 212, 0.1);
            color: #22d3ee;
            border: 1px solid rgba(6, 182, 212, 0.2);
            text-decoration: none;
            display: flex;
            align-items: center;
            margin-left: auto;
            font-weight: 700;
            font-size: 14px;
            transition: var(--transition);
        }

        .export-btn:hover {
            background: rgba(6, 182, 212, 0.2);
            transform: translateY(-2px);
        }

        /* ANALYTICS */

        .analytics {
            display: grid;
            grid-template-columns: 1fr 1.8fr;
            gap: 20px;
            margin-bottom: 25px;
        }

        .chart-box {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .chart-title {
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .chart-subtitle {
            color: var(--text-muted);
            font-size: 12px;
            margin-bottom: 16px;
        }

        .pie-container {
            height: 245px;
            display: flex;
            justify-content: center;
        }

        .line-container {
            height: 245px;
        }

        /* QUICK STATS */

        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 25px;
        }

        .stat {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 18px;
            padding: 20px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
            transition: var(--transition);
        }

        .stat:hover {
            transform: translateY(-4px);
            border-color: var(--border-hover);
            box-shadow: 0 12px 30px var(--accent-glow);
        }

        .stat-label {
            color: var(--text-muted);
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 26px;
            font-weight: 800;
            color: #fff;
        }

        .stat-line {
            margin-top: 12px;
            width: 100%;
            height: 3px;
            border-radius: 5px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        /* TABLE */

        .table-box {
            background: var(--bg-card);
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .result-count {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            font-size: 13px;
            color: var(--text-muted);
            background: rgba(17, 24, 39, 0.4);
        }

        .result-count strong {
            color: #fff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: rgba(11, 15, 25, 0.6);
            color: var(--text-muted);
            padding: 16px 20px;
            text-align: left;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--border-color);
        }

        td {
            padding: 18px 20px;
            border-bottom: 1px solid var(--border-color);
            font-size: 13px;
            color: #d1d5db;
        }

        tbody tr {
            transition: var(--transition);
        }

        tbody tr:hover {
            background: rgba(99, 102, 241, 0.04);
        }

        .employee-name {
            font-weight: 700;
            color: #fff;
        }

        .employee-id {
            color: var(--text-muted);
            font-size: 11px;
            font-family: 'JetBrains Mono', monospace;
            margin-top: 3px;
        }

        /* STATUS */

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.2);
            font-size: 11px;
            font-weight: 700;
        }

        .late-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(245, 158, 11, 0.1);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.2);
            font-size: 11px;
            font-weight: 700;
        }

        .ontime-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(99, 102, 241, 0.1);
            color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.2);
            font-size: 11px;
            font-weight: 700;
        }

        /* EMPTY */

        .empty {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-muted);
            font-size: 14px;
        }

        /* FOOTER */

        .footer {
            margin-top: 30px;
        }

        .dashboard-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 22px;
            background: var(--bg-card);
            color: var(--text-main);
            border: 1px solid var(--border-color);
            text-decoration: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .dashboard-btn:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        /* ANIMATION */

        @keyframes pageEnter {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* RESPONSIVE */

        @media(max-width: 1200px) {
            .sidebar { width: 220px; }
            .main { margin-left: 220px; width: calc(100% - 220px); padding: 24px; }
            .stats { grid-template-columns: repeat(2, 1fr); }
        }

        @media(max-width: 950px) {
            .analytics {
                grid-template-columns: 1fr;
            }
        }

        @media(max-width: 750px) {
            .app {
                display: block;
            }
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
                min-height: auto;
            }
            .menu {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                max-height: none;
            }
            .main {
                margin-left: 0;
                width: 100%;
                padding: 16px;
            }
            .container {
                width: 100%;
                margin: 0;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
                padding: 20px;
            }

            .search-form {
                flex-direction: column;
                align-items: stretch;
            }

            .employee-search,
            .date-search {
                width: 100%;
            }

            .search-btn,
            .clear-btn,
            .export-btn {
                width: 100%;
                justify-content: center;
                margin-left: 0;
            }

            .stats {
                grid-template-columns: 1fr;
            }

            .table-box {
                overflow-x: auto;
            }

            table {
                min-width: 850px;
            }
        }

    </style>

</head>

<body>

<div class="app">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="logo">
            <div class="logo-title">Employee & Workforce Portal</div>
            
        </div>

        <div class="menu-title">Overview</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/dashboard">
                <span class="menu-mark"></span>Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/employee/list">
                <span class="menu-mark"></span>Employees
            </a>
            <a href="${pageContext.request.contextPath}/project/list">
                <span class="menu-mark"></span>Projects
            </a>
            <a href="${pageContext.request.contextPath}/client/list">
                <span class="menu-mark"></span>Clients
            </a>
        </nav>

        <div class="menu-title">Operations</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/attendance/admin" class="active">
                <span class="menu-mark"></span>Attendance
            </a>
            <a href="${pageContext.request.contextPath}/leave/admin">
                <span class="menu-mark"></span>Leave Approval
            </a>
            <a href="${pageContext.request.contextPath}/expense/admin">
                <span class="menu-mark"></span>Expenses
            </a>
            <a href="${pageContext.request.contextPath}/resignation/admin">
                <span class="menu-mark"></span>Resignation
            </a>
        </nav>

        <div class="menu-title">Administration</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/reports">
                <span class="menu-mark"></span>Reports
            </a>
            <a href="${pageContext.request.contextPath}/audit">
                <span class="menu-mark"></span>Audit Logs
            </a>
            <a href="${pageContext.request.contextPath}/admin/list">
                <span class="menu-mark"></span>Admin Portal
            </a>
            <a href="${pageContext.request.contextPath}/restore/employees">
                <span class="menu-mark"></span>Restore Employees
            </a>
        </nav>

        <div class="sidebar-bottom">
            <a class="logout" href="${pageContext.request.contextPath}/auth/logout">
                <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
            </a>
        </div>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main">

        <div class="container">

            <!-- HEADER -->
            <div class="header">
                <div class="header-left">
                    <h1>Attendance Dashboard</h1>
                    <p>Search and monitor employee attendance records</p>
                </div>
            </div>

            <!-- SEARCH -->
            <div class="search-box">
                <div class="search-title">
                    Search Attendance
                </div>

                <form method="get"
                      action="${pageContext.request.contextPath}/attendance/admin"
                      class="search-form">

                    <input
                        type="text"
                        name="employeeId"
                        class="employee-search"
                        placeholder="Employee ID or Name"
                        value="${employeeId}">

                    <input
                        type="date"
                        name="date"
                        class="date-search"
                        value="${date}">

                    <button type="submit" class="search-btn">
                        <i class="fa-solid fa-magnifying-glass"></i> Search
                    </button>

                    <a href="${pageContext.request.contextPath}/attendance/admin"
                       class="clear-btn">
                        Clear
                    </a>

                    <a href="${pageContext.request.contextPath}/attendance/ai-analysis"
                       class="export-btn">
                        <i class="fa-solid fa-robot"></i> AI Attendance Analysis
                    </a>

                    <a href="${pageContext.request.contextPath}/reports/attendance.csv"
                       class="export-btn">
                        <i class="fa-solid fa-download"></i> Export CSV
                    </a>

                </form>
            </div>

            <!-- QUICK STATISTICS -->
            <div class="stats">
                <div class="stat">
                    <div class="stat-label">Total Records</div>
                    <div class="stat-value">${records.size()}</div>
                    <div class="stat-line"></div>
                </div>

                <div class="stat">
                    <div class="stat-label">Present</div>
                    <div class="stat-value" id="presentCount">0</div>
                    <div class="stat-line"></div>
                </div>

                <div class="stat">
                    <div class="stat-label">Late Arrivals</div>
                    <div class="stat-value" id="lateCount">0</div>
                    <div class="stat-line"></div>
                </div>

                <div class="stat">
                    <div class="stat-label">Average Worked Minutes</div>
                    <div class="stat-value" id="averageMinutes">0</div>
                    <div class="stat-line"></div>
                </div>
            </div>

            <!-- CHARTS -->
            <div class="analytics">
                <!-- PIE CHART -->
                <div class="chart-box">
                    <div class="chart-title">Attendance Status</div>
                    <div class="chart-subtitle">Attendance distribution for current results</div>
                    <div class="pie-container">
                        <canvas id="attendancePie"></canvas>
                    </div>
                </div>

                <!-- LINE CHART -->
                <div class="chart-box">
                    <div class="chart-title">Attendance Trend</div>
                    <div class="chart-subtitle">Attendance records by date</div>
                    <div class="line-container">
                        <canvas id="attendanceLine"></canvas>
                    </div>
                </div>
            </div>

            <!-- RESULTS -->
            <div class="table-box">
                <div class="result-count">
                    Attendance Records: <strong>${records.size()}</strong>
                </div>

                <c:choose>
                    <c:when test="${not empty records}">
                        <table>
                            <thead>
                            <tr>
                                <th>Employee</th>
                                <th>Date</th>
                                <th>Check In</th>
                                <th>Check Out</th>
                                <th>Status</th>
                                <th>Late</th>
                                <th>Worked Minutes</th>
                                <th>Location</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="a" items="${records}">
                                <tr>
                                    <td>
                                        <div class="employee-name">
                                            ${a.employee.employeeName}
                                        </div>
                                        <div class="employee-id">
                                            ${a.employee.employeeId}
                                        </div>
                                    </td>

                                    <td>${a.attendanceDate}</td>
                                    <td>${a.checkIn}</td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty a.checkOut}">
                                                ${a.checkOut}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <span class="status-badge">${a.status}</span>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${a.late}">
                                                <span class="late-badge">Yes</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="ontime-badge">No</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty a.workedMinutes}">
                                                ${a.workedMinutes}
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty a.attendanceType}">
                                                <strong>${a.attendanceType}</strong><br>
                                                <small>${a.latitude}, ${a.longitude}</small>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>

                    <c:otherwise>
                        <div class="empty">
                            No attendance records found.
                            <br><br>
                            Try searching by employee name, employee ID, or select a different date.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- FOOTER -->
            <div class="footer">
                <a href="${pageContext.request.contextPath}/dashboard" class="dashboard-btn">
                    <i class="fa-solid fa-arrow-left"></i> Dashboard
                </a>
            </div>

        </div>

    </main>

</div>

<!-- CHART DATA -->
<script>
    const attendanceDates = [];
    const attendanceValues = [];

    let present = 0;
    let late = 0;
    let totalMinutes = 0;
    let minuteRecords = 0;

    <c:forEach var="a" items="${records}">
        attendanceDates.push("${a.attendanceDate}");
        attendanceValues.push(1);

        <c:if test="${a.status == 'PRESENT'}">
            present++;
        </c:if>

        <c:if test="${a.late}">
            late++;
        </c:if>

        <c:if test="${not empty a.workedMinutes}">
            totalMinutes += ${a.workedMinutes};
            minuteRecords++;
        </c:if>
    </c:forEach>

    let onTime = Math.max(present - late, 0);
    let averageMinutes = 0;

    if (minuteRecords > 0) {
        averageMinutes = Math.round(totalMinutes / minuteRecords);
    }

    document.getElementById("presentCount").textContent = present;
    document.getElementById("lateCount").textContent = late;
    document.getElementById("averageMinutes").textContent = averageMinutes;

    /* PIE CHART */
    const pieContext = document.getElementById("attendancePie").getContext("2d");

    new Chart(pieContext, {
        type: "doughnut",
        data: {
            labels: ["On Time", "Late"],
            datasets: [{
                data: [onTime, late],
                backgroundColor: ["#6366f1", "#f59e0b"],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: "68%",
            plugins: {
                legend: {
                    position: "bottom",
                    labels: {
                        usePointStyle: true,
                        padding: 18,
                        color: "#9ca3af",
                        font: { family: "'Plus Jakarta Sans', sans-serif" }
                    }
                }
            }
        }
    });

    /* LINE CHART */
    const dateMap = {};

    for (let i = 0; i < attendanceDates.length; i++) {
        const date = attendanceDates[i];
        if (!dateMap[date]) {
            dateMap[date] = 0;
        }
        dateMap[date]++;
    }

    const lineDates = Object.keys(dateMap).reverse();
    const lineValues = lineDates.map(function(date) {
        return dateMap[date];
    });

    const lineContext = document.getElementById("attendanceLine").getContext("2d");

    new Chart(lineContext, {
        type: "line",
        data: {
            labels: lineDates,
            datasets: [{
                label: "Attendance Records",
                data: lineValues,
                borderColor: "#6366f1",
                backgroundColor: "rgba(99, 102, 241, 0.1)",
                fill: true,
                tension: 0.35,
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0,
                        color: "#9ca3af"
                    },
                    grid: {
                        color: "rgba(255, 255, 255, 0.05)"
                    }
                },
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: "#9ca3af"
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
</script>

</body>

</html>
