<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client List</title>

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
            max-width: 1250px;
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
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            margin-bottom: 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 25px;
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

        .header-left {
            position: relative;
        }

        .header h1 {
            margin: 0;
            font-size: 26px;
            color: #fff;
            font-weight: 800;
            letter-spacing: -0.5px;
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
            padding: 12px 24px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            color: white;
            font-size: 14px;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
            transition: var(--transition);
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        /* CLIENT DIRECTORY */
        .client-directory {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            animation: slideUp 0.7s ease;
        }

        /* HEADINGS */
        .directory-heading {
            display: grid;
            grid-template-columns: 120px minmax(220px, 1.7fr) minmax(180px, 1.2fr) 130px 170px;
            gap: 20px;
            padding: 18px 28px;
            background: rgba(17, 24, 39, 0.6);
            border-bottom: 1px solid var(--border-color);
        }

        .directory-heading div {
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: var(--text-muted);
        }

        /* CLIENT ROW */
        .client-row {
            display: grid;
            grid-template-columns: 120px minmax(220px, 1.7fr) minmax(180px, 1.2fr) 130px 170px;
            gap: 20px;
            align-items: center;
            min-height: 95px;
            padding: 18px 28px;
            border-bottom: 1px solid var(--border-color);
            transition: var(--transition);
        }

        .client-row:last-child {
            border-bottom: none;
        }

        .client-row:hover {
            background: rgba(99, 102, 241, 0.04);
            border-color: var(--border-hover);
        }

        /* CLIENT ID */
        .client-id {
            display: inline-flex;
            width: fit-content;
            padding: 6px 12px;
            border-radius: 8px;
            background: rgba(99, 102, 241, 0.12);
            color: #818cf8;
            border: 1px solid rgba(99, 102, 241, 0.2);
            font-size: 11px;
            font-weight: 700;
            font-family: 'JetBrains Mono', monospace;
        }

        /* CLIENT INFORMATION */
        .client-info {
            display: flex;
            align-items: center;
            gap: 14px;
            min-width: 0;
        }

        .client-avatar {
            width: 44px;
            height: 44px;
            flex-shrink: 0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            color: white;
            font-size: 16px;
            font-weight: 800;
            box-shadow: 0 4px 15px var(--accent-glow);
        }

        .client-details {
            min-width: 0;
        }

        .client-name {
            display: block;
            color: #fff;
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 4px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .client-description {
            display: block;
            color: var(--text-muted);
            font-size: 12px;
        }

        /* RELATIONSHIP */
        .relationship {
            color: var(--text-main);
            font-size: 13px;
            font-weight: 600;
            font-family: 'JetBrains Mono', monospace;
        }

        .relationship-label {
            display: block;
            margin-top: 4px;
            color: var(--text-muted);
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* ROLE */
        .role-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: fit-content;
            padding: 6px 14px;
            border-radius: 20px;
            background: rgba(6, 182, 212, 0.1);
            border: 1px solid rgba(6, 182, 212, 0.2);
            color: #22d3ee;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }

        /* ACTIONS */
        .actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 8px 14px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
            transition: var(--transition);
        }

        .edit-btn {
            background: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .edit-btn:hover {
            background: rgba(16, 185, 129, 0.2);
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

        .empty-title {
            color: #fff;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .empty-text {
            font-size: 13px;
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
        @media (max-width: 1200px) {
            .sidebar { width: 220px; }
            .main { margin-left: 220px; width: calc(100% - 220px); padding: 24px; }
        }

        @media (max-width: 1000px) {
            .directory-heading { display: none; }
            .client-row {
                grid-template-columns: 100px 1fr 160px 120px 150px;
                gap: 15px;
            }
        }

        @media (max-width: 750px) {
            .app { display: block; }
            .sidebar { position: relative; width: 100%; height: auto; min-height: auto; }
            .menu { display: grid; grid-template-columns: repeat(2, 1fr); max-height: none; }
            .main { margin-left: 0; width: 100%; padding: 16px; }

            .header {
                flex-direction: column;
                align-items: flex-start;
                padding: 20px;
                gap: 15px;
            }

            .add-btn {
                width: 100%;
                justify-content: center;
            }

            .client-row {
                display: block;
                padding: 20px;
            }

            .client-id { margin-bottom: 12px; }
            .client-info { margin-bottom: 15px; }
            .relationship { margin-bottom: 15px; }
            .role-badge { margin-bottom: 15px; display: inline-flex; }
            .actions { padding-top: 5px; }
            .action-btn { flex: 1; justify-content: center; }
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
            <a href="${pageContext.request.contextPath}/project/list">
                <span class="menu-mark"></span>Projects
            </a>
            <a href="${pageContext.request.contextPath}/client/list" class="active">
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
                    <h1>Clients Directory</h1>
                    <p>Manage registered clients and their information records</p>
                </div>
                <a href="${pageContext.request.contextPath}/client/create" class="add-btn">
                    <i class="fa-solid fa-user-plus"></i> Add New Client
                </a>
            </div>

            <!-- CLIENT DIRECTORY -->
            <div class="client-directory">

                <!-- COLUMN HEADINGS -->
                <div class="directory-heading">
                    <div>Client ID</div>
                    <div>Client</div>
                    <div>Relationship</div>
                    <div>Role</div>
                    <div>Actions</div>
                </div>

                <!-- CLIENTS -->
                <c:forEach var="client" items="${clients}">
                    <div class="client-row">

                        <!-- CLIENT ID -->
                        <div>
                            <span class="client-id">${client.clientId}</span>
                        </div>

                        <!-- CLIENT -->
                        <div class="client-info">
                            <div class="client-avatar">
                                <c:choose>
                                    <c:when test="${not empty client.clientName}">
                                        ${client.clientName.substring(0,1).toUpperCase()}
                                    </c:when>
                                    <c:otherwise>C</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="client-details">
                                <span class="client-name">${client.clientName}</span>
                                <span class="client-description">Registered Client</span>
                            </div>
                        </div>

                        <!-- RELATIONSHIP -->
                        <div>
                            <span class="relationship">${client.clientRelationshipDate}</span>
                            <span class="relationship-label">Relationship Date</span>
                        </div>

                        <!-- ROLE -->
                        <div>
                            <span class="role-badge">${client.role}</span>
                        </div>

                        <!-- ACTIONS -->
                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/client/edit/${client.clientId}" class="action-btn edit-btn">
                                <i class="fa-solid fa-pen-to-square"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/client/delete/${client.clientId}" class="action-btn delete-btn"
                               onclick="return confirm('Are you sure you want to delete this client?');">
                                <i class="fa-solid fa-trash"></i> Delete
                            </a>
                        </div>

                    </div>
                </c:forEach>

                <!-- EMPTY -->
                <c:if test="${empty clients}">
                    <div class="empty">
                        <i class="fa-solid fa-folder-open" style="font-size: 28px; margin-bottom: 10px; display: block; color: var(--accent-primary);"></i>
                        <div class="empty-title">No Clients Found</div>
                        <div class="empty-text">There are currently no registered clients in the system.</div>
                    </div>
                </c:if>

            </div>

        </div>

    </main>

</div>

</body>
</html>