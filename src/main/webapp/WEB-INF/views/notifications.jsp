
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap"
          rel="stylesheet">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-primary: #0b0f19;
            --bg-secondary: #111827;
            --bg-card: #1f2937;
            --border-color: rgba(255,255,255,.08);
            --border-hover: rgba(99,102,241,.4);
            --text-main: #f3f4f6;
            --text-muted: #9ca3af;
            --accent-primary: #6366f1;
            --accent-secondary: #06b6d4;
            --success: #10b981;
            --danger: #ef4444;
            --transition: all .3s ease;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--bg-primary);
            color: var(--text-main);
            min-height: 100vh;
            background-image:
                radial-gradient(circle at 10% 10%,
                    rgba(99,102,241,.08), transparent 40%),
                radial-gradient(circle at 90% 90%,
                    rgba(6,182,212,.06), transparent 40%);
            background-attachment: fixed;
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
            inset: 0 auto 0 0;
            z-index: 20;
            display: flex;
            flex-direction: column;
            box-shadow: 10px 0 30px rgba(0,0,0,.3);
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

        .menu a:hover,
        .menu a.active {
            color: #fff;
            background: rgba(99,102,241,.12);
            border-color: rgba(99,102,241,.25);
        }

        .menu a.active {
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
            border: 1px solid rgba(239,68,68,.2);
            border-radius: 12px;
            color: var(--danger);
            font-size: 13px;
            font-weight: 600;
            background: rgba(239,68,68,.05);
            transition: var(--transition);
        }

        .logout:hover {
            background: rgba(239,68,68,.15);
        }

        /* MAIN */
        .main {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 36px 40px 48px;
        }

        .container {
            width: 100%;
            max-width: 1000px;
            margin: auto;
            background: var(--bg-card);
            border-radius: 20px;
            padding: 32px;
            box-shadow: 0 10px 30px rgba(0,0,0,.3);
            border: 1px solid var(--border-color);
        }

        .header {
            background: linear-gradient(135deg,
                rgba(31,41,55,.7), rgba(17,24,39,.8));
            border: 1px solid var(--border-color);
            border-radius: 18px;
            padding: 24px 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
        }

        .header::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg,
                var(--accent-primary), var(--accent-secondary));
        }

        .header h1 {
            color: #fff;
            font-size: 24px;
            font-weight: 800;
        }

        .header p {
            margin-top: 6px;
            color: var(--text-muted);
            font-size: 13px;
        }

        .notification {
            background: rgba(17,24,39,.5);
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 16px;
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 15px rgba(0,0,0,.1);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .notification:hover {
            transform: translateY(-2px);
            border-color: var(--border-hover);
            box-shadow: 0 10px 25px rgba(99,102,241,.15);
        }

        .notification.unread {
            border-left: 4px solid var(--accent-primary);
            background: rgba(99,102,241,.07);
        }

        .notification.read {
            border-left: 4px solid var(--success);
            opacity: .9;
        }

        .notification-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 10px;
        }

        .type {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(99,102,241,.12);
            color: #a5b4fc;
            border: 1px solid rgba(99,102,241,.2);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .5px;
        }

        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
        }

        .status.unread-status {
            color: #c7d2fe;
            background: rgba(99,102,241,.15);
        }

        .status.read-status {
            color: #6ee7b7;
            background: rgba(16,185,129,.12);
        }

        .message {
            margin: 10px 0;
            color: var(--text-main);
            font-size: 14px;
            line-height: 1.7;
            overflow-wrap: anywhere;
        }

        .small {
            color: var(--text-muted);
            font-size: 11px;
            margin-bottom: 14px;
            font-family: 'JetBrains Mono', monospace;
        }

        .read-btn {
            border: none;
            padding: 9px 16px;
            border-radius: 8px;
            background: linear-gradient(135deg,
                var(--accent-primary), #4f46e5);
            color: white;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(99,102,241,.3);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .read-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(99,102,241,.5);
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 15px;
            padding: 12px 22px;
            background: var(--bg-secondary);
            color: var(--text-main);
            text-decoration: none;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
            border: 1px solid var(--border-color);
            transition: var(--transition);
        }

        .back-btn:hover {
            background: rgba(99,102,241,.1);
            border-color: var(--border-hover);
        }

        .empty {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
            font-size: 14px;
        }

        .empty i {
            display: block;
            font-size: 32px;
            margin-bottom: 12px;
        }

        @media (max-width: 1200px) {
            .sidebar { width: 220px; }
            .main {
                margin-left: 220px;
                width: calc(100% - 220px);
                padding: 24px;
            }
        }

        @media (max-width: 750px) {
            .app { display: block; }
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }
            .menu {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                max-height: none;
            }
            .main {
                margin-left: 0;
                width: 100%;
                padding: 16px;
            }
            .container { padding: 20px; }
            .header { display: block; }
        }
    </style>
</head>

<body>
<div class="app">

    <!-- ROLE-BASED SIDEBAR -->
    <aside class="sidebar">
        <div class="logo">
            <div class="logo-title">Employee &amp; Workforce</div>
            <div class="logo-subtitle">Management System</div>
        </div>

        <c:choose>
            <c:when test="${sessionScope.role == 'ROLE_ADMIN'}">

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
                    <a href="${pageContext.request.contextPath}/notifications"
                       class="active">
                        <span class="menu-mark"></span>Notifications
                    </a>
                </nav>

            </c:when>

            <c:otherwise>

                <div class="menu-title">My Workspace</div>
                <nav class="menu">
                    <a href="${pageContext.request.contextPath}/employee/dashboard">
                        <span class="menu-mark"></span>Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/attendance/my">
                        <span class="menu-mark"></span>My Attendance
                    </a>
                    <a href="${pageContext.request.contextPath}/leave/my">
                        <span class="menu-mark"></span>My Leave
                    </a>
                    <a href="${pageContext.request.contextPath}/expense/my">
                        <span class="menu-mark"></span>My Expenses
                    </a>
                    <a href="${pageContext.request.contextPath}/resignation/my">
                        <span class="menu-mark"></span>My Resignation
                    </a>
                    <a href="${pageContext.request.contextPath}/notifications"
                       class="active">
                        <span class="menu-mark"></span>Notifications
                    </a>
                </nav>

            </c:otherwise>
        </c:choose>

        <div class="sidebar-bottom">
            <a class="logout"
               href="${pageContext.request.contextPath}/auth/logout">
                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                Logout
            </a>
        </div>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main">
        <div class="container">

            <div class="header">
                <div>
                    <h1>
                        <i class="fa-regular fa-bell"></i>
                        Notifications
                    </h1>
                    <p>View and manage your latest system notifications.</p>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty notifications}">
                    <div class="empty">
                        <i class="fa-regular fa-bell-slash"></i>
                        No notifications available.
                    </div>
                </c:when>

                <c:otherwise>

                    <c:forEach var="n" items="${notifications}">

                        <c:url var="readUrl"
                               value="/notifications/read/${n.id}" />

                        <div class="notification
                            ${n.readFlag ? 'read' : 'unread'}">

                            <div class="notification-top">
                                <span class="type">
                                    <i class="fa-solid fa-circle-info"></i>
                                    <c:out value="${n.type}" />
                                </span>

                                <c:choose>
                                    <c:when test="${n.readFlag}">
                                        <span class="status read-status">
                                            <i class="fa-solid fa-check-double"></i>
                                            Read
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="status unread-status">
                                            <i class="fa-solid fa-circle"></i>
                                            Unread
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="message">
                                <c:out value="${n.message}" />
                            </div>

                            <div class="small">
                                <i class="fa-regular fa-clock"></i>
                                <c:out value="${n.createdAt}" />
                            </div>

                            <c:if test="${not n.readFlag}">
                                <form method="post"
                                      action="${readUrl}">

                                    <%-- Include CSRF token when Spring Security is enabled --%>
                                    <c:if test="${not empty _csrf}">
                                        <input type="hidden"
                                               name="${_csrf.parameterName}"
                                               value="${_csrf.token}" />
                                    </c:if>

                                    <button type="submit" class="read-btn">
                                        <i class="fa-solid fa-check"></i>
                                        Mark Read
                                    </button>
                                </form>
                            </c:if>

                        </div>

                    </c:forEach>

                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${sessionScope.role == 'ROLE_ADMIN'}">
                    <a href="${pageContext.request.contextPath}/dashboard"
                       class="back-btn">
                        <i class="fa-solid fa-arrow-left"></i>
                        Back to Dashboard
                    </a>
                </c:when>

                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/employee/dashboard"
                       class="back-btn">
                        <i class="fa-solid fa-arrow-left"></i>
                        Back to My Dashboard
                    </a>
                </c:otherwise>
            </c:choose>

        </div>
    </main>
</div>
</body>
</html>
