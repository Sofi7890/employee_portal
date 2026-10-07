
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login | Workforce Portal</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    :root {
        --bg: #0b1020;
        --card: #151c32;
        --input: #0e1529;
        --primary: #8b5cf6;
        --secondary: #22d3ee;
        --text: #f8fafc;
        --muted: #94a3b8;
        --border: rgba(148, 163, 184, 0.2);
        --error: #fb7185;
    }

    body {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 24px;
        font-family: "Segoe UI", Arial, sans-serif;
        color: var(--text);
        background:
            radial-gradient(circle at 15% 20%,
                rgba(139, 92, 246, 0.18), transparent 35%),
            radial-gradient(circle at 85% 80%,
                rgba(34, 211, 238, 0.13), transparent 35%),
            var(--bg);
        overflow-x: hidden;
    }

    .background-circle {
        position: fixed;
        width: 300px;
        height: 300px;
        border-radius: 50%;
        filter: blur(90px);
        opacity: 0.22;
        pointer-events: none;
        animation: float 8s ease-in-out infinite alternate;
    }

    .circle-one {
        background: var(--primary);
        top: -100px;
        left: -80px;
    }

    .circle-two {
        background: var(--secondary);
        bottom: -120px;
        right: -80px;
        animation-delay: 2s;
    }

    .login-wrapper {
        width: 100%;
        max-width: 440px;
        position: relative;
        z-index: 1;
        animation: fadeIn 0.8s ease both;
    }

    .login-card {
        background: rgba(21, 28, 50, 0.94);
        border: 1px solid var(--border);
        border-radius: 22px;
        padding: 40px;
        box-shadow: 0 25px 70px rgba(0, 0, 0, 0.35);
        backdrop-filter: blur(15px);
        transition: transform 0.3s ease,
                    box-shadow 0.3s ease;
    }

    .login-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 30px 80px rgba(0, 0, 0, 0.45);
    }

    .brand {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 32px;
    }

    .brand-icon {
        width: 48px;
        height: 48px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 14px;
        font-size: 24px;
        background: linear-gradient(
            135deg, var(--primary), var(--secondary)
        );
        box-shadow: 0 8px 25px rgba(139, 92, 246, 0.25);
    }

    .brand-name {
        font-size: 19px;
        font-weight: 700;
        letter-spacing: 0.3px;
    }

    .brand-subtitle {
        margin-top: 4px;
        color: var(--muted);
        font-size: 12px;
    }

    h1 {
        font-size: 30px;
        font-weight: 700;
        margin-bottom: 10px;
    }

    .description {
        color: var(--muted);
        font-size: 14px;
        line-height: 1.6;
        margin-bottom: 30px;
    }

    .form-group {
        margin-bottom: 22px;
    }

    label {
        display: block;
        font-size: 13px;
        font-weight: 600;
        margin-bottom: 9px;
        color: #e2e8f0;
    }

    .input-wrapper {
        position: relative;
    }

    .input-icon {
        position: absolute;
        top: 50%;
        left: 15px;
        transform: translateY(-50%);
        color: var(--muted);
        font-size: 17px;
        pointer-events: none;
    }

    input {
        width: 100%;
        height: 52px;
        padding: 0 48px 0 45px;
        border-radius: 12px;
        border: 1px solid var(--border);
        background: var(--input);
        color: var(--text);
        font-size: 14px;
        outline: none;
        transition: border 0.25s ease,
                    box-shadow 0.25s ease;
    }

    input::placeholder {
        color: #64748b;
    }

    input:focus {
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.15);
    }

    input.invalid {
        border-color: var(--error);
    }

    .toggle-password {
        position: absolute;
        right: 14px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: var(--muted);
        cursor: pointer;
        font-size: 12px;
        font-weight: 600;
    }

    .toggle-password:hover {
        color: var(--secondary);
    }

    .field-error {
        color: var(--error);
        font-size: 12px;
        margin-top: 7px;
        min-height: 15px;
    }

    /* Server error box appears only when an error exists */
    .server-error {
        background: rgba(251, 113, 133, 0.1);
        border: 1px solid rgba(251, 113, 133, 0.3);
        color: #fda4af;
        border-radius: 10px;
        padding: 12px 14px;
        font-size: 13px;
        margin-bottom: 20px;
        line-height: 1.5;
        animation: fadeIn 0.3s ease;
    }

    .login-button {
        width: 100%;
        height: 52px;
        border: none;
        border-radius: 12px;
        color: white;
        font-size: 15px;
        font-weight: 700;
        letter-spacing: 0.3px;
        cursor: pointer;
        background: linear-gradient(
            100deg, var(--primary), #6d5dfc, var(--secondary)
        );
        background-size: 200% auto;
        transition: background-position 0.4s ease,
                    transform 0.2s ease,
                    opacity 0.2s ease;
    }

    .login-button:hover {
        background-position: right center;
        transform: translateY(-2px);
    }

    .login-button:active {
        transform: scale(0.99);
    }

    .login-button:disabled {
        cursor: not-allowed;
        opacity: 0.7;
        transform: none;
    }

    .button-content {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }

    .spinner {
        display: none;
        width: 17px;
        height: 17px;
        border: 2px solid rgba(255, 255, 255, 0.4);
        border-top-color: white;
        border-radius: 50%;
        animation: spin 0.7s linear infinite;
    }

    .login-button.loading .spinner {
        display: inline-block;
    }

    .footer {
        margin-top: 28px;
        text-align: center;
        color: var(--muted);
        font-size: 12px;
        line-height: 1.7;
    }

    .footer span {
        color: var(--secondary);
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(25px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @keyframes float {
        from {
            transform: translate(0, 0);
        }
        to {
            transform: translate(35px, 45px);
        }
    }

    @keyframes spin {
        to {
            transform: rotate(360deg);
        }
    }

    @media (max-width: 480px) {
        body {
            padding: 16px;
        }

        .login-card {
            padding: 28px 22px;
            border-radius: 18px;
        }

        h1 {
            font-size: 26px;
        }

        .brand {
            margin-bottom: 27px;
        }
    }

    @media (prefers-reduced-motion: reduce) {
        *,
        *::before,
        *::after {
            animation-duration: 0.01ms !important;
            animation-iteration-count: 1 !important;
            transition-duration: 0.01ms !important;
        }
    }
</style>
</head>

<body>

<div class="background-circle circle-one"></div>
<div class="background-circle circle-two"></div>

<main class="login-wrapper">

    <section class="login-card">

        <div class="brand">
            <div class="brand-icon" aria-hidden="true">🛡</div>
            <div>
                <div class="logo-title">Employee &amp; Workforce Portal<div>
                <div class="brand-subtitle">Secure Access Portal</div>
            </div>
        </div>

        <h1>Sign in</h1>

        <p class="description">
            Enter your account details to access your dashboard.
        </p>

        <%-- Render the error box only when an error exists --%>
        <%
            String error = (String) request.getAttribute("error");
        %>

        <% if (error != null && !error.trim().isEmpty()) { %>
            <div class="server-error" role="alert" aria-live="polite">
                <%= org.springframework.web.util.HtmlUtils.htmlEscape(error) %>
            </div>
        <% } %>

        <form id="loginForm"
              action="${pageContext.request.contextPath}/auth/login"
              method="post"
              novalidate>

            <%-- CSRF token, if enabled in Spring Security --%>
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}">

            <div class="form-group">
                <label for="username">
                    Username / Email / Client ID
                </label>

                <div class="input-wrapper">
                    <span class="input-icon" aria-hidden="true">👤</span>

                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="Enter your username"
                        autocomplete="username"
                        maxlength="100"
                        required
                        aria-describedby="usernameError"
                    >
                </div>

                <div class="field-error"
                     id="usernameError"
                     aria-live="polite"></div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>

                <div class="input-wrapper">
                    <span class="input-icon" aria-hidden="true">🔒</span>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required
                        aria-describedby="passwordError"
                    >

                    <button
                        type="button"
                        class="toggle-password"
                        id="togglePassword"
                        aria-label="Show password"
                    >
                        SHOW
                    </button>
                </div>

                <div class="field-error"
                     id="passwordError"
                     aria-live="polite"></div>
            </div>

            <button type="submit"
                    class="login-button"
                    id="loginButton">

                <span class="button-content">
                    <span class="spinner" aria-hidden="true"></span>
                    <span id="buttonText">Sign In</span>
                </span>
            </button>

        </form>

        <div class="footer">
            Protected access for authorized users only.<br>
            <span>Secure • Simple • Reliable</span>
        </div>

    </section>

</main>

<script>
    const form = document.getElementById("loginForm");
    const username = document.getElementById("username");
    const password = document.getElementById("password");

    const usernameError = document.getElementById("usernameError");
    const passwordError = document.getElementById("passwordError");

    const togglePassword = document.getElementById("togglePassword");
    const loginButton = document.getElementById("loginButton");
    const buttonText = document.getElementById("buttonText");

    function showError(input, errorElement, message) {
        errorElement.textContent = message;
        input.classList.add("invalid");
        input.setAttribute("aria-invalid", "true");
    }

    function clearError(input, errorElement) {
        errorElement.textContent = "";
        input.classList.remove("invalid");
        input.removeAttribute("aria-invalid");
    }

    function validateUsername() {
        const value = username.value.trim();

        if (value.length === 0) {
            showError(
                username,
                usernameError,
                "Please enter your username, email, or client ID."
            );
            return false;
        }

        clearError(username, usernameError);
        return true;
    }

    function validatePassword() {
        // Do not trim passwords; spaces may be part of a password.
        if (password.value.length === 0) {
            showError(
                password,
                passwordError,
                "Please enter your password."
            );
            return false;
        }

        clearError(password, passwordError);
        return true;
    }

    username.addEventListener("input", validateUsername);
    password.addEventListener("input", validatePassword);

    togglePassword.addEventListener("click", function () {
        const isPassword = password.type === "password";

        password.type = isPassword ? "text" : "password";
        togglePassword.textContent = isPassword ? "HIDE" : "SHOW";

        togglePassword.setAttribute(
            "aria-label",
            isPassword ? "Hide password" : "Show password"
        );
    });

    form.addEventListener("submit", function (event) {
        const usernameValid = validateUsername();
        const passwordValid = validatePassword();

        if (!usernameValid || !passwordValid) {
            event.preventDefault();

            if (!usernameValid) {
                username.focus();
            } else {
                password.focus();
            }

            return;
        }

        loginButton.disabled = true;
        loginButton.classList.add("loading");
        buttonText.textContent = "Signing in...";
    });
</script>

</body>
</html>
