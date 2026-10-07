<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Project List</title>

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

        /* MAIN CONTENT */
        .main {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 36px 40px 48px;
        }

        .page {
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
            margin-bottom: 30px;
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

        /* decorative glow orb sitting quietly behind the title — purely
           atmospheric, never interferes with content or click targets */
        .header::before {
            content: '';
            position: absolute;
            top: -60px;
            right: 120px;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(99, 102, 241, 0.16), transparent 70%);
            pointer-events: none;
            animation: orbFloat 8s ease-in-out infinite;
        }

        @keyframes orbFloat {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(-14px, 10px) scale(1.08); }
        }

        .header-left {
            position: relative;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .header-icon {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            color: #fff;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            box-shadow: 0 8px 20px var(--accent-glow);
            flex-shrink: 0;
            animation: iconTilt 5s ease-in-out infinite;
        }

        @keyframes iconTilt {
            0%, 100% { transform: rotate(-4deg); }
            50% { transform: rotate(4deg); }
        }

        .header h1 {
            margin: 0;
            font-size: 26px;
            letter-spacing: -0.5px;
            font-weight: 800;
            background: linear-gradient(135deg, #ffffff 40%, var(--accent-secondary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .header p {
            margin: 6px 0 0;
            color: var(--text-muted);
            font-size: 13px;
        }

        .add-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            padding: 12px 22px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--success), #059669);
            color: white;
            font-size: 14px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
            transition: var(--transition);
            position: relative;
            z-index: 1;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        .add-btn i {
            transition: transform 0.3s ease;
        }

        .add-btn:hover i {
            transform: rotate(90deg);
        }

        /* PROJECT AREA */

        .project-area {
            background: var(--bg-card);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            border: 1px solid var(--border-color);
            animation: slideUp 0.7s ease;
        }

        /* TOP LABEL */

        .project-heading {
            display: grid;
            grid-template-columns: 120px minmax(220px, 1.6fr) minmax(150px, 1fr) minmax(200px, 1.2fr) 90px 150px;
            gap: 15px;
            padding: 18px 24px;
            background: rgba(11, 15, 25, 0.6);
            border-bottom: 1px solid var(--border-color);
        }

        .project-heading div {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-muted);
        }

        /* PROJECT ROW */

        .project-row {
            display: grid;
            grid-template-columns: 120px minmax(220px, 1.6fr) minmax(150px, 1fr) minmax(200px, 1.2fr) 90px 150px;
            gap: 15px;
            align-items: center;
            min-height: 88px;
            padding: 16px 24px;
            border-bottom: 1px solid var(--border-color);
            transition: var(--transition);
            position: relative;
            opacity: 0;
            animation: rowIn 0.5s ease forwards;
        }

        @keyframes rowIn {
            from { opacity: 0; transform: translateY(14px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .project-row:last-child {
            border-bottom: none;
        }

        .project-row:hover {
            background: rgba(99, 102, 241, 0.04);
            padding-left: 28px;
        }

        /* a soft accent bar that grows in on hover, echoing the header's
           top gradient line without adding any new interactive element */
        .project-row::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 0;
            background: linear-gradient(180deg, var(--accent-primary), var(--accent-secondary));
            transition: var(--transition);
        }

        .project-row:hover::before {
            width: 3px;
        }

        /* PROJECT ID */

        .project-id {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            width: fit-content;
            padding: 6px 10px;
            border-radius: 8px;
            background: rgba(99, 102, 241, 0.12);
            color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.2);
            font-size: 11px;
            font-weight: 700;
            font-family: 'JetBrains Mono', monospace;
        }

        .project-id i {
            font-size: 10px;
            opacity: 0.85;
        }

        /* PROJECT NAME */

        .project-info {
            min-width: 0;
        }

        .project-name {
            display: block;
            color: #fff;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            margin-bottom: 4px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .project-name:hover {
            color: #818cf8;
        }

        .project-description {
            color: var(--text-muted);
            font-size: 11px;
        }

        /* CLIENT */

        .client {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .client-avatar {
            flex-shrink: 0;
            width: 32px;
            height: 32px;
            border-radius: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: 800;
            color: #fff;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.25);
        }

        .client-avatar-empty {
            background: rgba(148, 163, 184, 0.15);
            color: var(--text-muted);
            box-shadow: none;
        }

        .client-name {
            display: block;
            color: var(--text-main);
            font-size: 13px;
            font-weight: 600;
        }

        .client-label {
            display: block;
            color: var(--text-muted);
            font-size: 10px;
            margin-top: 2px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* TIMELINE */

        .timeline {
            position: relative;
            padding-left: 14px;
        }

        .timeline::before {
            content: "";
            position: absolute;
            left: 0;
            top: 4px;
            bottom: 4px;
            width: 2px;
            border-radius: 2px;
            background: linear-gradient(180deg, var(--accent-primary), var(--accent-secondary));
            opacity: 0.4;
        }

        .start-date,
        .end-date {
            position: relative;
        }

        .start-date::before,
        .end-date::before {
            content: '';
            position: absolute;
            left: -17px;
            top: 50%;
            transform: translateY(-50%);
            width: 7px;
            height: 7px;
            border-radius: 50%;
        }

        .start-date {
            font-size: 11px;
            color: var(--text-main);
            font-weight: 600;
            margin-bottom: 4px;
            font-family: 'JetBrains Mono', monospace;
        }

        .start-date::before {
            background: var(--accent-primary);
            box-shadow: 0 0 8px var(--accent-glow);
        }

        .end-date {
            font-size: 11px;
            color: var(--text-muted);
            font-family: 'JetBrains Mono', monospace;
        }

        .end-date::before {
            background: var(--accent-secondary);
            box-shadow: 0 0 8px rgba(6, 182, 212, 0.3);
        }

        .date-label {
            color: #818cf8;
            font-weight: 700;
            margin-right: 4px;
        }

        /* TEAM */

        .team-count {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            min-width: 36px;
            height: 32px;
            padding: 0 10px;
            border-radius: 8px;
            background: rgba(6, 182, 212, 0.1);
            color: #22d3ee;
            border: 1px solid rgba(6, 182, 212, 0.2);
            font-size: 12px;
            font-weight: 700;
            font-family: 'JetBrains Mono', monospace;
        }

        .team-count i {
            font-size: 10px;
            opacity: 0.85;
        }

        /* ACTIONS */

        .actions {
            display: flex;
            align-items: center;
            gap: 6px;
            flex-wrap: wrap;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            padding: 6px 10px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 11px;
            font-weight: 700;
            transition: var(--transition);
        }

        .action-btn i {
            font-size: 10px;
        }

        .view-btn {
            background: rgba(6, 182, 212, 0.1);
            color: #22d3ee;
            border: 1px solid rgba(6, 182, 212, 0.2);
        }

        .view-btn:hover {
            background: rgba(6, 182, 212, 0.2);
            transform: translateY(-1px);
        }

        .edit-btn {
            background: rgba(99, 102, 241, 0.1);
            color: #818cf8;
            border: 1px solid rgba(99, 102, 241, 0.2);
        }

        .edit-btn:hover {
            background: rgba(99, 102, 241, 0.2);
            transform: translateY(-1px);
        }

        .delete-btn {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .delete-btn:hover {
            background: rgba(239, 68, 68, 0.2);
            transform: translateY(-1px);
        }

        /* EMPTY */

        .empty {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-muted);
        }

        .empty-icon {
            font-size: 34px;
            color: var(--accent-primary);
            opacity: 0.6;
            margin-bottom: 14px;
        }

        .empty-title {
            color: #fff;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .empty-text {
            font-size: 14px;
        }

        /* ANIMATION */

        @keyframes pageEnter {
            from { opacity: 0; transform: translateY(18px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(25px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* RESPONSIVE */

        @media (max-width: 1250px) {
            .sidebar { width: 220px; }
            .main { margin-left: 220px; width: calc(100% - 220px); padding: 24px; }
        }

        @media (max-width: 1050px) {
            .project-heading {
                display: none;
            }
            .project-row {
                grid-template-columns: 100px 1fr 130px 120px 140px;
                gap: 12px;
            }
            .project-row > .timeline {
                grid-column: 3;
            }
            .project-row > .team {
                grid-column: 4;
            }
            .project-row > .actions {
                grid-column: 5;
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
                align-items: flex-start;
                flex-direction: column;
                gap: 16px;
                padding: 20px;
            }
            .add-btn {
                width: 100%;
            }
            .project-row {
                display: block;
                padding: 20px;
                min-height: auto;
            }
            .project-row:hover {
                padding-left: 20px;
            }
            .project-id {
                margin-bottom: 12px;
            }
            .project-info {
                margin-bottom: 14px;
            }
            .project-name {
                white-space: normal;
            }
            .client, .timeline, .team {
                margin-bottom: 14px;
            }
            .actions {
                padding-top: 5px;
            }
            .action-btn {
                flex: 1;
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
            <a href="${pageContext.request.contextPath}/employee/list">
                <span class="menu-mark"></span>Employees
            </a>
            <a href="${pageContext.request.contextPath}/project/list" class="active">
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

        <div class="page">

            <!-- HEADER -->
            <div class="header">
                <div class="header-left">
                    <div class="header-icon">
                        <i class="fa-solid fa-diagram-project"></i>
                    </div>
                    <div>
                        <h1>Projects</h1>
                        <p>Manage projects, clients and assigned employees</p>
                    </div>
                </div>
                <a class="add-btn" href="${pageContext.request.contextPath}/project/create">
                    <i class="fa-solid fa-plus"></i> Add New Project
                </a>
            </div>

            <!-- PROJECT LIST -->
            <div class="project-area">

                <!-- COLUMN HEADINGS -->
                <div class="project-heading">
                    <div>Project ID</div>
                    <div>Project</div>
                    <div>Client</div>
                    <div>Timeline</div>
                    <div>Team</div>
                    <div>Actions</div>
                </div>

                <!-- PROJECTS -->
                <c:forEach var="proj" items="${projects}" varStatus="rowStatus">
                    <div class="project-row" style="animation-delay: ${rowStatus.index * 0.06}s;">

                        <!-- PROJECT ID -->
                        <div>
                            <span class="project-id">
                                <i class="fa-solid fa-hashtag"></i>${proj.projectId}
                            </span>
                        </div>

                        <!-- PROJECT -->
                        <div class="project-info">
                            <a class="project-name" href="${pageContext.request.contextPath}/project/detail/${proj.projectId}">
                                ${proj.projectName}
                            </a>
                            <span class="project-description">Project management and workforce assignment</span>
                        </div>

                        <!-- CLIENT -->
                        <div class="client">
                            <c:choose>
                                <c:when test="${proj.client != null && not empty proj.client.clientName}">
                                    <div class="client-avatar">${fn:toUpperCase(fn:substring(proj.client.clientName, 0, 1))}</div>
                                    <div>
                                        <span class="client-name">${proj.client.clientName}</span>
                                        <span class="client-label">Client</span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="client-avatar client-avatar-empty">-</div>
                                    <div>
                                        <span class="client-name">N/A</span>
                                        <span class="client-label">Client</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- TIMELINE -->
                        <div class="timeline">
                            <div class="start-date">
                                <span class="date-label">Start</span>${proj.projectStartDate}
                            </div>
                            <div class="end-date">
                                <span class="date-label">End</span>${proj.projectEndDate != null ? proj.projectEndDate : 'Ongoing'}
                            </div>
                        </div>

                        <!-- TEAM -->
                        <div class="team">
                            <span class="team-count">
                                <i class="fa-solid fa-user-group"></i>${proj.employees != null ? proj.employees.size() : 0}
                            </span>
                        </div>

                        <!-- ACTIONS -->
                        <div class="actions">
                            <a class="action-btn view-btn" href="${pageContext.request.contextPath}/project/detail/${proj.projectId}">
                                <i class="fa-solid fa-eye"></i> View
                            </a>
                            <a class="action-btn edit-btn" href="${pageContext.request.contextPath}/project/edit/${proj.projectId}">
                                <i class="fa-regular fa-pen-to-square"></i> Edit
                            </a>
                            <a class="action-btn delete-btn" href="${pageContext.request.contextPath}/project/delete/${proj.projectId}" onclick="return confirm('Are you sure you want to delete this project?');">
                                <i class="fa-regular fa-trash-can"></i> Delete
                            </a>
                        </div>

                    </div>
                </c:forEach>

                <!-- EMPTY -->
                <c:if test="${empty projects}">
                    <div class="empty">
                        <i class="fa-regular fa-folder-open empty-icon"></i>
                        <div class="empty-title">No Projects Found</div>
                        <div class="empty-text">There are currently no projects available.</div>
                    </div>
                </c:if>

            </div>

        </div>

    </main>

</div>

</body>
</html>
