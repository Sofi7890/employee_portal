<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Central Approval Center - Enterprise HR</title>

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
            max-width: 1150px;
            margin: auto;
        }

        /* Header */

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

        /* Panel */

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

            margin-bottom: 18px;

            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Create form */

        .approval-form {
            display: grid;

            grid-template-columns:
                1fr
                1fr
                1.4fr
                auto;

            gap: 12px;

            align-items: end;
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 7px;
        }

        .field label {
            color: var(--text-muted);

            font-size: 11px;
            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 0.5px;
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

            width: 100%;
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
            justify-content: center;

            gap: 8px;

            white-space: nowrap;
        }

        button:hover {
            transform: translateY(-2px);

            box-shadow:
                0 8px 25px rgba(0, 0, 0, 0.4);
        }

        .create-button {
            width: 100%;
        }

        .help-text {
            margin-top: 14px;

            color: var(--text-muted);

            font-size: 12px;

            line-height: 1.6;
        }

        .help-text i {
            color: var(--accent-secondary);
            margin-right: 5px;
        }

        /* Table */

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 900px;
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

        td:first-child {
            font-family: 'JetBrains Mono', monospace;

            font-weight: 700;

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

        .type-badge {
            display: inline-flex;

            align-items: center;

            padding: 4px 10px;

            border-radius: 6px;

            background: rgba(6, 182, 212, 0.1);

            color: #22d3ee;

            border: 1px solid rgba(6, 182, 212, 0.2);

            font-size: 11px;

            font-weight: 700;
        }

        .status-badge {
            display: inline-flex;

            align-items: center;

            gap: 6px;

            padding: 6px 12px;

            border-radius: 20px;

            background: rgba(245, 158, 11, 0.1);

            color: #fbbf24;

            border: 1px solid rgba(245, 158, 11, 0.2);

            font-size: 10px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 0.5px;
        }

        .status-approved {
            background: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border-color: rgba(16, 185, 129, 0.2);
        }

        .status-rejected {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border-color: rgba(239, 68, 68, 0.2);
        }

        .level-badge {
            font-family: 'JetBrains Mono', monospace;

            font-weight: 700;

            color: #fff;
        }

        .review-form {
            display: flex;

            gap: 8px;

            align-items: center;

            flex-wrap: wrap;
        }

        .comment-input {
            height: 36px;

            min-width: 150px;

            width: 180px;

            font-size: 12px;

            padding: 0 10px;
        }

        .review-btn {
            height: 36px;

            padding: 0 14px;

            font-size: 12px;
        }

        .approve-btn {
            background:
                linear-gradient(
                    135deg,
                    var(--success),
                    #059669
                );

            box-shadow:
                0 4px 15px rgba(16, 185, 129, 0.3);
        }

        .reject-btn {
            background:
                linear-gradient(
                    135deg,
                    var(--danger),
                    #dc2626
                );

            box-shadow:
                0 4px 15px rgba(239, 68, 68, 0.3);
        }

        .completed-review {
            color: var(--text-muted);

            font-size: 12px;

            white-space: nowrap;
        }

        .empty-row {
            text-align: center;

            padding: 40px !important;

            color: var(--text-muted);
        }

        .empty-row i {
            display: block;

            font-size: 28px;

            margin-bottom: 10px;
        }

        .reference-help {
            font-size: 11px;
            color: var(--text-muted);
            margin-top: 4px;
        }

        @media (max-width: 1000px) {

            .approval-form {
                grid-template-columns: 1fr 1fr;
            }

            .create-button {
                width: 100%;
            }
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

            .approval-form {
                grid-template-columns: 1fr;
            }

            .create-button {
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

    <!-- Header -->

    <div class="top-header">

        <div>

            <h1>Central Approval Center</h1>

            <p class="muted">
                Manage administrative requests, multi-level approval workflows, and review tracking.
            </p>

        </div>

        <a class="back-link"
           href="${pageContext.request.contextPath}/enterprise">

            <i class="fa-solid fa-arrow-left"></i>

            Enterprise Center

        </a>

    </div>


    <!-- Create Approval -->

    <div class="panel">

        <div class="panel-title">

            <i class="fa-solid fa-circle-plus"
               style="color: var(--accent-secondary);"></i>

            Create New Approval Request

        </div>


        <form class="approval-form"
              method="post"
              action="${pageContext.request.contextPath}/enterprise/approvals/create"
              id="approvalForm">


            <!-- Employee -->

            <div class="field">

                <label>Employee</label>

                <select name="employeeId"
                        id="employeeId"
                        required>

                    <option value="">
                        Select Employee
                    </option>

                    <c:forEach var="e" items="${employees}">

                        <option value="${e.employeeId}">
                            ${e.employeeId} - ${e.employeeName}
                        </option>

                    </c:forEach>

                </select>

            </div>


            <!-- Request Type -->

            <div class="field">

                <label>Request Type</label>

                <select name="type"
                        id="requestType"
                        required>

                    <option value="LEAVE">
                        LEAVE
                    </option>

                    <option value="EXPENSE">
                        EXPENSE
                    </option>

                    <option value="PAYROLL">
                        PAYROLL
                    </option>

                    <option value="OFFBOARDING">
                        OFFBOARDING
                    </option>

                </select>

            </div>


            <!-- Related Request -->

            <div class="field">

                <label>Related Request</label>

                <select id="relatedRequest"
                        required>

                    <option value="">
                        Select employee first
                    </option>

                </select>

                

            </div>


            <!-- Hidden Reference ID -->

            <input type="hidden"
                   name="referenceId"
                   id="referenceId">


            <!-- Create -->

            <div class="field">

                <label>&nbsp;</label>

                <button type="submit"
                        class="create-button">

                    <i class="fa-solid fa-plus"></i>

                    Create Approval

                </button>

            </div>

        </form>


        <div class="help-text">

            <i class="fa-solid fa-circle-info"></i>

            Select an employee and request type. Existing requests belonging to that employee
            will automatically appear in the Related Request list.

        </div>

    </div>


    <!-- Approval Repository -->

    <div class="panel">

        <div class="panel-title">

            <i class="fa-solid fa-clipboard-check"
               style="color: var(--accent-primary);"></i>

            Active Approvals Workflow Repository

        </div>


        <div class="table-wrapper">

            <table>

                <thead>

                <tr>

                    <th>Employee ID</th>

                    <th>Request Type</th>

                    <th>Reference ID</th>

                    <th>Current Level</th>

                    <th>Status</th>

                    <th>Action & Review</th>

                </tr>

                </thead>


                <tbody>

                <c:forEach var="a" items="${approvals}">

                    <tr>

                        <td>
                            ${a.employee.employeeId}
                        </td>


                        <td>

                            <span class="type-badge">
                                ${a.requestType}
                            </span>

                        </td>


                        <td style="
                            font-family: 'JetBrains Mono', monospace;
                            font-size: 12px;
                            color: var(--text-muted);
                        ">

                            ${a.referenceId}

                        </td>


                        <td>

                            <span class="level-badge">
                                ${a.currentLevel}
                            </span>

                        </td>


                        <td>

                            <c:choose>

                                <c:when test="${a.status == 'APPROVED'}">

                                    <span class="status-badge status-approved">

                                        <i class="fa-solid fa-circle-check"></i>

                                        APPROVED

                                    </span>

                                </c:when>


                                <c:when test="${a.status == 'REJECTED'}">

                                    <span class="status-badge status-rejected">

                                        <i class="fa-solid fa-circle-xmark"></i>

                                        REJECTED

                                    </span>

                                </c:when>


                                <c:otherwise>

                                    <span class="status-badge">

                                        <i class="fa-solid fa-clock"></i>

                                        ${a.status}

                                    </span>

                                </c:otherwise>

                            </c:choose>

                        </td>


                        <td>

                            <c:choose>

                                <c:when test="${a.status == 'PENDING'}">

                                    <form class="review-form"
                                          method="post"
                                          action="${pageContext.request.contextPath}/enterprise/approvals/${a.id}/action">

                                        <input class="comment-input"
                                               name="comments"
                                               placeholder="Approval comment...">

                                        <button type="submit"
                                                name="action"
                                                value="APPROVE"
                                                class="review-btn approve-btn">

                                            <i class="fa-solid fa-check"></i>

                                            Approve

                                        </button>

                                        <button type="submit"
                                                name="action"
                                                value="REJECT"
                                                class="review-btn reject-btn">

                                            <i class="fa-solid fa-xmark"></i>

                                            Reject

                                        </button>

                                    </form>

                                </c:when>


                                <c:otherwise>

                                    <span class="completed-review">

                                        <i class="fa-solid fa-check-double"></i>

                                        Review completed

                                    </span>

                                </c:otherwise>

                            </c:choose>

                        </td>

                    </tr>

                </c:forEach>


                <c:if test="${empty approvals}">

                    <tr>

                        <td colspan="6"
                            class="empty-row">

                            <i class="fa-solid fa-inbox"></i>

                            No approval requests found.

                        </td>

                    </tr>

                </c:if>

                </tbody>

            </table>

        </div>

    </div>

</div>


<script>

    /*
     * Existing requests supplied by the controller.
     * The browser only receives the request ID and employee ID.
     */

    const requests = {

        LEAVE: [

            <c:forEach var="r" items="${leaveRequests}" varStatus="status">

                {
                    id: "${r.id}",
                    employeeId: "${r.employee.employeeId}"
                }

                <c:if test="${!status.last}">,</c:if>

            </c:forEach>

        ],

        EXPENSE: [

            <c:forEach var="r" items="${expenseRequests}" varStatus="status">

                {
                    id: "${r.id}",
                    employeeId: "${r.employee.employeeId}"
                }

                <c:if test="${!status.last}">,</c:if>

            </c:forEach>

        ],

        PAYROLL: [

            <c:forEach var="r" items="${payrollRequests}" varStatus="status">

                {
                    id: "${r.id}",
                    employeeId: "${r.employee.employeeId}"
                }

                <c:if test="${!status.last}">,</c:if>

            </c:forEach>

        ],

        OFFBOARDING: [

            <c:forEach var="r" items="${offboardingRequests}" varStatus="status">

                {
                    id: "${r.id}",
                    employeeId: "${r.employee.employeeId}"
                }

                <c:if test="${!status.last}">,</c:if>

            </c:forEach>

        ]

    };


    const employeeSelect =
        document.getElementById("employeeId");

    const typeSelect =
        document.getElementById("requestType");

    const relatedSelect =
        document.getElementById("relatedRequest");

    const referenceInput =
        document.getElementById("referenceId");

    const form =
        document.getElementById("approvalForm");


    function loadRelatedRequests() {

        const employeeId =
            employeeSelect.value;

        const type =
            typeSelect.value;

        relatedSelect.innerHTML = "";

        referenceInput.value = "";


        if (!employeeId) {

            const option =
                document.createElement("option");

            option.value = "";

            option.textContent =
                "Select employee first";

            relatedSelect.appendChild(option);

            return;
        }


        const list =
            requests[type] || [];


        const filtered =
            list.filter(function(request) {

                return request.employeeId === employeeId;

            });


        if (filtered.length === 0) {

            const option =
                document.createElement("option");

            option.value = "";

            option.textContent =
                "No existing " + type + " request found";

            relatedSelect.appendChild(option);

            return;
        }


        const first =
            document.createElement("option");

        first.value = "";

        first.textContent =
            "Select related " + type + " request";

        relatedSelect.appendChild(first);


        filtered.forEach(function(request) {

            const option =
                document.createElement("option");

            option.value =
                request.id;

            option.textContent =
                type + " Request #" + request.id;

            relatedSelect.appendChild(option);

        });

    }


    employeeSelect.addEventListener(
        "change",
        loadRelatedRequests
    );


    typeSelect.addEventListener(
        "change",
        loadRelatedRequests
    );


    relatedSelect.addEventListener(
        "change",
        function() {

            referenceInput.value =
                relatedSelect.value;

        }
    );


    form.addEventListener(
        "submit",
        function(event) {

            if (!employeeSelect.value) {

                alert("Please select an employee.");

                event.preventDefault();

                return;
            }


            if (!relatedSelect.value) {

                alert(
                    "Please select an existing related request."
                );

                event.preventDefault();

                return;
            }


            referenceInput.value =
                relatedSelect.value;

        }
    );

</script>


</body>

</html>