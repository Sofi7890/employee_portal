
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Employee Form</title>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>
        :root {
            --bg-primary: #0b0f19;
            --bg-secondary: #111827;
            --bg-card: #1f2937;
            --border-color: rgba(255,255,255,0.10);
            --border-hover: rgba(99,102,241,0.5);
            --text-main: #f3f4f6;
            --text-muted: #9ca3af;
            --accent-primary: #6366f1;
            --accent-secondary: #06b6d4;
            --danger: #f87171;
            --success: #34d399;
            --transition: all 0.25s ease;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--bg-primary);
            color: var(--text-main);
            min-height: 100vh;
            padding: 40px 20px;
            background-image:
                radial-gradient(circle at 10% 10%, rgba(99,102,241,0.12), transparent 40%),
                radial-gradient(circle at 90% 90%, rgba(6,182,212,0.08), transparent 40%);
            background-attachment: fixed;
            animation: pageFade 0.6s ease;
        }

        @keyframes pageFade {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .container {
            width: 100%;
            max-width: 850px;
            margin: auto;
        }

        .form-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.35);
            position: relative;
            overflow: hidden;
        }

        .form-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(
                90deg,
                var(--accent-primary),
                var(--accent-secondary)
            );
        }

        .header {
            margin-bottom: 28px;
            padding-bottom: 22px;
            border-bottom: 1px solid var(--border-color);
        }

        .header h1 {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #fff;
        }

        .header p {
            margin-top: 8px;
            color: var(--text-muted);
            font-size: 13px;
            line-height: 1.6;
        }

        .form-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 17px;
        }

        .form-table td:first-child {
            width: 32%;
            padding: 0 18px 0 0;
            vertical-align: top;
            padding-top: 13px;
            font-size: 13px;
            font-weight: 700;
        }

        .form-table td:last-child {
            width: 68%;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="password"],
        input[type="date"],
        select {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            background: rgba(11,15,25,0.7);
            color: var(--text-main);
            font-family: inherit;
            font-size: 14px;
            outline: none;
            transition: var(--transition);
        }

        input[type="file"] {
            width: 100%;
            padding: 12px;
            border: 1px dashed rgba(156,163,175,0.45);
            border-radius: 12px;
            background: rgba(11,15,25,0.4);
            color: var(--text-muted);
            font-family: inherit;
            font-size: 13px;
        }

        input:focus,
        select:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.15);
        }

        input[readonly] {
            background: rgba(17,24,39,0.8);
            color: var(--text-muted);
            cursor: not-allowed;
        }

        select option {
            background: var(--bg-secondary);
            color: var(--text-main);
        }

        .required-note {
            margin-top: 7px;
            color: var(--text-muted);
            font-size: 11px;
            line-height: 1.5;
        }

        .field-error {
            display: block;
            color: var(--danger);
            font-size: 12px;
            margin-top: 6px;
            line-height: 1.4;
        }

        .field-error:empty {
            display: none;
        }

        .invalid-field {
            border-color: var(--danger) !important;
            box-shadow: 0 0 0 2px rgba(248,113,113,0.1);
        }

        .valid-field {
            border-color: var(--success) !important;
        }

        .photo-preview {
            display: none;
            width: 110px;
            height: 110px;
            object-fit: cover;
            border-radius: 14px;
            margin-top: 12px;
            border: 1px solid var(--border-color);
        }

        .button-row {
            padding-top: 25px;
            text-align: left;
        }

        .submit-btn,
        .pdf-btn,
        .cancel-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 13px 22px;
            border-radius: 12px;
            font-family: inherit;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: var(--transition);
        }

        .submit-btn {
            border: none;
            color: white;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            box-shadow: 0 5px 18px rgba(99,102,241,0.25);
        }

        .pdf-btn {
            border: 1px solid var(--border-color);
            background: var(--bg-secondary);
            color: var(--text-main);
            margin-left: 8px;
        }

        .cancel-btn {
            border: 1px solid var(--border-color);
            background: transparent;
            color: var(--text-main);
            margin-left: 8px;
        }

        .submit-btn:hover,
        .pdf-btn:hover,
        .cancel-btn:hover {
            transform: translateY(-2px);
        }

        .pdf-btn:hover,
        .cancel-btn:hover {
            border-color: var(--border-hover);
            background: rgba(99,102,241,0.1);
        }

        .form-message {
            display: none;
            margin-bottom: 18px;
            padding: 12px 15px;
            border-radius: 10px;
            font-size: 13px;
            line-height: 1.5;
        }

        .form-message.show {
            display: block;
        }

        .form-message.error {
            background: rgba(239,68,68,0.1);
            color: #fca5a5;
            border: 1px solid rgba(239,68,68,0.3);
        }

        .form-message.success {
            background: rgba(16,185,129,0.1);
            color: #6ee7b7;
            border: 1px solid rgba(16,185,129,0.3);
        }

        @media (max-width: 650px) {
            body {
                padding: 20px 12px;
            }

            .form-card {
                padding: 24px 18px;
            }

            .header h1 {
                font-size: 23px;
            }

            .form-table,
            .form-table tbody,
            .form-table tr,
            .form-table td {
                display: block;
                width: 100%;
            }

            .form-table td:first-child {
                padding: 0 0 8px;
            }

            .form-table tr {
                margin-bottom: 15px;
            }

            .submit-btn,
            .pdf-btn,
            .cancel-btn {
                width: 100%;
                margin: 8px 0 0;
            }
        }

        @media print {
            body {
                background: white !important;
                color: #111827 !important;
                padding: 0;
                animation: none;
            }

            .container {
                max-width: 100%;
            }

            .form-card {
                background: white !important;
                color: #111827 !important;
                box-shadow: none;
                border: 1px solid #ddd;
                padding: 25px;
            }

            .header h1,
            .form-table td:first-child {
                color: #111827 !important;
            }

            .header p,
            .required-note {
                color: #555 !important;
            }

            input,
            select {
                color: #111827 !important;
                background: white !important;
                border: 1px solid #aaa !important;
                box-shadow: none !important;
            }

            .button-row,
            .field-error,
            .form-message,
            input[type="file"] {
                display: none !important;
            }

            .photo-preview {
                display: block !important;
                print-color-adjust: exact;
            }

            .form-table {
                border-spacing: 0 10px;
            }
        }
    </style>
</head>

<body>

<div class="container">
    <div class="form-card">

        <div class="header">
            <c:choose>
                <c:when test="${employee.employeeId != null}">
                    <h1>Edit Employee</h1>
                    <p>Update the employee profile information below.</p>
                </c:when>
                <c:otherwise>
                    <h1>Add Employee</h1>
                    <p>Enter the details to create a new employee profile.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div id="formMessage" class="form-message" role="alert"></div>

        <c:choose>
            <c:when test="${employee.employeeId != null}">
                <c:set var="formAction"
                       value="${pageContext.request.contextPath}/employee/update/${employee.employeeId}" />
            </c:when>
            <c:otherwise>
                <c:set var="formAction"
                       value="${pageContext.request.contextPath}/employee/create" />
            </c:otherwise>
        </c:choose>

        <form id="employeeForm"
              action="${formAction}"
              method="post"
              enctype="multipart/form-data"
              novalidate>

            <table class="form-table">
                <tbody>

                <!-- Employee Name -->
                <tr>
                    <td><label for="employeeName">Employee Name *</label></td>
                    <td>
                        <input type="text"
                               id="employeeName"
                               name="employeeName"
                               value="${employee.employeeName}"
                               placeholder="Enter full name"
                               minlength="2"
                               maxlength="60"
                               autocomplete="name"
                               required>
                        <small class="field-error" id="nameError"></small>
                    </td>
                </tr>

                <!-- Department -->
                <tr>
                    <td><label for="employeeDept">Department *</label></td>
                    <td>
                        <input type="text"
                               id="employeeDept"
                               name="employeeDept"
                               value="${employee.employeeDept}"
                               placeholder="Enter department"
                               maxlength="50"
                               required>
                        <small class="field-error" id="deptError"></small>
                    </td>
                </tr>

                <!-- Email -->
                <tr>
                    <td><label for="employeeEmail">Email *</label></td>
                    <td>
                        <c:choose>
                            <c:when test="${employee.employeeId != null}">
                                <input type="email"
                                       id="employeeEmail"
                                       name="employeeEmail"
                                       value="${employee.employeeEmail}"
                                       readonly
                                       required>
                                <div class="required-note">
                                    Email cannot be changed while editing the profile.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <input type="email"
                                       id="employeeEmail"
                                       name="employeeEmail"
                                       value="${employee.employeeEmail}"
                                       placeholder="example@gmail.com"
                                       maxlength="254"
                                       autocomplete="email"
                                       required>
                            </c:otherwise>
                        </c:choose>
                        <small class="field-error" id="emailError"></small>
                    </td>
                </tr>

                <!-- Phone -->
                <tr>
                    <td><label for="employeePhone">Phone Number *</label></td>
                    <td>
                        <input type="tel"
                               id="employeePhone"
                               name="employeePhone"
                               value="${employee.employeePhone}"
                               placeholder="Enter 10-digit mobile number"
                               inputmode="numeric"
                               maxlength="10"
                               pattern="[6-9][0-9]{9}"
                               autocomplete="tel"
                               required>
                        <small class="field-error" id="phoneError"></small>
                        <div class="required-note">
                            Enter a 10-digit Indian mobile number starting with 6, 7, 8 or 9.
                        </div>
                    </td>
                </tr>

                <!-- Password -->
                <tr>
                    <td><label for="password">Password</label></td>
                    <td>
                        <input type="password"
                               id="password"
                               name="password"
                               placeholder="Enter password"
                               minlength="8"
                               maxlength="64"
                               autocomplete="new-password">
                        <small class="field-error" id="passwordError"></small>
                        <div class="required-note">
                            Leave blank when editing if you do not want to change the password.
                            If entered, use at least 8 characters with a letter and a number.
                        </div>
                    </td>
                </tr>

                <!-- Employee Photo -->
                <tr>
                    <td><label for="image">Employee Photo</label></td>
                    <td>
                        <c:if test="${not empty employee.imagePath}">
                            <img id="currentPhoto"
                                 class="photo-preview"
                                 src="${pageContext.request.contextPath}/employee/image/${employee.employeeId}"
                                 alt="Current employee photo"
                                 style="display:block;">
                        </c:if>

                        <input type="file"
                               id="image"
                               name="image"
                               accept="image/jpeg,image/png,image/gif,image/webp">

                        <small class="field-error" id="imageError"></small>

                        <img id="imagePreview"
                             class="photo-preview"
                             alt="Selected employee photo">

                        <div class="required-note">
                            Optional. JPG, JPEG, PNG, GIF or WEBP. Maximum size: 2 MB.
                        </div>
                    </td>
                </tr>

                <!-- Role -->
                <tr>
                    <td><label for="role">Role *</label></td>
                    <td>
                        <input type="text"
                               id="role"
                               name="role"
                               value="${employee.role}"
                               placeholder="Enter employee role"
                               maxlength="30"
                               required>
                        <small class="field-error" id="roleError"></small>
                    </td>
                </tr>

                <!-- Date of Joining -->
                <tr>
                    <td><label for="dateOfJoining">Date of Joining *</label></td>
                    <td>
                        <input type="date"
                               id="dateOfJoining"
                               name="dateOfJoining"
                               value="${employee.dateOfJoining}"
                               required>
                        <small class="field-error" id="dateError"></small>
                    </td>
                </tr>

                <!-- Project -->
                <tr>
                    <td><label for="projectId">Project</label></td>
                    <td>
                        <select id="projectId" name="project.projectId">
                            <option value="">-- Select Project --</option>

                            <c:forEach var="proj" items="${projects}">
                                <option value="${proj.projectId}"
                                    <c:if test="${employee.project != null && employee.project.projectId eq proj.projectId}">
                                        selected
                                    </c:if>>
                                    <c:out value="${proj.projectName}" />
                                </option>
                            </c:forEach>
                        </select>
                        <small class="field-error" id="projectError"></small>
                    </td>
                </tr>

                <!-- Buttons -->
                <tr>
                    <td colspan="2" class="button-row">
                        <c:choose>
                            <c:when test="${employee.employeeId != null}">
                                <button type="submit" class="submit-btn">
                                    Update Employee
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="submit-btn">
                                    Create Employee
                                </button>
                            </c:otherwise>
                        </c:choose>

                        <button type="button" class="pdf-btn" id="pdfButton">
                            Save as PDF
                        </button>

                        <a href="${pageContext.request.contextPath}/employee/list"
                           class="cancel-btn">
                            Cancel
                        </a>
                    </td>
                </tr>

                </tbody>
            </table>
        </form>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("employeeForm");

    const name = document.getElementById("employeeName");
    const dept = document.getElementById("employeeDept");
    const email = document.getElementById("employeeEmail");
    const phone = document.getElementById("employeePhone");
    const password = document.getElementById("password");
    const role = document.getElementById("role");
    const joiningDate = document.getElementById("dateOfJoining");
    const image = document.getElementById("image");

    const preview = document.getElementById("imagePreview");
    const currentPhoto = document.getElementById("currentPhoto");
    const formMessage = document.getElementById("formMessage");

    const isEdit = ${employee.employeeId != null};

    function showError(field, errorId, message) {
        const error = document.getElementById(errorId);
        error.textContent = message;

        if (field) {
            field.classList.add("invalid-field");
            field.classList.remove("valid-field");
            field.setAttribute("aria-invalid", "true");
        }
    }

    function clearError(field, errorId) {
        document.getElementById(errorId).textContent = "";

        if (field) {
            field.classList.remove("invalid-field");
            field.classList.add("valid-field");
            field.setAttribute("aria-invalid", "false");
        }
    }

    function validateName() {
        const value = name.value.trim();

        if (value.length < 2 || value.length > 60) {
            showError(name, "nameError",
                "Name must be between 2 and 60 characters.");
            return false;
        }

        if (!/^[A-Za-z][A-Za-z .'-]*$/.test(value)) {
            showError(name, "nameError",
                "Use English letters, spaces, dots, apostrophes or hyphens only.");
            return false;
        }

        clearError(name, "nameError");
        return true;
    }

    function validateDepartment() {
        const value = dept.value.trim();

        if (value.length === 0 || value.length > 50) {
            showError(dept, "deptError",
                "Department is required and must be at most 50 characters.");
            return false;
        }

        clearError(dept, "deptError");
        return true;
    }

    function validateEmail() {
        const value = email.value.trim();

        if (value === "") {
            showError(email, "emailError", "Email is required.");
            return false;
        }

        if (value.length > 254 ||
            !/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(value)) {
            showError(email, "emailError",
                "Enter a valid email address, such as name@example.com.");
            return false;
        }

        clearError(email, "emailError");
        return true;
    }

    function validatePhone() {
        const value = phone.value.trim();

        if (!/^[6-9][0-9]{9}$/.test(value)) {
            showError(phone, "phoneError",
                "Enter a valid 10-digit Indian mobile number starting with 6–9.");
            return false;
        }

        clearError(phone, "phoneError");
        return true;
    }

    function validatePassword() {
        const value = password.value;

        if (value === "" && isEdit) {
            clearError(password, "passwordError");
            return true;
        }

        if (value === "" && !isEdit) {
            showError(password, "passwordError",
                "Password is required for a new employee.");
            return false;
        }

        if (value.length < 8 || value.length > 64) {
            showError(password, "passwordError",
                "Password must be between 8 and 64 characters.");
            return false;
        }

        if (!/[A-Za-z]/.test(value) || !/[0-9]/.test(value)) {
            showError(password, "passwordError",
                "Password must contain at least one letter and one number.");
            return false;
        }

        clearError(password, "passwordError");
        return true;
    }

    function validateRole() {
        const value = role.value.trim();

        if (value.length === 0 || value.length > 30) {
            showError(role, "roleError",
                "Role is required and must be at most 30 characters.");
            return false;
        }

        clearError(role, "roleError");
        return true;
    }

    function validateDate() {
        const value = joiningDate.value;

        if (value === "") {
            showError(joiningDate, "dateError",
                "Date of joining is required.");
            return false;
        }

        const selectedDate = new Date(value + "T00:00:00");
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (selectedDate > today) {
            showError(joiningDate, "dateError",
                "Date of joining cannot be in the future.");
            return false;
        }

        clearError(joiningDate, "dateError");
        return true;
    }

    function validateImage() {
        const file = image.files && image.files[0];

        if (!file) {
            document.getElementById("imageError").textContent = "";
            return true;
        }

        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/gif",
            "image/webp"
        ];

        if (!allowedTypes.includes(file.type)) {
            showError(image, "imageError",
                "Choose a JPG, PNG, GIF or WEBP image.");
            return false;
        }

        if (file.size > 2 * 1024 * 1024) {
            showError(image, "imageError",
                "Image size must be 2 MB or less.");
            return false;
        }

        document.getElementById("imageError").textContent = "";
        image.classList.remove("invalid-field");
        return true;
    }

    function validateAll() {
        const results = [
            validateName(),
            validateDepartment(),
            validateEmail(),
            validatePhone(),
            validatePassword(),
            validateRole(),
            validateDate(),
            validateImage()
        ];

        return results.every(Boolean);
    }

    function showMessage(message, type) {
        formMessage.textContent = message;
        formMessage.className = "form-message show " + type;
    }

    function clearMessage() {
        formMessage.textContent = "";
        formMessage.className = "form-message";
    }

    name.addEventListener("input", function () {
        validateName();
        clearMessage();
    });

    dept.addEventListener("input", validateDepartment);
    email.addEventListener("input", validateEmail);
    phone.addEventListener("input", validatePhone);
    password.addEventListener("input", validatePassword);
    role.addEventListener("input", validateRole);
    joiningDate.addEventListener("change", validateDate);

    image.addEventListener("change", function () {
        if (validateImage()) {
            const file = image.files && image.files[0];

            if (file) {
                preview.src = URL.createObjectURL(file);
                preview.style.display = "block";

                if (currentPhoto) {
                    currentPhoto.style.display = "none";
                }
            } else {
                preview.removeAttribute("src");
                preview.style.display = "none";

                if (currentPhoto) {
                    currentPhoto.style.display = "block";
                }
            }
        } else {
            image.value = "";
            preview.removeAttribute("src");
            preview.style.display = "none";
        }
    });

    form.addEventListener("submit", function (event) {
        clearMessage();

        if (!validateAll()) {
            event.preventDefault();
            showMessage(
                "Please correct the highlighted fields before submitting.",
                "error"
            );

            const firstInvalid = form.querySelector(".invalid-field");

            if (firstInvalid) {
                firstInvalid.focus();
                firstInvalid.scrollIntoView({
                    behavior: "smooth",
                    block: "center"
                });
            }
        }
    });

    document.getElementById("pdfButton").addEventListener("click", function () {
        clearMessage();

        if (!validateAll()) {
            showMessage(
                "Please correct the highlighted fields before saving as PDF.",
                "error"
            );

            const firstInvalid = form.querySelector(".invalid-field");

            if (firstInvalid) {
                firstInvalid.focus();
                firstInvalid.scrollIntoView({
                    behavior: "smooth",
                    block: "center"
                });
            }

            return;
        }

        // Print dialog allows the user to save the form as a PDF.
        window.print();
    });

});
</script>

</body>
</html>
