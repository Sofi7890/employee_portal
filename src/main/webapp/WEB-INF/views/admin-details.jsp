<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Admin Details</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0f172a;
            color: #e5e7eb;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .header {
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0 0 8px;
            font-size: 30px;
        }

        .header p {
            margin: 0;
            color: #94a3b8;
        }

        .card {
            background: #111827;
            border: 1px solid #1f2937;
            border-radius: 14px;
            padding: 28px;
            margin-bottom: 20px;
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 28px;
        }

        .avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: #1e293b;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: #cbd5e1;
        }

        .profile h2 {
            margin: 0 0 6px;
        }

        .profile p {
            margin: 4px 0;
            color: #94a3b8;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px;
        }

        .info {
            background: #0f172a;
            border: 1px solid #1f2937;
            border-radius: 10px;
            padding: 16px;
        }

        .label {
            display: block;
            font-size: 12px;
            color: #64748b;
            margin-bottom: 7px;
            text-transform: uppercase;
            letter-spacing: .5px;
        }

        .value {
            font-size: 15px;
            font-weight: 600;
            word-break: break-word;
        }

        .status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: #064e3b;
            color: #6ee7b7;
            font-size: 12px;
            font-weight: 700;
        }

        .actions {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
        }

        .btn-back {
            background: #1e293b;
            color: #e5e7eb;
        }

        .btn-edit {
            background: #2563eb;
            color: white;
        }

        .btn:hover {
            opacity: .88;
        }

        @media (max-width: 700px) {
            .grid {
                grid-template-columns: 1fr;
            }

            .profile {
                align-items: flex-start;
            }

            .actions {
                flex-wrap: wrap;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>
            <i class="fa-solid fa-user-shield"></i>
            Administrator Details
        </h1>

        <p>
            View administrator account information and access status.
        </p>
    </div>

    <div class="card">

        <div class="profile">

            <div class="avatar">
                <i class="fa-solid fa-user-shield"></i>
            </div>

            <div>
                <h2>${admin.username}</h2>

                <p>
                    Administrator ID:
                    <strong>#${admin.adminId}</strong>
                </p>

                <p>
                    ${admin.email}
                </p>
            </div>

        </div>

        <div class="grid">

            <div class="info">
                <span class="label">Admin ID</span>
                <span class="value">
                    ${admin.adminId}
                </span>
            </div>

            <div class="info">
                <span class="label">Username</span>
                <span class="value">
                    ${admin.username}
                </span>
            </div>

            <div class="info">
                <span class="label">Email</span>
                <span class="value">
                    ${admin.email}
                </span>
            </div>

            <div class="info">
                <span class="label">Role</span>
                <span class="value">
                    ${admin.role}
                </span>
            </div>

            <div class="info">
                <span class="label">Account Status</span>

                <span class="status">
                    ${empty admin.status ? 'ACTIVE' : admin.status}
                </span>
            </div>

            <div class="info">
                <span class="label">Created Date</span>

                <span class="value">
                    <c:choose>
                        <c:when test="${not empty admin.createdDate}">
                            ${admin.createdDate}
                        </c:when>
                        <c:otherwise>
                            Not Available
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

            <div class="info">
                <span class="label">Last Login</span>

                <span class="value">
                    <c:choose>
                        <c:when test="${not empty admin.lastLogin}">
                            ${admin.lastLogin}
                        </c:when>
                        <c:otherwise>
                            Never
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

            <div class="info">
                <span class="label">Access Level</span>

                <span class="value">
                    Administrator
                </span>
            </div>

        </div>

        <div class="actions">

            <a href="${pageContext.request.contextPath}/admin/list"
               class="btn btn-back">
                <i class="fa-solid fa-arrow-left"></i>
                Back to Administrators
            </a>

            <a href="${pageContext.request.contextPath}/admin/edit/${admin.adminId}"
               class="btn btn-edit">
                <i class="fa-solid fa-pen"></i>
                Edit Administrator
            </a>

        </div>

    </div>

</div>

</body>
</html>