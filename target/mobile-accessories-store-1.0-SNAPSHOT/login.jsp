<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In | ACCESSO</title>
    <!-- Modern Icons & Fonts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="auth-page">

    <!-- Background Animated Blobs -->
    <div class="bg-blobs">
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>
    </div>

    <!-- Glass Card -->
    <div class="auth-glass-card">
        <!-- Brand Logo -->
        <div style="text-align: center; margin-bottom: 40px;">
            <a href="${pageContext.request.contextPath}/index.jsp" class="nav-brand" style="justify-content: center; font-size: 2.2rem;">
                ACCESSO<span>.in</span>
            </a>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 10px;">Welcome back to premium accessories.</p>
        </div>

        <%
            String error = request.getParameter("error");
            String msg = request.getParameter("msg");
            if(error != null) {
        %>
            <div class="alert" style="background: rgba(197, 48, 48, 0.1); color: #C53030; padding: 15px; border-radius: 12px; margin-bottom: 25px; font-weight: 600; font-size: 0.85rem; border: 1px solid rgba(197, 48, 48, 0.2);">
                <i class="fa-solid fa-circle-exclamation"></i> &nbsp;<%= error %>
            </div>
        <% } if(msg != null) { %>
            <div class="alert" style="background: rgba(47, 133, 90, 0.1); color: #2F855A; padding: 15px; border-radius: 12px; margin-bottom: 25px; font-weight: 600; font-size: 0.85rem; border: 1px solid rgba(47, 133, 90, 0.2);">
                <i class="fa-solid fa-check-circle"></i> &nbsp;<%= msg %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">
            <div class="input-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="name@company.com" required>
            </div>
            
            <div class="input-group">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                    <label for="password" style="margin-bottom:0;">Password</label>
                    <a href="#" style="font-size: 0.8rem; color: var(--accent); font-weight: 700; text-decoration: none;">Forgot?</a>
                </div>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>
            
            <button type="submit" class="btn-cta" style="width: 100%; justify-content: center; margin-top: 10px;">Sign In</button>
        </form>
        
        <div style="text-align: center; margin-top: 35px; border-top: 1px solid #E2E8F0; padding-top: 25px;">
            <p style="font-size: 0.9rem; color: var(--text-muted);">
                New to ACCESSO? <a href="${pageContext.request.contextPath}/register.jsp" style="color: var(--primary); font-weight: 800; text-decoration: none;">Create account</a>
            </p>
        </div>

        <div style="margin-top: 40px; display: flex; justify-content: center; gap: 20px; font-size: 0.75rem; opacity: 0.6;">
            <a href="#" style="color: var(--primary); text-decoration: none;">Privacy Policy</a>
            <a href="#" style="color: var(--primary); text-decoration: none;">Terms of Service</a>
            <a href="#" style="color: var(--primary); text-decoration: none;">Help Support</a>
        </div>
    </div>

    <!-- Modern Scripts -->
    <script src="js/script.js"></script>
</body>
</html>