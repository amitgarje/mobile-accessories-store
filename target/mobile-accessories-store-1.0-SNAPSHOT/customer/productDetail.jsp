<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - ACCESSO.in</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body style="background-color: #f0f2f2;">
    
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
            transition: all 0.3s ease;
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }
        
        .product-main-grid {
            display: grid; 
            grid-template-columns: 1fr 1fr 280px; 
            gap: 40px; 
            background: white; 
            padding: 30px; 
            border-radius: 8px; 
            border: 1px solid #d5d9d9; 
            min-height: 500px;
        }

        @media (max-width: 992px) {
            .product-main-grid {
                grid-template-columns: 1fr 1fr;
            }
            .buy-box {
                grid-column: span 2;
            }
        }

        @media (max-width: 768px) {
            .product-main-grid {
                grid-template-columns: 1fr;
                padding: 20px;
            }
            .buy-box {
                grid-column: span 1;
            }
            .product-img-box {
                position: static !important;
            }
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
                        <a href="${pageContext.request.contextPath}/CartServlet?action=view" class="nav-item" style="font-size: 1.1rem;">
                            <i class="fa-solid fa-cart-shopping"></i>
                            <span style="background: var(--accent); color: white; padding: 2px 6px; border-radius: 10px; font-size: 0.75rem; vertical-align: top;">
                                ${not empty sessionScope.cartSize ? sessionScope.cartSize : '0'}
                            </span>
                        </a>
                        <a href="${pageContext.request.contextPath}/logout.jsp" class="nav-item" style="color: #ef4444;">Sign Out</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="nav-item">Sign In</a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn-cta">Get Started</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
    
    <div class="container" style="max-width: 1200px; padding: 140px 20px 40px;">
        <nav style="margin-bottom: 25px; font-size: 0.9rem; color: #565959;">
            <a href="${pageContext.request.contextPath}/ProductServlet?action=list" style="color: #007185; text-decoration:none;">${product.category}</a> › <span style="color: #c45500;">${product.name}</span>
        </nav>

        <div class="product-main-grid">
            <div class="product-img-box" style="text-align: center; position: sticky; top: 20px;">
                <c:choose>
                    <c:when test="${not empty product.image}">
                        <img src="${product.image}" alt="${product.name}" style="max-width: 100%; height: auto; max-height: 450px; object-fit: contain; transition: transform 0.3s ease;">
                    </c:when>
                    <c:otherwise>
                        <div style="width: 100%; height: 400px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; color: #cbd5e0; border-radius: 8px;">
                            <i class="fa-solid fa-image fa-4x"></i>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div style="display: flex; flex-direction: column;">
                <h1 style="font-size: 1.8rem; font-weight: 500; color: #0F1111; margin-bottom: 15px; line-height: 1.3;">${product.name}</h1>
                <div style="display:flex; align-items:center; gap:10px; margin-bottom: 15px;">
                    <span style="color: #007185; font-size: 0.95rem; cursor: pointer;">Visit the ACCESSO Store</span>
                    <div style="color: #ffb400; font-size: 0.9rem;">
                        <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>
                        <span style="color: #007185; margin-left: 5px; font-weight: 400;">4,812 ratings</span>
                    </div>
                </div>
                
                <hr style="border: 0; border-top: 1px solid #d5d9d9; margin-bottom: 20px;">
                
                <div style="display: flex; align-items: baseline; gap: 5px; margin-bottom: 20px;">
                    <span style="font-size: 1.8rem; font-weight: 400; color: #565959;">₹</span>
                    <span style="font-size: 2.2rem; font-weight: 600; color: #0F1111;">${product.price}</span>
                </div>
                
                <div style="margin-bottom: 25px;">
                    <h3 style="font-size: 1.1rem; color: #0F1111; margin-bottom: 10px;">About this item</h3>
                    <ul style="color: #0F1111; line-height: 1.8; font-size: 0.95rem; padding-left: 18px;">
                        <li>Premium build quality with durable materials.</li>
                        <li>Specifically designed for modern mobile devices.</li>
                        <li>${product.description}</li>
                    </ul>
                </div>
            </div>

            <!-- Buy Box -->
            <div class="buy-box" style="border: 1px solid #d5d9d9; border-radius: 8px; padding: 20px; display: flex; flex-direction: column; height: fit-content; gap: 15px;">
                <div style="font-size: 1.8rem; color: #0F1111; font-weight: 500;">₹${product.price}</div>
                <div style="font-size: 0.95rem; color: #565959;">FREE delivery <span style="font-weight: 700; color: #111;">Tomorrow, March 21</span>. Order within <span style="color:#007100;">12 hrs 30 mins</span>.</div>
                
                <div style="margin-top: 5px;">
                    <c:choose>
                        <c:when test="${product.stock > 0}">
                            <div style="color: #007600; font-size: 1.1rem; font-weight: 700; margin-bottom: 15px;">In Stock</div>
                            <form action="${pageContext.request.contextPath}/CartServlet" method="POST" style="margin-bottom: 10px;">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="id" value="${product.id}">
                                <button type="submit" class="btn btn-primary" style="width: 100%; border-radius: 20px; background: #FFD814; border-color: #FCD200; color: #0F1111; padding: 8px 0;">Add to Cart</button>
                            </form>
                            <button onclick="location.href='${pageContext.request.contextPath}/OrderServlet?action=checkout&id=${product.id}'" style="width: 100%; border-radius: 20px; background: #FFA41C; border: 1px solid #FF8F00; color: #0F1111; padding: 8px 0; cursor: pointer; font-weight: 400; font-size: 0.85rem;">Buy Now</button>
                        </c:when>
                        <c:otherwise>
                            <div style="color: #B12704; font-size: 1.1rem; font-weight: 700; margin-bottom: 15px;">Currently Unavailable</div>
                            <div style="font-size: 0.85rem; color: #565959;">We don't know when or if this item will be back in stock.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div style="font-size: 0.85rem; color: #565959; margin-top: 10px;">
                    <div style="display:flex; justify-content:space-between; margin-bottom: 5px;">
                        <span>Ships from</span> <span style="color: #111;">ACCESSO.in</span>
                    </div>
                    <div style="display:flex; justify-content:space-between;">
                        <span>Sold by</span> <span style="color: #111;">ACCESSO Retail</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <footer style="margin-top: 60px; background: #232f3e; color: white; padding: 40px 0;">
        <div class="container" style="text-align: center;">
            <a href="${pageContext.request.contextPath}/index.jsp" style="color: white; text-decoration: none; font-size: 1.5rem; font-weight: 700;">ACCESSO<span style="color:#febd69;">.in</span></a>
            <p style="margin-top: 15px; font-size: 0.85rem; color: #ddd;">&copy; 2026 ACCESSO Inc. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
