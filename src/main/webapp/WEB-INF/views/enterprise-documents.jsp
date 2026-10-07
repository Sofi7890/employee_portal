<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Employee Documents - Enterprise </title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap"
          rel="stylesheet">

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

        /* Form */

        form {

            display: flex;

            gap: 12px;

            align-items: center;

            flex-wrap: wrap;
        }

        input,
        select {

            height: 44px;

            padding: 0 16px;

            border: 1px solid var(--border-color);

            border-radius: 12px;

            background: rgba(11, 15, 25, 0.6);

            color: var(--text-main);

            font-family: 'Plus Jakarta Sans', sans-serif;

            font-size: 13px;

            outline: none;

            transition: var(--transition);

            flex: 1;

            min-width: 150px;
        }

        select {

            cursor: pointer;

            padding-right: 32px;
        }

        input:hover,
        select:hover {

            border-color: var(--border-hover);
        }

        input:focus,
        select:focus {

            border-color: var(--accent-primary);

            background: rgba(11, 15, 25, 0.8);

            box-shadow:
                0 0 15px var(--accent-glow);
        }

        select option {

            background: var(--bg-secondary);

            color: var(--text-main);
        }

        input[type="date"] {

            font-family: 'JetBrains Mono', monospace;

            font-size: 12px;
        }

        /* File Upload */

        input[type="file"] {

            height: 44px;

            padding: 7px 10px;

            cursor: pointer;

            color: var(--text-muted);

            min-width: 220px;
        }

        input[type="file"]::file-selector-button {

            border: none;

            border-radius: 8px;

            padding: 7px 12px;

            margin-right: 10px;

            background: rgba(99, 102, 241, 0.15);

            color: #818cf8;

            font-family: 'Plus Jakarta Sans', sans-serif;

            font-weight: 600;

            cursor: pointer;

            transition: var(--transition);
        }

        input[type="file"]::file-selector-button:hover {

            background: rgba(99, 102, 241, 0.25);
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

        /* Table */

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

        /* Document Type */

        .document-type {

            display: inline-block;

            padding: 4px 10px;

            background: rgba(99, 102, 241, 0.1);

            color: #818cf8;

            border-radius: 6px;

            font-weight: 600;

            font-size: 11px;

            white-space: nowrap;
        }

        /* Status */

        .status-badge {

            display: inline-flex;

            align-items: center;

            gap: 5px;

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

        /* View File */

        .view-file {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            padding: 8px 12px;

            border-radius: 9px;

            background: rgba(99, 102, 241, 0.12);

            color: #818cf8;

            border: 1px solid rgba(99, 102, 241, 0.22);

            text-decoration: none;

            font-size: 11px;

            font-weight: 700;

            transition: var(--transition);

            white-space: nowrap;
        }

        .view-file:hover {

            background: rgba(99, 102, 241, 0.22);

            color: #a5b4fc;

            border-color: rgba(99, 102, 241, 0.4);

            transform: translateY(-1px);
        }

        .no-file {

            color: var(--text-muted);

            font-size: 11px;
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
            select,
            button {

                width: 100%;

                min-width: 0;
            }

            .panel {

                padding: 20px;
            }

            input[type="file"] {

                width: 100%;
            }
        }

    </style>

</head>

<body>

<div class="wrap">

    <!-- Header -->

    <div class="top-header">

        <div>

            <h1>Employee Documents</h1>

            <p class="muted">
                Manage  documents, record details, and expiry tracking.
            </p>

        </div>

        <a class="back-link"
           href="${pageContext.request.contextPath}/enterprise">

            <i class="fa-solid fa-arrow-left"></i>

            Enterprise Center

        </a>

    </div>


    <!-- Upload Document -->

    <div class="panel">

        <div class="panel-title">

            <i class="fa-solid fa-file-circle-plus"
               style="color: var(--accent-secondary);"></i>

            Upload / Add New Document Record

        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/enterprise/documents/save"
              enctype="multipart/form-data">

            <select name="employeeId" required>

                <option value="">
                    Select Employee
                </option>

                <c:forEach var="e" items="${employees}">

                    <option value="${e.employeeId}">
                        ${e.employeeId} - ${e.employeeName}
                    </option>

                </c:forEach>

            </select>


            <input name="type"
                   placeholder="Document Type (e.g. ID Proof)"
                   required>


            <input name="name"
                   placeholder="Document Name"
                   required>


            <input name="issueDate"
                   type="date"
                   title="Issue Date">


            <input name="expiryDate"
                   type="date"
                   title="Expiry Date">


            <input type="file"
                   name="documentFile"
                   accept=".pdf,.jpg,.jpeg,.png,.doc,.docx"
                   required>


            <button type="submit">

                <i class="fa-solid fa-cloud-arrow-up"></i>

                Upload Document

            </button>

        </form>

        <span class="form-note">

            <i class="fa-solid fa-circle-info"></i>

            Supported files: PDF, JPG, JPEG, PNG, DOC and DOCX.

        </span>

    </div>


    <!-- Document Repository -->

    <div class="panel">

        <div class="panel-title">

            <i class="fa-solid fa-folder-open"
               style="color: var(--accent-primary);"></i>

            Workforce Document Repository

        </div>

        <div class="table-wrapper">

            <table>

                <thead>

                <tr>

                    <th>Employee ID</th>

                    <th>Document Type</th>

                    <th>Document Name</th>

                    <th>Issue Date</th>

                    <th>Expiry Date</th>

                    <th>Status</th>

                    <th>Document</th>

                </tr>

                </thead>

                <tbody>

                <c:forEach var="d" items="${documents}">

                    <tr>

                        <td style="
                            font-family: 'JetBrains Mono', monospace;
                            font-weight: 700;
                            color: #fff;
                        ">

                            ${d.employee.employeeId}

                        </td>


                        <td>

                            <span class="document-type">

                                ${d.documentType}

                            </span>

                        </td>


                        <td style="
                            font-weight: 600;
                            color: #fff;
                        ">

                            ${d.documentName}

                        </td>


                        <td style="
                            font-family: 'JetBrains Mono', monospace;
                            font-size: 12px;
                            color: var(--text-muted);
                        ">

                            ${d.issueDate}

                        </td>


                        <td style="
                            font-family: 'JetBrains Mono', monospace;
                            font-size: 12px;
                            color: var(--text-muted);
                        ">

                            ${d.expiryDate}

                        </td>


                        <td>

                            <span class="status-badge">

                                <i class="fa-solid fa-circle-check"></i>

                                ${d.status}

                            </span>

                        </td>


                        <td>

                            <c:choose>

                                <c:when test="${not empty d.filePath}">

                                    <a class="view-file"
                                       href="${pageContext.request.contextPath}/enterprise/documents/${d.id}/view"
                                       target="_blank">

                                        <i class="fa-solid fa-file-arrow-up"></i>

                                        View File

                                    </a>

                                </c:when>

                                <c:otherwise>

                                    <span class="no-file">
                                        No File
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