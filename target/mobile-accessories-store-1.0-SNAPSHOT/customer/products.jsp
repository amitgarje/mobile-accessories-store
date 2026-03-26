<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${empty param.category ? 'All Collections' : param.category} | ACCESSO</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>

            <style>
                :root {
                    --primary: #0f172a;
                    --accent: #3b82f6;
                    --bg-light: #ffffff;
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

                .nav-glass.scrolled {
                    top: 15px;
                    width: 90%;
                    max-width: 900px;
                    height: 65px;
                    background: rgba(255, 255, 255, 0.98);
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

                .nav-brand span {
                    color: var(--accent);
                }

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

                .nav-item:hover {
                    color: #000;
                }

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

            <body data-is-logged-in="${not empty sessionScope.user}">

                <nav class="nav-glass" id="mainNavbar">
                    <div class="nav-container">
                        <a href="${pageContext.request.contextPath}/index.jsp" class="nav-brand">
                            ACCESSO<span>.in</span>
                        </a>

                        <button class="nav-toggle" id="navToggle">
                            <i class="fa-solid fa-bars"></i>
                        </button>

                        <div class="nav-links">
                            <a href="${pageContext.request.contextPath}/ProductServlet?action=list"
                                class="nav-item">Shop</a>
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <a href="${pageContext.request.contextPath}/OrderServlet?action=my_orders"
                                        class="nav-item">Orders</a>
                                    <a href="${pageContext.request.contextPath}/CartServlet?action=view"
                                        class="nav-item" style="font-size: 1.1rem;">
                                        <i class="fa-solid fa-cart-shopping"></i>
                                        <span class="cart-count"
                                            style="background: var(--accent); color: white; padding: 2px 6px; border-radius: 10px; font-size: 0.75rem; vertical-align: top;">
                                            ${not empty sessionScope.cartSize ? sessionScope.cartSize : '0'}
                                        </span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/logout.jsp" class="nav-item"
                                        style="color: #ef4444;">Sign Out</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login.jsp" class="nav-item">Sign In</a>
                                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn-cta">Get
                                        Started</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </nav>

                <main style="padding-top: 140px; min-height: 80vh;">
                    <!-- Dynamic Header Section -->
                    <section class="container" style="margin-bottom: 60px;">
                        <c:choose>
                            <c:when test="${param.category == 'Cases'}">
                                <div class="glass-card"
                                    style="background: linear-gradient(135deg, rgba(255,107,107,0.1) 0%, rgba(255,142,83,0.1) 100%); padding: 80px 60px; border-radius: 40px; display: flex; align-items: center; justify-content: space-between;">
                                    <div>
                                        <span
                                            style="color: #FF6B6B; font-weight: 800; text-transform: uppercase; letter-spacing: 2px; font-size: 0.8rem;">Protection
                                            Redefined</span>
                                        <h1
                                            style="font-size: 4rem; font-weight: 800; margin: 15px 0; color: var(--primary);">
                                            Armor for your <span style="color: #FF6B6B;">Digital Life.</span></h1>
                                        <p style="color: var(--text-muted); max-width: 500px; font-size: 1.1rem;">
                                            Military-grade drop protection meets stunning Apple-inspired aesthetics.</p>
                                    </div>
                                    <i class="fa-solid fa-shield-halved fa-8x"
                                        style="color: rgba(255,107,107,0.1);"></i>
                                </div>
                            </c:when>
                            <c:when test="${param.category == 'Power'}">
                                <div class="glass-card"
                                    style="background: linear-gradient(135deg, rgba(13,130,70,0.1) 0%, rgba(32,178,170,0.1) 100%); padding: 80px 60px; border-radius: 40px; display: flex; align-items: center; justify-content: space-between;">
                                    <div>
                                        <span
                                            style="color: #0d8246; font-weight: 800; text-transform: uppercase; letter-spacing: 2px; font-size: 0.8rem;">Stay
                                            Energized</span>
                                        <h1
                                            style="font-size: 4rem; font-weight: 800; margin: 15px 0; color: var(--primary);">
                                            Infinite <span style="color: #0d8246;">Power.</span></h1>
                                        <p style="color: var(--text-muted); max-width: 500px; font-size: 1.1rem;">
                                            Ultra-fast GaN chargers and MagSafe peripherals for the power user.</p>
                                    </div>
                                    <i class="fa-solid fa-bolt-lightning fa-8x" style="color: rgba(13,130,70,0.1);"></i>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="text-align: center; margin-bottom: 60px;">
                                    <span
                                        style="color: var(--accent); font-weight: 800; text-transform: uppercase; letter-spacing: 2px; font-size: 0.8rem;">Curated
                                        Collection</span>
                                    <h1
                                        style="font-size: 3.5rem; font-weight: 800; margin: 15px 0; color: var(--primary);">
                                        ${empty param.category ? 'Global Catalog' : param.category}</h1>
                                    <div
                                        style="width: 60px; height: 4px; background: var(--accent); margin: 0 auto; border-radius: 10px;">
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </section>

                    <!-- Product Grid -->
                    <section class="container">
                        <c:if test="${empty products}">
                            <div style="text-align: center; padding: 100px 20px; color: var(--text-muted);">
                                <i class="fa-solid fa-magnifying-glass fa-3x"
                                    style="margin-bottom: 20px; opacity: 0.3;"></i>
                                <h3>No items found in this collection.</h3>
                                <a href="${pageContext.request.contextPath}/ProductServlet?action=list"
                                    class="btn-minimal" style="margin-top: 20px; display: inline-block;">Browse All</a>
                            </div>
                        </c:if>

                        <c:if test="${not empty products}">
                            <div class="product-grid">
                                <c:forEach var="p" items="${products}">
                                    <div class="minimal-card ${p.stock <= 0 ? 'out-of-stock' : ''}">
                                        <div class="card-img-container"
                                            onclick="location.href='ProductServlet?action=view&id=${p.id}'"
                                            style="cursor:pointer;">
                                            <div class="img-aspect-ratio">
                                                <img src="${not empty p.image ? p.image : 'images/placeholder.png'}"
                                                    onerror="this.src='images/placeholder.png'" alt="${p.name}">
                                            </div>
                                            <c:if test="${p.stock <= 0}">
                                                <div class="out-label">Sold Out</div>
                                            </c:if>
                                        </div>
                                        <div class="card-info">
                                            <span class="category-tag">${p.category}</span>
                                            <h3 class="product-title">${p.name}</h3>
                                            <div class="product-price">₹${p.price}</div>
                                            <div class="add-to-cart-overlay">
                                                <c:choose>
                                                    <c:when test="${p.stock > 0}">
                                                        <c:choose>
                                                            <c:when test="${not empty sessionScope.user}">
                                                                <button type="button" class="btn-minimal"
                                                                    onclick="addToCartAjax(this, '${p.id}', '${pageContext.request.contextPath}')">
                                                                    Add to Bag
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="button" class="btn-minimal"
                                                                    onclick="location.href='${pageContext.request.contextPath}/login.jsp'">
                                                                    Sign in to Buy
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn-minimal" disabled
                                                            style="opacity:0.5; cursor:not-allowed;">
                                                            Out of Stock
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                    </section>
                </main>

                <!-- Minimal Footer -->
                <footer style="background: var(--primary); color: white; padding: 100px 0 50px;">
                    <div class="container footer-grid">
                        <div class="footer-col">
                            <a href="#" class="nav-brand" style="margin-bottom: 25px;">ACCESSO<span>.in</span></a>
                            <p style="opacity: 0.6; line-height: 1.8;">The nexus of premium craftsmanship and functional
                                mobile technology.</p>
                        </div>
                        <div class="footer-col">
                            <h4 style="margin-bottom: 25px; font-size: 1rem;">Experience</h4>
                            <ul style="list-style: none; opacity: 0.6; line-height: 2;">
                                <li>Store Locator</li>
                                <li>ACCESSO Care</li>
                                <li>Sustainability</li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h4 style="margin-bottom: 25px; font-size: 1rem;">Legal</h4>
                            <ul style="list-style: none; opacity: 0.6; line-height: 2;">
                                <li>Privacy Policy</li>
                                <li>Terms of Use</li>
                                <li>Sales Policy</li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h4 style="margin-bottom: 25px; font-size: 1rem;">Social</h4>
                            <div style="display: flex; gap: 20px; font-size: 1.2rem; opacity: 0.8;">
                                <i class="fa-brands fa-instagram"></i>
                                <i class="fa-brands fa-twitter"></i>
                                <i class="fa-brands fa-dribbble"></i>
                            </div>
                        </div>
                    </div>
                    <div class="container"
                        style="margin-top: 80px; padding-top: 30px; border-top: 1px solid rgba(255,255,255,0.1); display: flex; justify-content: space-between; font-size: 0.8rem; opacity: 0.5;">
                        <p>&copy; 2026 ACCESSO.in Global.</p>
                        <p>Designed for the next generation.</p>
                    </div>
                </footer>

                <script src="${pageContext.request.contextPath}/js/script.js"></script>
            </body>

        </html>