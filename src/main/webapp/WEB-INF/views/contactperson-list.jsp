<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Person List</title>

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

        .container {
            max-width: 1200px;
            margin: auto;
            background: var(--bg-card);
            border-radius: 24px;
            padding: 36px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
            animation: fadeInAnim 0.6s ease;
        }

        .container::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        @keyframes fadeInAnim {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 28px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .header h2 {
            margin: 0;
            color: #fff;
            font-size: 26px;
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
            gap: 8px;
            padding: 12px 24px;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 700;
            font-size: 14px;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        .table-wrapper {
            overflow-x: auto;
            border-radius: 16px;
            border: 1px solid var(--border-color);
            background: rgba(17, 24, 39, 0.5);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: transparent;
        }

        th {
            background: rgba(17, 24, 39, 0.8);
            color: var(--text-muted);
            text-align: left;
            padding: 16px;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            border-bottom: 1px solid var(--border-color);
            white-space: nowrap;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-main);
            font-size: 13px;
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

        .contact-id {
            font-weight: 700;
            color: #818cf8;
            font-family: 'JetBrains Mono', monospace;
        }

        .contact-name {
            font-weight: 700;
            color: #fff;
        }

        .email {
            color: #818cf8;
            font-family: 'JetBrains Mono', monospace;
        }

        .phone {
            color: var(--text-main);
            font-family: 'JetBrains Mono', monospace;
        }

        .designation {
            display: inline-flex;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(6, 182, 212, 0.1);
            border: 1px solid rgba(6, 182, 212, 0.2);
            color: #22d3ee;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .client-name {
            font-weight: 700;
            color: #a5b4fc;
        }

        .actions {
            white-space: nowrap;
            display: flex;
            gap: 8px;
        }

        .edit-btn,
        .delete-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 14px;
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

        .empty-message {
            text-align: center;
            padding: 50px;
            color: var(--text-muted);
            font-size: 13px;
        }

        @media (max-width: 1200px) {
            .sidebar { width: 220px; }
            .main { margin-left: 220px; width: calc(100% - 220px); padding: 24px; }
        }

        @media (max-width: 750px) {
            .app { display: block; }
            .sidebar { position: relative; width: 100%; height: auto; min-height: auto; }
            .menu { display: grid; grid-template-columns: repeat(2, 1fr); max-height: none; }
            .main { margin-left: 0; width: 100%; padding: 16px; }

            .container {
                padding: 20px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .header h2 {
                font-size: 22px;
            }

            .add-btn {
                width: 100%;
                justify-content: center;
            }

            th,
            td {
                padding: 12px;
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

        <div class="container">

            <div class="header">
                <div>
                    <h2>Contact Persons</h2>
                    <p>Manage client contact persons and their contact details</p>
                </div>

                <a href="${pageContext.request.contextPath}/contact-person/create" class="add-btn">
                    <i class="fa-solid fa-user-plus"></i> Add New Contact Person
                </a>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Designation</th>
                            <th>Client</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="client" items="${clients}">
                            <c:forEach var="cp" items="${client.contactPersons}">
                                <tr>
                                    <td class="contact-id">
                                        ${cp.id}
                                    </td>
                                    <td class="contact-name">
                                        ${cp.name}
                                    </td>
                                    <td class="email">
                                        ${cp.email}
                                    </td>
                                    <td class="phone">
                                        ${cp.phone}
                                    </td>
                                    <td>
                                        <span class="designation">
                                            ${cp.designation}
                                        </span>
                                    </td>
                                    <td class="client-name">
                                        ${client.clientName}
                                    </td>
                                    <td class="actions">
                                        <a href="${pageContext.request.contextPath}/contact-person/edit/${cp.id}" class="edit-btn">
                                            <i class="fa-solid fa-pen-to-square"></i> Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/contact-person/delete/${cp.id}" class="delete-btn"
                                           onclick="return confirm('Are you sure you want to delete this contact person?');">
                                            <i class="fa-solid fa-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:forEach>

                        <c:if test="${empty clients}">
                            <tr>
                                <td colspan="7" class="empty-message">
                                    <i class="fa-solid fa-address-book" style="font-size: 28px; margin-bottom: 10px; display: block; color: var(--accent-primary);"></i>
                                    No contact persons found.
                                </td>
                            </tr>
                        </c:if>

                    </tbody>
                </table>
            </div>

        </div>

    </main>

</div>

</body>

</html>