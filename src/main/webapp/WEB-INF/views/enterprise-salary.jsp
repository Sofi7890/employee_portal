<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Salary & Compensation - Enterprise HR</title>

    <!-- Google Fonts & Icons -->

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
            max-width: 1250px;
            margin: auto;
        }


        /* =========================
           TOP HEADER
           ========================= */

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

            overflow: visible;
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


        /* =========================
           PANELS
           ========================= */

        .panel {

            background: var(--bg-card);

            border: 1px solid var(--border-color);

            border-radius: 24px;

            padding: 32px;

            margin-bottom: 24px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.3);

            position: relative;

            overflow: visible;
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


        /* =========================
           FORM
           ========================= */

        form {

            display: flex;

            gap: 12px;

            align-items: center;

            flex-wrap: wrap;
        }


        input {

            height: 44px;

            padding: 0 14px;

            border: 1px solid var(--border-color);

            border-radius: 12px;

            background: rgba(11, 15, 25, 0.6);

            color: var(--text-main);

            font-family: 'Plus Jakarta Sans', sans-serif;

            font-size: 13px;

            outline: none;

            transition: var(--transition);

            flex: 1;

            min-width: 140px;
        }


        input:hover {
            border-color: var(--border-hover);
        }


        input:focus {

            border-color: var(--accent-primary);

            background: rgba(11, 15, 25, 0.8);

            box-shadow:
                0 0 15px var(--accent-glow);
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


        /* =========================
           SEARCHABLE EMPLOYEE
           ========================= */

        .employee-picker {

            position: relative;

            flex: 1 1 280px;

            min-width: 280px;
        }


        .employee-search-box {

            height: 44px;

            display: flex;

            align-items: center;

            gap: 10px;

            padding: 0 14px;

            background:
                rgba(11, 15, 25, 0.6);

            border: 1px solid var(--border-color);

            border-radius: 12px;

            transition: var(--transition);

            cursor: text;
        }


        .employee-search-box:hover {

            border-color: var(--border-hover);
        }


        .employee-picker.open
        .employee-search-box {

            border-color: var(--accent-primary);

            background:
                rgba(11, 15, 25, 0.8);

            box-shadow:
                0 0 15px var(--accent-glow);
        }


        .employee-search-icon {

            color: var(--text-muted);

            font-size: 13px;
        }


        .employee-search-box input {

            flex: 1;

            width: 100%;

            min-width: 0;

            height: 42px;

            padding: 0;

            border: none;

            outline: none;

            background: transparent;

            box-shadow: none;

            margin: 0;
        }


        .employee-search-box input:focus {

            border: none;

            outline: none;

            background: transparent;

            box-shadow: none;
        }


        .employee-arrow {

            color: var(--text-muted);

            font-size: 11px;

            transition: transform 0.2s ease;
        }


        .employee-picker.open
        .employee-arrow {

            transform: rotate(180deg);
        }


        /* =========================
           DROPDOWN
           ========================= */

        .employee-dropdown {

            position: absolute;

            top: 51px;

            left: 0;

            right: 0;

            z-index: 9999;

            display: none;

            max-height: 280px;

            overflow-y: auto;

            background: var(--bg-secondary);

            border: 1px solid var(--border-color);

            border-radius: 12px;

            box-shadow:
                0 20px 40px rgba(0, 0, 0, 0.55);
        }


        .employee-picker.open
        .employee-dropdown {

            display: block;
        }


        .employee-option {

            min-height: 48px;

            padding: 10px 14px;

            display: flex;

            align-items: center;

            gap: 12px;

            cursor: pointer;

            border-bottom:
                1px solid rgba(255,255,255,0.05);

            transition:
                background 0.2s ease;
        }


        .employee-option:last-child {

            border-bottom: none;
        }


        .employee-option:hover {

            background:
                rgba(99, 102, 241, 0.12);
        }


        .employee-id {

            font-family:
                'JetBrains Mono', monospace;

            font-size: 12px;

            color: var(--accent-secondary);

            font-weight: 600;

            min-width: 70px;
        }


        .employee-name {

            font-size: 13px;

            color: var(--text-main);
        }


        .employee-placeholder {

            color: var(--text-muted);

            cursor: default;
        }


        .employee-placeholder:hover {

            background: transparent;
        }


        .no-employee {

            padding: 18px;

            text-align: center;

            color: var(--text-muted);

            font-size: 12px;
        }


        /* =========================
           TABLE
           ========================= */

        .table-wrapper {

            width: 100%;

            overflow-x: auto;
        }


        table {

            width: 100%;

            min-width: 950px;

            border-collapse: collapse;
        }


        th {

            background:
                rgba(17, 24, 39, 0.8);

            color: var(--text-muted);

            padding: 16px 18px;

            text-align: left;

            font-size: 10px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 0.8px;

            border-bottom:
                1px solid var(--border-color);
        }


        td {

            padding: 16px 18px;

            border-bottom:
                1px solid var(--border-color);

            font-size: 13px;

            color: var(--text-main);

            font-family:
                'JetBrains Mono', monospace;
        }


        td:first-child {

            font-family:
                'Plus Jakarta Sans', sans-serif;

            font-weight: 600;

            color: #fff;
        }


        tbody tr {

            transition: var(--transition);
        }


        tbody tr:hover {

            background:
                rgba(99, 102, 241, 0.04);
        }


        tbody tr:last-child td {

            border-bottom: none;
        }


        /* =========================
           MOBILE
           ========================= */

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
            button {

                width: 100%;

                min-width: 0;
            }


            .employee-picker {

                width: 100%;

                min-width: 0;
            }


            .panel {

                padding: 20px;
            }

        }

    </style>

</head>


<body>

<div class="wrap">


    <!-- =========================
         HEADER
         ========================= -->

    <div class="top-header">

        <div>

            <h1>
                Salary & Compensation
            </h1>

            <p class="muted">
                All existing employees receive an automated starter structure.
                Modify structure records below.
            </p>

        </div>


        <a class="back-link"
           href="${pageContext.request.contextPath}/enterprise">

            <i class="fa-solid fa-arrow-left"></i>

            Enterprise Center

        </a>

    </div>


    <!-- =========================
         CONFIGURATION
         ========================= -->

    <div class="panel">

        <div class="panel-title">

            <i class="fa-solid fa-sliders"
               style="color: var(--accent-secondary);">
            </i>

            Configure / Update Salary Structure

        </div>


        <form method="post"
              action="${pageContext.request.contextPath}/enterprise/salary/save">


            <!-- =========================
                 SEARCHABLE EMPLOYEE DROPDOWN
                 ========================= -->

            <div class="employee-picker"
                 id="employeePicker">


                <div class="employee-search-box"
                     id="employeeSearchBox">

                    <i class="fa-solid fa-magnifying-glass employee-search-icon">
                    </i>


                    <input
                            type="text"
                            id="employeeSearch"
                            placeholder="Select or search employee..."
                            autocomplete="off">


                    <i class="fa-solid fa-chevron-down employee-arrow">
                    </i>

                </div>


                <div class="employee-dropdown"
                     id="employeeDropdown">


                    <div class="employee-option employee-placeholder"
                         data-placeholder="true">

                        Select Employee

                    </div>


                    <c:forEach var="e"
                               items="${employees}">

                        <div class="employee-option"
                             data-id="${e.employeeId}"
                             data-name="${e.employeeName}"
                             data-search="${e.employeeId} ${e.employeeName}">

                            <span class="employee-id">
                                ${e.employeeId}
                            </span>

                            <span class="employee-name">
                                ${e.employeeName}
                            </span>

                        </div>

                    </c:forEach>


                    <div class="no-employee"
                         id="noEmployee"
                         style="display:none;">

                        No employee found

                    </div>

                </div>


                <!-- Actual value submitted to controller -->

                <input type="hidden"
                       name="employeeId"
                       id="selectedEmployeeId"
                       required>

            </div>


            <!-- =========================
                 SALARY FIELDS
                 ========================= -->

            <input
                    name="basic"
                    type="number"
                    step="0.01"
                    placeholder="Basic"
                    required>


            <input
                    name="hra"
                    type="number"
                    step="0.01"
                    placeholder="HRA"
                    required>


            <input
                    name="allowances"
                    type="number"
                    step="0.01"
                    placeholder="Allowances"
                    required>


            <input
                    name="pf"
                    type="number"
                    step="0.01"
                    placeholder="PF"
                    required>


            <input
                    name="tax"
                    type="number"
                    step="0.01"
                    placeholder="Tax"
                    required>


            <button type="submit">

                <i class="fa-solid fa-floppy-disk"></i>

                Save Salary

            </button>

        </form>

    </div>


    <!-- =========================
         ACTIVE SALARY STRUCTURES
         ========================= -->

    <div class="panel">

        <div class="panel-title">

            <i class="fa-solid fa-table-list"
               style="color: var(--accent-primary);">
            </i>

            Active Salary Structures

        </div>


        <div class="table-wrapper">

            <table>

                <thead>

                <tr>

                    <th>Employee</th>

                    <th>Basic</th>

                    <th>HRA</th>

                    <th>Allowances</th>

                    <th>Gross</th>

                    <th>PF</th>

                    <th>Tax</th>

                    <th>Net Salary</th>

                    <th>Effective</th>

                </tr>

                </thead>


                <tbody>

                <c:forEach var="x"
                           items="${salaries}">

                    <tr>

                        <td>
                            ${x.employee.employeeId}
                            -
                            ${x.employee.employeeName}
                        </td>

                        <td>
                            ${x.basicSalary}
                        </td>

                        <td>
                            ${x.hra}
                        </td>

                        <td>
                            ${x.allowances}
                        </td>

                        <td style="color: #22d3ee;">
                            ${x.gross}
                        </td>

                        <td>
                            ${x.pf}
                        </td>

                        <td>
                            ${x.tax}
                        </td>

                        <td>

                            <b style="color: #34d399;">
                                ${x.netSalary}
                            </b>

                        </td>

                        <td style="font-size: 12px;
                                   color: var(--text-muted);">

                            ${x.effectiveFrom}

                        </td>

                    </tr>

                </c:forEach>

                </tbody>

            </table>

        </div>

    </div>

</div>


<!-- =========================
     SEARCHABLE DROPDOWN SCRIPT
     ========================= -->

<script>

    const employeePicker =
        document.getElementById("employeePicker");

    const employeeSearch =
        document.getElementById("employeeSearch");

    const employeeDropdown =
        document.getElementById("employeeDropdown");

    const selectedEmployeeId =
        document.getElementById("selectedEmployeeId");

    const noEmployee =
        document.getElementById("noEmployee");


    const employeeOptions =
        employeeDropdown.querySelectorAll(
            ".employee-option[data-id]"
        );


    /* =========================
       OPEN DROPDOWN
       ========================= */

    employeeSearch.addEventListener(
        "focus",
        function () {

            employeePicker.classList.add("open");

            filterEmployees();

        }
    );


    employeeSearch.addEventListener(
        "click",
        function () {

            employeePicker.classList.add("open");

            filterEmployees();

        }
    );


    /* =========================
       SEARCH
       ========================= */

    employeeSearch.addEventListener(
        "input",
        function () {

            employeePicker.classList.add("open");

            filterEmployees();

            /*
             * User is searching again,
             * therefore clear previous selection.
             */

            selectedEmployeeId.value = "";

        }
    );


    function filterEmployees() {

        const search =
            employeeSearch.value
                .toLowerCase()
                .trim();


        let found = 0;


        employeeOptions.forEach(
            function (option) {

                const employeeId =
                    option.dataset.id
                        .toLowerCase();

                const employeeName =
                    option.dataset.name
                        .toLowerCase();

                const fullText =
                    employeeId +
                    " " +
                    employeeName;


                if (
                    search === "" ||
                    fullText.includes(search)
                ) {

                    option.style.display =
                        "flex";

                    found++;

                } else {

                    option.style.display =
                        "none";

                }

            }
        );


        if (found === 0) {

            noEmployee.style.display =
                "block";

        } else {

            noEmployee.style.display =
                "none";

        }

    }


    /* =========================
       SELECT EMPLOYEE
       ========================= */

    employeeDropdown.addEventListener(
        "click",
        function (event) {

            const option =
                event.target.closest(
                    ".employee-option[data-id]"
                );


            if (!option) {
                return;
            }


            const employeeId =
                option.dataset.id;

            const employeeName =
                option.dataset.name;


            /*
             * Store actual employee ID
             * for the existing controller.
             */

            selectedEmployeeId.value =
                employeeId;


            /*
             * Display selected employee.
             */

            employeeSearch.value =
                employeeId +
                " - " +
                employeeName;


            /*
             * Close dropdown.
             */

            employeePicker.classList.remove(
                "open"
            );

        }
    );


    /* =========================
       CLICK OUTSIDE
       ========================= */

    document.addEventListener(
        "click",
        function (event) {

            if (
                !employeePicker.contains(
                    event.target
                )
            ) {

                employeePicker.classList.remove(
                    "open"
                );

            }

        }
    );


    /* =========================
       KEYBOARD SUPPORT
       ========================= */

    employeeSearch.addEventListener(
        "keydown",
        function (event) {

            if (
                event.key === "ArrowDown"
            ) {

                employeePicker.classList.add(
                    "open"
                );

                filterEmployees();

            }


            if (
                event.key === "Escape"
            ) {

                employeePicker.classList.remove(
                    "open"
                );

            }

        }
    );


    /* =========================
       FORM VALIDATION
       ========================= */

    document.querySelector("form")
        .addEventListener(
            "submit",
            function (event) {

                if (
                    !selectedEmployeeId.value
                ) {

                    event.preventDefault();

                    employeePicker.classList.add(
                        "open"
                    );

                    employeeSearch.focus();

                    alert(
                        "Please select an employee."
                    );

                }

            }
        );

</script>


</body>

</html>