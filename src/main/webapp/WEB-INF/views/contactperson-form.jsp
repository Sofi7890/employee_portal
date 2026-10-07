<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Person Form</title>

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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
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

        .form-container {
            width: 100%;
            max-width: 650px;
            background: var(--bg-card);
            border-radius: 24px;
            padding: 36px 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
            animation: fadeInAnim 0.6s ease;
        }

        .form-container::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        @keyframes fadeInAnim {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-header {
            text-align: left;
            margin-bottom: 28px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .form-header h2 {
            margin: 0;
            color: #fff;
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .form-header p {
            margin: 6px 0 0;
            color: var(--text-muted);
            font-size: 13px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-main);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        .form-group input,
        .form-group select {
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

        .form-group input:hover,
        .form-group select:hover {
            border-color: var(--border-hover);
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: var(--accent-primary);
            background: rgba(11, 15, 25, 0.8);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        select option {
            background: var(--bg-secondary);
            color: var(--text-main);
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 28px;
        }

        .submit-btn {
            flex: 1;
            border: none;
            padding: 14px;
            border-radius: 12px;
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
            padding: 14px;
            border-radius: 12px;
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

        @media (max-width: 600px) {
            body {
                padding: 15px;
            }

            .form-container {
                padding: 24px;
            }

            .form-actions {
                flex-direction: column;
            }

            .form-header h2 {
                font-size: 22px;
            }
        }
    </style>

</head>

<body>

<div class="form-container">

    <div class="form-header">
        <h2>
            ${contactPerson.id != null ? "Edit Contact Person" : "Add Contact Person"}
        </h2>
        <p>
            Manage contact person information records securely
        </p>
    </div>

    <c:choose>
        <c:when test="${contactPerson.id != null}">
            <form method="post" action="${pageContext.request.contextPath}/contact-person/update/${contactPerson.id}">
        </c:when>
        <c:otherwise>
            <form method="post" action="${pageContext.request.contextPath}/contact-person/create">
        </c:otherwise>
    </c:choose>

        <div class="form-group">
            <label>Name</label>
            <input type="text"
                   name="name"
                   value="${contactPerson.name}"
                   placeholder="Enter contact person name"
                   required />
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email"
                   name="email"
                   value="${contactPerson.email}"
                   placeholder="Enter email address"
                   required />
        </div>

        <div class="form-group">
            <label>Phone</label>
            <input type="text"
                   name="phone"
                   value="${contactPerson.phone}"
                   placeholder="Enter phone number"
                   required />
        </div>

        <div class="form-group">
            <label>Designation</label>
            <input type="text"
                   name="designation"
                   value="${contactPerson.designation}"
                   placeholder="Enter designation"
                   required />
        </div>

        <div class="form-group">
            <label>Client</label>
            <select name="clientId" required>
                <option value="">-- Select Client --</option>
                <c:forEach var="client" items="${clients}">
                    <option value="${client.clientId}"
                        ${contactPerson.client != null && contactPerson.client.clientId == client.clientId ? "selected" : ""}>
                        ${client.clientName}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-actions">
            <input type="submit"
                   class="submit-btn"
                   value="${contactPerson.id != null ? 'Update Contact' : 'Create Contact'}" />

            <a href="${pageContext.request.contextPath}/contact-person/list" class="cancel-btn">
                <i class="fa-solid fa-arrow-left"></i> Cancel
            </a>
        </div>

    </form>

</div>

</body>

</html>