<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise HR Control Center</title>

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
            max-width: 1200px;
            margin: auto;
        }

        /* Top Header */
        .top {
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

        .top::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .top h1 {
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

        .back-admin-btn {
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

        .back-admin-btn:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        /* KPI Metrics Grid */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }

        .card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 24px;
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
            transform: translateY(-4px);
            border-color: var(--border-hover);
            box-shadow: 0 15px 35px var(--accent-glow);
        }

        .card .muted {
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .num {
            font-size: 28px;
            font-weight: 800;
            color: #fff;
            font-family: 'JetBrains Mono', monospace;
        }

        /* Module Links Grid */
        .links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }

        .links a {
            padding: 22px;
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            color: var(--text-main);
            text-decoration: none;
            transition: var(--transition);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .links a:hover {
            background: rgba(99, 102, 241, 0.08);
            border-color: var(--border-hover);
            color: #fff;
            transform: translateY(-4px);
            box-shadow: 0 15px 35px var(--accent-glow);
        }

        .links a b {
            font-size: 15px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #fff;
        }

        .links a span.muted {
            font-size: 12px;
            margin: 0;
        }

        /* Self-service enterprise footer link */
        .self-service-box {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 20px 24px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .self-service-box a {
            color: #818cf8;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
        }

        .self-service-box a:hover {
            color: #fff;
            transform: translateY(-1px);
        }

        @media (max-width: 750px) {
            body { padding: 20px 10px; }
            .top { flex-direction: column; align-items: flex-start; gap: 16px; padding: 20px; }
            .back-admin-btn { width: 100%; justify-content: center; }
            .grid, .links { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

<div class="wrap">

    <!-- Top Header -->
    <div class="top">
        <div>
            <h1>Enterprise Control Center</h1>
            <p class="muted">Payroll &bull; Approvals &bull; Performance &bull; Lifecycle &bull; Documents &bull; Time</p>
        </div>
        <a class="back-admin-btn" href="${pageContext.request.contextPath}/dashboard">
            <i class="fa-solid fa-arrow-left"></i> Back to Admin
        </a>
    </div>

    <!-- KPI Metric Cards -->
    <div class="grid">
        <div class="card">
            <div class="muted">Salary Structures</div>
            <div class="num">${salaryCount}</div>
        </div>
        <div class="card">
            <div class="muted">Payroll Records</div>
            <div class="num">${payrollCount}</div>
        </div>
        <div class="card">
            <div class="muted">Pending Approvals</div>
            <div class="num">${pendingApprovals}</div>
        </div>
        <div class="card">
            <div class="muted">Open Goals</div>
            <div class="num">${openGoals}</div>
        </div>
    </div>

    <!-- Module Navigation Grid -->
    <div class="links">
        <a href="${pageContext.request.contextPath}/enterprise/salary">
            <b><i class="fa-solid fa-wallet" style="color: #34d399;"></i> Salary & Compensation</b>
            <span class="muted">Salary structure, PF, tax and net pay calculations</span>
        </a>
        <a href="${pageContext.request.contextPath}/enterprise/payroll">
            <b><i class="fa-solid fa-file-invoice-dollar" style="color: #22d3ee;"></i> Payroll & Payslips</b>
            <span class="muted">Process monthly payroll and history records</span>
        </a>
        <a href="${pageContext.request.contextPath}/enterprise/documents">
            <b><i class="fa-solid fa-folder-open" style="color: #fbbf24;"></i> Employee Documents</b>
            <span class="muted">HR documents storage and expiry tracking</span>
        </a>
        <a href="${pageContext.request.contextPath}/enterprise/performance">
            <b><i class="fa-solid fa-bullseye" style="color: #f59e0b;"></i> KPI / OKR Performance</b>
            <span class="muted">Goals, performance targets and progress tracking</span>
        </a>
        <a href="${pageContext.request.contextPath}/enterprise/onboarding">
            <b><i class="fa-solid fa-user-plus" style="color: #818cf8;"></i> Onboarding</b>
            <span class="muted">Generate joining checklist and orientation tasks</span>
        </a>
        <a href="${pageContext.request.contextPath}/enterprise/offboarding">
            <b><i class="fa-solid fa-user-slash" style="color: #f87171;"></i> Offboarding</b>
            <span class="muted">Clearance and handover workflow management</span>
        </a>
        <a href="${pageContext.request.contextPath}/enterprise/approvals">
            <b><i class="fa-solid fa-clipboard-check" style="color: #34d399;"></i> Approval Center</b>
            <span class="muted">Two-level administrative approval workflow</span>
        </a>
        <a href="${pageContext.request.contextPath}/enterprise/time">
            <b><i class="fa-solid fa-clock-rotate-left" style="color: #06b6d4;"></i> Time Tracking</b>
            <span class="muted">Regular working hours and overtime calculation</span>
        </a>
        <a href="${pageContext.request.contextPath}/enterprise/analytics">
            <b><i class="fa-solid fa-chart-line" style="color: #a5b4fc;"></i> Analytics</b>
            <span class="muted">Headcount, attendance and payroll key performance indicators</span>
        </a>
    </div>

    <!-- Employee Self Service Enterprise View Footer Link 
    <div class="self-service-box">
        <a href="${pageContext.request.contextPath}/enterprise/my">
            <i class="fa-solid fa-id-badge"></i> <i class="fa-solid fa-arrow-right" style="font-size: 11px;"></i>
        </a>
    </div> -->

</div>

</body>
</html>