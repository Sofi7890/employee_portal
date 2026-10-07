<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard - Self Service</title>

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
            width: 100%;
            max-width: 1250px;
            margin: auto;
            animation: fadeIn 0.6s ease;
        }

        /* Top Navigation Header bar */
        .nav {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            color: white;
            padding: 22px 36px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
        }

        .nav::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .nav-title {
            font-size: 18px;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-title i {
            color: var(--accent-secondary);
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: var(--text-main);
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .nav-links a:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        .nav-links a.salary-link {
            background: rgba(6, 182, 212, 0.1);
            color: #22d3ee;
            border-color: rgba(6, 182, 212, 0.2);
        }

        .nav-links a.salary-link:hover {
            background: rgba(6, 182, 212, 0.2);
            color: #fff;
        }

        .logout {
            background: rgba(239, 68, 68, 0.1) !important;
            border: 1px solid rgba(239, 68, 68, 0.3) !important;
            color: var(--danger) !important;
        }

        .logout:hover {
            background: rgba(239, 68, 68, 0.2) !important;
            border-color: rgba(239, 68, 68, 0.5) !important;
        }

        /* Welcome Card */
        .welcome {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 36px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            gap: 24px;
        }

        .welcome::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .welcome-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            border: 3px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 28px;
            font-weight: 800;
            flex-shrink: 0;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        .welcome-content h1 {
            margin: 0;
            color: #fff;
            font-size: 26px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .welcome-content p {
            margin: 6px 0 0;
            color: var(--text-muted);
            font-size: 13px;
        }

        /* Metrics Grid Cards */
        .grid {
            display: grid;
            grid-template-columns: repeat(5, minmax(0, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 24px 20px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            position: relative;
            overflow: hidden;
            transition: var(--transition);
        }

        .card::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
            opacity: 0.3;
            transition: var(--transition);
        }

        .card:hover {
            transform: translateY(-4px);
            border-color: var(--border-hover);
            box-shadow: 0 15px 35px var(--accent-glow);
        }

        .card:hover::after {
            opacity: 1;
        }

        .card b {
            color: var(--text-muted);
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            font-weight: 700;
            display: block;
            margin-bottom: 8px;
        }

        .card h2 {
            margin: 0;
            color: #fff;
            font-size: 26px;
            font-weight: 800;
            font-family: 'JetBrains Mono', monospace;
        }

        /* Employee Section Table */
        .employee-section {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            margin-bottom: 28px;
            padding: 32px;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            position: relative;
            overflow: hidden;
        }

        .employee-section::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .section-title {
            margin: 0 0 20px;
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            background: transparent;
            border-collapse: collapse;
            min-width: 800px;
        }

        th {
            background: rgba(17, 24, 39, 0.8);
            color: var(--text-muted);
            padding: 14px 18px;
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

        tbody tr {
            transition: var(--transition);
        }

        tbody tr:hover {
            background: rgba(99, 102, 241, 0.04);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .status {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.2);
            color: #34d399;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Services Links Section */
        .links-section {
            margin-bottom: 30px;
        }

        .links-title {
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            margin: 0 0 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .links {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
        }

        .links a {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 22px;
            border-radius: 20px;
            text-decoration: none;
            color: var(--text-main);
            font-weight: 700;
            font-size: 13px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .links a::after {
            content: '\f054';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            font-size: 11px;
            color: var(--text-muted);
            transition: var(--transition);
        }

        .links a::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
            opacity: 0.3;
            transition: var(--transition);
        }

        .links a:hover {
            transform: translateY(-4px);
            color: #fff;
            background: rgba(99, 102, 241, 0.08);
            border-color: var(--border-hover);
            box-shadow: 0 15px 35px var(--accent-glow);
        }

        .links a:hover::after {
            color: var(--accent-secondary);
            transform: translateX(3px);
        }

        .links a:hover::before {
            opacity: 1;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 1200px) {
            .grid { grid-template-columns: repeat(3, minmax(0, 1fr)); }
            .links { grid-template-columns: repeat(3, minmax(0, 1fr)); }
        }

        @media (max-width: 900px) {
            .grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
            .links { grid-template-columns: repeat(2, minmax(0, 1fr)); }
        }

        @media (max-width: 700px) {
            body { padding: 20px 10px; }

            .nav {
                flex-direction: column;
                gap: 14px;
                align-items: flex-start;
                padding: 20px;
            }

            .nav-links {
                width: 100%;
                flex-wrap: wrap;
            }

            .nav-links a {
                flex: 1;
                justify-content: center;
            }

            .wrap { width: 100%; }

            .welcome { flex-direction: column; align-items: flex-start; padding: 24px 20px; }
            .welcome h1 { font-size: 22px; }

            .grid, .links { grid-template-columns: 1fr; }
            .employee-section { padding: 20px; }
        }
    </style>

</head>

<body>

    <div class="wrap">

        <!-- Top Navigation Header -->
        <div class="nav">
            <div class="nav-title">
                <i class="fa-solid fa-id-badge"></i> Employee Self-Service Portal
            </div>

            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/enterprise/my" class="salary-link">
                    <i class="fa-solid fa-wallet"></i> Salary & Performance
                </a>
                <a href="${pageContext.request.contextPath}/notifications">
                    <i class="fa-regular fa-bell"></i> Notifications
                </a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="logout">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
                </a>
            </div>
        </div>

        <!-- Welcome Box -->
        <div class="welcome">
            <div class="welcome-avatar">
                <c:choose>
                    <c:when test="${not empty employee.imagePath}">
                        <img src="${pageContext.request.contextPath}/employee/image/${employee.employeeId}"
                             alt="${employee.employeeName}"
                             style="width:100%;height:100%;object-fit:cover;border-radius:50%;">
                    </c:when>
                    <c:when test="${not empty employee.employeeName}">
                        ${employee.employeeName.substring(0,1).toUpperCase()}
                    </c:when>
                    <c:otherwise>E</c:otherwise>
                </c:choose>
            </div>
            <div class="welcome-content">
                <h1>Welcome back, ${employee.employeeName}</h1>
                <p>Manage your attendance, leave, expenses, and resignation requests efficiently from your secure dashboard.</p>
            </div>
        </div>

        <!-- Metrics Cards Grid -->
        <div class="grid">
            <div class="card">
                <b>Employee ID</b>
                <h2>${employee.employeeId}</h2>
            </div>

            <div class="card">
                <b>Leave Remaining</b>
                <h2 style="color: var(--success);">${balance.remainingDays}</h2>
            </div>

            <div class="card">
                <b>Attendance Records</b>
                <h2 style="color: var(--accent-secondary);">${attendanceCount}</h2>
            </div>

            <div class="card">
                <b>Pending Leave</b>
                <h2 style="color: var(--warning);">${pendingLeaves}</h2>
            </div>

            <div class="card">
                <b>Pending Expenses</b>
                <h2 style="color: #f87171;">${pendingExpenses}</h2>
            </div>
        </div>

        <!-- Employee Info Table Section -->
        <div class="employee-section">
            <h2 class="section-title"><i class="fa-regular fa-user-circle"></i> Employee Information</h2>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Department</th>
                            <th>Joining Date</th>
                            <th>Project</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="font-weight: 700; color: #fff;">${employee.employeeName}</td>
                            <td style="font-family: 'JetBrains Mono', monospace; color: #818cf8; font-size: 12px;">${employee.employeeEmail}</td>
                            <td><span style="display:inline-block; padding: 4px 10px; background: rgba(99, 102, 241, 0.1); color: #818cf8; border-radius: 6px; font-weight: 600; font-size: 11px;">${employee.employeeDept}</span></td>
                            <td style="font-family: 'JetBrains Mono', monospace; font-size: 12px; color: var(--text-muted);">${employee.dateOfJoining}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${employee.project != null}">
                                        <span style="color: #22d3ee; font-weight: 600;">${employee.project.projectName}</span>
                                    </c:when>
                                    <c:otherwise><span style="color: #fbbf24; font-weight: 600;">Bench</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <span class="status">${empty employee.employmentStatus ? 'ACTIVE' : employee.employmentStatus}</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Employee Services Quick Links -->
        <div class="links-section">
            <h2 class="links-title"><i class="fa-solid fa-layer-group"></i> Employee Services</h2>
            <div class="links">
                <a href="${pageContext.request.contextPath}/attendance/my">
                    <span><i class="fa-solid fa-clock-rotate-left" style="color: var(--accent-secondary); margin-right: 8px;"></i> My Attendance</span>
                </a>
                <a href="${pageContext.request.contextPath}/leave/my">
                    <span><i class="fa-solid fa-calendar-days" style="color: var(--success); margin-right: 8px;"></i> My Leave</span>
                </a>
                <a href="${pageContext.request.contextPath}/leave/apply">
                    <span><i class="fa-solid fa-calendar-plus" style="color: var(--warning); margin-right: 8px;"></i> Apply Leave</span>
                </a>
                <a href="${pageContext.request.contextPath}/expense/my">
                    <span><i class="fa-solid fa-receipt" style="color: #8b5cf6; margin-right: 8px;"></i> My Expenses</span>
                </a>
                <a href="${pageContext.request.contextPath}/expense/apply">
                    <span><i class="fa-solid fa-file-invoice-dollar" style="color: var(--accent-primary); margin-right: 8px;"></i> Submit Expense</span>
                </a>
                <a href="${pageContext.request.contextPath}/resignation/my">
                    <span><i class="fa-solid fa-file-shield" style="color: #f87171; margin-right: 8px;"></i> Resignation Status</span>
                </a>
                <a href="${pageContext.request.contextPath}/resignation/apply">
                    <span><i class="fa-solid fa-file-pen" style="color: #ec4899; margin-right: 8px;"></i> Submit Resignation</span>
                </a>
                <a href="${pageContext.request.contextPath}/enterprise/my">
                    <span><i class="fa-solid fa-wallet" style="color: #34d399; margin-right: 8px;"></i> Salary & Performance</span>
                </a>
            </div>
        </div>

    </div>

</body>

</html>