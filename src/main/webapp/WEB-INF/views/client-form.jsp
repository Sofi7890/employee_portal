<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
        <c:choose>
            <c:when test="${client.clientId != null}">Edit Client</c:when>
            <c:otherwise>Add Client</c:otherwise>
        </c:choose>
    </title>

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
                radial-gradient(circle at 10% 10%,
                    rgba(99,102,241,0.12), transparent 40%),
                radial-gradient(circle at 90% 90%,
                    rgba(6,182,212,0.08), transparent 40%);
            background-attachment: fixed;
            animation: pageFade 0.6s ease;
        }

        @keyframes pageFade {
            from {
                opacity: 0;
                transform: translateY(8px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
            padding: 13px 18px 0 0;
            vertical-align: top;
            font-size: 13px;
            font-weight: 700;
        }

        .form-table td:last-child {
            width: 68%;
        }

        input[type="text"],
        input[type="password"],
        input[type="date"] {
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

        input:focus {
            border-color: var(--accent-primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.15);
        }

        input[type="date"] {
            color-scheme: dark;
        }

        input::placeholder {
            color: #6b7280;
        }

        .required-note {
            margin-top: 7px;
            color: var(--text-muted);
            font-size: 11px;
            line-height: 1.6;
        }

        .required-star {
            color: #f87171;
        }

        .button-row {
            padding-top: 25px;
            text-align: left;
        }

        .submit-btn,
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
            background: linear-gradient(
                135deg,
                var(--accent-primary),
                #4f46e5
            );
            box-shadow: 0 5px 18px rgba(99,102,241,0.25);
        }

        .cancel-btn {
            border: 1px solid var(--border-color);
            background: transparent;
            color: var(--text-main);
            margin-left: 8px;
        }

        .submit-btn:hover,
        .cancel-btn:hover {
            transform: translateY(-2px);
        }

        .submit-btn:hover {
            box-shadow: 0 8px 22px rgba(99,102,241,0.35);
        }

        .cancel-btn:hover {
            border-color: var(--border-hover);
            background: rgba(99,102,241,0.1);
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

            .button-row {
                padding-top: 15px;
            }

            .submit-btn,
            .cancel-btn {
                width: 100%;
                margin: 8px 0 0;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <div class="form-card">

        <div class="header">
            <c:choose>
                <c:when test="${client.clientId != null}">
                    <h1>Edit Client</h1>
                    <p>Update the client information below.</p>
                </c:when>
                <c:otherwise>
                    <h1>Add Client</h1>
                    <p>Enter the details to register a new client.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <c:choose>
            <c:when test="${client.clientId != null}">
                <c:url var="formAction"
                       value="/client/update/${client.clientId}" />
            </c:when>
            <c:otherwise>
                <c:url var="formAction" value="/client/create" />
            </c:otherwise>
        </c:choose>

        <form action="${formAction}" method="post">

            <table class="form-table">
                <tbody>

                <!-- Client Name -->
                <tr>
                    <td>
                        <label for="clientName">
                            Client Name <span class="required-star">*</span>
                        </label>
                    </td>
                    <td>
                        <input type="text"
                               id="clientName"
                               name="clientName"
                               value="<c:out value='${client.clientName}'/>"
                               placeholder="Enter client name"
                               required>
                    </td>
                </tr>

                <!-- Relationship Date -->
                <tr>
                    <td>
                        <label for="clientRelationshipDate">
                            Relationship Date
                        </label>
                    </td>
                    <td>
                        <input type="date"
                               id="clientRelationshipDate"
                               name="clientRelationshipDate"
                               value="${client.clientRelationshipDate}">

                        <div class="required-note">
                            Select the date the client relationship began.
                        </div>
                    </td>
                </tr>

                <!-- Password -->
                <tr>
                    <td>
                        <label for="password">
                            Password
                            <c:if test="${client.clientId == null}">
                                <span class="required-star">*</span>
                            </c:if>
                        </label>
                    </td>
                    <td>
                        <input type="password"
                               id="password"
                               name="password"
                               placeholder="Enter password"
                               autocomplete="new-password"
                               <c:if test="${client.clientId == null}">
                                   required
                               </c:if>>

                        <div class="required-note">
                            <c:choose>
                                <c:when test="${client.clientId != null}">
                                    Leave blank if you do not want to change
                                    the password.
                                </c:when>
                                <c:otherwise>
                                    Password is required when creating a
                                    new client.
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>

                <!-- Role -->
                <tr>
                    <td>
                        <label for="role">Role</label>
                    </td>
                    <td>
                        <input type="text"
                               id="role"
                               name="role"
                               value="<c:out value='${client.role}'/>"
                               placeholder="Enter client role">
                    </td>
                </tr>

                <!-- Actions -->
                <tr>
                    <td colspan="2" class="button-row">

                        <button type="submit" class="submit-btn">
                            <c:choose>
                                <c:when test="${client.clientId != null}">
                                    Update Client
                                </c:when>
                                <c:otherwise>
                                    Create Client
                                </c:otherwise>
                            </c:choose>
                        </button>

                        <a href="<c:url value='/client/list'/>"
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

</body>
</html>