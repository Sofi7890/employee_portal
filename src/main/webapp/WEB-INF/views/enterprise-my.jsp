<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Enterprise HR - Self Service</title>

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
            max-width: 1150px;
            margin: auto;
        }

        /* Top Header */
        .top-header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 36px;
            margin-bottom: 28px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .top-header::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .top-header h1 {
            margin: 0;
            color: #fff;
            font-size: 26px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .muted {
            color: var(--text-muted);
            font-size: 13px;
            margin-top: 6px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: var(--text-main);
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 12px 20px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            white-space: nowrap;
        }

        .back-link:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        /* Grid Cards */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }

        .card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px;
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
        }

        .card:hover {
            transform: translateY(-3px);
            border-color: var(--border-hover);
            box-shadow: 0 15px 35px var(--accent-glow);
        }

        .card h2 {
            font-size: 16px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card p {
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card p b {
            color: var(--text-main);
            font-family: 'JetBrains Mono', monospace;
        }

        .net-salary-box {
            margin-top: 16px;
            padding-top: 14px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .net-salary-box h3 {
            font-size: 18px;
            font-weight: 800;
            color: #34d399;
            font-family: 'JetBrains Mono', monospace;
        }

        /* Lists formatting */
        .item-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .item-row {
            padding: 12px 14px;
            background: rgba(11, 15, 25, 0.5);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            font-size: 13px;
        }

        .item-row b {
            color: #fff;
        }

        /* Table Styling */
        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 800px;
            border-collapse: collapse;
        }

        th {
            background: rgba(17, 24, 39, 0.8);
            color: var(--text-muted);
            padding: 16px 18px;
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
            font-family: 'JetBrains Mono', monospace;
        }

        td:first-child {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-weight: 600;
            color: #fff;
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

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .payslip-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
            color: #818cf8;
            background: rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.2);
            padding: 6px 12px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 600;
            transition: var(--transition);
            margin-left: 12px;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .payslip-link:hover {
            background: rgba(99, 102, 241, 0.2);
            color: #fff;
            transform: translateY(-1px);
        }

        @media (max-width: 850px) {
            body { padding: 20px 10px; }
            .top-header { flex-direction: column; align-items: flex-start; gap: 16px; padding: 20px; }
            .back-link { width: 100%; justify-content: center; }
            .grid { grid-template-columns: 1fr; }
            .card { padding: 20px; }
        }
    </style>
</head>

<body>

<div class="wrap">

    <!-- Top Header Bar -->
    <div class="top-header">
        <div>
            <h1>My Enterprise HR</h1>
            <p class="muted">Access your assigned salary structure, performance goals, compliance documents, and payroll history.</p>
        </div>
        <a class="back-link" href="${pageContext.request.contextPath}/employee/dashboard">
            <i class="fa-solid fa-arrow-left"></i> My Dashboard
        </a>
    </div>

    <!-- Top Info Grid Cards -->
    <div class="grid">
        <!-- My Salary Card -->
        <div class="card">
            <h2><i class="fa-solid fa-wallet" style="color: #34d399;"></i> My Salary Structure</h2>
            <c:choose>
                <c:when test="${not empty salary}">
                    <p>Basic Salary: <b>Rs. ${salary.basicSalary}</b></p>
                    <p>HRA Allowance: <b>Rs. ${salary.hra}</b></p>
                    <p>Other Allowances: <b>Rs. ${salary.allowances}</b></p>
                    <p>Total Deductions: <b style="color: #f87171;">Rs. ${salary.totalDeductions}</b></p>
                    <div class="net-salary-box">
                        <span style="font-size: 13px; font-weight: 700; color: var(--text-muted);">Net Compensation</span>
                        <h3>Rs. ${salary.netSalary}</h3>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="muted" style="text-align: center; padding: 20px 0;">No salary structure assigned yet.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- My Goals Card -->
        <div class="card">
            <h2><i class="fa-solid fa-bullseye" style="color: #f59e0b;"></i> My Performance Goals</h2>
            <div class="item-list">
                <c:choose>
                    <c:when test="${not empty goals}">
                        <c:forEach var="g" items="${goals}">
                            <div class="item-row">
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
                                    <span style="font-size: 10px; font-weight: 700; text-transform: uppercase; background: rgba(99, 102, 241, 0.1); color: #818cf8; border: 1px solid rgba(99, 102, 241, 0.2); padding: 2px 8px; border-radius: 6px;">${g.goalType}</span>
                                    <span style="font-family: 'JetBrains Mono', monospace; font-size: 12px; color: #22d3ee; font-weight: 700;">${g.progressPercent}%</span>
                                </div>
                                <div style="font-size: 13px; font-weight: 600; color: #fff;">${g.title}</div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="muted" style="text-align: center; padding: 20px 0;">No active goals found.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- My Documents Card -->
        <div class="card">
            <h2><i class="fa-solid fa-folder-open" style="color: #fbbf24;"></i> My Documents</h2>
            <div class="item-list">
                <c:choose>
                    <c:when test="${not empty documents}">
                        <c:forEach var="d" items="${documents}">
                            <div class="item-row">
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 4px;">
                                    <span style="font-size: 10px; font-weight: 700; text-transform: uppercase; color: #818cf8;">${d.documentType}</span>
                                    <span style="font-size: 11px; color: var(--text-muted);">Expiry: ${d.expiryDate}</span>
                                </div>
                                <div style="font-size: 13px; font-weight: 600; color: #fff;">${d.documentName}</div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="muted" style="text-align: center; padding: 20px 0;">No documents recorded.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Payroll History Panel Table -->
    <div class="card" style="margin-top: 24px;">
        <h2><i class="fa-solid fa-file-invoice-dollar" style="color: #22d3ee;"></i> My Payroll & Payslips History</h2>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Period</th>
                        <th>Gross Pay</th>
                        <th>Deductions</th>
                        <th>Net Pay</th>
                        <th>Status / Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty payroll}">
                            <c:forEach var="p" items="${payroll}">
                                <tr>
                                    <td>${p.payrollMonth} / ${p.payrollYear}</td>
                                    <td style="color: #22d3ee;">${p.gross}</td>
                                    <td style="color: #f87171;">${p.deductions}</td>
                                    <td><b style="color: #34d399;">${p.net}</b></td>
                                    <td>
                                        <span class="status-badge">${p.status}</span>
                                        <a class="payslip-link" href="${pageContext.request.contextPath}/enterprise/payslip/${p.id}">
                                            <i class="fa-solid fa-print"></i> View Payslip
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="muted" style="text-align: center; padding: 40px 0; font-family: 'Plus Jakarta Sans', sans-serif;">
                                    No payroll records processed for your account yet.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>