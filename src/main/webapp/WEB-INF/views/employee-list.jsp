<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Employee Directory</title>

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
            width: 100%;
            overflow-x: hidden;
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
            max-width: 100%;
        }

        /* TOP HEADER */
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
            margin-bottom: 28px;
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

        .header-left h2 {
            margin: 0;
            color: #fff;
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .header-left p {
            margin: 6px 0 0;
            color: var(--text-muted);
            font-size: 13px;
        }

        .dashboard-link {
            color: var(--text-main);
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            padding: 10px 18px;
            border-radius: 12px;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            white-space: nowrap;
        }

        .dashboard-link:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        /* PAGE TITLE */
        .page-title {
            margin-bottom: 24px;
        }

        .page-title h1 {
            margin: 0;
            color: #fff;
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .page-title p {
            margin: 6px 0 0;
            color: var(--text-muted);
            font-size: 14px;
        }

        /* TOOLBAR */
        .toolbar {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            flex-wrap: wrap;
            width: 100%;
        }

        .search-box {
            flex: 1;
            min-width: 200px;
        }

        .search-box input {
            width: 100%;
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

        .search-box input:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        .search-box input::placeholder {
            color: var(--text-muted);
        }

        .toolbar select {
            height: 44px;
            padding: 0 28px 0 12px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            background: rgba(11, 15, 25, 0.6);
            color: var(--text-main);
            font-size: 13px;
            outline: none;
            cursor: pointer;
            transition: var(--transition);
        }

        .toolbar select:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        .btn {
            height: 44px;
            padding: 0 16px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            background: var(--bg-secondary);
            color: var(--text-main);
            border: 1px solid var(--border-color);
            white-space: nowrap;
        }

        .btn-search {
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            color: #ffffff;
            border: none;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }

        .btn-add {
            background: linear-gradient(135deg, var(--success), #059669);
            color: #ffffff;
            border: none;
            margin-left: auto;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            border-color: var(--border-hover);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        /* EMPLOYEE GRID */
        .employee-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 24px;
            width: 100%;
        }

        .employee-card {
            background: var(--bg-card);
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transition: var(--transition);
            animation: cardIn 0.5s ease both;
            width: 100%;
        }

        .employee-card:hover {
            transform: translateY(-5px);
            border-color: var(--border-hover);
            box-shadow: 0 15px 35px var(--accent-glow);
        }

        .card-cover {
            height: 120px;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.3), rgba(6, 182, 212, 0.2));
            position: relative;
            border-bottom: 1px solid var(--border-color);
        }

        .employee-avatar {
            width: 86px;
            height: 86px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            border: 4px solid var(--bg-card);
            position: absolute;
            left: 50%;
            bottom: -43px;
            transform: translateX(-50%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 30px;
            font-weight: 800;
            box-shadow: 0 5px 20px rgba(0,0,0,0.4);
            overflow: hidden;
        }

        .card-body {
            padding: 54px 22px 22px;
        }

        .employee-name {
            text-align: center;
            margin-bottom: 4px;
        }

        .employee-name h3 {
            margin: 0;
            color: #fff;
            font-size: 18px;
            font-weight: 700;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .employee-id {
            text-align: center;
            color: var(--text-muted);
            font-size: 12px;
            font-family: 'JetBrains Mono', monospace;
            margin-top: 4px;
        }

        .badge-row {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin: 16px 0 20px;
            flex-wrap: wrap;
        }

        .role-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(99, 102, 241, 0.12);
            color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.2);
            font-size: 11px;
            font-weight: 700;
        }

        .project-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(6, 182, 212, 0.1);
            color: #22d3ee;
            border: 1px solid rgba(6, 182, 212, 0.2);
            font-size: 11px;
            font-weight: 700;
        }

        .bench-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(245, 158, 11, 0.1);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.2);
            font-size: 11px;
            font-weight: 700;
        }

        .details {
            border-top: 1px solid var(--border-color);
        }

        .detail-row {
            display: grid;
            grid-template-columns: 90px 1fr;
            min-height: 40px;
            align-items: center;
            border-bottom: 1px solid var(--border-color);
            gap: 10px;
        }

        .detail-label {
            color: var(--text-muted);
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-value {
            color: var(--text-main);
            font-size: 12px;
            font-weight: 500;
            word-break: break-all;
        }

        .department-value {
            display: inline-block;
            padding: 4px 8px;
            background: rgba(99, 102, 241, 0.1);
            color: #818cf8;
            border-radius: 6px;
            font-weight: 600;
            text-align: center;
        }

        .email-value {
            color: #818cf8;
            font-family: 'JetBrains Mono', monospace;
            font-size: 11px;
        }

        .card-actions {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            margin-top: 20px;
        }

        .action-btn {
            text-align: center;
            padding: 10px 4px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 11px;
            font-weight: 700;
            transition: var(--transition);
        }

        .action-view {
            background: rgba(6, 182, 212, 0.1);
            color: #22d3ee;
            border: 1px solid rgba(6, 182, 212, 0.2);
        }

        .action-edit {
            background: rgba(99, 102, 241, 0.1);
            color: #818cf8;
            border: 1px solid rgba(99, 102, 241, 0.2);
        }

        .action-delete {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .action-view:hover {
            background: rgba(6, 182, 212, 0.2);
            transform: translateY(-2px);
        }

        .action-edit:hover {
            background: rgba(99, 102, 241, 0.2);
            transform: translateY(-2px);
        }

        .action-delete:hover {
            background: rgba(239, 68, 68, 0.2);
            transform: translateY(-2px);
        }

        .empty-card {
            grid-column: 1 / -1;
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 80px 25px;
            text-align: center;
            color: var(--text-muted);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .empty-card h3 {
            margin: 0 0 8px;
            color: #fff;
            font-size: 20px;
        }

        .empty-card p {
            margin: 0;
            font-size: 14px;
        }

        @keyframes cardIn {
            from {
                opacity: 0;
                transform: translateY(15px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 1400px) {
            .employee-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 950px) {
            .sidebar {
                width: 220px;
            }
            .main {
                margin-left: 220px;
                width: calc(100% - 220px);
                padding: 24px;
            }
        }

        @media (max-width: 750px) {
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
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
                padding: 20px;
            }
            .toolbar {
                flex-direction: column;
                align-items: stretch;
            }
            .search-box {
                max-width: none;
                width: 100%;
            }
            .toolbar select,
            .toolbar .btn {
                width: 100%;
                justify-content: center;
            }
            .btn-add {
                margin-left: 0;
            }
            .employee-grid {
                grid-template-columns: 1fr;
            }
            .card-actions {
                grid-template-columns: repeat(3, 1fr);
            }
            div[style*="grid-template-columns:repeat(4,minmax(0,1fr))"] {
                grid-template-columns: repeat(2, 1fr) !important;
            }
        }

        @media (max-width: 480px) {
            div[style*="grid-template-columns:repeat(4,minmax(0,1fr))"] {
                grid-template-columns: 1fr !important;
            }
        }
    </style>
</head>

<body>

<div class="app">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="logo">
            <div class="logo-title">Employee & Workforce</div>
            <div class="logo-subtitle">Management System</div>
        </div>

        <div class="menu-title">Overview</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/dashboard">
                <span class="menu-mark"></span>Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/employee/list" class="active">
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
                <span class="menu-mark"></span>Admin Management
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

        <div class="header">
            <div class="header-left">
                <h2>Employee & Workforce System</h2>
                <p>Manage employees, projects and workforce information</p>
            </div>
            <a href="${pageContext.request.contextPath}/dashboard" class="dashboard-link">
                Dashboard
            </a>
        </div>

        <div class="page-title">
            <h1>Employee Directory</h1>
            <p>Create a directory of current employees and manage workforce information.</p>
        </div>

        <!-- ADVANCED WORKFORCE SUMMARY -->
        <div style="display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:14px;margin:0 0 24px;width:100%;">
            <div style="background:var(--bg-card);border:1px solid var(--border-color);border-radius:16px;padding:18px;min-height:0;box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                <div style="font-size:11px;color:#9ca3af;text-transform:uppercase;font-weight:700;">Showing</div>
                <div style="font-size:26px;font-weight:800;margin-top:6px;color:#fff;font-family:'JetBrains Mono',monospace;">${filterCount}</div>
                <div style="font-size:11px;color:#9ca3af;margin-top:2px;">employees</div>
            </div>
            <div style="background:var(--bg-card);border:1px solid var(--border-color);border-radius:16px;padding:18px;min-height:0;box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                <div style="font-size:11px;color:#9ca3af;text-transform:uppercase;font-weight:700;">Assigned</div>
                <div style="font-size:26px;font-weight:800;margin-top:6px;color:#fff;font-family:'JetBrains Mono',monospace;">${assignedCount}</div>
                <div style="font-size:11px;color:#9ca3af;margin-top:2px;">with projects</div>
            </div>
            <div style="background:var(--bg-card);border:1px solid var(--border-color);border-radius:16px;padding:18px;min-height:0;box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                <div style="font-size:11px;color:#9ca3af;text-transform:uppercase;font-weight:700;">Bench</div>
                <div style="font-size:26px;font-weight:800;margin-top:6px;color:#fff;font-family:'JetBrains Mono',monospace;">${benchCount}</div>
                <div style="font-size:11px;color:#9ca3af;margin-top:2px;">available workforce</div>
            </div>
            <div style="background:var(--bg-card);border:1px solid var(--border-color);border-radius:16px;padding:18px;min-height:0;box-shadow:0 10px 30px rgba(0,0,0,0.3);">
                <div style="font-size:11px;color:#9ca3af;text-transform:uppercase;font-weight:700;">Directory</div>
                <div style="font-size:26px;font-weight:800;margin-top:6px;color:#fff;font-family:'JetBrains Mono',monospace;">360°</div>
                <div style="font-size:11px;color:#9ca3af;margin-top:2px;">profile management</div>
            </div>
        </div>

        <form method="get" action="${pageContext.request.contextPath}/employee/search">
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" name="q" value="${q}" placeholder="Search ID, name, email or department">
                </div>

                <select name="department">
                    <option value="">All Departments</option>
                    <c:forEach var="d" items="${departments}">
                        <option value="${d}" ${department == d ? 'selected' : ''}>${d}</option>
                    </c:forEach>
                </select>

                <select name="roleFilter">
                    <option value="">All Roles</option>
                    <c:forEach var="r" items="${roles}">
                        <option value="${r}" ${roleFilter == r ? 'selected' : ''}>${r}</option>
                    </c:forEach>
                </select>

                <select name="status">
                    <option value="">All Status</option>
                    <c:forEach var="st" items="${statuses}">
                        <option value="${st}" ${status == st ? 'selected' : ''}>${st}</option>
                    </c:forEach>
                </select>

                <select name="project">
                    <option value="">All Projects</option>
                    <option value="BENCH" ${project == 'BENCH' ? 'selected' : ''}>Bench</option>
                    <c:forEach var="p" items="${projects}">
                        <option value="${p.projectId}" ${project == p.projectId ? 'selected' : ''}>${p.projectName}</option>
                    </c:forEach>
                </select>

                <select name="sort">
                    <option value="">Sort By</option>
                    <option value="name" ${sort == 'name' ? 'selected' : ''}>Name A-Z</option>
                    <option value="joining" ${sort == 'joining' ? 'selected' : ''}>Newest Joining</option>
                </select>

                <button type="submit" class="btn btn-search">
                    <i class="fa-solid fa-magnifying-glass"></i> Apply
                </button>

                <a href="${pageContext.request.contextPath}/employee/list" class="btn">
                    <i class="fa-solid fa-rotate-left"></i> Reset
                </a>

                <a href="${pageContext.request.contextPath}/reports/employees.csv" class="btn">
                    <i class="fa-solid fa-file-csv"></i> Export
                </a>

                <a href="${pageContext.request.contextPath}/employee/create" class="btn btn-add">
                    <i class="fa-solid fa-user-plus"></i> Add Employee
                </a>
            </div>
        </form>

        <div class="employee-grid">
            <c:forEach var="emp" items="${employees}">
                <div class="employee-card">
                    <div class="card-cover">
                        <div class="employee-avatar">
                            <c:choose>
                                <c:when test="${not empty emp.imagePath}">
                                    <img src="${pageContext.request.contextPath}/employee/image/${emp.employeeId}"
                                         alt="${emp.employeeName}"
                                         style="width:100%;height:100%;object-fit:cover;border-radius:50%;">
                                </c:when>
                                <c:when test="${not empty emp.employeeName}">
                                    ${emp.employeeName.substring(0,1).toUpperCase()}
                                </c:when>
                                <c:otherwise>E</c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="card-body">
                        <div class="employee-name">
                            <h3>${emp.employeeName}</h3>
                        </div>
                        <div class="employee-id">
                            ID: ${emp.employeeId}
                        </div>

                        <div class="badge-row">
                            <span class="role-badge">${emp.role}</span>
                            <c:choose>
                                <c:when test="${emp.project != null}">
                                    <span class="project-badge">${emp.project.projectName}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="bench-badge">Bench</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="details">
                            <div class="detail-row">
                                <div class="detail-label">Department</div>
                                <div class="detail-value">
                                    <span class="department-value">${emp.employeeDept}</span>
                                </div>
                            </div>

                            <div class="detail-row">
                                <div class="detail-label">Email</div>
                                <div class="detail-value email-value">${emp.employeeEmail}</div>
                            </div>

                            <div class="detail-row">
                                <div class="detail-label">Phone</div>
                                <div class="detail-value">${emp.employeePhone}</div>
                            </div>

                            <div class="detail-row">
                                <div class="detail-label">Joining</div>
                                <div class="detail-value" style="font-family:'JetBrains Mono', monospace;">${emp.dateOfJoining}</div>
                            </div>
                            <div class="detail-row">
                                <div class="detail-label">Status</div>
                                <div class="detail-value">${empty emp.employmentStatus ? 'ACTIVE' : emp.employmentStatus}</div>
                            </div>

                            <div class="detail-row">
                                <div class="detail-label">Project</div>
                                <div class="detail-value">
                                    <c:choose>
                                        <c:when test="${emp.project != null}">
                                            ${emp.project.projectName}
                                        </c:when>
                                        <c:otherwise>Bench</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="card-actions">
                            <a class="action-btn action-view" href="${pageContext.request.contextPath}/employee/details/${emp.employeeId}">
                                View
                            </a>
                            <a class="action-btn action-edit" href="${pageContext.request.contextPath}/employee/edit/${emp.employeeId}">
                                Edit
                            </a>
                            <a class="action-btn action-delete" href="${pageContext.request.contextPath}/employee/delete/${emp.employeeId}" onclick="return confirm('Are you sure you want to delete this employee?')">
                                Delete
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty employees}">
                <div class="empty-card">
                    <h3>No Employees Found</h3>
                    <p>No employee records are available for the current search.</p>
                </div>
            </c:if>
        </div>

    </main>

</div>

</body>
</html>