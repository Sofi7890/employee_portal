<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resignation</title>

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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 25px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .page {
            width: 100%;
            max-width: 650px;
            animation: pageEnter 0.7s ease;
        }

        /* Header */
        .header {
            text-align: center;
            color: white;
            margin-bottom: 24px;
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

        /* Box Card */
        .box {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 36px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: hidden;
        }

        .box::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--accent-primary), var(--accent-secondary));
        }

        .box h2 {
            margin: 0 0 8px;
            color: #fff;
            font-size: 18px;
            font-weight: 700;
        }

        .description {
            margin: 0 0 24px;
            color: var(--text-muted);
            font-size: 13px;
            line-height: 1.5;
        }

        .field-label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-main);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        textarea {
            width: 100%;
            min-height: 170px;
            padding: 14px 16px;
            resize: vertical;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            background: rgba(11, 15, 25, 0.6);
            color: var(--text-main);
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 14px;
            line-height: 1.5;
            outline: none;
            transition: var(--transition);
        }

        textarea:hover {
            border-color: var(--border-hover);
        }

        textarea:focus {
            border-color: var(--accent-primary);
            background: rgba(11, 15, 25, 0.8);
            box-shadow: 0 0 15px var(--accent-glow);
        }

        textarea::placeholder {
            color: var(--text-muted);
        }

        .button-area {
            margin-top: 24px;
        }

        button {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--accent-primary), #4f46e5);
            color: white;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }

        button:active {
            transform: translateY(0);
        }

        .note {
            margin-top: 20px;
            padding: 14px;
            background: rgba(17, 24, 39, 0.5);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            color: var(--text-muted);
            font-size: 12px;
            text-align: center;
        }

        @keyframes pageEnter {
            from {
                opacity: 0;
                transform: translateY(30px) scale(0.97);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        @media (max-width: 600px) {
            body { padding: 15px; }
            .box { padding: 24px 20px; }
            .header h1 { font-size: 22px; }
        }
    </style>
</head>

<body>

<div class="page">

    <div class="header">
        <h1>Resignation Portal</h1>
        <p>Submit your resignation request securely</p>
    </div>

    <div class="box">

        <h2>Submit Resignation</h2>

        <p class="description">
            Please provide the reason for your resignation. Your request will be reviewed and processed by the administrator.
        </p>

        <form method="post"
              action="${pageContext.request.contextPath}/resignation/apply">

            <label class="field-label" for="reason">
                Reason for Resignation
            </label>

            <textarea id="reason"
                      name="reason"
                      placeholder="Provide a detailed explanation for your resignation..."
                      required></textarea>

            <div class="button-area">
                <button type="submit">
                    <i class="fa-solid fa-paper-plane"></i> Submit Request
                </button>
            </div>

        </form>

        <div class="note">
            Please ensure you provide a clear and complete reason for your resignation request.
        </div>

    </div>

</div>

</body>
</html>