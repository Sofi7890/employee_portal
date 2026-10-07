<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Client Dashboard</title>

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
            width: 100%;
            max-width: 1150px;
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: hidden;
            animation: fadeDown 0.6s ease;
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

        .logout-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: var(--danger);
            padding: 10px 20px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 700;
            transition: var(--transition);
        }

        .logout-btn:hover {
            background: rgba(239, 68, 68, 0.2);
            border-color: rgba(239, 68, 68, 0.5);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.2);
        }

        /* Cards / Sections */
        .section {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 32px;
            margin-bottom: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            animation: fadeUp 0.7s ease;
            position: relative;
        }

        .section h2 {
            margin: 0 0 24px;
            color: #fff;
            font-size: 18px;
            font-weight: 700;
        }

        /* Information Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }

        .info-card {
            background: rgba(17, 24, 39, 0.5);
            border: 1px solid var(--border-color);
            border-left: 4px solid var(--accent-primary);
            padding: 18px;
            border-radius: 14px;
            transition: var(--transition);
        }

        .info-card:hover {
            transform: translateY(-3px);
            border-color: var(--border-hover);
            box-shadow: 0 8px 20px var(--accent-glow);
        }

        .info-label {
            display: block;
            color: var(--text-muted);
            font-size: 10px;
            font-weight: 700;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        .info-value {
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            font-family: 'JetBrains Mono', monospace;
        }

        /* Tables */
        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            min-width: 700px;
        }

        th {
            background: rgba(17, 24, 39, 0.6);
            color: var(--text-muted);
            padding: 14px 18px;
            text-align: left;
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            border-bottom: 1px solid var(--border-color);
        }

        th:first-child {
            border-top-left-radius: 12px;
        }

        th:last-child {
            border-top-right-radius: 12px;
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

        .project-id {
            color: #818cf8;
            font-weight: 700;
            font-family: 'JetBrains Mono', monospace;
        }

        .project-name {
            color: #fff;
            font-weight: 700;
        }

        .contact-name {
            color: #fff;
            font-weight: 700;
        }

        /* Action Buttons */
        .actions {
            display: flex;
            gap: 8px;
        }

        .edit-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
            text-decoration: none;
            padding: 7px 14px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 700;
            transition: var(--transition);
        }

        .edit-btn:hover {
            background: rgba(16, 185, 129, 0.2);
            transform: translateY(-1px);
        }

        .delete-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
            text-decoration: none;
            padding: 7px 14px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 700;
            transition: var(--transition);
        }

        .delete-btn:hover {
            background: rgba(239, 68, 68, 0.2);
            transform: translateY(-1px);
        }

        /* Empty Message */
        .empty {
            background: rgba(17, 24, 39, 0.4);
            border: 1px dashed var(--border-color);
            border-radius: 14px;
            padding: 40px 20px;
            text-align: center;
            color: var(--text-muted);
            font-size: 13px;
        }

        /* Animations */
        @keyframes fadeDown {
            from { opacity: 0; transform: translateY(-15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 750px) {
            body {
                padding: 20px 10px;
            }

            .header {
                flex-direction: column;
                gap: 18px;
                text-align: center;
                padding: 20px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .section {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <!-- Header -->
    <div class="header">
        <div>
            <h1>Welcome, ${client.clientName}</h1>
            <p>Client dashboard and project management overview</p>
        </div>
        <a href="${pageContext.request.contextPath}/auth/logout" class="logout-btn">
            <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
        </a>
    </div>

    <!-- Client Information -->
    <div class="section">
        <h2>My Information</h2>
        <div class="info-grid">
            <div class="info-card">
                <span class="info-label">Client ID</span>
                <span class="info-value">${client.clientId}</span>
            </div>
            <div class="info-card">
                <span class="info-label">Relationship Date</span>
                <span class="info-value">${client.clientRelationshipDate}</span>
            </div>
            <div class="info-card">
                <span class="info-label">Role</span>
                <span class="info-value">${client.role}</span>
            </div>
        </div>
    </div>

    <!-- Projects -->
    <div class="section">
        <h2>My Projects</h2>
        <c:choose>
            <c:when test="${not empty projects}">
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Project ID</th>
                                <th>Name</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="project" items="${projects}">
                                <tr>
                                    <td class="project-id">${project.projectId}</td>
                                    <td class="project-name">${project.projectName}</td>
                                    <td>${project.projectStartDate}</td>
                                    <td>${project.projectEndDate != null ? project.projectEndDate : '-'}</td>
                                    <td>
                                        <div class="actions">
                                            <a href="<c:url value='/project/edit/${project.projectId}' />" class="edit-btn">
                                                <i class="fa-solid fa-pen-to-square"></i> Edit
                                            </a>
                                            <a href="<c:url value='/project/delete/${project.projectId}' />" class="delete-btn"
                                               onclick="return confirm('Are you sure you want to delete this project?');">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty">
                    <i class="fa-solid fa-folder-open" style="font-size: 24px; margin-bottom: 8px; display: block; color: var(--accent-primary);"></i>
                    No active projects found.
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Contacts -->
    <div class="section">
        <h2>My Contacts</h2>
        <c:choose>
            <c:when test="${not empty contacts}">
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="contact" items="${contacts}">
                                <tr>
                                    <td class="contact-name">${contact.name}</td>
                                    <td>${contact.email}</td>
                                    <td>${contact.phone}</td>
                                    <td>
                                        <div class="actions">
                                            <a href="<c:url value='/contact-person/edit/${contact.id}' />" class="edit-btn">
                                                <i class="fa-solid fa-pen-to-square"></i> Edit
                                            </a>
                                            <a href="<c:url value='/contact-person/delete/${contact.id}' />" class="delete-btn"
                                               onclick="return confirm('Are you sure you want to delete this contact?');">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty">
                    <i class="fa-solid fa-address-book" style="font-size: 24px; margin-bottom: 8px; display: block; color: var(--accent-primary);"></i>
                    No contact persons registered for this client.
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</div>

</body>
</html>