<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | ACCESSO</title>
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
    <div class="auth-glass-card" style="max-width: 500px;">
        <!-- Brand Logo -->
        <div style="text-align: center; margin-bottom: 40px;">
            <a href="${pageContext.request.contextPath}/index.jsp" class="nav-brand" style="justify-content: center; font-size: 2.2rem;">
                ACCESSO<span>.in</span>
            </a>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 10px;">Join the community of premium accessories.</p>
        </div>

        <%
            String error = request.getParameter("error");
            if(error != null) {
        %>
            <div class="alert" style="background: rgba(197, 48, 48, 0.1); color: #C53030; padding: 15px; border-radius: 12px; margin-bottom: 25px; font-weight: 600; font-size: 0.85rem; border: 1px solid rgba(197, 48, 48, 0.2);">
                <i class="fa-solid fa-circle-exclamation"></i> &nbsp;<%= error %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/RegisterServlet" method="POST">
            <div class="input-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" placeholder="John Doe" required>
            </div>

            <div class="input-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="name@company.com" required>
            </div>
            
            <div class="input-group">
                <label for="password">Create Password</label>
                <input type="password" id="password" name="password" placeholder="At least 8 characters" required>
            </div>

            <div class="input-group">
                <label for="role">Account Type</label>
                <select id="role" name="role" style="width: 100%; padding: 14px 20px; border-radius: 12px; border: 1px solid #E2E8F0; background: #FFFFFF; font-size: 1rem; transition: var(--transition); cursor: pointer; outline: none;">
                    <option value="customer">Customer</option>
                    <option value="admin">Administrator</option>
                    <option value="delivery">Delivery Partner</option>
                </select>
            </div>
            
            <button type="submit" class="btn-cta" style="width: 100%; justify-content: center; margin-top: 10px;">Create Account</button>
        </form>
        
        <div style="text-align: center; margin-top: 35px; border-top: 1px solid #E2E8F0; padding-top: 25px;">
            <p style="font-size: 0.9rem; color: var(--text-muted);">
                Already have an account? <a href="${pageContext.request.contextPath}/login.jsp" style="color: var(--primary); font-weight: 800; text-decoration: none;">Sign In</a>
            </p>
        </div>

        <p style="margin-top: 30px; font-size: 0.75rem; text-align: center; color: var(--text-muted); line-height: 1.6;">
            By creating an account, you agree to our <a href="#" style="color: var(--primary); font-weight: 700;">Terms</a> and <a href="#" style="color: var(--primary); font-weight: 700;">Privacy Policy</a>.
        </p>
    </div>

    <!-- Modern Scripts -->
    <script src="js/script.js"></script>
</body>
</html>