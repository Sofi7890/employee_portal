
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Form</title>

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
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .container {
            width: 100%;
            max-width: 650px;
            background: var(--bg-card);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            overflow: hidden;
            border: 1px solid var(--border-color);
            position: relative;
        }

        .container::before {
            content: '';
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
            background: linear-gradient(
                135deg,
                rgba(31, 41, 55, 0.7),
                rgba(17, 24, 39, 0.8)
            );
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border-color);
            color: white;
            padding: 28px 36px;
            text-align: left;
        }

        .header h2 {
            margin: 0;
            font-size: 24px;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #fff;
        }

        .header p {
            margin: 6px 0 0;
            font-size: 13px;
            color: var(--text-muted);
        }

        .form-content {
            padding: 36px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 700;
            color: var(--text-main);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        .required {
            color: var(--danger);
        }

        .form-group input {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            font-size: 14px;
            outline: none;
            transition: var(--transition);
            background: rgba(11, 15, 25, 0.6);
            color: var(--text-main);
        }

        .form-group input:focus {
            border-color: var(--accent-primary);
            background: rgba(11, 15, 25, 0.8);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        .form-group input:hover {
            border-color: var(--border-hover);
        }

        .form-group input.input-error {
            border-color: var(--danger);
            box-shadow: 0 0 8px rgba(239, 68, 68, 0.2);
        }

        .error {
            display: block;
            color: var(--danger);
            font-size: 12px;
            margin-top: 6px;
            min-height: 16px;
        }

        .button-row {
            display: flex;
            gap: 12px;
            margin-top: 32px;
        }

        .btn {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(
                135deg,
                var(--accent-primary),
                #4f46e5
            );
            color: white;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        .btn-cancel {
            background: var(--bg-secondary);
            color: var(--text-main);
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-cancel:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        @media (max-width: 600px) {
            body {
                padding: 15px;
            }

            .header {
                padding: 24px;
            }

            .form-content {
                padding: 24px;
            }

            .button-row {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="header">
        <c:choose>
            <c:when test="${admin.adminId != null}">
                <h2>Edit Administrator</h2>
                <p>Update administrator account information records</p>
            </c:when>

            <c:otherwise>
                <h2>Add Administrator</h2>
                <p>Create a new secure system administrator account</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="form-content">

        <c:choose>
            <c:when test="${admin.adminId != null}">
                <form id="adminForm"
                      action="${pageContext.request.contextPath}/admin/update/${admin.adminId}"
                      method="post">
            </c:when>

            <c:otherwise>
                <form id="adminForm"
                      action="${pageContext.request.contextPath}/admin/create"
                      method="post">
            </c:otherwise>
        </c:choose>

            <!-- Username -->
            <div class="form-group">
                <label for="username">
                    Username <span class="required">*</span>
                </label>

                <input type="text"
                       id="username"
                       name="username"
                       value="<c:out value='${admin.username}'/>"
                       placeholder="Enter username"
                       minlength="3"
                       maxlength="30"
                       pattern="[A-Za-z0-9_ ]+"
                       title="Use 3–30 characters: letters, numbers, spaces or underscore."
                       autocomplete="username"
                       required>

                <small class="error" id="usernameError"></small>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label for="email">
                    Email <span class="required">*</span>
                </label>

                <input type="email"
                       id="email"
                       name="email"
                       value="<c:out value='${admin.email}'/>"
                       placeholder="Enter email address"
                       maxlength="100"
                       autocomplete="email"
                       required>

                <small class="error" id="emailError"></small>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="password">
                    Password
                    <c:if test="${admin.adminId == null}">
                        <span class="required">*</span>
                    </c:if>
                </label>

                <input type="password"
                       id="password"
                       name="password"
                       placeholder="Enter password"
                       minlength="8"
                       maxlength="64"
                       autocomplete="new-password"
                       <c:if test="${admin.adminId == null}">required</c:if>>

                <small class="error" id="passwordError">
                    <c:if test="${admin.adminId != null}">
                        Leave blank to keep the current password.
                    </c:if>
                </small>
            </div>

            <!-- Role -->
            <div class="form-group">
                <label for="role">
                    Role <span class="required">*</span>
                </label>

                <input type="text"
                       id="role"
                       name="role"
                       value="<c:out value='${admin.role != null ? admin.role : "ROLE_ADMIN"}'/>"
                       placeholder="ROLE_ADMIN"
                       required
                       readonly>

                <small class="error" id="roleError"></small>
            </div>

            <!-- Buttons -->
            <div class="button-row">

                <c:choose>
                    <c:when test="${admin.adminId != null}">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-pen-to-square"></i>
                            Update Admin
                        </button>
                    </c:when>

                    <c:otherwise>
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-user-plus"></i>
                            Create Admin
                        </button>
                    </c:otherwise>
                </c:choose>

                <a href="${pageContext.request.contextPath}/admin/list"
                   class="btn btn-cancel">
                    <i class="fa-solid fa-arrow-left"></i>
                    Cancel
                </a>

            </div>

        </form>

    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("adminForm");

    const username = document.getElementById("username");
    const email = document.getElementById("email");
    const password = document.getElementById("password");
    const role = document.getElementById("role");

    function showError(input, errorId, message) {
        document.getElementById(errorId).textContent = message;
        input.classList.toggle("input-error", message !== "");
    }

    function validateUsername() {
        const value = username.value.trim();

        if (value === "") {
            showError(username, "usernameError",
                "Username is required.");
            return false;
        }

        if (value.length < 3 || value.length > 30) {
            showError(username, "usernameError",
                "Username must be 3–30 characters.");
            return false;
        }

        if (!/^[A-Za-z0-9_ ]+$/.test(value)) {
            showError(username, "usernameError",
                "Only letters, numbers, spaces and underscores are allowed.");
            return false;
        }

        showError(username, "usernameError", "");
        return true;
    }

    function validateEmail() {
        const value = email.value.trim();

        if (value === "") {
            showError(email, "emailError",
                "Email is required.");
            return false;
        }

        if (!email.checkValidity()) {
            showError(email, "emailError",
                "Please enter a valid email address.");
            return false;
        }

        showError(email, "emailError", "");
        return true;
    }

    function validatePassword() {
        const value = password.value;

        if (password.required && value.trim() === "") {
            showError(password, "passwordError",
                "Password is required.");
            return false;
        }

        if (value !== "" && value.length < 8) {
            showError(password, "passwordError",
                "Password must be at least 8 characters.");
            return false;
        }

        if (value.length > 64) {
            showError(password, "passwordError",
                "Password cannot exceed 64 characters.");
            return false;
        }

        showError(password, "passwordError", "");
        return true;
    }

    function validateRole() {
        const value = role.value.trim();

        if (value !== "ROLE_ADMIN") {
            showError(role, "roleError",
                "Role must be ROLE_ADMIN.");
            return false;
        }

        showError(role, "roleError", "");
        return true;
    }

    username.addEventListener("input", validateUsername);
    email.addEventListener("input", validateEmail);
    password.addEventListener("input", validatePassword);

    form.addEventListener("submit", function (event) {

        const usernameValid = validateUsername();
        const emailValid = validateEmail();
        const passwordValid = validatePassword();
        const roleValid = validateRole();

        if (!usernameValid ||
            !emailValid ||
            !passwordValid ||
            !roleValid) {

            event.preventDefault();
        }
    });

});
</script>

</body>
</html>
