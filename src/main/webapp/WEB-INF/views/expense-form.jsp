<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Expense</title>

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

        .page-container {
            max-width: 720px;
            margin: auto;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7), rgba(17, 24, 39, 0.8));
            backdrop-filter: blur(12px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 36px;
            margin-bottom: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.7s ease;
        }

        .header::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .header h1 {
            margin: 0;
            color: #fff;
            font-size: 26px;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .header p {
            margin: 6px 0 0;
            color: var(--text-muted);
            font-size: 13px;
        }

        /* Expense Card */
        .expense-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 36px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.6s ease;
            position: relative;
        }

        .section-title {
            font-size: 16px;
            font-weight: 700;
            color: #fff;
            border-left: 4px solid var(--accent-primary);
            padding-left: 12px;
            margin-bottom: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 13px 16px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            background: rgba(11, 15, 25, 0.6);
            color: var(--text-main);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 14px;
            outline: none;
            transition: var(--transition);
        }

        input:hover,
        select:hover,
        textarea:hover {
            border-color: var(--border-hover);
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: var(--accent-primary);
            background: rgba(11, 15, 25, 0.8);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        select option {
            background: var(--bg-secondary);
            color: var(--text-main);
        }

        textarea {
            min-height: 130px;
            resize: vertical;
        }

        input[type="file"] {
            padding: 12px;
            background: rgba(17, 24, 39, 0.5);
            cursor: pointer;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .file-note {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 6px;
        }

        .button-row {
            display: flex;
            gap: 12px;
            margin-top: 28px;
        }

        button {
            flex: 1;
            border: none;
            padding: 14px 20px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            color: white;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        .back-button {
            flex: 0 0 auto;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            padding: 14px 22px;
            border-radius: 12px;
            background: var(--bg-secondary);
            color: var(--text-main);
            font-size: 14px;
            font-weight: 600;
            border: 1px solid var(--border-color);
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .back-button:hover {
            background: rgba(99, 102, 241, 0.1);
            color: #fff;
            border-color: var(--border-hover);
            transform: translateY(-2px);
        }

        .required {
            color: var(--danger);
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            body { padding: 20px 10px; }
            .header { padding: 20px; }
            .header h1 { font-size: 22px; }
            .expense-card { padding: 24px 20px; }
            .button-row { flex-direction: column; }
            .back-button { text-align: center; justify-content: center; }
        }
    </style>
</head>

<body>

<div class="page-container">

    <div class="header">
        <h1>Submit Expense</h1>
        <p>Submit your expense claim for reimbursement review and approval</p>
    </div>

    <div class="expense-card">

        <div class="section-title">
            Expense Claim Details
        </div>

        <form method="post"
              enctype="multipart/form-data"
              action="${pageContext.request.contextPath}/expense/apply">

            <div class="form-group">
                <label for="expenseType">
                    Expense Type
                </label>
                <select id="expenseType" name="expenseType">
                    <option>TRAVEL</option>
                    <option>FOOD</option>
                    <option>ACCOMMODATION</option>
                    <option>OFFICE</option>
                    <option>OTHER</option>
                </select>
            </div>

            <div class="form-group">
                <label for="amount">
                    Amount <span class="required">*</span>
                </label>
                <input type="number"
                       id="amount"
                       step="0.01"
                       min="0"
                       name="amount"
                       placeholder="Enter expense amount"
                       required>
            </div>

            <div class="form-group">
                <label for="description">
                    Description <span class="required">*</span>
                </label>
                <textarea id="description"
                          name="description"
                          placeholder="Enter details about this expense"
                          required></textarea>
            </div>

            <div class="form-group">
                <label for="receipt">
                    Receipt
                </label>
                <input type="file"
                       id="receipt"
                       name="receipt">
                <div class="file-note">
                    Attach a receipt or supporting document if available.
                </div>
            </div>

            <div class="button-row">
                <a href="${pageContext.request.contextPath}/dashboard" class="back-button">
                    <i class="fa-solid fa-arrow-left"></i> Dashboard
                </a>

                <button type="submit">
                    <i class="fa-solid fa-paper-plane"></i> Submit Expense
                </button>
            </div>

        </form>

    </div>

</div>

</body>
</html>