<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Leave</title>

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

        .container {
            max-width: 1200px;
            margin: auto;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 36px;
            margin-bottom: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.6s ease;
        }

        .header::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .header h1 {
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

        /* Balance Card */
        .balance-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 36px;
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border-left: 4px solid var(--accent-primary);
            animation: slideUp 0.5s ease;
            transition: var(--transition);
        }

        .balance-card:hover {
            border-color: var(--border-hover);
            box-shadow: 0 15px 35px var(--accent-glow);
        }

        .balance-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .balance-number {
            font-size: 32px;
            font-weight: 800;
            color: #818cf8;
            font-family: 'JetBrains Mono', monospace;
        }

        .balance-text {
            color: var(--text-muted);
            font-size: 13px;
            line-height: 1.5;
        }

        .balance-text strong {
            color: #fff;
            font-size: 14px;
            font-weight: 700;
        }

        .apply-btn {
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
            white-space: nowrap;
        }

        .apply-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        /* Table Card */
        .table-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 32px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow-x: auto;
            animation: slideUp 0.6s ease;
        }

        table {
            width: 100%;
            min-width: 900px;
            border-collapse: collapse;
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

        .leave-type {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.2);
            color: #818cf8;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .dates {
            white-space: nowrap;
            color: var(--text-main);
            font-family: 'JetBrains Mono', monospace;
            font-size: 12px;
        }

        .days {
            font-weight: 700;
            color: #22d3ee;
            text-align: center;
            font-family: 'JetBrains Mono', monospace;
        }

        .reason {
            max-width: 240px;
            color: var(--text-muted);
            line-height: 1.5;
            font-size: 12px;
        }

        .comment {
            max-width: 220px;
            color: var(--text-muted);
            line-height: 1.5;
            font-size: 12px;
        }

        .status {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: #fbbf24;
            border: 1px solid rgba(245, 158, 11, 0.2);
        }

        .status-approved {
            background: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .status-rejected {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .empty {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-muted);
        }

        .empty h2 {
            color: #fff;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .empty p {
            font-size: 13px;
        }

        .back {
            margin-top: 24px;
        }

        .back a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: var(--text-main);
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 12px 24px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .back a:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 650px) {
            body { padding: 20px 10px; }
            .header { padding: 20px; }
            .header h1 { font-size: 22px; }
            .balance-card { flex-direction: column; align-items: flex-start; padding: 20px; }
            .balance-info { flex-direction: column; align-items: flex-start; gap: 8px; }
            .apply-btn { width: 100%; justify-content: center; }
            .table-card { padding: 20px; }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>My Leave</h1>
        <p>View your leave balance and track submitted leave requests history</p>
    </div>

    <div class="balance-card">
        <div class="balance-info">
            <div class="balance-number">
                ${balance.remainingDays}
            </div>
            <div class="balance-text">
                <strong>Days Remaining</strong><br>
                out of ${balance.allocatedDays} allocated days
            </div>
        </div>

        <a class="apply-btn" href="${pageContext.request.contextPath}/leave/apply">
            <i class="fa-solid fa-calendar-plus"></i> Apply Leave
        </a>
    </div>

    <div class="table-card">
        <c:choose>
            <c:when test="${empty requests}">
                <div class="empty">
                    <i class="fa-solid fa-folder-open" style="font-size: 28px; margin-bottom: 10px; display: block; color: var(--accent-primary);"></i>
                    <h2>No Leave Requests</h2>
                    <p>You have not submitted any leave requests yet.</p>
                </div>
            </c:when>

            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Dates</th>
                            <th>Days</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Comment</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="l" items="${requests}">
                            <tr>
                                <td>
                                    <span class="leave-type">${l.leaveType}</span>
                                </td>
                                <td class="dates">${l.startDate} to ${l.endDate}</td>
                                <td class="days">${l.days}</td>
                                <td class="reason">${l.reason}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${l.status == 'PENDING'}">
                                            <span class="status status-pending">PENDING</span>
                                        </c:when>
                                        <c:when test="${l.status == 'APPROVED'}">
                                            <span class="status status-approved">APPROVED</span>
                                        </c:when>
                                        <c:when test="${l.status == 'REJECTED'}">
                                            <span class="status status-rejected">REJECTED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status" style="background: rgba(156, 163, 175, 0.1); color: var(--text-muted); border: 1px solid rgba(156, 163, 175, 0.2);">
                                                ${l.status}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="comment">${l.adminComment}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="back">
        <a href="${pageContext.request.contextPath}/employee/dashboard">
            <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>