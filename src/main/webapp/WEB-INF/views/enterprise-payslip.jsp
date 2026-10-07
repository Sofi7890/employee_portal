<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Payslip - Enterprise HR</title>

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

        .slip-wrapper {
            max-width: 820px;
            margin: auto;
        }

        /* Action Top Bar */
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: var(--text-main);
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 10px 18px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .back-link:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        .print-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            color: white;
            border: none;
            padding: 10px 22px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }

        .print-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        /* Payslip Card */
        .slip {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: hidden;
            animation: slideUp 0.6s ease;
        }

        .slip::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .slip-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 24px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .slip-header h1 {
            font-size: 24px;
            font-weight: 800;
            color: #fff;
            letter-spacing: -0.5px;
            margin-bottom: 4px;
        }

        .slip-header p {
            font-size: 13px;
            color: var(--text-muted);
        }

        .company-badge {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 6px 12px;
            background: rgba(99, 102, 241, 0.1);
            color: #818cf8;
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 20px;
        }

        .meta-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin-bottom: 24px;
            background: rgba(11, 15, 25, 0.5);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 20px;
        }

        .meta-item {
            font-size: 13px;
            color: var(--text-muted);
        }

        .meta-item b {
            color: #fff;
            font-family: 'JetBrains Mono', monospace;
        }

        hr {
            border: none;
            border-top: 1px solid var(--border-color);
            margin: 24px 0;
        }

        .row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 16px;
            border-bottom: 1px solid var(--border-color);
            font-size: 14px;
        }

        .row span:last-child {
            font-family: 'JetBrains Mono', monospace;
            font-weight: 600;
            color: var(--text-main);
        }

        .row.total {
            margin-top: 10px;
            background: rgba(99, 102, 241, 0.08);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 12px;
            font-size: 18px;
            font-weight: 800;
        }

        .row.total span {
            color: #fff;
        }

        .row.total span:last-child {
            color: #34d399;
            font-size: 20px;
        }

        .status-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            font-size: 12px;
            color: var(--text-muted);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 14px;
            border-radius: 20px;
            background: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        @media print {
            body {
                background: #fff;
                color: #111;
                padding: 0;
            }
            .action-bar {
                display: none;
            }
            .slip {
                background: #fff;
                border: none;
                box-shadow: none;
                padding: 20px;
                color: #111;
            }
            .slip::after {
                display: none;
            }
            .slip-header h1 {
                color: #111;
            }
            .meta-grid {
                background: #f9fafb;
                border: 1px solid #e5e7eb;
            }
            .meta-item b {
                color: #111;
            }
            .row {
                border-color: #e5e7eb;
                color: #374151;
            }
            .row span:last-child {
                color: #111;
            }
            .row.total {
                background: #f3f4f6;
                border-color: #d1d5db;
            }
            .row.total span {
                color: #111;
            }
            .row.total span:last-child {
                color: #059669;
            }
            .company-badge {
                background: #eef2ff;
                color: #4f46e5;
                border-color: #c7d2fe;
            }
            .status-footer {
                border-color: #e5e7eb;
                color: #6b7280;
            }
        }

        @media (max-width: 650px) {
            body { padding: 20px 10px; }
            .slip { padding: 24px 20px; }
            .meta-grid { grid-template-columns: 1fr; }
            .slip-header { flex-direction: column; align-items: flex-start; gap: 12px; }
        }
    </style>
</head>

<body>

<div class="slip-wrapper">

    <!-- Action Bar -->
    <div class="action-bar">
        <a class="back-link" href="${pageContext.request.contextPath}/enterprise/my">
            <i class="fa-solid fa-arrow-left"></i> Back to My Enterprise HR
        </a>
        <button class="print-btn" onclick="window.print()">
            <i class="fa-solid fa-print"></i> Print / Save PDF
        </button>
    </div>

    <!-- Official Payslip Document Card -->
    <div class="slip">
        <div class="slip-header">
            <div>
                <h1>Official Salary Payslip</h1>
                <p>Employee & Workforce Management System</p>
            </div>
            <div class="company-badge">Verified Document</div>
        </div>

        <div class="meta-grid">
            <div class="meta-item">
                Employee: <b>${p.employee.employeeName}</b> (${p.employee.employeeId})
            </div>
            <div class="meta-item">
                Department: <b>${p.employee.employeeDept}</b>
            </div>
            <div class="meta-item" style="grid-column: 1 / -1; margin-top: 4px;">
                Payroll Period: <b>${p.payrollMonth} / ${p.payrollYear}</b>
            </div>
        </div>

        <hr>

        <div class="row">
            <span>Basic Salary & Earnings (Gross)</span>
            <span>Rs. ${p.gross}</span>
        </div>

        <div class="row">
            <span>Total Deductions (PF + Professional Tax)</span>
            <span style="color: #f87171;">- Rs. ${p.deductions}</span>
        </div>

        <div class="row total">
            <span>Net Compensation Payable</span>
            <span>Rs. ${p.net}</span>
        </div>

        <div class="status-footer">
            <div>
                Status: <span class="status-badge">${p.status}</span>
            </div>
            <div style="font-style: italic;">
                Generated by Employee & Workforce Management System
            </div>
        </div>
    </div>

</div>

</body>
</html>