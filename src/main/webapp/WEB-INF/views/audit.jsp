<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise Audit Logs</title>
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
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
            padding: 40px 24px;
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

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* HEADER SECTION */
        .header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 32px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            margin-bottom: 30px;
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

        .header-left h1 {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -0.5px;
            background: linear-gradient(135deg, #fff, #9ca3af);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header-left h1 i {
            -webkit-text-fill-color: var(--accent-primary);
            font-size: 24px;
        }

        .header-left p {
            color: var(--text-muted);
            font-size: 14px;
            margin-top: 6px;
        }

        .record-box {
            background: rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.3);
            padding: 14px 24px;
            border-radius: 16px;
            text-align: center;
            box-shadow: inset 0 2px 4px rgba(255, 255, 255, 0.05);
        }

        .record-number {
            font-size: 24px;
            font-weight: 800;
            color: #818cf8;
        }

        .record-label {
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-muted);
            margin-top: 2px;
        }

        /* METRICS GRID */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .summary-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 24px;
            position: relative;
            overflow: hidden;
            transition: var(--transition);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        .summary-card:hover {
            transform: translateY(-5px);
            border-color: var(--border-hover);
            box-shadow: 0 12px 30px var(--accent-glow);
        }

        .summary-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 4px; height: 100%;
            background: linear-gradient(to bottom, var(--accent-primary), var(--accent-secondary));
        }

        .summary-title {
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: var(--text-muted);
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .summary-title i {
            color: var(--accent-primary);
            font-size: 14px;
        }

        .summary-value {
            font-size: 32px;
            font-weight: 800;
            color: #fff;
            letter-spacing: -1px;
        }

        /* LOG CARD CONTAINER */
        .logs-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            margin-bottom: 30px;
        }

        .logs-header {
            padding: 24px 32px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(17, 24, 39, 0.4);
        }

        .logs-header h2 {
            font-size: 18px;
            font-weight: 700;
            color: #fff;
        }

        .logs-header p {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 4px;
        }

        .log-status {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.2);
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .log-status::before {
            content: '';
            width: 7px; height: 7px;
            background: var(--success);
            border-radius: 50%;
            box-shadow: 0 0 8px var(--success);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.4; transform: scale(1.2); }
            100% { opacity: 1; transform: scale(1); }
        }

        /* TABLE DESIGN */
        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 1000px;
            border-collapse: collapse;
            text-align: left;
        }

        thead {
            background: rgba(11, 15, 25, 0.6);
        }

        th {
            padding: 16px 24px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-muted);
            border-bottom: 1px solid var(--border-color);
        }

        td {
            padding: 18px 24px;
            font-size: 13px;
            color: #d1d5db;
            border-bottom: 1px solid var(--border-color);
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

        /* COLUMN STYLING */
        .date {
            font-family: 'JetBrains Mono', monospace;
            color: #818cf8;
            font-size: 12px;
            font-weight: 500;
            white-space: nowrap;
        }

        .actor-wrapper {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .actor-avatar {
            width: 36px; height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: 700;
            flex-shrink: 0;
            box-shadow: 0 2px 10px rgba(99, 102, 241, 0.3);
        }

        .actor-name {
            font-weight: 600;
            color: #fff;
        }

        .action-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 8px;
            background: rgba(99, 102, 241, 0.12);
            color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.2);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.3px;
        }

        .entity-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 8px;
            background: rgba(6, 182, 212, 0.1);
            color: #22d3ee;
            border: 1px solid rgba(6, 182, 212, 0.2);
            font-size: 11px;
            font-weight: 700;
        }

        .entity-id {
            font-family: 'JetBrains Mono', monospace;
            color: var(--text-muted);
            font-size: 12px;
        }

        .details {
            max-width: 350px;
            color: var(--text-muted);
            line-height: 1.5;
            word-break: break-word;
            font-size: 12px;
        }

        /* EMPTY STATE */
        .empty {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 80px 20px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .empty-circle {
            width: 80px; height: 80px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: rgba(99, 102, 241, 0.1);
            border: 1px solid rgba(99, 102, 241, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 20px var(--accent-glow);
        }

        .empty-circle i {
            font-size: 32px;
            color: var(--accent-primary);
        }

        .empty-title {
            font-size: 20px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 8px;
        }

        .empty-text {
            font-size: 14px;
            color: var(--text-muted);
        }

        /* FOOTER ACTIONS */
        .footer {
            display: flex;
            gap: 16px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 26px;
            border-radius: 14px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: var(--transition);
            cursor: pointer;
            border: none;
        }

        .dashboard-btn {
            background: var(--bg-card);
            color: var(--text-main);
            border: 1px solid var(--border-color);
        }

        .dashboard-btn:hover {
            background: rgba(255, 255, 255, 0.05);
            border-color: var(--text-muted);
            transform: translateY(-2px);
        }

        .refresh-btn {
            background: linear-gradient(135deg, var(--accent-primary), #7c3aed);
            color: white;
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.3);
        }

        .refresh-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.5);
        }

        /* RESPONSIVE DESIGN */
        @media (max-width: 1024px) {
            .summary-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 640px) {
            body {
                padding: 16px 12px;
            }
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
                padding: 24px;
            }
            .record-box {
                width: 100%;
            }
            .summary-grid {
                grid-template-columns: 1fr;
            }
            .logs-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }
            .footer {
                flex-direction: column;
            }
            .btn {
                justify-content: center;
            }
        }
    </style>
</head>
<body>

<div class="container">

    <!-- HEADER -->
    <div class="header">
        <div class="header-left">
            <h1><i class="fa-solid fa-shield-halved"></i> Audit Logs</h1>
            <p>Real-time security auditing and enterprise system monitoring suite</p>
        </div>
        <div class="record-box">
            <div class="record-number">${logs.size()}</div>
            <div class="record-label">Total Records</div>
        </div>
    </div>

    <!-- SUMMARY METRICS -->
    <div class="summary-grid">
        <div class="summary-card">
            <div class="summary-title">Total Records <i class="fa-solid fa-database"></i></div>
            <div class="summary-value">${logs.size()}</div>
        </div>
        <div class="summary-card">
            <div class="summary-title">System Activity <i class="fa-solid fa-server"></i></div>
            <div class="summary-value">${logs.size()}</div>
        </div>
        <div class="summary-card">
            <div class="summary-title">Logged Events <i class="fa-solid fa-clock-rotate-left"></i></div>
            <div class="summary-value">${logs.size()}</div>
        </div>
        <div class="summary-card">
            <div class="summary-title">Audit Status <i class="fa-solid fa-circle-check" style="color:var(--success);"></i></div>
            <div class="summary-value" style="font-size:24px; color:var(--success); display:flex; align-items:center; height:41px;">Active</div>
        </div>
    </div>

    <!-- LOG TABLE SECTION -->
    <c:choose>
        <c:when test="${not empty logs}">
            <div class="logs-card">
                <div class="logs-header">
                    <div>
                        <h2>System Activity Logs</h2>
                        <p>Recent trace activities and event logs captured across system infrastructure</p>
                    </div>
                    <div class="log-status">Live Monitoring</div>
                </div>

                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Timestamp</th>
                                <th>Actor</th>
                                <th>Action</th>
                                <th>Entity</th>
                                <th>ID</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${logs}">
                                <tr>
                                    <td class="date">${l.createdAt}</td>
                                    <td>
                                        <div class="actor-wrapper">
                                            <div class="actor-avatar">
                                                <c:choose>
                                                    <c:when test="${not empty l.actor}">
                                                        ${l.actor.substring(0,1).toUpperCase()}
                                                    </c:when>
                                                    <c:otherwise>A</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="actor-name">
                                                <c:choose>
                                                    <c:when test="${not empty l.actor}">
                                                        ${l.actor}
                                                    </c:when>
                                                    <c:otherwise>System</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="action-badge">${l.action}</span>
                                    </td>
                                    <td>
                                        <span class="entity-badge">${l.entityType}</span>
                                    </td>
                                    <td class="entity-id">${l.entityId}</td>
                                    <td class="details">${l.details}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty">
                <div class="empty-circle">
                    <i class="fa-solid fa-folder-open"></i>
                </div>
                <div class="empty-title">No Audit Logs Found</div>
                <div class="empty-text">There are currently no recorded system activities or trace tracks available.</div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- FOOTER NAV -->
    <div class="footer">
        <a href="${pageContext.request.contextPath}/dashboard" class="btn dashboard-btn">
            <i class="fa-solid fa-arrow-left"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/audit" class="btn refresh-btn">
            <i class="fa-solid fa-rotate"></i> Refresh Logs
        </a>
    </div>

</div>

</body>
</html>