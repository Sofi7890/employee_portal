<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Details</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 40px 20px;
            font-family: Arial, Helvetica, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            min-height: 100vh;
            color: #333;
        }

        .container {
            width: 100%;
            max-width: 850px;
            margin: auto;
        }

        .card {
            background: #ffffff;
            border-radius: 18px;
            padding: 35px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.18);
            animation: fadeIn 0.6s ease;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h2 {
            margin: 0;
            color: #4c51bf;
            font-size: 30px;
        }

        .header p {
            margin-top: 8px;
            color: #777;
            font-size: 14px;
        }

        .details-table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            border-radius: 12px;
        }

        .details-table tr {
            transition: background 0.2s ease;
        }

        .details-table tr:hover {
            background: #f7f7ff;
        }

        .details-table td {
            padding: 16px 18px;
            border-bottom: 1px solid #e8e8ef;
            font-size: 15px;
        }

        .details-table td:first-child {
            width: 35%;
            font-weight: bold;
            color: #4c51bf;
            background: #f5f6ff;
        }

        .details-table td:last-child {
            color: #333;
        }

        .details-table tr:last-child td {
            border-bottom: none;
        }

        .employee-id {
            font-weight: bold;
            color: #764ba2;
        }

        .role-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            background: #ede9fe;
            color: #6d28d9;
            font-weight: bold;
            font-size: 13px;
        }

        .project-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            background: #e0f2fe;
            color: #0369a1;
            font-weight: bold;
            font-size: 13px;
        }

        .no-project {
            color: #888;
            font-style: italic;
        }

        .actions {
            margin-top: 28px;
            display: flex;
            justify-content: center;
        }

        .back-btn {
            display: inline-block;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 10px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: bold;
            transition: all 0.25s ease;
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(76, 81, 191, 0.3);
        }

        .not-found {
            background: white;
            max-width: 600px;
            margin: 80px auto;
            padding: 40px;
            border-radius: 18px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.18);
            animation: fadeIn 0.6s ease;
        }

        .not-found h2 {
            color: #dc2626;
            margin-bottom: 10px;
        }

        .not-found p {
            color: #666;
            margin-bottom: 25px;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(15px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 600px) {
            body {
                padding: 20px 12px;
            }

            .card {
                padding: 22px;
            }

            .header h2 {
                font-size: 24px;
            }

            .details-table td {
                padding: 13px 10px;
                font-size: 14px;
            }

            .details-table td:first-child {
                width: 40%;
            }
        }
    </style>
</head>

<body>

<c:if test="${employee != null}">

    <div class="container">

        <div class="card">

            <c:if test="${not empty employee.imagePath}">
                <div style="text-align:center;margin:20px 0;">
                    <img src="${pageContext.request.contextPath}/employee/image/${employee.employeeId}"
                         alt="${employee.employeeName}"
                         style="width:120px;height:120px;object-fit:cover;border-radius:50%;">
                </div>
            </c:if>

            <div class="header">
                <h2>Employee Details</h2>
                <p>Complete employee information</p>
            </div>

            <table class="details-table">

                <tr>
                    <td>ID</td>
                    <td class="employee-id">
                        ${employee.employeeId}
                    </td>
                </tr>

                <tr>
                    <td>Name</td>
                    <td>
                        ${employee.employeeName}
                    </td>
                </tr>

                <tr>
                    <td>Department</td>
                    <td>
                        ${employee.employeeDept}
                    </td>
                </tr>

                <tr>
                    <td>Email</td>
                    <td>
                        ${employee.employeeEmail}
                    </td>
                </tr>

                <tr>
                    <td>Phone</td>
                    <td>
                        ${employee.employeePhone}
                    </td>
                </tr>

                <tr>
                    <td>Date of Joining</td>
                    <td>
                        ${employee.dateOfJoining}
                    </td>
                </tr>

                <tr>
                    <td>Role</td>
                    <td>
                        <span class="role-badge">
                            ${employee.role}
                        </span>
                    </td>
                </tr>

                <tr>
                    <td>Project</td>
                    <td>

                        <c:choose>

                            <c:when test="${employee.project != null}">
                                <span class="project-badge">
                                    ${employee.project.projectName}
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="no-project">
                                    None
                                </span>
                            </c:otherwise>

                        </c:choose>

                    </td>
                </tr>

            </table>

            <div class="actions">
                <a class="back-btn"
                   href="${pageContext.request.contextPath}/employee/list">
                    Back to Employee List
                </a>
            </div>

        </div>

    </div>

</c:if>


<c:if test="${employee == null}">

    <div class="not-found">

        <h2>No Employee Found</h2>

        <p>
            The requested employee could not be found.
        </p>

        <a class="back-btn"
           href="${pageContext.request.contextPath}/employee/list">
            Back to Employee List
        </a>

    </div>

</c:if>

</body>
</html>