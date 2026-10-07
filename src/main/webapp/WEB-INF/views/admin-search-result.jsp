<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Search Result</title>
</head>
<body>
<h2>Search Result for Username: ${searchedUsername}</h2>

<c:if test="${admin != null}">
    <p>ID: ${admin.adminId}</p>
    <p>Username: ${admin.username}</p>
    <p>Email: ${admin.email}</p>
    <p>Role: ${admin.role}</p>
</c:if>

<c:if test="${admin == null}">
    <p>No admin found.</p>
</c:if>

<a href="${pageContext.request.contextPath}/admin/list">Back to Admin List</a>
</body>
</html>
