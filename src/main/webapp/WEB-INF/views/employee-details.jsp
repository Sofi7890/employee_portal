<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee 360° Profile</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --bg-primary:#0b0f19;
            --bg-secondary:#111827;
            --bg-card:#1f2937;
            --border-color:rgba(255,255,255,.08);
            --border-hover:rgba(99,102,241,.4);
            --text-main:#f3f4f6;
            --text-muted:#9ca3af;
            --accent-primary:#6366f1;
            --accent-secondary:#06b6d4;
            --accent-glow:rgba(99,102,241,.25);
            --success:#10b981;
            --danger:#ef4444;
            --warning:#f59e0b;
        }
        *{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        body{
            font-family:'Plus Jakarta Sans',sans-serif;
            background:var(--bg-primary);
            color:var(--text-main);
            min-height:100vh;
            overflow-x:hidden;
            background-image:radial-gradient(circle at 10% 10%,rgba(99,102,241,.08),transparent 40%),radial-gradient(circle at 90% 90%,rgba(6,182,212,.06),transparent 40%);
        }
        .app{display:flex;min-height:100vh;width:100%}
        .sidebar{
            width:260px;min-width:260px;position:fixed;left:0;top:0;bottom:0;z-index:20;
            padding:28px 16px;background:var(--bg-secondary);border-right:1px solid var(--border-color);
            display:flex;flex-direction:column;box-shadow:10px 0 30px rgba(0,0,0,.3)
        }
        .logo{padding:5px 12px 24px;border-bottom:1px solid var(--border-color)}
        .logo-title{font-size:16px;font-weight:800;color:#fff}
        .logo-subtitle{margin-top:4px;font-size:10px;color:var(--text-muted);letter-spacing:1.2px;text-transform:uppercase}
        .menu-title{margin:22px 12px 8px;font-size:10px;color:var(--text-muted);text-transform:uppercase;letter-spacing:1.5px;font-weight:700}
        .menu{display:flex;flex-direction:column;gap:4px;overflow-y:auto;max-height:calc(100vh - 280px)}
        .menu a{display:flex;align-items:center;min-height:40px;padding:10px 12px;border-radius:10px;text-decoration:none;color:var(--text-muted);font-size:13px;font-weight:500;border:1px solid transparent}
        .menu a:hover,.menu a.active{color:#fff;background:rgba(99,102,241,.1);border-color:rgba(99,102,241,.2)}
        .menu-mark{width:6px;height:6px;border-radius:50%;background:var(--text-muted);margin-right:12px;flex-shrink:0}
        .menu a:hover .menu-mark,.menu a.active .menu-mark{background:var(--accent-primary);box-shadow:0 0 10px var(--accent-primary)}
        .sidebar-bottom{margin-top:auto;padding-top:16px;border-top:1px solid var(--border-color)}
        .logout{display:flex;align-items:center;justify-content:center;gap:8px;text-decoration:none;padding:12px;border:1px solid rgba(239,68,68,.2);border-radius:12px;color:var(--danger);font-size:13px;font-weight:600;background:rgba(239,68,68,.05)}

        .main{margin-left:260px;width:calc(100% - 260px);min-width:0;padding:36px 40px 48px;overflow:hidden}
        .topbar{
            background:linear-gradient(135deg,rgba(31,41,55,.75),rgba(17,24,39,.85));
            border:1px solid var(--border-color);border-radius:24px;padding:26px 32px;margin-bottom:26px;
            display:flex;justify-content:space-between;align-items:center;gap:20px;position:relative;overflow:hidden
        }
        .topbar:after{content:'';position:absolute;left:0;right:0;top:0;height:2px;background:linear-gradient(90deg,var(--accent-primary),var(--accent-secondary))}
        .topbar h1{font-size:24px;font-weight:800;color:#fff}.topbar p{margin-top:5px;color:var(--text-muted);font-size:13px}
        .top-actions{display:flex;gap:10px;flex-wrap:wrap}
        .btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;padding:11px 16px;border-radius:11px;text-decoration:none;font-size:12px;font-weight:700;border:1px solid var(--border-color);background:var(--bg-card);color:#fff;white-space:nowrap}
        .btn.primary{background:linear-gradient(135deg,var(--accent-primary),#4f46e5);border:0}
        .btn:hover{transform:translateY(-2px);border-color:var(--border-hover)}

        .profile-hero{
            background:var(--bg-card);border:1px solid var(--border-color);border-radius:24px;padding:28px;
            display:grid;grid-template-columns:auto minmax(0,1fr) auto;gap:24px;align-items:center;margin-bottom:20px;position:relative;overflow:hidden
        }
        .profile-hero:before{content:'';position:absolute;inset:0;background:linear-gradient(135deg,rgba(99,102,241,.08),transparent 55%);pointer-events:none}
        .avatar{width:112px;height:112px;border-radius:50%;border:4px solid var(--bg-primary);background:linear-gradient(135deg,var(--accent-primary),var(--accent-secondary));display:flex;align-items:center;justify-content:center;font-size:38px;font-weight:800;overflow:hidden;position:relative;z-index:1}
        .avatar img{width:100%;height:100%;object-fit:cover}
        .hero-info{min-width:0;position:relative;z-index:1}.hero-info h2{font-size:30px;color:#fff;font-weight:800;overflow-wrap:anywhere}.hero-id{font-family:'JetBrains Mono',monospace;color:var(--text-muted);font-size:12px;margin-top:5px}.hero-meta{display:flex;gap:8px;flex-wrap:wrap;margin-top:14px}
        .badge{display:inline-flex;align-items:center;padding:6px 11px;border-radius:20px;font-size:11px;font-weight:700;border:1px solid rgba(99,102,241,.25);background:rgba(99,102,241,.1);color:#a5b4fc}
        .badge.success{background:rgba(16,185,129,.1);border-color:rgba(16,185,129,.25);color:#34d399}.badge.warning{background:rgba(245,158,11,.1);border-color:rgba(245,158,11,.25);color:#fbbf24}
        .hero-status{text-align:right;position:relative;z-index:1}.status-dot{display:inline-flex;align-items:center;gap:7px;font-size:12px;font-weight:700}.status-dot:before{content:'';width:8px;height:8px;border-radius:50%;background:var(--success);box-shadow:0 0 10px var(--success)}
        .status-sub{margin-top:7px;color:var(--text-muted);font-size:11px}

        .section{margin-top:20px}.section-title{display:flex;justify-content:space-between;align-items:end;margin-bottom:12px;gap:10px}.section-title h3{font-size:17px;color:#fff}.section-title span{font-size:11px;color:var(--text-muted)}
        .grid-2{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:20px}.grid-4{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:14px}
        .panel{background:var(--bg-card);border:1px solid var(--border-color);border-radius:20px;padding:22px;min-width:0;overflow:hidden}
        .panel h4{font-size:14px;color:#fff;margin-bottom:17px}.panel-sub{font-size:11px;color:var(--text-muted);margin-top:-10px;margin-bottom:16px}
        .info-row{display:grid;grid-template-columns:145px minmax(0,1fr);gap:14px;min-height:42px;align-items:center;border-bottom:1px solid var(--border-color)}.info-row:last-child{border-bottom:0}.info-label{font-size:10px;color:var(--text-muted);text-transform:uppercase;font-weight:700;letter-spacing:.5px}.info-value{font-size:12px;color:#fff;overflow-wrap:anywhere}.mono{font-family:'JetBrains Mono',monospace;font-size:11px}
        .metric{padding:18px;background:var(--bg-card);border:1px solid var(--border-color);border-radius:18px;min-width:0}.metric-label{font-size:10px;text-transform:uppercase;color:var(--text-muted);font-weight:700;letter-spacing:.6px}.metric-number{font-size:25px;font-weight:800;margin-top:7px;color:#fff}.metric-note{font-size:10px;color:var(--text-muted);margin-top:3px}
        .table-wrap{width:100%;overflow-x:auto}.data-table{width:100%;border-collapse:collapse;min-width:650px}.data-table th{font-size:10px;text-transform:uppercase;color:var(--text-muted);text-align:left;padding:11px;border-bottom:1px solid var(--border-color)}.data-table td{font-size:11px;padding:12px 11px;border-bottom:1px solid var(--border-color);color:#e5e7eb}.data-table tr:last-child td{border-bottom:0}
        .pill{display:inline-flex;padding:5px 9px;border-radius:15px;font-size:10px;font-weight:700;background:rgba(99,102,241,.1);color:#a5b4fc}.pill.office{background:rgba(16,185,129,.1);color:#34d399}.pill.home{background:rgba(6,182,212,.1);color:#22d3ee}.pill.late{background:rgba(245,158,11,.1);color:#fbbf24}.pill.approved{background:rgba(16,185,129,.1);color:#34d399}.pill.pending{background:rgba(245,158,11,.1);color:#fbbf24}.pill.rejected{background:rgba(239,68,68,.1);color:#f87171}
        .ai-box{border:1px solid rgba(99,102,241,.3);background:linear-gradient(135deg,rgba(99,102,241,.12),rgba(6,182,212,.06));border-radius:18px;padding:20px}.ai-top{display:flex;justify-content:space-between;align-items:center;gap:12px}.ai-score{font-size:32px;font-weight:800;color:#fff}.risk{font-size:11px;font-weight:800;padding:7px 10px;border-radius:15px;background:rgba(239,68,68,.12);color:#f87171}.ai-summary{font-size:12px;line-height:1.7;color:#d1d5db;margin-top:12px}.recommendation{margin-top:12px;font-size:11px;color:#cbd5e1}.ai-link{display:inline-flex;margin-top:15px;color:#a5b4fc;text-decoration:none;font-size:11px;font-weight:700}
        .timeline{display:flex;flex-direction:column}.event{display:grid;grid-template-columns:14px minmax(0,1fr);gap:12px;padding:12px 0;border-bottom:1px solid var(--border-color)}.event:last-child{border-bottom:0}.event-dot{width:9px;height:9px;border-radius:50%;background:var(--accent-primary);margin-top:4px;box-shadow:0 0 8px var(--accent-primary)}.event-title{font-size:11px;font-weight:700;color:#fff}.event-meta{font-size:10px;color:var(--text-muted);margin-top:4px}.empty{padding:24px;text-align:center;color:var(--text-muted);font-size:12px}
        .actions{display:flex;gap:10px;flex-wrap:wrap;margin-top:20px}

        @media(max-width:1200px){.grid-4{grid-template-columns:repeat(2,minmax(0,1fr))}.profile-hero{grid-template-columns:auto minmax(0,1fr)}.hero-status{grid-column:2;text-align:left}}
        @media(max-width:900px){.sidebar{width:220px;min-width:220px}.main{margin-left:220px;width:calc(100% - 220px);padding:24px}.grid-2{grid-template-columns:1fr}}
        @media(max-width:700px){.app{display:block}.sidebar{position:relative;width:100%;min-width:0}.menu{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));max-height:none}.main{margin-left:0;width:100%;padding:14px}.topbar{padding:20px;flex-direction:column;align-items:flex-start}.top-actions,.top-actions .btn{width:100%}.profile-hero{grid-template-columns:1fr;text-align:center;justify-items:center}.hero-status{grid-column:auto;text-align:center}.hero-meta{justify-content:center}.grid-4{grid-template-columns:1fr}.info-row{grid-template-columns:105px minmax(0,1fr)}}
        @media(max-width:450px){.menu{grid-template-columns:1fr}.profile-hero{padding:20px}.avatar{width:92px;height:92px}.hero-info h2{font-size:24px}.panel{padding:16px}.metric-number{font-size:22px}}
    </style>
</head>
<body>

<div class="app">
    <aside class="sidebar">
        <div class="logo"><div class="logo-title">Employee & Workforce</div><div class="logo-subtitle">Management System</div></div>
        <div class="menu-title">Overview</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/dashboard"><span class="menu-mark"></span>Dashboard</a>
            <a href="${pageContext.request.contextPath}/employee/list" class="active"><span class="menu-mark"></span>Employees</a>
            <a href="${pageContext.request.contextPath}/project/list"><span class="menu-mark"></span>Projects</a>
            <a href="${pageContext.request.contextPath}/client/list"><span class="menu-mark"></span>Clients</a>
        </nav>
        <div class="menu-title">Operations</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/attendance/admin"><span class="menu-mark"></span>Attendance</a>
            <a href="${pageContext.request.contextPath}/leave/admin"><span class="menu-mark"></span>Leave Approval</a>
            <a href="${pageContext.request.contextPath}/expense/admin"><span class="menu-mark"></span>Expenses</a>
            <a href="${pageContext.request.contextPath}/resignation/admin"><span class="menu-mark"></span>Resignation</a>
        </nav>
        <div class="menu-title">Administration</div>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/reports"><span class="menu-mark"></span>Reports</a>
            <a href="${pageContext.request.contextPath}/audit"><span class="menu-mark"></span>Audit Logs</a>
            <a href="${pageContext.request.contextPath}/admin/list"><span class="menu-mark"></span>Admin Management</a>
            <a href="${pageContext.request.contextPath}/restore/employees"><span class="menu-mark"></span>Restore Employees</a>
        </nav>
        <div class="sidebar-bottom"><a class="logout" href="${pageContext.request.contextPath}/auth/logout"><i class="fa-solid fa-arrow-right-from-bracket"></i>Logout</a></div>
    </aside>

    <main class="main">
        <div class="topbar">
            <div><h1>Employee & Workforce System</h1><p>Employee 360&#176; profile and workforce information</p></div>
            <div class="top-actions">
                <a class="btn" href="${pageContext.request.contextPath}/employee/list"><i class="fa-solid fa-arrow-left"></i> Employee List</a>
                <a class="btn primary" href="${pageContext.request.contextPath}/employee/edit/${employee.employeeId}"><i class="fa-solid fa-pen"></i> Edit Employee</a>
            </div>
        </div>

        <c:if test="${employee != null}">
            <div class="profile-hero">
                <div class="avatar">
                    <c:choose>
                        <c:when test="${not empty employee.imagePath}"><img src="${pageContext.request.contextPath}/employee/image/${employee.employeeId}" alt="${employee.employeeName}"></c:when>
                        <c:when test="${not empty employee.employeeName}">${employee.employeeName.substring(0,1).toUpperCase()}</c:when>
                        <c:otherwise>E</c:otherwise>
                    </c:choose>
                </div>
                <div class="hero-info">
                    <h2>${employee.employeeName}</h2>
                    <div class="hero-id">${employee.employeeId} &middot; ${employee.employeeEmail}</div>
                    <div class="hero-meta">
                        <span class="badge">${employee.role}</span>
                        <span class="badge">${employee.employeeDept}</span>
                        <c:choose><c:when test="${employee.project != null}"><span class="badge">Project: ${employee.project.projectName}</span></c:when><c:otherwise><span class="badge warning">Bench</span></c:otherwise></c:choose>
                    </div>
                </div>
                <div class="hero-status">
                    <div class="status-dot">${empty employee.employmentStatus ? 'ACTIVE' : employee.employmentStatus}</div>
                    <div class="status-sub">Joined ${employee.dateOfJoining}</div>
                </div>
            </div>

            <div class="section">
                <div class="section-title"><h3>Employment Overview</h3><span>Current workforce assignment</span></div>
                <div class="grid-2">
                    <div class="panel">
                        <h4><i class="fa-solid fa-id-badge"></i> Employment Information</h4>
                        <div class="info-row"><div class="info-label">Employee ID</div><div class="info-value mono">${employee.employeeId}</div></div>
                        <div class="info-row"><div class="info-label">Department</div><div class="info-value">${employee.employeeDept}</div></div>
                        <div class="info-row"><div class="info-label">Role</div><div class="info-value">${employee.role}</div></div>
                        <div class="info-row"><div class="info-label">Status</div><div class="info-value">${empty employee.employmentStatus ? 'ACTIVE' : employee.employmentStatus}</div></div>
                        <div class="info-row"><div class="info-label">Date of Joining</div><div class="info-value">${employee.dateOfJoining}</div></div>
                        <div class="info-row"><div class="info-label">Phone</div><div class="info-value">${employee.employeePhone}</div></div>
                        <div class="info-row"><div class="info-label">Email</div><div class="info-value">${employee.employeeEmail}</div></div>
                    </div>
                    <div class="panel">
                        <h4><i class="fa-solid fa-diagram-project"></i> Current Project Assignment</h4>
                        <c:choose>
                            <c:when test="${employee.project != null}">
                                <div class="info-row"><div class="info-label">Project</div><div class="info-value">${employee.project.projectName}</div></div>
                                <div class="info-row"><div class="info-label">Project ID</div><div class="info-value mono">${employee.project.projectId}</div></div>
                                <div class="info-row"><div class="info-label">Client</div><div class="info-value">${employee.project.client != null ? employee.project.client.clientName : 'Not linked'}</div></div>
                                <div class="info-row"><div class="info-label">Start Date</div><div class="info-value">${employee.project.projectStartDate}</div></div>
                                <div class="info-row"><div class="info-label">End Date</div><div class="info-value">${empty employee.project.projectEndDate ? 'Ongoing' : employee.project.projectEndDate}</div></div>
                                <div class="info-row"><div class="info-label">Project Status</div><div class="info-value">${employee.project.active ? 'ACTIVE' : 'INACTIVE'}</div></div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty">Employee is currently on the <strong>Bench</strong> and available for project allocation.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="section">
                <div class="section-title"><h3>Attendance & Workforce Summary</h3><span>Based on recorded attendance</span></div>
                <div class="grid-4">
                    <div class="metric"><div class="metric-label">Attendance Records</div><div class="metric-number">${attendanceTotal}</div><div class="metric-note">total records</div></div>
                    <div class="metric"><div class="metric-label">Present Days</div><div class="metric-number">${presentDays}</div><div class="metric-note">recorded present</div></div>
                    <div class="metric"><div class="metric-label">Late Days</div><div class="metric-number">${lateDays}</div><div class="metric-note">late arrivals</div></div>
                    <div class="metric"><div class="metric-label">Office / Home</div><div class="metric-number">${officeDays} / ${homeDays}</div><div class="metric-note">GPS attendance type</div></div>
                </div>
            </div>

            <div class="section grid-2">
                <div class="panel">
                    <div class="section-title"><h3>Recent Attendance</h3><span>Latest 8 records</span></div>
                    <div class="table-wrap">
                        <table class="data-table"><thead><tr><th>Date</th><th>Check In</th><th>Check Out</th><th>Location</th><th>Status</th></tr></thead><tbody>
                            <c:forEach var="a" items="${attendanceRecords}">
                                <tr><td>${a.attendanceDate}</td><td>${a.checkIn}</td><td>${empty a.checkOut ? '&mdash;' : a.checkOut}</td><td><span class="pill ${a.attendanceType == 'OFFICE' ? 'office' : 'home'}">${empty a.attendanceType ? '&mdash;' : a.attendanceType}</span></td><td><span class="pill ${a.late ? 'late' : ''}">${a.late ? 'LATE' : a.status}</span></td></tr>
                            </c:forEach>
                            <c:if test="${empty attendanceRecords}"><tr><td colspan="5" class="empty">No attendance records found.</td></tr></c:if>
                        </tbody></table>
                    </div>
                </div>

                <div class="panel">
                    <div class="section-title"><h3>AI Workforce Insight</h3><span>Attendance behavior analysis</span></div>
                    <div class="ai-box">
                        <div class="ai-top"><div class="ai-score">${attendanceAnalysis.attendanceScore}<small>/100</small></div><div class="risk">${attendanceAnalysis.riskLevel}</div></div>
                        <div class="ai-summary">${attendanceAnalysis.summary}</div>
                        <div class="recommendation"><strong>Recommendation:</strong> ${attendanceAnalysis.recommendation}</div>
                        <a class="ai-link" href="${pageContext.request.contextPath}/attendance/ai-analysis?employeeId=${employee.employeeId}&days=30">View Detailed AI Analysis &rarr;</a>
                    </div>
                </div>
            </div>

            <div class="section grid-2">
                <div class="panel">
                    <div class="section-title"><h3>Leave Summary</h3><span>Employee leave activity</span></div>
                    <div class="grid-4" style="grid-template-columns:repeat(3,minmax(0,1fr));margin-bottom:14px">
                        <div class="metric"><div class="metric-label">Allocated</div><div class="metric-number">${balance.allocatedDays}</div></div>
                        <div class="metric"><div class="metric-label">Used</div><div class="metric-number">${balance.usedDays}</div></div>
                        <div class="metric"><div class="metric-label">Remaining</div><div class="metric-number">${balance.remainingDays}</div></div>
                    </div>
                    <div class="info-row"><div class="info-label">Pending Requests</div><div class="info-value">${pendingLeaves}</div></div>
                    <div class="info-row"><div class="info-label">Approved Requests</div><div class="info-value">${approvedLeaves}</div></div>
                    <div class="table-wrap" style="margin-top:10px"><table class="data-table" style="min-width:480px"><thead><tr><th>Type</th><th>Dates</th><th>Days</th><th>Status</th></tr></thead><tbody>
                        <c:forEach var="l" items="${leaveRequests}"><tr><td>${l.leaveType}</td><td>${l.startDate} &rarr; ${l.endDate}</td><td>${l.days}</td><td><span class="pill ${l.status == 'APPROVED' ? 'approved' : l.status == 'REJECTED' ? 'rejected' : 'pending'}">${l.status}</span></td></tr></c:forEach>
                        <c:if test="${empty leaveRequests}"><tr><td colspan="4" class="empty">No leave requests found.</td></tr></c:if>
                    </tbody></table></div>
                </div>

                <div class="panel">
                    <div class="section-title"><h3>Expense Summary</h3><span>Employee expense activity</span></div>
                    <div class="grid-4" style="grid-template-columns:repeat(2,minmax(0,1fr));margin-bottom:14px">
                        <div class="metric"><div class="metric-label">Total Claims</div><div class="metric-number">${expenseClaims.size()}</div></div>
                        <div class="metric"><div class="metric-label">Total Amount</div><div class="metric-number">&#8377;${totalExpenseAmount}</div></div>
                        <div class="metric"><div class="metric-label">Approved</div><div class="metric-number">&#8377;${approvedExpenseAmount}</div></div>
                        <div class="metric"><div class="metric-label">Pending</div><div class="metric-number">${pendingExpenses}</div></div>
                    </div>
                    <div class="table-wrap"><table class="data-table" style="min-width:480px"><thead><tr><th>Type</th><th>Amount</th><th>Status</th><th>Submitted</th></tr></thead><tbody>
                        <c:forEach var="x" items="${expenseClaims}"><tr><td>${x.expenseType}</td><td>&#8377;${x.amount}</td><td><span class="pill ${x.status == 'APPROVED' ? 'approved' : x.status == 'REJECTED' ? 'rejected' : 'pending'}">${x.status}</span></td><td>${x.submittedAt}</td></tr></c:forEach>
                        <c:if test="${empty expenseClaims}"><tr><td colspan="4" class="empty">No expense claims found.</td></tr></c:if>
                    </tbody></table></div>
                </div>
            </div>

            <div class="section grid-2">
                <div class="panel">
                    <div class="section-title"><h3>Employee Lifecycle</h3><span>Resignation / exit status</span></div>
                    <c:choose><c:when test="${latestResignation != null}">
                        <div class="info-row"><div class="info-label">Status</div><div class="info-value"><span class="pill ${latestResignation.status == 'APPROVED' ? 'approved' : latestResignation.status == 'REJECTED' ? 'rejected' : 'pending'}">${latestResignation.status}</span></div></div>
                        <div class="info-row"><div class="info-label">Submitted</div><div class="info-value">${latestResignation.submittedDate}</div></div>
                        <div class="info-row"><div class="info-label">Last Working Date</div><div class="info-value">${empty latestResignation.lastWorkingDate ? 'Not set' : latestResignation.lastWorkingDate}</div></div>
                        <div class="info-row"><div class="info-label">Reason</div><div class="info-value">${latestResignation.reason}</div></div>
                    </c:when><c:otherwise><div class="empty">No resignation request has been submitted.</div></c:otherwise></c:choose>
                </div>

                <div class="panel">
                    <div class="section-title"><h3>Activity Timeline</h3><span>Recent system activity</span></div>
                    <div class="timeline">
                        <c:forEach var="act" items="${activities}"><div class="event"><div class="event-dot"></div><div><div class="event-title">${act.action} &middot; ${act.entityType}</div><div class="event-meta">${act.details} &middot; ${act.createdAt}</div></div></div></c:forEach>
                        <c:if test="${empty activities}"><div class="empty">No audit activity found for this employee.</div></c:if>
                    </div>
                </div>
            </div>

            <div class="actions">
                <a class="btn" href="${pageContext.request.contextPath}/employee/list"><i class="fa-solid fa-arrow-left"></i> Back to Employee List</a>
                <a class="btn primary" href="${pageContext.request.contextPath}/employee/edit/${employee.employeeId}"><i class="fa-solid fa-pen"></i> Edit Employee</a>
                <a class="btn" href="${pageContext.request.contextPath}/attendance/ai-analysis?employeeId=${employee.employeeId}&days=30"><i class="fa-solid fa-robot"></i> AI Attendance Analysis</a>
            </div>
        </c:if>

        <c:if test="${employee == null}">
            <div class="panel" style="text-align:center;padding:70px 20px"><h2 style="color:#fff;margin-bottom:10px">Employee Not Found</h2><p style="color:var(--text-muted);margin-bottom:20px">The requested employee profile could not be found.</p><a class="btn primary" href="${pageContext.request.contextPath}/employee/list">Back to Employee List</a></div>
        </c:if>
    </main>
</div>
</body>
</html>