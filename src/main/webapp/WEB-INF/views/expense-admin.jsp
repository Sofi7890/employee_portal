<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense Approval - EMS</title>

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

        .page {
            min-height: 100vh;
        }

        /* HEADER */

        .top-header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 36px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
            animation: fadeDown 0.5s ease;
        }

        .top-header::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .header-inner {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .header-title h1 {
            margin: 0;
            font-size: 26px;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #fff;
        }

        .header-title p {
            margin: 6px 0 0;
            font-size: 13px;
            color: var(--text-muted);
        }

        .dashboard-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: var(--text-main);
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 10px 18px;
            border-radius: 12px;
            font-size: 13px;
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

        /* MAIN */

        .container {
            max-width: 1400px;
            margin: auto;
        }

        /* SUMMARY */

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 28px;
        }

        .summary-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 18px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            transition: var(--transition);
            animation: slideUp 0.55s ease;
            position: relative;
            overflow: hidden;
        }

        .summary-card:hover {
            transform: translateY(-4px);
            border-color: var(--border-hover);
            box-shadow: 0 12px 30px var(--accent-glow);
        }

        .summary-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            color: white;
            font-size: 14px;
            font-weight: 800;
            flex-shrink: 0;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }

        .summary-card:nth-child(2) .summary-icon {
            background: linear-gradient(135deg, var(--warning), #ea580c);
            box-shadow: 0 4px 15px rgba(245, 158, 11, 0.3);
        }

        .summary-card:nth-child(3) .summary-icon {
            background: linear-gradient(135deg, var(--success), #0d9488);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }

        .summary-info span {
            display: block;
            color: var(--text-muted);
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .summary-info strong {
            display: block;
            color: #fff;
            font-size: 26px;
            font-weight: 800;
        }

        /* CONTENT */

        .content-card {
            background: var(--bg-card);
            border-radius: 20px;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: slideUp 0.6s ease;
        }

        .content-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            background: rgba(17, 24, 39, 0.4);
        }

        .content-header h2 {
            margin: 0;
            color: #fff;
            font-size: 15px;
            font-weight: 700;
        }

        .content-header p {
            margin: 4px 0 0;
            color: var(--text-muted);
            font-size: 12px;
        }

        .claim-count {
            background: rgba(99, 102, 241, 0.1);
            color: #818cf8;
            border: 1px solid rgba(99, 102, 241, 0.2);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }

        /* TABLE */

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 1150px;
            border-collapse: collapse;
        }

        thead {
            background: rgba(11, 15, 25, 0.6);
        }

        th {
            padding: 16px 20px;
            text-align: left;
            color: var(--text-muted);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--border-color);
            white-space: nowrap;
        }

        td {
            padding: 18px 20px;
            border-bottom: 1px solid var(--border-color);
            font-size: 13px;
            color: #d1d5db;
            vertical-align: middle;
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

        /* EMPLOYEE */

        .employee-box {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 200px;
        }

        .employee-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
            flex-shrink: 0;
            box-shadow: 0 2px 10px rgba(99, 102, 241, 0.3);
        }

        .employee-info strong {
            display: block;
            color: #fff;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .employee-info span {
            display: block;
            color: var(--text-muted);
            font-size: 11px;
            font-family: 'JetBrains Mono', monospace;
        }

        /* DATE */

        .date-box {
            color: var(--text-main);
            white-space: nowrap;
            line-height: 1.5;
            font-size: 12px;
            font-family: 'JetBrains Mono', monospace;
        }

        .date-box strong {
            color: #fff;
        }

        /* TYPE */

        .expense-type {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 8px;
            background: rgba(99, 102, 241, 0.12);
            color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.2);
            font-size: 11px;
            font-weight: 700;
            white-space: nowrap;
        }

        /* AMOUNT */

        .amount-box {
            font-weight: 700;
            color: var(--success);
            font-size: 14px;
            white-space: nowrap;
            font-family: 'JetBrains Mono', monospace;
        }

        /* DESCRIPTION */

        .description-box {
            max-width: 250px;
            color: var(--text-muted);
            line-height: 1.5;
            font-size: 12px;
        }

        /* STATUS */

        .status {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.2);
        }

        .status-approved {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .status-rejected {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .status-default {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-muted);
        }

        /* ACTIONS */

        .action-area {
            min-width: 255px;
        }

        .action-form {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 6px;
        }

        .reason-input {
            width: 145px;
            padding: 8px 10px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            outline: none;
            font-size: 11px;
            color: var(--text-main);
            background: rgba(11, 15, 25, 0.6);
            transition: var(--transition);
        }

        .reason-input:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 10px var(--accent-glow);
        }

        .action-btn {
            border: none;
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
        }

        .approve-btn {
            color: var(--success);
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .approve-btn:hover {
            background: rgba(16, 185, 129, 0.2);
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.2);
        }

        .reject-btn {
            color: var(--danger);
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .reject-btn:hover {
            background: rgba(239, 68, 68, 0.2);
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.2);
        }

        .no-action {
            color: var(--text-muted);
            font-size: 12px;
            font-style: italic;
        }

        /* EMPTY */

        .empty {
            text-align: center;
            padding: 80px 20px;
        }

        .empty-icon {
            width: 64px;
            height: 64px;
            margin: 0 auto 16px;
            border-radius: 50%;
            background: rgba(99, 102, 241, 0.1);
            color: var(--accent-primary);
            border: 1px solid rgba(99, 102, 241, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            font-weight: 800;
            box-shadow: 0 0 20px var(--accent-glow);
        }

        .empty h2 {
            margin: 0 0 6px;
            color: #fff;
            font-size: 18px;
            font-weight: 700;
        }

        .empty p {
            margin: 0;
            color: var(--text-muted);
            font-size: 13px;
        }

        /* FOOTER */

        .footer {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            color: var(--text-muted);
            font-size: 11px;
            text-align: right;
        }

        .footer a {
            display: none; /* Replaced by sidebar structure */
        }

        /* ANIMATIONS */

        @keyframes fadeDown {
            from { opacity: 0; transform: translateY(-15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(18px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* RESPONSIVE */

        @media (max-width: 1200px) {
            .sidebar { width: 220px; }
            .main { margin-left: 220px; width: calc(100% - 220px); padding: 24px; }
        }

        @media (max-width: 850px) {
            .app { display: block; }
            .sidebar { position: relative; width: 100%; height: auto; min-height: auto; }
            .menu { display: grid; grid-template-columns: repeat(2, 1fr); max-height: none; }
            .main { margin-left: 0; width: 100%; padding: 16px; }
            .top-header { padding: 20px; }
            .header-inner { align-items: flex-start; flex-direction: column; }
            .summary-grid { grid-template-columns: 1fr; }
            .content-header { align-items: flex-start; flex-direction: column; }
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
            <a href="${pageContext.request.contextPath}/attendance/admin">
                <span class="menu-mark"></span>Attendance
            </a>
            <a href="${pageContext.request.contextPath}/leave/admin">
                <span class="menu-mark"></span>Leave Approval
            </a>
            <a href="${pageContext.request.contextPath}/expense/admin" class="active">
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

        <div class="page">

            <!-- HEADER -->
            <div class="top-header">
                <div class="header-inner">
                    <div class="header-title">
                        <h1>Expenses Dashboard</h1>
                        <p>Review, approve and manage employee expense claims</p>
                    </div>
                    <a class="dashboard-btn" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fa-solid fa-arrow-left"></i> Dashboard
                    </a>
                </div>
            </div>

            <!-- MAIN -->
            <div class="container">

                <!-- SUMMARY -->
                <div class="summary-grid">
                    <div class="summary-card">
                        <div class="summary-icon">EC</div>
                        <div class="summary-info">
                            <span>Total Expense Claims</span>
                            <strong>${claims.size()}</strong>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="summary-icon">P</div>
                        <div class="summary-info">
                            <span>Pending Claims</span>
                            <strong id="pendingCount">0</strong>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="summary-icon">A</div>
                        <div class="summary-info">
                            <span>Approved Claims</span>
                            <strong id="approvedCount">0</strong>
                        </div>
                    </div>
                </div>

                <!-- CLAIMS -->
                <div class="content-card">
                    <div class="content-header">
                        <div>
                            <h2>Employee Expense Claims</h2>
                            <p>Review submitted expenses and take appropriate action.</p>
                        </div>
                        <div class="claim-count">
                            ${claims.size()} Claims
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${empty claims}">
                            <div class="empty">
                                <div class="empty-icon">
                                    <i class="fa-solid fa-folder-open"></i>
                                </div>
                                <h2>No Expense Claims</h2>
                                <p>There are currently no expense claims to display.</p>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="table-wrapper">
                                <table>
                                    <thead>
                                    <tr>
                                        <th>Employee</th>
                                        <th>Date</th>
                                        <th>Expense Type</th>
                                        <th>Amount</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <c:forEach var="x" items="${claims}">
                                        <tr>
                                            <!-- EMPLOYEE -->
                                            <td>
                                                <div class="employee-box">
                                                    <div class="employee-avatar">
                                                        <c:choose>
                                                            <c:when test="${not empty x.employee.employeeName}">
                                                                ${x.employee.employeeName.substring(0,1).toUpperCase()}
                                                            </c:when>
                                                            <c:otherwise>E</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="employee-info">
                                                        <strong>${x.employee.employeeName}</strong>
                                                        <span>${x.employee.employeeId}</span>
                                                    </div>
                                                </div>
                                            </td>

                                            <!-- DATE -->
                                            <td>
                                                <div class="date-box">
                                                    <strong>${x.submittedAt}</strong>
                                                </div>
                                            </td>

                                            <!-- TYPE -->
                                            <td>
                                                <span class="expense-type">${x.expenseType}</span>
                                            </td>

                                            <!-- AMOUNT -->
                                            <td>
                                                <div class="amount-box">${x.amount}</div>
                                            </td>

                                            <!-- DESCRIPTION -->
                                            <td>
                                                <div class="description-box">${x.description}</div>
                                            </td>

                                            <!-- STATUS -->
                                            <td>
                                                <c:choose>
                                                    <c:when test="${x.status == 'PENDING'}">
                                                        <span class="status status-pending">PENDING</span>
                                                    </c:when>
                                                    <c:when test="${x.status == 'APPROVED'}">
                                                        <span class="status status-approved">APPROVED</span>
                                                    </c:when>
                                                    <c:when test="${x.status == 'REJECTED'}">
                                                        <span class="status status-rejected">REJECTED</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status status-default">${x.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <!-- ACTION -->
                                            <td class="action-area">
                                                <c:if test="${x.status == 'PENDING'}">
                                                    <!-- APPROVE -->
                                                    <form class="action-form" method="post" action="${pageContext.request.contextPath}/expense/${x.id}/approve">
                                                        <button type="submit" class="action-btn approve-btn">Approve</button>
                                                    </form>

                                                    <!-- REJECT -->
                                                    <form class="action-form" method="post" action="${pageContext.request.contextPath}/expense/${x.id}/reject">
                                                        <input class="reason-input" name="comment" placeholder="Reason for rejection">
                                                        <button type="submit" class="action-btn reject-btn">Reject</button>
                                                    </form>
                                                </c:if>

                                                <c:if test="${x.status != 'PENDING'}">
                                                    <span class="no-action">No action required</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>

            <div class="footer">
                Employee & Workforce Portal
            </div>

        </div>

    </main>

</div>

<!-- SUMMARY COUNTERS -->
<script>
    let pending = 0;
    let approved = 0;

    <c:forEach var="x" items="${claims}">
        <c:if test="${x.status == 'PENDING'}">
            pending++;
        </c:if>
        <c:if test="${x.status == 'APPROVED'}">
            approved++;
        </c:if>
    </c:forEach>

    document.getElementById("pendingCount").textContent = pending;
    document.getElementById("approvedCount").textContent = approved;
</script>

</body>
</html>