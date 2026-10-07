<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EMS Admin Dashboard</title>
    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            /* ---- Core palette : deep slate / indigo, built for a data-dense
               enterprise workforce console rather than a generic SaaS kit ---- */
            --bg-primary: #090c14;
            --bg-secondary: #0e131f;
            --bg-card: #131a29;
            --bg-card-alt: #0f1522;
            --border-color: rgba(148, 163, 184, 0.10);
            --border-hover: rgba(94, 114, 235, 0.45);
            --text-main: #e7eaf2;
            --text-muted: #8891a4;
            --text-faint: #5c6579;
            --accent-primary: #5e72eb;
            --accent-secondary: #16b8a6;
            --accent-glow: rgba(94, 114, 235, 0.22);
            --success: #22c55e;
            --danger: #f4495f;
            --warning: #eab308;
            --radius-lg: 18px;
            --radius-md: 12px;
            --radius-sm: 8px;
            --ease: cubic-bezier(0.16, 1, 0.3, 1);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html {
            scroll-behavior: smooth;
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.001ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.001ms !important;
                scroll-behavior: auto !important;
            }
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-primary);
            color: var(--text-main);
            min-height: 100vh;
            background-image:
                radial-gradient(circle at 8% 0%, rgba(94, 114, 235, 0.10) 0%, transparent 42%),
                radial-gradient(circle at 96% 100%, rgba(22, 184, 166, 0.08) 0%, transparent 45%);
            background-attachment: fixed;
        }

        /* subtle one-time top progress sweep to signal the app has loaded —
           a single orchestrated moment rather than motion on every element */
        .load-bar {
            position: fixed;
            top: 0; left: 0;
            height: 2px;
            width: 100%;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
            transform-origin: left;
            animation: loadSweep 1.1s var(--ease) forwards;
            z-index: 100;
        }
        @keyframes loadSweep {
            from { transform: scaleX(0); opacity: 1; }
            85%  { transform: scaleX(1); opacity: 1; }
            to   { transform: scaleX(1); opacity: 0; }
        }

        .app {
            display: flex;
            min-height: 100vh;
        }

        /* ============ SIDEBAR ============ */
        .sidebar {
            width: 252px;
            background: var(--bg-secondary);
            border-right: 1px solid var(--border-color);
            padding: 26px 14px;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            z-index: 20;
            display: flex;
            flex-direction: column;
            opacity: 0;
            transform: translateX(-14px);
            animation: sidebarIn 0.5s var(--ease) 0.05s forwards;
        }

        @keyframes sidebarIn {
            to { opacity: 1; transform: translateX(0); }
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 11px;
            padding: 4px 10px 22px;
            border-bottom: 1px solid var(--border-color);
        }

        .logo-mark {
            width: 34px;
            height: 34px;
            flex-shrink: 0;
            border-radius: 9px;
            background: linear-gradient(135deg, var(--accent-primary), #3a4dc4);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            font-weight: 800;
            color: #fff;
            box-shadow: 0 6px 16px rgba(94, 114, 235, 0.35);
        }

        .logo-title {
            font-size: 15.5px;
            font-weight: 700;
            letter-spacing: -0.2px;
            color: #fff;
            line-height: 1.25;
        }

        .logo-subtitle {
            margin-top: 1px;
            font-size: 11.5px;
            color: var(--text-muted);
            font-weight: 500;
        }

        .menu-title {
            margin: 20px 10px 7px;
            font-size: 11.5px;
            color: var(--text-faint);
            font-weight: 700;
            letter-spacing: 0.3px;
        }

        .menu {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .menu a {
            display: flex;
            align-items: center;
            gap: 11px;
            min-height: 38px;
            padding: 8px 12px;
            border-radius: var(--radius-sm);
            text-decoration: none;
            color: var(--text-muted);
            font-size: 14px;
            font-weight: 500;
            border-left: 2px solid transparent;
            transition: color 0.18s var(--ease), background-color 0.18s var(--ease), border-color 0.18s var(--ease);
        }

        .menu a:hover {
            color: #fff;
            background: rgba(94, 114, 235, 0.07);
        }

        .menu a.active {
            color: #fff;
            background: rgba(94, 114, 235, 0.12);
            border-left-color: var(--accent-primary);
            font-weight: 600;
        }

        .menu a i {
            width: 15px;
            text-align: center;
            font-size: 14px;
            color: var(--text-faint);
            transition: color 0.18s var(--ease);
        }

        .menu a:hover i,
        .menu a.active i {
            color: var(--accent-primary);
        }

        .sidebar-bottom {
            margin-top: auto;
            padding-top: 14px;
            border-top: 1px solid var(--border-color);
        }

        .logout {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            padding: 11px;
            border: 1px solid rgba(244, 73, 95, 0.18);
            border-radius: var(--radius-sm);
            color: var(--danger);
            font-size: 13.5px;
            font-weight: 600;
            background: rgba(244, 73, 95, 0.05);
            transition: background-color 0.18s var(--ease), border-color 0.18s var(--ease);
        }

        .logout:hover {
            background: rgba(244, 73, 95, 0.13);
            border-color: rgba(244, 73, 95, 0.35);
        }

        /* ============ MAIN ============ */
        .main {
            margin-left: 252px;
            width: calc(100% - 252px);
            padding: 32px 36px 44px;
        }

        /* ============ TOP BAR ============ */
        .topbar {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 22px 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
            opacity: 0;
            transform: translateY(10px);
            animation: rise 0.5s var(--ease) 0.1s forwards;
        }

        .topbar-left h1 {
            font-size: 23px;
            font-weight: 800;
            letter-spacing: -0.3px;
            color: #fff;
        }

        .topbar-left p {
            margin-top: 3px;
            color: var(--text-muted);
            font-size: 13px;
        }

        .top-actions {
            display: flex;
            gap: 10px;
        }

        .top-btn {
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            border: 1px solid var(--border-color);
            background: var(--bg-card-alt);
            color: var(--text-main);
            border-radius: var(--radius-sm);
            padding: 9px 15px;
            font-size: 13.5px;
            font-weight: 600;
            transition: border-color 0.18s var(--ease), color 0.18s var(--ease), transform 0.18s var(--ease);
        }

        .top-btn:hover {
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-1px);
        }

        /* ============ STATUS ============ */
        .status-row {
            display: flex;
            align-items: center;
            gap: 9px;
            margin-bottom: 18px;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 500;
            opacity: 0;
            animation: rise 0.5s var(--ease) 0.16s forwards;
        }

        .status-dot {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: var(--success);
            box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.5);
            animation: statusPulse 2.2s infinite;
        }

        @keyframes statusPulse {
            0%   { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0.45); }
            70%  { box-shadow: 0 0 0 7px rgba(34, 197, 94, 0); }
            100% { box-shadow: 0 0 0 0 rgba(34, 197, 94, 0); }
        }

        /* ============ KPI CARDS ============ */
        .stats {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 12px;
            margin-bottom: 18px;
        }

        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            padding: 16px 14px;
            text-decoration: none;
            display: block;
            opacity: 0;
            transform: translateY(10px);
            animation: rise 0.5s var(--ease) forwards;
            transition: border-color 0.18s var(--ease), transform 0.18s var(--ease), background-color 0.18s var(--ease);
        }

        .stat-card:hover {
            border-color: var(--border-hover);
            transform: translateY(-3px);
            background: var(--bg-card-alt);
        }

        .stat-icon {
            width: 26px;
            height: 26px;
            border-radius: 7px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            margin-bottom: 10px;
            background: rgba(94, 114, 235, 0.10);
            color: var(--accent-primary);
        }

        .stat-label {
            color: var(--text-muted);
            font-size: 11.5px;
            font-weight: 600;
            letter-spacing: 0.2px;
        }

        .stat-value {
            margin-top: 7px;
            font-size: 24px;
            font-weight: 700;
            color: #fff;
            line-height: 1;
            font-family: 'JetBrains Mono', monospace;
            font-variant-numeric: tabular-nums;
        }

        .stat-note {
            margin-top: 6px;
            font-size: 11px;
            color: var(--text-faint);
        }

        /* ============ SPLIT GRID ============ */
        .dashboard-split-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            margin-bottom: 18px;
        }

        .panel {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 512px;
            opacity: 0;
            transform: translateY(12px);
            animation: rise 0.55s var(--ease) 0.22s forwards;
        }

        .panel-header {
            padding: 17px 22px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
        }

        .panel-title {
            font-size: 15.5px;
            font-weight: 700;
            color: #fff;
        }

        .panel-meta {
            font-size: 11.5px;
            color: var(--text-faint);
            font-weight: 600;
        }

        .panel-body {
            padding: 18px 20px;
            overflow-y: auto;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .panel-body::-webkit-scrollbar { width: 5px; }
        .panel-body::-webkit-scrollbar-thumb {
            background: rgba(148, 163, 184, 0.15);
            border-radius: 4px;
        }

        /* enterprise sub-grid */
        .enterprise-top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 4px;
            flex-shrink: 0;
            gap: 10px;
        }

        .enterprise-subtitle {
            font-size: 12.5px;
            color: var(--text-muted);
        }

        .enterprise-open {
            white-space: nowrap;
            text-decoration: none;
            color: #fff;
            background: var(--accent-primary);
            padding: 7px 14px;
            border-radius: var(--radius-sm);
            font-size: 12px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: filter 0.18s var(--ease), transform 0.18s var(--ease);
        }

        .enterprise-open:hover {
            filter: brightness(1.1);
            transform: translateY(-1px);
        }

        .enterprise-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 9px;
        }

        .enterprise-card {
            display: flex;
            gap: 10px;
            align-items: center;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            background: var(--bg-card-alt);
            color: var(--text-main);
            text-decoration: none;
            transition: border-color 0.18s var(--ease), transform 0.18s var(--ease);
        }

        .enterprise-card:hover {
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        .enterprise-card span {
            font-size: 15px;
            flex: 0 0 auto;
            width: 30px;
            height: 30px;
            border-radius: 8px;
            background: rgba(94, 114, 235, 0.10);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .enterprise-card b {
            display: block;
            font-size: 13px;
            color: #fff;
            font-weight: 700;
        }

        .enterprise-card small {
            display: block;
            color: var(--text-faint);
            font-size: 10.5px;
            line-height: 1.3;
            margin-top: 1px;
        }

        /* quick management sub-grid */
        .quick-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 9px;
        }

        .quick-link {
            text-decoration: none;
            color: var(--text-main);
            background: var(--bg-card-alt);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            padding: 13px 14px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            transition: border-color 0.18s var(--ease), transform 0.18s var(--ease);
        }

        .quick-link:hover {
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        .quick-title {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: #fff;
        }

        .quick-desc {
            display: block;
            margin-top: 3px;
            font-size: 11px;
            color: var(--text-faint);
            line-height: 1.3;
        }

        /* ============ FOOTER ============ */
        .footer {
            margin-top: 22px;
            padding-top: 15px;
            border-top: 1px solid var(--border-color);
            color: var(--text-faint);
            font-size: 12px;
            text-align: right;
        }

        /* shared entrance keyframe + stagger */
        @keyframes rise {
            to { opacity: 1; transform: translateY(0); }
        }
        .stats .stat-card:nth-child(1) { animation-delay: 0.20s; }
        .stats .stat-card:nth-child(2) { animation-delay: 0.24s; }
        .stats .stat-card:nth-child(3) { animation-delay: 0.28s; }
        .stats .stat-card:nth-child(4) { animation-delay: 0.32s; }
        .stats .stat-card:nth-child(5) { animation-delay: 0.36s; }
        .stats .stat-card:nth-child(6) { animation-delay: 0.40s; }
        .stats .stat-card:nth-child(7) { animation-delay: 0.44s; }
        .dashboard-split-grid .panel:nth-child(2) { animation-delay: 0.28s; }

        /* ============ RESPONSIVE ============ */
        @media (max-width: 1400px) {
            .stats { grid-template-columns: repeat(4, 1fr); }
        }

        @media (max-width: 1100px) {
            .dashboard-split-grid { grid-template-columns: 1fr; }
            .panel { height: auto; max-height: 520px; }
        }

        @media (max-width: 1000px) {
            .sidebar { width: 210px; }
            .main { margin-left: 210px; width: calc(100% - 210px); padding: 20px; }
            .stats { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 650px) {
            .app { display: block; }
            .sidebar { position: relative; width: 100%; height: auto; min-height: auto; }
            .menu { display: grid; grid-template-columns: repeat(2, 1fr); }
            .main { margin-left: 0; width: 100%; padding: 16px; }
            .topbar { flex-direction: column; align-items: flex-start; gap: 14px; padding: 18px; }
            .top-actions { width: 100%; }
            .top-btn { flex: 1; justify-content: center; }
            .stats, .enterprise-grid, .quick-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

<div class="load-bar"></div>

<div class="app">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="logo">
            <div class="logo-mark">EW</div>
            <div>
               <div class="logo-title">Employee &amp; Workforce Portal</div>

            </div>
        </div>

        <div class="menu-title">Overview</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/dashboard" class="active">
                <i class="fa-solid fa-grip"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/employee/list">
                <i class="fa-solid fa-users"></i> Employees
            </a>
            <a href="${pageContext.request.contextPath}/project/list">
                <i class="fa-solid fa-diagram-project"></i> Projects
            </a>
            <a href="${pageContext.request.contextPath}/client/list">
                <i class="fa-solid fa-building"></i> Clients
            </a>
        </nav>

        <div class="menu-title">Operations</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/attendance/admin">
                <i class="fa-solid fa-calendar-check"></i> Attendance
            </a>
            <a href="${pageContext.request.contextPath}/leave/admin">
                <i class="fa-solid fa-plane-departure"></i> Leave Approval
            </a>
            <a href="${pageContext.request.contextPath}/expense/admin">
                <i class="fa-solid fa-receipt"></i> Expenses
            </a>
            <a href="${pageContext.request.contextPath}/resignation/admin">
                <i class="fa-solid fa-door-open"></i> Resignation
            </a>
        </nav>

        <div class="menu-title">Administration</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/reports">
                <i class="fa-solid fa-chart-pie"></i> Reports
            </a>
            <a href="${pageContext.request.contextPath}/audit">
                <i class="fa-solid fa-clipboard-list"></i> Audit Logs
            </a>
            <a href="${pageContext.request.contextPath}/admin/list">
                <i class="fa-solid fa-user-shield"></i> Admin Portal
            </a>
            <a href="${pageContext.request.contextPath}/restore/employees">
                <i class="fa-solid fa-clock-rotate-left"></i> Restore Employees
            </a>
        </nav>

        <div class="sidebar-bottom">
            <a class="logout" href="${pageContext.request.contextPath}/auth/logout">
                <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
            </a>
        </div>
    </aside>

    <!-- MAIN -->
    <main class="main">

        <!-- TOP BAR -->
        <div class="topbar">
            <div class="topbar-left">
                <h1>Admin Dashboard</h1>
                <p>Workforce overview and operational control center</p>
            </div>
            <div class="top-actions">
                <a class="top-btn" href="${pageContext.request.contextPath}/notifications">
                    <i class="fa-regular fa-bell"></i> Notifications
                </a>
                <a class="top-btn" href="${pageContext.request.contextPath}/reports">
                    <i class="fa-solid fa-chart-pie"></i> Reports
                </a>
            </div>
        </div>

        <!-- STATUS -->
        <div class="status-row">
            <span class="status-dot"></span> System overview active
        </div>

        <!-- KPI CARDS (Fully Clickable Links) -->
        <section class="stats">
            <a href="${pageContext.request.contextPath}/employee/list" class="stat-card">
                <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
                <div class="stat-label">Employees</div>
                <div class="stat-value counter" data-value="${employeeCount}">0</div>
                <div class="stat-note">Total workforce</div>
            </a>
            <a href="${pageContext.request.contextPath}/client/list" class="stat-card">
                <div class="stat-icon"><i class="fa-solid fa-building"></i></div>
                <div class="stat-label">Clients</div>
                <div class="stat-value counter" data-value="${clientCount}">0</div>
                <div class="stat-note">Active client records</div>
            </a>
            <a href="${pageContext.request.contextPath}/project/list" class="stat-card">
                <div class="stat-icon"><i class="fa-solid fa-diagram-project"></i></div>
                <div class="stat-label">Projects</div>
                <div class="stat-value counter" data-value="${projectCount}">0</div>
                <div class="stat-note">Registered projects</div>
            </a>
            <a href="${pageContext.request.contextPath}/employee/list" class="stat-card">
                <div class="stat-icon"><i class="fa-solid fa-user-clock"></i></div>
                <div class="stat-label">Bench</div>
                <div class="stat-value counter" data-value="${benchCount}">0</div>
                <div class="stat-note">Available workforce</div>
            </a>
            <a href="${pageContext.request.contextPath}/attendance/admin" class="stat-card">
                <div class="stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
                <div class="stat-label">Attendance</div>
                <div class="stat-value counter" data-value="${attendanceCount}">0</div>
                <div class="stat-note">Attendance records</div>
            </a>
            <a href="${pageContext.request.contextPath}/leave/admin" class="stat-card">
                <div class="stat-icon"><i class="fa-solid fa-plane-departure"></i></div>
                <div class="stat-label">Pending Leave</div>
                <div class="stat-value counter" data-value="${pendingLeaves}">0</div>
                <div class="stat-note">Awaiting approval</div>
            </a>
            <a href="${pageContext.request.contextPath}/expense/admin" class="stat-card">
                <div class="stat-icon"><i class="fa-solid fa-receipt"></i></div>
                <div class="stat-label">Pending Expense</div>
                <div class="stat-value counter" data-value="${pendingExpenses}">0</div>
                <div class="stat-note">Awaiting review</div>
            </a>
        </section>

        <!-- BALANCED SYMMETRIC SPLIT ROW: ENTERPRISE HR & QUICK MANAGEMENT -->
        <div class="dashboard-split-grid">

            <!-- ENTERPRISE HR PANEL -->
            <section class="panel">
                <div class="panel-header">
                    <span class="panel-title">Enterprise Control Center</span>
                    <span class="panel-meta">HR &amp; Analytics</span>
                </div>
                <div class="panel-body">
                    <div class="enterprise-top-bar">
                        <span class="enterprise-subtitle">Salary, payroll, performance, onboarding &amp; tracking</span>
                        <a class="enterprise-open" href="${pageContext.request.contextPath}/enterprise">
                            <i class="fa-solid fa-building-user"></i> Open all
                        </a>
                    </div>
                    <div class="enterprise-grid">
                        <a href="${pageContext.request.contextPath}/enterprise/salary" class="enterprise-card">
                            <span><i class="fa-solid fa-wallet" style="color: #34d399; font-size: 14px;"></i></span>
                            <div><b>Salary &amp; Comp</b><small>Basic, HRA, PF &amp; Tax</small></div>
                        </a>
                        <a href="${pageContext.request.contextPath}/enterprise/payroll" class="enterprise-card">
                            <span><i class="fa-solid fa-file-invoice-dollar" style="color: #22d3ee; font-size: 14px;"></i></span>
                            <div><b>Payroll &amp; Slips</b><small>Processing &amp; records</small></div>
                        </a>
                        <a href="${pageContext.request.contextPath}/enterprise/performance" class="enterprise-card">
                            <span><i class="fa-solid fa-bullseye" style="color: #f59e0b; font-size: 14px;"></i></span>
                            <div><b>KPI / OKR</b><small>Targets &amp; goals</small></div>
                        </a>
                        <a href="${pageContext.request.contextPath}/enterprise/onboarding" class="enterprise-card">
                            <span><i class="fa-solid fa-user-plus" style="color: #818cf8; font-size: 14px;"></i></span>
                            <div><b>Onboarding</b><small>Checklists &amp; tasks</small></div>
                        </a>
                        <a href="${pageContext.request.contextPath}/enterprise/offboarding" class="enterprise-card">
                            <span><i class="fa-solid fa-user-slash" style="color: #f87171; font-size: 14px;"></i></span>
                            <div><b>Offboarding</b><small>Clearance &amp; exit</small></div>
                        </a>
                        <a href="${pageContext.request.contextPath}/enterprise/approvals" class="enterprise-card">
                            <span><i class="fa-solid fa-clipboard-check" style="color: #34d399; font-size: 14px;"></i></span>
                            <div><b>Approval Center</b><small>Two-level workflows</small></div>
                        </a>
                        <a href="${pageContext.request.contextPath}/enterprise/documents" class="enterprise-card">
                            <span><i class="fa-solid fa-folder-open" style="color: #fbbf24; font-size: 14px;"></i></span>
                            <div><b>Documents</b><small>Expiry &amp; tracking</small></div>
                        </a>
                        <a href="${pageContext.request.contextPath}/enterprise/time" class="enterprise-card">
                            <span><i class="fa-solid fa-clock-rotate-left" style="color: #06b6d4; font-size: 14px;"></i></span>
                            <div><b>Time Tracking</b><small>Hours &amp; overtime</small></div>
                        </a>
                        <a href="${pageContext.request.contextPath}/enterprise/analytics" class="enterprise-card" style="grid-column: span 2;">
                            <span><i class="fa-solid fa-chart-line" style="color: #a5b4fc; font-size: 14px;"></i></span>
                            <div><b>HR Analytics</b><small>Headcount, attendance and payroll reporting KPIs</small></div>
                        </a>
                    </div>
                </div>
            </section>

            <!-- QUICK MANAGEMENT PANEL -->
            <section class="panel">
                <div class="panel-header">
                    <span class="panel-title">Quick Management</span>
                    <span class="panel-meta">System modules</span>
                </div>
                <div class="panel-body">
                    <div class="quick-grid">
                        <a class="quick-link" href="${pageContext.request.contextPath}/employee/list">
                            <span class="quick-title">Employee Management</span>
                            <span class="quick-desc">Manage workforce records</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/project/list">
                            <span class="quick-title">Project Management</span>
                            <span class="quick-desc">Manage project assignments</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/client/list">
                            <span class="quick-title">Client Management</span>
                            <span class="quick-desc">Manage company clients</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/contact-person/list">
                            <span class="quick-title">Contact Persons</span>
                            <span class="quick-desc">Manage contact records</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/attendance/admin">
                            <span class="quick-title">Attendance</span>
                            <span class="quick-desc">Monitor employee attendance</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/leave/admin">
                            <span class="quick-title">Leave Approval</span>
                            <span class="quick-desc">Review leave requests</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/expense/admin">
                            <span class="quick-title">Expense Approval</span>
                            <span class="quick-desc">Review submitted expenses</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/resignation/admin">
                            <span class="quick-title">Resignation</span>
                            <span class="quick-desc">Manage employee exits</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/enterprise">
                            <span class="quick-title">Enterprise HR</span>
                            <span class="quick-desc">Payroll, KPI &amp; analytics hub</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/reports">
                            <span class="quick-title">Reports</span>
                            <span class="quick-desc">View system reports</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/audit">
                            <span class="quick-title">Audit Logs</span>
                            <span class="quick-desc">Review system activity</span>
                        </a>
                        <a class="quick-link" href="${pageContext.request.contextPath}/admin/list">
                            <span class="quick-title">Admin Management</span>
                            <span class="quick-desc">Manage admin accounts</span>
                        </a>
                    </div>
                </div>
            </section>

        </div>

        <div class="footer">
            Employee &amp; Workforce Portal
        </div>

    </main>
</div>

<!-- NUMBER ANIMATION SCRIPT (unchanged logic, same data-value/backend binding) -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var counters = document.querySelectorAll(".counter");
        counters.forEach(function (counter, index) {
            var target = parseInt(counter.getAttribute("data-value")) || 0;
            var duration = 1100;
            var startTime = null;

            function animateNumber(timestamp) {
                if (!startTime) startTime = timestamp;
                var progress = Math.min((timestamp - startTime) / duration, 1);
                var easedProgress = 1 - Math.pow(1 - progress, 3);
                var current = Math.floor(target * easedProgress);
                counter.textContent = current;
                if (progress < 1) {
                    requestAnimationFrame(animateNumber);
                } else {
                    counter.textContent = target;
                }
            }

            setTimeout(function () {
                requestAnimationFrame(animateNumber);
            }, 300 + (index * 60));
        });
    });
</script>

</body>
</html>
