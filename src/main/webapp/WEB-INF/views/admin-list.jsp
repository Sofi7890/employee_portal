<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Management</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>

        :root {
            --bg-primary: #0b0f19;
            --bg-secondary: #111827;
            --bg-card: #1f2937;
            --border-color: rgba(255,255,255,0.08);
            --border-hover: rgba(99,102,241,0.4);
            --text-main: #f3f4f6;
            --text-muted: #9ca3af;
            --accent-primary: #6366f1;
            --accent-secondary: #06b6d4;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --transition: all 0.3s cubic-bezier(0.4,0,0.2,1);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-main);
            min-height: 100vh;
            background-image:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(99,102,241,0.08) 0%,
                    transparent 40%
                ),
                radial-gradient(
                    circle at 90% 90%,
                    rgba(6,182,212,0.06) 0%,
                    transparent 40%
                );
            background-attachment: fixed;
        }

        .app {
            display: flex;
            min-height: 100vh;
        }

        /* =========================================================
           SIDEBAR
           ========================================================= */

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
            box-shadow: 10px 0 30px rgba(0,0,0,0.3);
        }

        .logo {
            padding: 5px 12px 24px;
            border-bottom: 1px solid var(--border-color);
        }

        .logo-title {
            font-size: 16px;
            font-weight: 800;
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
            background: rgba(99,102,241,0.1);
            border-color: rgba(99,102,241,0.2);
            transform: translateX(4px);
        }

        .menu a.active {
            color: #fff;
            background:
                linear-gradient(
                    135deg,
                    rgba(99,102,241,0.2),
                    rgba(6,182,212,0.1)
                );
            border-color: rgba(99,102,241,0.3);
            font-weight: 700;
        }

        .menu-mark {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--text-muted);
            margin-right: 12px;
            flex-shrink: 0;
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
            border: 1px solid rgba(239,68,68,0.2);
            border-radius: 12px;
            color: var(--danger);
            font-size: 13px;
            font-weight: 600;
            background: rgba(239,68,68,0.05);
        }

        /* =========================================================
           MAIN
           ========================================================= */

        .main {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 36px 40px 48px;
        }

        .container {
            width: 100%;
            max-width: 1450px;
            margin: auto;
            background: var(--bg-card);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            overflow: hidden;
            border: 1px solid var(--border-color);
        }

        /* =========================================================
           HEADER
           ========================================================= */

        .header {
            background:
                linear-gradient(
                    135deg,
                    rgba(31,41,55,0.7),
                    rgba(17,24,39,0.8)
                );
            border-bottom: 1px solid var(--border-color);
            padding: 28px 36px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            position: relative;
        }

        .header::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background:
                linear-gradient(
                    90deg,
                    var(--accent-primary),
                    var(--accent-secondary)
                );
        }

        .header h2 {
            font-size: 24px;
            font-weight: 800;
            color: #fff;
        }

        .header p {
            margin-top: 6px;
            font-size: 13px;
            color: var(--text-muted);
        }

        .add-btn {
            background:
                linear-gradient(
                    135deg,
                    var(--success),
                    #059669
                );
            color: white;
            padding: 11px 18px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
        }

        /* =========================================================
           SUMMARY
           ========================================================= */

        .summary {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            padding: 24px;
        }

        .summary-card {
            background: rgba(11,15,25,0.55);
            border: 1px solid var(--border-color);
            border-radius: 15px;
            padding: 20px;
            transition: var(--transition);
        }

        .summary-card:hover {
            transform: translateY(-3px);
            border-color: var(--border-hover);
        }

        .summary-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .summary-label {
            color: var(--text-muted);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 700;
        }

        .summary-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(99,102,241,0.12);
            color: #818cf8;
        }

        .summary-number {
            margin-top: 12px;
            font-size: 27px;
            font-weight: 800;
            color: white;
        }

        /* =========================================================
           TOOLBAR
           ========================================================= */

        .toolbar {
            padding: 0 24px 22px;
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 240px;
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 13px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        .search-box input,
        .filter-select,
        .sort-select {
            width: 100%;
            background: #111827;
            color: white;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 11px 12px 11px 38px;
            outline: none;
            font-family: inherit;
        }

        .filter-select,
        .sort-select {
            width: 180px;
            padding: 11px 12px;
        }

        .search-box input:focus,
        .filter-select:focus,
        .sort-select:focus {
            border-color: var(--border-hover);
        }

        /* =========================================================
           TABLE
           ========================================================= */

        .table-container {
            padding: 0 24px 24px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1050px;
        }

        th {
            background: rgba(11,15,25,0.6);
            color: var(--text-muted);
            padding: 15px 16px;
            text-align: left;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--border-color);
        }

        td {
            padding: 16px;
            border-bottom: 1px solid var(--border-color);
            color: #d1d5db;
            font-size: 12px;
            white-space: nowrap;
        }

        tr:hover td {
            background: rgba(99,102,241,0.04);
        }

        .id {
            color: #818cf8;
            font-family: 'JetBrains Mono', monospace;
            font-weight: 700;
        }

        .username {
            color: white;
            font-weight: 700;
        }

        .email {
            color: #cbd5e1;
        }

        .role {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            background: rgba(99,102,241,0.12);
            color: #a5b4fc;
            border: 1px solid rgba(99,102,241,0.2);
            font-size: 10px;
            font-weight: 700;
        }

        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
        }

        .status-active {
            background: rgba(16,185,129,0.1);
            color: #34d399;
            border: 1px solid rgba(16,185,129,0.2);
        }

        .status-inactive {
            background: rgba(239,68,68,0.1);
            color: #f87171;
            border: 1px solid rgba(239,68,68,0.2);
        }

        .date {
            color: #cbd5e1;
            font-family: 'JetBrains Mono', monospace;
            font-size: 11px;
        }

        .never {
            color: var(--text-muted);
            font-style: italic;
        }

        /* =========================================================
           ACTIONS
           ========================================================= */

        .actions {
            display: flex;
            gap: 7px;
        }

        .action-btn {
            padding: 7px 10px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 10px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            border: 1px solid transparent;
        }

        .view-btn {
            background: rgba(6,182,212,0.1);
            color: #22d3ee;
            border-color: rgba(6,182,212,0.2);
        }

        .edit-btn {
            background: rgba(99,102,241,0.1);
            color: #818cf8;
            border-color: rgba(99,102,241,0.2);
        }

        .delete-btn {
            background: rgba(239,68,68,0.1);
            color: #f87171;
            border-color: rgba(239,68,68,0.2);
        }

        .action-btn:hover {
            transform: translateY(-1px);
        }

        /* =========================================================
           EMPTY
           ========================================================= */

        .empty {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }

        .empty i {
            font-size: 38px;
            margin-bottom: 15px;
            color: #6366f1;
        }

        /* =========================================================
           FOOTER
           ========================================================= */

        .footer {
            padding: 0 36px 30px;
        }

        .dashboard-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--bg-card);
            color: var(--text-main);
            border: 1px solid var(--border-color);
            padding: 10px 18px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
        }

        @media (max-width: 1100px) {

            .summary {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 1200px) {

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
                padding: 20px;
            }

            .add-btn {
                width: 100%;
                justify-content: center;
            }

            .summary {
                grid-template-columns: 1fr;
            }

            .toolbar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box,
            .filter-select,
            .sort-select {
                width: 100%;
            }

            .footer {
                padding: 0 15px 20px;
            }
        }

    </style>

</head>

<body>

<div class="app">

    <!-- SIDEBAR -->

    <aside class="sidebar">

        <div class="logo">

            <div class="logo-title">
                Employee & Workforce Portal
            </div>


        </div>

        <div class="menu-title">
            Overview
        </div>

        <nav class="menu">

            <a href="${pageContext.request.contextPath}/dashboard">
                <span class="menu-mark"></span>
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/employee/list">
                <span class="menu-mark"></span>
                Employees
            </a>

            <a href="${pageContext.request.contextPath}/project/list">
                <span class="menu-mark"></span>
                Projects
            </a>

            <a href="${pageContext.request.contextPath}/client/list">
                <span class="menu-mark"></span>
                Clients
            </a>

        </nav>

        <div class="menu-title">
            Operations
        </div>

        <nav class="menu">

            <a href="${pageContext.request.contextPath}/attendance/admin">
                <span class="menu-mark"></span>
                Attendance
            </a>

            <a href="${pageContext.request.contextPath}/leave/admin">
                <span class="menu-mark"></span>
                Leave Approval
            </a>

            <a href="${pageContext.request.contextPath}/expense/admin">
                <span class="menu-mark"></span>
                Expenses
            </a>

            <a href="${pageContext.request.contextPath}/resignation/admin">
                <span class="menu-mark"></span>
                Resignation
            </a>

        </nav>

        <div class="menu-title">
            Administration
        </div>

        <nav class="menu">

            <a href="${pageContext.request.contextPath}/reports">
                <span class="menu-mark"></span>
                Reports
            </a>

            <a href="${pageContext.request.contextPath}/audit">
                <span class="menu-mark"></span>
                Audit Logs
            </a>

            <a href="${pageContext.request.contextPath}/admin/list"
               class="active">
                <span class="menu-mark"></span>
                Admin Portal
            </a>

            <a href="${pageContext.request.contextPath}/restore/employees">
                <span class="menu-mark"></span>
                Restore Employees
            </a>

        </nav>

        <div class="sidebar-bottom">

            <a class="logout"
               href="${pageContext.request.contextPath}/auth/logout">

                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                Logout

            </a>

        </div>

    </aside>


    <!-- MAIN -->

    <main class="main">

        <div class="container">

            <!-- HEADER -->

            <div class="header">

                <div>

                    <h2>
                        <i class="fa-solid fa-user-shield"></i>
                        Admin Dashboard
                    </h2>

                    <p>
                        Manage administrator accounts, roles,
                        access and account activity.
                    </p>

                </div>

                <a href="${pageContext.request.contextPath}/admin/create"
                   class="add-btn">

                    <i class="fa-solid fa-user-plus"></i>
                    Add New Admin

                </a>

            </div>


            <!-- SUMMARY -->

            <div class="summary">

                <div class="summary-card">

                    <div class="summary-top">

                        <span class="summary-label">
                            Total Administrators
                        </span>

                        <span class="summary-icon">
                            <i class="fa-solid fa-users-gear"></i>
                        </span>

                    </div>

                    <div class="summary-number">
                        ${totalAdmins}
                    </div>

                </div>


                <div class="summary-card">

                    <div class="summary-top">

                        <span class="summary-label">
                            Active Accounts
                        </span>

                        <span class="summary-icon">
                            <i class="fa-solid fa-circle-check"></i>
                        </span>

                    </div>

                    <div class="summary-number">
                        ${activeCount}
                    </div>

                </div>


                <div class="summary-card">

                    <div class="summary-top">

                        <span class="summary-label">
                            Inactive Accounts
                        </span>

                        <span class="summary-icon">
                            <i class="fa-solid fa-user-slash"></i>
                        </span>

                    </div>

                    <div class="summary-number">
                        ${inactiveCount}
                    </div>

                </div>


                <div class="summary-card">

                    <div class="summary-top">

                        <span class="summary-label">
                            Access Roles
                        </span>

                        <span class="summary-icon">
                            <i class="fa-solid fa-key"></i>
                        </span>

                    </div>

                    <div class="summary-number">
                        ${roleCount}
                    </div>

                </div>

            </div>


            <!-- SEARCH / FILTER -->

            <div class="toolbar">

                <div class="search-box">

                    <i class="fa-solid fa-magnifying-glass"></i>

                    <input type="text"
                           id="adminSearch"
                           placeholder="Search username or email..."
                           onkeyup="filterAdmins()">

                </div>


                <select id="statusFilter"
                        class="filter-select"
                        onchange="filterAdmins()">

                    <option value="">
                        All Status
                    </option>

                    <option value="ACTIVE">
                        Active
                    </option>

                    <option value="INACTIVE">
                        Inactive
                    </option>

                </select>


                <select id="roleFilter"
                        class="filter-select"
                        onchange="filterAdmins()">

                    <option value="">
                        All Roles
                    </option>

                    <c:forEach var="a" items="${admins}">

                        <option value="${a.role}">
                            ${a.role}
                        </option>

                    </c:forEach>

                </select>


                <select id="sortFilter"
                        class="sort-select"
                        onchange="sortAdmins()">

                    <option value="">
                        Default Order
                    </option>

                    <option value="az">
                        Username A-Z
                    </option>

                    <option value="za">
                        Username Z-A
                    </option>

                    <option value="newest">
                        Newest Admin
                    </option>

                </select>

            </div>


            <!-- TABLE -->

            <div class="table-container">

                <c:choose>

                    <c:when test="${not empty admins}">

                        <table id="adminTable">

                            <thead>

                            <tr>

                                <th>ID</th>

                                <th>Administrator</th>

                                <th>Email</th>

                                <th>Role</th>

                                <th>Status</th>

                                <th>Created</th>

                                <th>Last Login</th>

                                <th>Actions</th>

                            </tr>

                            </thead>

                            <tbody>

                            <c:forEach var="admin"
                                       items="${admins}">

                                <tr class="admin-row"
                                    data-username="${admin.username}"
                                    data-email="${admin.email}"
                                    data-status="${admin.status}"
                                    data-role="${admin.role}"
                                    data-created="${admin.createdDate}">

                                    <td class="id">
                                        #${admin.adminId}
                                    </td>

                                    <td>

                                        <div class="username">
                                            ${admin.username}
                                        </div>

                                    </td>

                                    <td class="email">
                                        ${admin.email}
                                    </td>

                                    <td>

                                        <span class="role">
                                            ${admin.role}
                                        </span>

                                    </td>

                                    <td>

                                        <c:choose>

                                            <c:when test="${admin.status == 'ACTIVE'}">

                                                <span class="status status-active">

                                                    <i class="fa-solid fa-circle"></i>
                                                    ACTIVE

                                                </span>

                                            </c:when>

                                            <c:otherwise>

                                                <span class="status status-inactive">

                                                    <i class="fa-solid fa-circle"></i>
                                                    INACTIVE

                                                </span>

                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td class="date">

                                        <c:choose>

                                            <c:when test="${not empty admin.createdDate}">
                                                ${admin.createdDate}
                                            </c:when>

                                            <c:otherwise>
                                                -
                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td>

                                        <c:choose>

                                            <c:when test="${not empty admin.lastLogin}">

                                                <span class="date">
                                                    ${admin.lastLogin}
                                                </span>

                                            </c:when>

                                            <c:otherwise>

                                                <span class="never">
                                                    Never logged in
                                                </span>

                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td>

                                        <div class="actions">

                                            <a href="${pageContext.request.contextPath}/admin/details/${admin.adminId}"
                                               class="action-btn view-btn">

                                                <i class="fa-solid fa-eye"></i>
                                                View

                                            </a>

                                            <a href="${pageContext.request.contextPath}/admin/edit/${admin.adminId}"
                                               class="action-btn edit-btn">

                                                <i class="fa-solid fa-pen"></i>
                                                Edit

                                            </a>

                                            <a href="${pageContext.request.contextPath}/admin/delete/${admin.adminId}"
                                               class="action-btn delete-btn"
                                               onclick="return confirm('Are you sure you want to delete this administrator?');">

                                                <i class="fa-solid fa-trash"></i>
                                                Delete

                                            </a>

                                        </div>

                                    </td>

                                </tr>

                            </c:forEach>

                            </tbody>

                        </table>

                    </c:when>


                    <c:otherwise>

                        <div class="empty">

                            <i class="fa-solid fa-user-shield"></i>

                            <div>
                                No administrators found.
                            </div>

                        </div>

                    </c:otherwise>

                </c:choose>

            </div>


            <!-- FOOTER -->

            <div class="footer">

                <a href="${pageContext.request.contextPath}/dashboard"
                   class="dashboard-btn">

                    <i class="fa-solid fa-arrow-left"></i>
                    Dashboard

                </a>

            </div>

        </div>

    </main>

</div>


<script>

    function filterAdmins() {

        const search =
            document.getElementById("adminSearch")
                .value
                .toLowerCase();

        const status =
            document.getElementById("statusFilter")
                .value
                .toLowerCase();

        const role =
            document.getElementById("roleFilter")
                .value
                .toLowerCase();

        const rows =
            document.querySelectorAll(".admin-row");

        rows.forEach(function(row) {

            const username =
                row.dataset.username.toLowerCase();

            const email =
                row.dataset.email.toLowerCase();

            const rowStatus =
                row.dataset.status.toLowerCase();

            const rowRole =
                row.dataset.role.toLowerCase();

            const searchMatch =
                username.includes(search) ||
                email.includes(search);

            const statusMatch =
                !status ||
                rowStatus === status;

            const roleMatch =
                !role ||
                rowRole === role;

            row.style.display =
                searchMatch &&
                statusMatch &&
                roleMatch
                    ? ""
                    : "none";

        });

    }


    function sortAdmins() {

        const value =
            document.getElementById("sortFilter").value;

        const tbody =
            document.querySelector("#adminTable tbody");

        if (!tbody) {
            return;
        }

        const rows =
            Array.from(
                tbody.querySelectorAll(".admin-row")
            );

        rows.sort(function(a, b) {

            if (value === "az") {

                return a.dataset.username
                    .localeCompare(
                        b.dataset.username
                    );

            }

            if (value === "za") {

                return b.dataset.username
                    .localeCompare(
                        a.dataset.username
                    );

            }

            if (value === "newest") {

                return b.dataset.created
                    .localeCompare(
                        a.dataset.created
                    );

            }

            return 0;

        });

        rows.forEach(function(row) {
            tbody.appendChild(row);
        });

    }

</script>

</body>
</html>