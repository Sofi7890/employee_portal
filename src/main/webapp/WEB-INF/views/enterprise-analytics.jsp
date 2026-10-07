<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HR Workforce Analytics - Enterprise HR</title>

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
            max-width: 1100px;
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

        /* Analytics Grid Cards */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
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

        .card span.muted {
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            font-weight: 700;
            display: block;
            margin-bottom: 8px;
        }

        .num {
            font-size: 28px;
            font-weight: 800;
            color: #fff;
            font-family: 'JetBrains Mono', monospace;
            margin-top: 4px;
        }

        @media (max-width: 750px) {
            body { padding: 20px 10px; }
            .top-header { flex-direction: column; align-items: flex-start; gap: 16px; padding: 20px; }
            .back-link { width: 100%; justify-content: center; }
            .grid { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

<div class="wrap">

    <!-- Top Header Bar -->
    <div class="top-header">
        <div>
            <h1>Workforce Analytics</h1>
            <p class="muted">Real-time overview of headcount distribution, attendance metrics, and processed payroll totals.</p>
        </div>
        <a class="back-link" href="${pageContext.request.contextPath}/enterprise">
            <i class="fa-solid fa-arrow-left"></i> Enterprise Center
        </a>
    </div>

    <!-- Analytics Cards Grid -->
    <div class="grid">
        <div class="card">
            <span class="muted"><i class="fa-solid fa-users" style="color: var(--accent-primary); margin-right: 6px;"></i> Total Employees</span>
            <div class="num">${total}</div>
        </div>
        <div class="card">
            <span class="muted"><i class="fa-solid fa-user-check" style="color: var(--success); margin-right: 6px;"></i> Active Workforce</span>
            <div class="num" style="color: #34d399;">${active}</div>
        </div>
        <div class="card">
            <span class="muted"><i class="fa-solid fa-user-slash" style="color: var(--danger); margin-right: 6px;"></i> Resigned / Exited</span>
            <div class="num" style="color: #f87171;">${resigned}</div>
        </div>
        <div class="card">
            <span class="muted"><i class="fa-solid fa-building" style="color: var(--accent-secondary); margin-right: 6px;"></i> Office Attendance</span>
            <div class="num" style="color: #22d3ee;">${office}</div>
        </div>
        <div class="card">
            <span class="muted"><i class="fa-solid fa-house-laptop" style="color: var(--warning); margin-right: 6px;"></i> Home Attendance</span>
            <div class="num" style="color: #fbbf24;">${home}</div>
        </div>
        <div class="card">
            <span class="muted"><i class="fa-solid fa-wallet" style="color: #34d399; margin-right: 6px;"></i> Processed Net Payroll</span>
            <div class="num" style="font-size: 22px; color: #34d399;">Rs. ${payrollTotal}</div>
        </div>
    </div>

</div>

</body>
</html>