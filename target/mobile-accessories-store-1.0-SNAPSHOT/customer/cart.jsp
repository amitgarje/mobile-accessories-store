<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Bag | ACCESSO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --primary: #0f172a;
            --accent: #3b82f6;
            --bg-light: #f8fafc;
            --text-dark: #334155;
            --text-muted: #64748b;
            --radius-lg: 24px;
            --radius-md: 16px;
        }

        /* Professional Centered Navbar */
        .nav-glass {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 90%;
            max-width: 900px;
            height: 70px;
            padding: 0 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(12px);
            border-radius: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }

        .nav-brand {
            font-size: 1.6rem;
            font-weight: 900;
            text-decoration: none;
            color: #000;
            letter-spacing: -1px;
            display: flex;
            align-items: center;
        }

        .nav-brand span { color: var(--accent); }

        .nav-links {
            display: flex;
            gap: 25px;
            align-items: center;
        }

        .nav-item {
            text-decoration: none;
            color: #444;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s;
        }

        .nav-item:hover { color: #000; }

        .btn-cta {
            background: #000;
            color: white !important;
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
            font-size: 0.9rem;
        }

        /* Cart Specifics */
        .cart-grid { display: grid; grid-template-columns: 1fr 380px; gap: 40px; }
        .cart-item-card { 
            background: white; padding: 25px; border-radius: 20px; border: 1px solid #EEE; 
            display: flex; gap: 25px; margin-bottom: 20px; transition: all 0.3s ease;
        }
        .cart-item-card:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .item-preview { width: 120px; height: 120px; border-radius: 15px; background: #F8F9FA; padding: 10px; border: 1px solid #EEE; overflow: hidden; }
        .item-preview img { width: 100%; height: 100%; object-fit: contain; }
        .summary-card { 
            background: white; padding: 40px; border-radius: 24px; border: 1px solid #EEE; 
            position: sticky; top: 120px; height: fit-content;
        }
    </style>
</head>
<body style="background-color: var(--bg-light);">

    <nav class="nav-glass" id="mainNavbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="nav-brand">
                ACCESSO<span>.in</span>
            </a>
            
            <button class="nav-toggle" id="navToggle">
                <i class="fa-solid fa-bars"></i>
            </button>

            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="nav-item">Shop</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/OrderServlet?action=my_orders" class="nav-item">Orders</a>
                        <a href="${pageContext.request.contextPath}/logout.jsp" class="nav-item" style="color: #ef4444; margin-left:15px;">Sign Out</a>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </nav>

    <main class="container" style="padding-top: 150px; padding-bottom: 100px;">
        <header style="margin-bottom: 60px;">
            <h1 style="font-size: 3rem; font-weight: 800; color: var(--primary);">Your Bag</h1>
            <p style="color: var(--text-muted); font-size: 1.1rem;">Review your selection of premium accessories.</p>
        </header>

        <c:if test="${not empty param.error}">
            <div class="alert" style="background: rgba(255, 77, 77, 0.1); color: #FF4D4D; padding: 15px; border-radius: 12px; margin-bottom: 40px;">
                <i class="fa-solid fa-circle-exclamation"></i> &nbsp;${param.error}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div style="text-align: center; padding: 100px 20px;">
                    <i class="fa-solid fa-bag-shopping fa-4x" style="opacity: 0.1; margin-bottom: 30px;"></i>
                    <h2 style="font-weight: 800; color: #111;">Your bag is empty.</h2>
                    <p style="color: #AAA; margin-top: 10px; margin-bottom: 40px;">Looks like you haven't added anything to your cart yet.</p>
                    <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="btn-cta">Start Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-grid">
                    <div class="cart-items-list">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item-card">
                                <div class="item-preview">
                                    <img src="${not empty item.product.image ? item.product.image : 'https://via.placeholder.com/150'}" alt="${item.product.name}">
                                </div>
                                <div style="flex: 1;">
                                    <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                                        <div>
                                            <span style="font-size: 0.8rem; color: var(--accent); font-weight: 800; text-transform: uppercase;">${item.product.category}</span>
                                            <h3 style="font-size: 1.3rem; font-weight: 800; margin: 5px 0;">${item.product.name}</h3>
                                        </div>
                                        <div style="text-align: right;">
                                            <div style="font-weight: 800; font-size: 1.2rem;">₹${item.product.price}</div>
                                        </div>
                                    </div>
                                    <div style="display: flex; align-items: center; gap: 25px; margin-top: 25px; padding-top: 20px; border-top: 1px solid #F5F5F5;">
                                        <div style="font-size: 0.9rem; color: #555; background: #F8F9FA; padding: 5px 15px; border-radius: 10px; font-weight: 700;">Qty: ${item.quantity}</div>
                                        <a href="${pageContext.request.contextPath}/CartServlet?action=remove&id=${item.product.id}" style="color: #FF4D4D; font-size: 0.85rem; font-weight: 800; text-decoration: none;">
                                            <i class="fa-solid fa-trash-can"></i> Remove
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <aside class="summary-card">
                        <h3 style="font-size: 1.2rem; font-weight: 800; margin-bottom: 30px;">Summary</h3>
                        
                        <div style="display: flex; justify-content: space-between; margin-bottom: 20px; font-weight: 600; color: #777;">
                            <span>Subtotal</span>
                            <span>₹${cartTotal}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-bottom: 20px; font-weight: 600; color: #777;">
                            <span>Shipping</span>
                            <span style="color: #00C851;">FREE</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-top: 30px; padding-top: 30px; border-top: 1px solid #F5F5F5; font-size: 1.5rem; font-weight: 800; color: var(--primary);">
                            <span>Total</span>
                            <span>₹${cartTotal}</span>
                        </div>

                        <a href="${pageContext.request.contextPath}/OrderServlet?action=checkout" class="btn-cta" style="width: 100%; border-radius: 15px; margin-top: 40px; justify-content: center; font-size: 1.1rem; padding: 18px;">
                            Check Out
                        </a>
                        
                        <div style="margin-top: 30px; text-align: center; opacity: 0.4; font-size: 0.8rem; display: flex; justify-content: center; gap: 15px;">
                            <i class="fa-brands fa-cc-visa fa-2x"></i>
                            <i class="fa-brands fa-cc-mastercard fa-2x"></i>
                            <i class="fa-brands fa-cc-apple-pay fa-2x"></i>
                        </div>
                    </aside>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>