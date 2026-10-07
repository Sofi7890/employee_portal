<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Attendance</title>

    <!-- Google Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

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
                radial-gradient(circle at 10% 10%, rgba(99, 102, 241, 0.08) 0%, transparent 40%),
                radial-gradient(circle at 90% 90%, rgba(6, 182, 212, 0.06) 0%, transparent 40%);
            background-attachment: fixed;
            animation: fadeIn 0.8s ease-out;
            padding: 40px 20px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .container {
            max-width: 1100px;
            margin: auto;
            animation: fadeInAnim 0.6s ease;
        }

        @keyframes fadeInAnim {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Header */
        .page-header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 36px;
            margin-bottom: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .page-header h1 {
            margin: 0;
            color: #fff;
            font-size: 26px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .page-header p {
            margin: 6px 0 0;
            color: var(--text-muted);
            font-size: 13px;
        }

        /* Today Box / Actions Card */
        .box {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 32px;
            margin-bottom: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .today-info {
            font-size: 15px;
            color: var(--text-main);
            font-weight: 600;
        }

        .today-info b {
            color: #fff;
            margin-right: 8px;
            font-weight: 700;
        }

        .action-buttons {
            display: flex;
            gap: 12px;
        }

        button {
            border: none;
            padding: 12px 24px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .checkin-btn {
            background: linear-gradient(135deg, var(--success), #059669);
            color: white;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }

        .checkin-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
        }

        .checkout-btn {
            background: linear-gradient(135deg, var(--danger), #dc2626);
            color: white;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }

        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
        }

        /* Table Section */
        .table-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 32px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow-x: auto;
            margin-bottom: 24px;
        }

        .table-card h3 {
            margin: 0 0 20px;
            color: #fff;
            font-size: 18px;
            font-weight: 700;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 750px;
        }

        th {
            background: rgba(17, 24, 39, 0.8);
            color: var(--text-muted);
            padding: 14px 18px;
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
            font-family: 'JetBrains Mono', monospace;
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

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .status-present {
            background: rgba(16, 185, 129, 0.1);
            color: #34d399;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .status-absent {
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        /* Footer Back Button */
        .footer-back {
            text-align: left;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: var(--text-main);
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            padding: 12px 24px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .back-btn:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        @media (max-width: 750px) {
            body { padding: 20px 10px; }
            .page-header { flex-direction: column; align-items: flex-start; gap: 15px; padding: 20px; }
            .box { flex-direction: column; align-items: flex-start; padding: 20px; }
            .action-buttons { width: 100%; flex-direction: column; }
            button { width: 100%; justify-content: center; }
            .table-card { padding: 20px; }
        }
    </style>
</head>

<body>

<div class="container">

    <!-- Header -->
    <div class="page-header">
        <div>
            <h1>My Attendance</h1>
            <p>Track your daily check-ins, check-outs and working hours history</p>
        </div>
    </div>

    <!-- Today's Status Box -->
    <div class="box">
        <div class="today-info">
            <b>Today's Status:</b> 
            <c:choose>
                <c:when test="${today==null}">
                    <span style="color: var(--text-muted);">Not marked</span>
                </c:when>
                <c:otherwise>
                    <span style="color: #34d399; font-weight: 700;">${today.status}</span> | In: ${today.checkIn} | Out: ${today.checkOut}
                    <c:if test="${not empty today.attendanceType}"> | Location: <strong>${today.attendanceType}</strong></c:if>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="action-buttons">
            <form id="checkinForm" method="post" action="${pageContext.request.contextPath}/attendance/checkin">
                <input type="hidden" name="latitude" id="latitude">
                <input type="hidden" name="longitude" id="longitude">
                <button type="button" class="checkin-btn" onclick="checkInWithLocation()">
                    <i class="fa-solid fa-location-dot"></i> Check In with Live Location
                </button>
            </form>
            <form method="post" action="${pageContext.request.contextPath}/attendance/checkout">
                <button type="submit" class="checkout-btn">
                    <i class="fa-solid fa-right-from-bracket"></i> Check Out
                </button>
            </form>
        </div>
    </div>

    <!-- Attendance History Table -->
    <div class="table-card">
        <h3>Attendance Logs</h3>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>In</th>
                    <th>Out</th>
                    <th>Status</th>
                    <th>Late</th>
                    <th>Minutes</th>
                    <th>Location</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${records}">
                    <tr>
                        <td>${a.attendanceDate}</td>
                        <td>${a.checkIn}</td>
                        <td>${a.checkOut}</td>
                        <td>
                            <span class="status-badge ${a.status == 'PRESENT' ? 'status-present' : 'status-absent'}">
                                ${a.status}
                            </span>
                        </td>
                        <td>${a.late}</td>
                        <td>${a.workedMinutes} mins</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty a.attendanceType}">
                                    <strong>${a.attendanceType}</strong><br>
                                    <small>${a.latitude}, ${a.longitude}</small>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Back Navigation -->
    <div class="footer-back">
        <a href="${pageContext.request.contextPath}/employee/dashboard" class="back-btn">
            <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

</div>

<script>
function checkInWithLocation() {
    if (!navigator.geolocation) {
        alert("Live location is not supported by this browser.");
        return;
    }

    const button = document.querySelector("#checkinForm button");
    button.disabled = true;
    button.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Getting live location...';

    navigator.geolocation.getCurrentPosition(function(position) {
        document.getElementById("latitude").value = position.coords.latitude;
        document.getElementById("longitude").value = position.coords.longitude;
        document.getElementById("checkinForm").submit();
    }, function(error) {
        button.disabled = false;
        button.innerHTML = '<i class="fa-solid fa-location-dot"></i> Check In with Live Location';
        if (error.code === error.PERMISSION_DENIED) {
            alert("Location permission was denied. Please allow location access and try again.");
        } else if (error.code === error.POSITION_UNAVAILABLE) {
            alert("Your current location could not be determined. Please try again.");
        } else {
            alert("Unable to get your live location. Please try again.");
        }
    }, { enableHighAccuracy: true, timeout: 15000, maximumAge: 0 });
}
</script>

<c:if test="${param.error == 'location'}">
<script>alert("Live location is required to mark attendance.");</script>
</c:if>

</body>
</html>