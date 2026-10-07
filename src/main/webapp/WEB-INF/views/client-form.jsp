<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>

    <title>
        <c:choose>
            <c:when test="${client.clientId != null}">Edit Client</c:when>
            <c:otherwise>Add Client</c:otherwise>
        </c:choose>
    </title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, Helvetica, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .form-container {
            width: 100%;
            max-width: 650px;
            background: #ffffff;
            border-radius: 18px;
            padding: 35px 40px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.20);
            animation: fadeIn 0.6s ease;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h2 {
            margin: 0;
            color: #4f46e5;
            font-size: 30px;
        }

        .form-header p {
            margin-top: 8px;
            color: #777;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #d7d7df;
            border-radius: 9px;
            font-size: 15px;
            outline: none;
            transition: all 0.25s ease;
        }

        .form-group input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 28px;
        }

        .submit-btn {
            flex: 1;
            border: none;
            padding: 13px;
            border-radius: 9px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.25s ease;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(102, 126, 234, 0.30);
        }

        .cancel-btn {
            flex: 1;
            text-align: center;
            text-decoration: none;
            padding: 13px;
            border-radius: 9px;
            background: #f1f3f5;
            color: #444;
            font-size: 15px;
            font-weight: bold;
            transition: all 0.25s ease;
        }

        .cancel-btn:hover {
            background: #e2e5e8;
            transform: translateY(-2px);
        }

        .required-note {
            margin-top: 18px;
            text-align: center;
            font-size: 12px;
            color: #888;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 600px) {

            body {
                padding: 15px;
            }

            .form-container {
                padding: 25px 20px;
            }

            .form-actions {
                flex-direction: column;
            }

            .form-header h2 {
                font-size: 25px;
            }
        }

    </style>

</head>

<body>

<div class="form-container">

    <div class="form-header">

        <h2>
            <c:choose>
                <c:when test="${client.clientId != null}">
                    Edit Client
                </c:when>
                <c:otherwise>
                    Add Client
                </c:otherwise>
            </c:choose>
        </h2>

        <p>
            <c:choose>
                <c:when test="${client.clientId != null}">
                    Update the client information below
                </c:when>
                <c:otherwise>
                    Enter the client information below
                </c:otherwise>
            </c:choose>
        </p>

    </div>


    <c:choose>

        <c:when test="${client.clientId != null}">

            <form action="<c:url value='/client/update/${client.clientId}' />"
                  method="post">

        </c:when>

        <c:otherwise>

            <form action="<c:url value='/client/create' />"
                  method="post">

        </c:otherwise>

    </c:choose>


        <div class="form-group">

            <label>Client Name</label>

            <input type="text"
                   name="clientName"
                   value="${client.clientName}"
                   placeholder="Enter client name"
                   required />

        </div>


        <div class="form-group">

            <label>Relationship Date</label>

            <input type="date"
                   name="clientRelationshipDate"
                   value="${client.clientRelationshipDate}" />

        </div>


        <div class="form-group">

            <label>Password</label>

            <input type="password"
                   name="password"
                   placeholder="Enter password"
                   <c:if test="${client.clientId == null}">required</c:if> />

        </div>


        <div class="form-group">

            <label>Role</label>

            <input type="text"
                   name="role"
                   value="${client.role}"
                   placeholder="Enter client role" />

        </div>


        <div class="form-actions">

            <input type="submit"
                   class="submit-btn"
                   value="<c:choose><c:when test='${client.clientId != null}'>Update</c:when><c:otherwise>Create</c:otherwise></c:choose>" />

            <a href="<c:url value='/client/list' />"
               class="cancel-btn">
                Cancel
            </a>

        </div>

        <div class="required-note">
            Password is required when creating a new client.
        </div>

    </form>

</div>

</body>
</html>