<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed | ACCESSO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --primary: #0f172a;
            --accent: #3b82f6;
            --success: #00c853;
            --bg-light: #f1f5f9;
            --radius-xl: 32px;
        }

        body {
            background-color: var(--bg-light);
            font-family: 'Inter', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
        }

        /* Professional Centered Navbar (Same as other pages) */
        .nav-glass {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: auto;
            min-width: 600px;
            max-width: 900px;
            height: 70px;
            padding: 0 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(12px);
            border-radius: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .nav-container { display: flex; align-items: center; gap: 40px; }
        .nav-brand { font-size: 1.6rem; font-weight: 900; text-decoration: none; color: #000; letter-spacing: -1px; }
        .nav-brand span { color: var(--accent); }

        /* PhonePe Style Card */
        .confirmation-card {
            background: white;
            width: 100%;
            max-width: 450px;
            padding: 50px 40px;
            border-radius: var(--radius-xl);
            box-shadow: 0 20px 60px rgba(0,0,0,0.05);
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes slideUp {
            from { transform: translateY(30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .success-icon-circle {
            width: 100px;
            height: 100px;
            background: var(--success);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3.5rem;
            margin: 0 auto 30px;
            box-shadow: 0 10px 25px rgba(0, 200, 83, 0.3);
            animation: scaleIn 0.5s cubic-bezier(0.16, 1, 0.3, 1) 0.2s both;
        }

        @keyframes scaleIn {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }

        .status-text {
            color: var(--primary);
            font-size: 1.8rem;
            font-weight: 900;
            margin-bottom: 8px;
        }

        .sub-status {
            color: var(--success);
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 40px;
        }

        .order-details {
            background: #f8fafc;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 40px;
            text-align: left;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 0.95rem;
        }

        .detail-item:last-child { margin-bottom: 0; }
        .detail-label { color: var(--text-muted); font-weight: 600; }
        .detail-value { color: var(--primary); font-weight: 800; }

        .btn-done {
            background: var(--primary);
            color: white !important;
            padding: 18px;
            border-radius: 18px;
            text-decoration: none;
            font-weight: 800;
            font-size: 1.1rem;
            display: block;
            width: 100%;
            transition: transform 0.2s;
        }

        .btn-done:active { transform: scale(0.98); }

        .redirect-msg {
            margin-top: 25px;
            font-size: 0.85rem;
            color: var(--text-muted);
            font-weight: 600;
        }

        #countdown { color: var(--accent); font-weight: 800; }
    </style>
</head>
<body>
    
    <nav class="nav-glass">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="nav-brand">
                ACCESSO<span>.in</span>
            </a>
        </div>
    </nav>

    <div class="confirmation-card">
        <div class="success-icon-circle">
            <i class="fa-solid fa-check"></i>
        </div>
        
        <h1 class="status-text">Order Confirmed</h1>
        <p class="sub-status">Your order is received, thank you!</p>
        
        <div class="order-details">
            <div class="detail-item">
                <span class="detail-label">Order ID</span>
                <span class="detail-value">#ORD-${param.orderId}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Status</span>
                <span class="detail-value" style="color: var(--success);">Payment Successful</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Store</span>
                <span class="detail-value">ACCESSO Global</span>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/index.jsp" class="btn-done">
            Return to Store
        </a>

        <p class="redirect-msg">
            Auto-redirecting in <span id="countdown">5</span>s
        </p>
    </div>

    <script>
        let seconds = 5;
        const countdownEl = document.getElementById('countdown');
        const interval = setInterval(() => {
            seconds--;
            countdownEl.textContent = seconds;
            if (seconds <= 0) {
                clearInterval(interval);
                window.location.href = '${pageContext.request.contextPath}/index.jsp';
            }
        }, 1000);
    </script>
</body>
</html>
