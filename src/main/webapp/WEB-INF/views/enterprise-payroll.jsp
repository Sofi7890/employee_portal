<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Monthly Payroll - Enterprise HR</title>

    <!-- Google Fonts & Icons -->

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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

                radial-gradient(
                    circle at 10% 10%,
                    rgba(99, 102, 241, 0.08) 0%,
                    transparent 40%
                ),

                radial-gradient(
                    circle at 90% 90%,
                    rgba(6, 182, 212, 0.06) 0%,
                    transparent 40%
                );

            background-attachment: fixed;

            animation: fadeIn 0.8s ease-out;

            padding: 40px 20px;

        }

        @keyframes fadeIn {

            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }

        }

        .wrap {

            max-width: 1200px;

            margin: auto;

        }

        /* Top Header */

        .top-header {

            background:
                linear-gradient(
                    135deg,
                    rgba(31, 41, 55, 0.7),
                    rgba(17, 24, 39, 0.8)
                );

            backdrop-filter: blur(12px);

            border: 1px solid var(--border-color);

            border-radius: 24px;

            padding: 28px 36px;

            margin-bottom: 28px;

            box-shadow:
                0 20px 40px rgba(0, 0, 0, 0.4);

            display: flex;

            justify-content: space-between;

            align-items: center;

            position: relative;

            overflow: hidden;

        }

        .top-header::after {

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

            box-shadow:
                0 4px 15px rgba(0, 0, 0, 0.2);

            white-space: nowrap;

        }

        .back-link:hover {

            background: rgba(99, 102, 241, 0.1);

            color: #fff;

            border-color: var(--border-hover);

            transform: translateY(-2px);

        }

        /* Panels */

        .panel {

            background: var(--bg-card);

            border: 1px solid var(--border-color);

            border-radius: 24px;

            padding: 32px;

            margin-bottom: 24px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.3);

            position: relative;

            overflow: hidden;

        }

        .panel::after {

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

        .panel-title {

            font-size: 16px;

            font-weight: 700;

            color: #fff;

            margin-bottom: 16px;

            display: flex;

            align-items: center;

            gap: 10px;

        }

        /* Form Controls */

        form {

            display: flex;

            gap: 12px;

            align-items: center;

            flex-wrap: wrap;

        }

        input {

            height: 44px;

            padding: 0 16px;

            border: 1px solid var(--border-color);

            border-radius: 12px;

            background: rgba(11, 15, 25, 0.6);

            color: var(--text-main);

            font-family: 'Plus Jakarta Sans', sans-serif;

            font-size: 14px;

            outline: none;

            transition: var(--transition);

            width: 140px;

        }

        input:hover {

            border-color: var(--border-hover);

        }

        input:focus {

            border-color: var(--accent-primary);

            background: rgba(11, 15, 25, 0.8);

            box-shadow:
                0 0 15px var(--accent-glow);

        }

        button {

            height: 44px;

            padding: 0 24px;

            border: none;

            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    var(--accent-primary),
                    #4f46e5
                );

            color: white;

            font-size: 14px;

            font-weight: 700;

            cursor: pointer;

            transition: var(--transition);

            box-shadow:
                0 4px 15px rgba(99, 102, 241, 0.3);

            display: inline-flex;

            align-items: center;

            gap: 8px;

            white-space: nowrap;

        }

        button:hover {

            transform: translateY(-2px);

            box-shadow:
                0 8px 25px rgba(0, 0, 0, 0.4);

        }

        .form-note {

            display: block;

            margin-top: 12px;

            color: var(--text-muted);

            font-size: 12px;

        }

        /* Table Wrapper & Styling */

        .table-wrapper {

            width: 100%;

            overflow-x: auto;

        }

        table {

            width: 100%;

            min-width: 1000px;

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

            vertical-align: middle;

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

        /* Status Badge */

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

            white-space: nowrap;

        }

        .status-hold {

            background: rgba(245, 158, 11, 0.12);

            color: #fbbf24;

            border-color: rgba(245, 158, 11, 0.25);

        }

        .status-approved {

            background: rgba(6, 182, 212, 0.12);

            color: #22d3ee;

            border-color: rgba(6, 182, 212, 0.25);

        }

        /* Action Buttons */

        .action-form {

            display: inline-flex;

            margin: 0;

        }

        .action-btn {

            height: 34px;

            padding: 0 14px;

            border-radius: 9px;

            font-size: 11px;

            font-weight: 700;

            border: 1px solid transparent;

            box-shadow: none;

            margin: 0;

        }

        .hold-btn {

            background: rgba(245, 158, 11, 0.12);

            color: #fbbf24;

            border-color: rgba(245, 158, 11, 0.25);

        }

        .hold-btn:hover {

            background: rgba(245, 158, 11, 0.22);

            border-color: rgba(245, 158, 11, 0.45);

            box-shadow:
                0 5px 15px rgba(245, 158, 11, 0.15);

        }

        .release-btn {

            background: rgba(16, 185, 129, 0.12);

            color: #34d399;

            border-color: rgba(16, 185, 129, 0.25);

        }

        .release-btn:hover {

            background: rgba(16, 185, 129, 0.22);

            border-color: rgba(16, 185, 129, 0.45);

            box-shadow:
                0 5px 15px rgba(16, 185, 129, 0.15);

        }

        .no-action {

            color: var(--text-muted);

            font-size: 12px;

        }

        @media (max-width: 850px) {

            body {

                padding: 20px 10px;

            }

            .top-header {

                flex-direction: column;

                align-items: flex-start;

                gap: 16px;

                padding: 20px;

            }

            .back-link {

                width: 100%;

                justify-content: center;

            }

            form {

                flex-direction: column;

                align-items: stretch;

            }

            input,
            button {

                width: 100%;

            }

            .panel {

                padding: 20px;

            }

        }

    </style>

</head>

<body>

<div class="wrap">

    <!-- Top Header Bar -->

    <div class="top-header">

        <div>

            <h1>Monthly Payroll</h1>

            <p class="muted">
                Process and review automated monthly payroll cycles across workforce records.
            </p>

        </div>

        <a class="back-link"
           href="${pageContext.request.contextPath}/enterprise">

            <i class="fa-solid fa-arrow-left"></i>

            Enterprise Center

        </a>

    </div>


    <!-- Processing Panel -->

    <div class="panel">

        <div class="panel-title">

            <i class="fa-solid fa-calculator"
               style="color: var(--accent-secondary);"></i>

            Run Payroll Cycle

        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/enterprise/payroll/process">

            <input name="month"
                   type="number"
                   min="1"
                   max="12"
                   value="${now.monthValue}"
                   placeholder="Month"
                   required>

            <input name="year"
                   type="number"
                   value="${now.year}"
                   placeholder="Year"
                   required>

            <button type="submit">

                <i class="fa-solid fa-gears"></i>

                Process Payroll for All Employees

            </button>

        </form>

        <span class="form-note">

            <i class="fa-solid fa-circle-info"></i>

            Processing is idempotent for the same employee, month, and year combination.

            Existing <b>ON HOLD</b> payroll records will remain on hold if the cycle is processed again.

        </span>

    </div>


    <!-- Payroll History Panel -->

    <div class="panel">

        <div class="panel-title">

            <i class="fa-solid fa-receipt"
               style="color: var(--accent-primary);"></i>

            Payroll History & Records

        </div>

        <div class="table-wrapper">

            <table>

                <thead>

                <tr>

                    <th>Employee</th>

                    <th>Period</th>

                    <th>Gross</th>

                    <th>Deductions</th>

                    <th>Net Pay</th>

                    <th>Status</th>

                    <th>Processed At</th>

                    <th>Action</th>

                </tr>

                </thead>

                <tbody>

                <c:forEach var="p" items="${payroll}">

                    <tr>

                        <td>
                            ${p.employee.employeeId} -
                            ${p.employee.employeeName}
                        </td>

                        <td>
                            ${p.payrollMonth} / ${p.payrollYear}
                        </td>

                        <td style="color: #22d3ee;">
                            ${p.gross}
                        </td>

                        <td style="color: #f87171;">
                            ${p.deductions}
                        </td>

                        <td>
                            <b style="color: #34d399;">
                                ${p.net}
                            </b>
                        </td>

                        <td>

                            <c:choose>

                                <c:when test="${p.status == 'ON HOLD'}">

                                    <span class="status-badge status-hold">

                                        <i class="fa-solid fa-pause"
                                           style="margin-right: 5px;"></i>

                                        ON HOLD

                                    </span>

                                </c:when>

                                <c:when test="${p.status == 'APPROVED'}">

                                    <span class="status-badge status-approved">

                                        <i class="fa-solid fa-check"
                                           style="margin-right: 5px;"></i>

                                        APPROVED

                                    </span>

                                </c:when>

                                <c:otherwise>

                                    <span class="status-badge">
                                        ${p.status}
                                    </span>

                                </c:otherwise>

                            </c:choose>

                        </td>

                        <td style="font-size: 12px; color: var(--text-muted);">

                            ${p.processedAt}

                        </td>

                        <td>

                            <c:choose>

                                <c:when test="${p.status == 'PROCESSED'}">

                                    <form class="action-form"
                                          method="post"
                                          action="${pageContext.request.contextPath}/enterprise/payroll/${p.id}/hold"
                                          onsubmit="return confirm('Are you sure you want to hold this employee payroll?');">

                                        <button type="submit"
                                                class="action-btn hold-btn">

                                            <i class="fa-solid fa-pause"></i>

                                            Hold

                                        </button>

                                    </form>

                                </c:when>

                                <c:when test="${p.status == 'ON HOLD'}">

                                    <form class="action-form"
                                          method="post"
                                          action="${pageContext.request.contextPath}/enterprise/payroll/${p.id}/release"
                                          onsubmit="return confirm('Release this payroll and approve it for payment?');">

                                        <button type="submit"
                                                class="action-btn release-btn">

                                            <i class="fa-solid fa-check"></i>

                                            Release

                                        </button>

                                    </form>

                                </c:when>

                                <c:when test="${p.status == 'APPROVED'}">

                                    <span class="no-action">

                                        <i class="fa-solid fa-circle-check"></i>

                                        Ready for payment

                                    </span>

                                </c:when>

                                <c:otherwise>

                                    <span class="no-action">
                                        —
                                    </span>

                                </c:otherwise>

                            </c:choose>

                        </td>

                    </tr>

                </c:forEach>

                </tbody>

            </table>

        </div>

    </div>

</div>

</body>

</html>