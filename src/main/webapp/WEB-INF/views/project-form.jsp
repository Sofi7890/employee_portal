<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Form</title>

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
            padding: 40px 20px;
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

        .page {
            width: 100%;
            max-width: 700px;
            margin: 0 auto;
            animation: pageEnter 0.7s ease;
        }

        .header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 24px 32px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
            text-align: left;
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
            font-size: 24px;
            color: #fff;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .header p {
            margin: 6px 0 0;
            font-size: 13px;
            color: var(--text-muted);
        }

        .form-card {
            background: var(--bg-card);
            border-radius: 24px;
            padding: 36px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            position: relative;
            overflow: hidden;
            border: 1px solid var(--border-color);
            animation: slideUp 0.8s ease;
        }

        .form-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .form-title {
            text-align: left;
            margin: 0 0 24px;
            color: #fff;
            font-size: 18px;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-main);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        input[type="text"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            background: rgba(11, 15, 25, 0.6);
            color: var(--text-main);
            font-size: 14px;
            outline: none;
            transition: var(--transition);
        }

        input[type="text"]:hover,
        input[type="date"]:hover,
        select:hover {
            border-color: var(--border-hover);
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        select:focus {
            border-color: var(--accent-primary);
            background: rgba(11, 15, 25, 0.8);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        select option {
            background: var(--bg-secondary);
            color: var(--text-main);
        }

        /* Date inputs: the native calendar icon renders near-black by
           default and disappears on our dark fields, so recolor it into
           the accent palette and give it its own small pill so it's a
           clearly visible, clickable target */
        input[type="date"] {
            color-scheme: dark;
        }

        input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(60%) sepia(90%) saturate(1200%) hue-rotate(200deg) brightness(1.15);
            opacity: 1;
            cursor: pointer;
            padding: 4px;
            border-radius: 6px;
            background-color: rgba(99, 102, 241, 0.12);
            transition: var(--transition);
        }

        input[type="date"]::-webkit-calendar-picker-indicator:hover {
            background-color: rgba(99, 102, 241, 0.25);
            transform: scale(1.08);
        }

        input[type="date"]::-moz-calendar-picker-indicator {
            filter: invert(60%) sepia(90%) saturate(1200%) hue-rotate(200deg) brightness(1.15);
        }

        .button-area {
            display: flex;
            gap: 12px;
            margin-top: 28px;
        }

        .submit-btn {
            flex: 1;
            border: none;
            border-radius: 12px;
            padding: 14px;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            color: white;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        .cancel-btn {
            flex: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            border-radius: 12px;
            padding: 14px;
            background: var(--bg-secondary);
            color: var(--text-main);
            font-size: 14px;
            font-weight: 600;
            border: 1px solid var(--border-color);
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .cancel-btn:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        .required-note {
            margin-top: 20px;
            text-align: center;
            color: var(--text-muted);
            font-size: 11px;
        }

        @keyframes pageEnter {
            from { opacity: 0; transform: translateY(30px) scale(0.98); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(35px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            body { padding: 20px 12px; }
            .form-card { padding: 24px; }
            .header h1 { font-size: 22px; }
            .form-title { font-size: 16px; }
            .button-area { flex-direction: column; }
        }
    </style>
</head>

<body>

<div class="page">

    <div class="header">
        <h1>Project Management</h1>
        <p>Employee and Workforce Management System</p>
    </div>

    <div class="form-card">

        <c:choose>
            <c:when test="${project.projectId != null}">
                <h2 class="form-title">Edit Project</h2>
                <form action="${pageContext.request.contextPath}/project/update/${project.projectId}" method="post">
            </c:when>
            <c:otherwise>
                <h2 class="form-title">Add Project</h2>
                <form action="${pageContext.request.contextPath}/project/create" method="post">
            </c:otherwise>
        </c:choose>

            <div class="form-group">
                <label for="projectName">Project Name</label>
                <input type="text" id="projectName" name="projectName" value="${project.projectName}" placeholder="Enter project name" required />
            </div>

            <div class="form-group">
                <label for="projectStartDate">Start Date</label>
                <input type="date" id="projectStartDate" name="projectStartDate" value="${project.projectStartDate}" required />
            </div>

            <div class="form-group">
                <label for="projectEndDate">End Date</label>
                <input type="date" id="projectEndDate" name="projectEndDate" value="${project.projectEndDate}" />
            </div>

            <div class="form-group">
                <label for="client">Client</label>
                <select name="client.clientId" id="client">
                    <option value="">-- Select Client --</option>
                    <c:forEach var="cl" items="${clients}">
                        <option value="${cl.clientId}"
                            <c:if test="${project.client != null && project.client.clientId eq cl.clientId}">
                                selected
                            </c:if>>
                            ${cl.clientName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="button-area">
                <c:choose>
                    <c:when test="${project.projectId != null}">
                        <input type="submit" value="Update Project" class="submit-btn" />
                    </c:when>
                    <c:otherwise>
                        <input type="submit" value="Create Project" class="submit-btn" />
                    </c:otherwise>
                </c:choose>

                <a href="${pageContext.request.contextPath}/project/list" class="cancel-btn">
                    <i class="fa-solid fa-arrow-left"></i> Cancel
                </a>
            </div>

            <div class="required-note">
                Project name and start date are required fields.
            </div>

        </form>

    </div>

</div>

</body>
</html>
