<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Employee Search</title>

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
            width: 94%;
            max-width: 1400px;
            margin: auto;
            animation: fadeIn 0.6s ease;
        }

        .header-card {
            background: #ffffff;
            padding: 28px;
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.16);
            margin-bottom: 22px;
        }

        .header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 22px;
        }

        h1 {
            margin: 0;
            color: #4c51bf;
            font-size: 29px;
        }

        .subtitle {
            margin: 7px 0 0;
            color: #777;
            font-size: 14px;
        }

        .dashboard-btn {
            text-decoration: none;
            color: #4c51bf;
            background: #eef0ff;
            padding: 10px 17px;
            border-radius: 9px;
            font-weight: bold;
            font-size: 14px;
            transition: all 0.25s ease;
        }

        .dashboard-btn:hover {
            background: #e0e3ff;
            transform: translateY(-2px);
        }

        .search-form {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .search-form input,
        .search-form select {
            padding: 12px 14px;
            border: 1px solid #d7d8e5;
            border-radius: 9px;
            font-size: 14px;
            outline: none;
            background: white;
            transition: all 0.25s ease;
        }

        .search-form input {
            width: 350px;
        }

        .search-form input:focus,
        .search-form select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.12);
        }

        .search-btn {
            padding: 12px 24px;
            border: none;
            border-radius: 9px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.25s ease;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 16px rgba(76, 81, 191, 0.3);
        }

        .table-card {
            background: white;
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.16);
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 850px;
            border-collapse: collapse;
        }

        th {
            background: linear-gradient(135deg, #4c51bf, #764ba2);
            color: white;
            padding: 15px 13px;
            text-align: left;
            font-size: 13px;
            white-space: nowrap;
        }

        td {
            padding: 14px 13px;
            border-bottom: 1px solid #ececf2;
            font-size: 13px;
        }

        tbody tr {
            transition: all 0.2s ease;
        }

        tbody tr:hover {
            background: #f7f7ff;
        }

        .employee-id {
            color: #4c51bf;
            font-weight: bold;
        }

        .name {
            font-weight: bold;
            color: #333;
        }

        .email {
            color: #555;
        }

        .department {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            background: #f3e8ff;
            color: #7e22ce;
            font-size: 12px;
            font-weight: bold;
        }

        .project {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            background: #e0f2fe;
            color: #0369a1;
            font-size: 12px;
            font-weight: bold;
        }

        .bench {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            background: #fff7ed;
            color: #c2410c;
            font-size: 12px;
            font-weight: bold;
        }

        .empty {
            text-align: center;
            padding: 40px !important;
            color: #777;
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

        @media (max-width: 700px) {
            body {
                padding: 20px 12px;
            }

            .container {
                width: 96%;
            }

            .header-card {
                padding: 20px;
            }

            .header-row {
                display: block;
            }

            h1 {
                font-size: 24px;
            }

            .dashboard-btn {
                display: inline-block;
                margin-top: 15px;
            }

            .search-form {
                display: block;
            }

            .search-form input,
            .search-form select,
            .search-btn {
                width: 100%;
                margin-bottom: 8px;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header-card">

        <div class="header-row">

            <div>
                <h1>Employee Search</h1>
                <p class="subtitle">
                    Search employees by ID, name, email or department
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/dashboard"
               class="dashboard-btn">
                Dashboard
            </a>

        </div>


        <form method="get"
              action="${pageContext.request.contextPath}/employee/search"
              class="search-form">

            <input
                type="text"
                name="q"
                value="${q}"
                placeholder="ID, name, email, department">

            <select name="sort">

                <option value="">
                    Sort
                </option>

                <option value="name">
                    Name
                </option>

                <option value="joining">
                    Joining Date
                </option>

            </select>

            <button type="submit" class="search-btn">
                Search
            </button>

        </form>

    </div>


    <div class="table-card">

        <table>

            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Department</th>
                    <th>Joining</th>
                    <th>Project</th>
                </tr>
            </thead>

            <tbody>

            <c:forEach var="e" items="${employees}">

                <tr>

                    <td>
                        <strong class="employee-id">
                            ${e.employeeId}
                        </strong>
                    </td>

                    <td>
                        <span class="name">
                            ${e.employeeName}
                        </span>
                    </td>

                    <td>
                        <span class="email">
                            ${e.employeeEmail}
                        </span>
                    </td>

                    <td>
                        <span class="department">
                            ${e.employeeDept}
                        </span>
                    </td>

                    <td>
                        ${e.dateOfJoining}
                    </td>

                    <td>

                        <c:choose>

                            <c:when test="${e.project!=null}">
                                <span class="project">
                                    ${e.project.projectName}
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="bench">
                                    Bench
                                </span>
                            </c:otherwise>

                        </c:choose>

                    </td>

                </tr>

            </c:forEach>


            <c:if test="${empty employees}">

                <tr>
                    <td colspan="6" class="empty">
                        No employees found.
                    </td>
                </tr>

            </c:if>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>