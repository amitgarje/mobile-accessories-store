<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>ACCESSO | Premium Mobile Accessories</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="css/style.css">

            <style>
                /* Embedded Premium UI Styles */
                :root {
                    --primary: #0f172a;
                    --accent: #3b82f6;
                    --bg-light: #ffffff;
                    --text-dark: #334155;
                    --text-muted: #64748b;
                    --radius-lg: 24px;
                    --radius-md: 16px;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background-color: var(--bg-light);
                    margin: 0;
                    padding: 0;
                    color: var(--primary);
                    overflow-x: hidden;
                }

                /* Glassmorphism Navbar */
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
                    transition: all 0.5s ease;
                }

                .nav-container {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    width: 100%;
                }

                .nav-glass.scrolled {
                    top: 15px;
                    left: 50%;
                    transform: translateX(-50%);
                    /* ✅ keep centered */

                    width: 90%;
                    max-width: 900px;
                    /* control size */

                    height: 65px;
                    border-radius: 40px;

                    background: rgba(255, 255, 255, 0.98);
                    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                    border: 1px solid rgba(255, 255, 255, 0.3);
                }

                .nav-glass.scrolled .nav-container {
                    padding: 0 30px;
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
                    margin-left: 2px;
                }

                /* Logo Dot Decor */
                .nav-brand::after {
                    content: '';
                    display: inline-block;
                    width: 6px;
                    height: 6px;
                    background: var(--accent);
                    border-radius: 50%;
                    margin-left: 4px;
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
                    position: relative;
                }

                .nav-item:hover {
                    color: #000;
                }

                /* Underline Effect */
                .nav-item::after {
                    content: '';
                    position: absolute;
                    bottom: -4px;
                    left: 0;
                    width: 0;
                    height: 2px;
                    background: var(--accent);
                    transition: width 0.3s;
                }

                .nav-item:hover::after {
                    width: 100%;
                }

                .btn-cta {
                    background: #000;
                    color: white !important;
                    padding: 10px 24px;
                    border-radius: 8px;
                    text-decoration: none;
                    font-weight: 700;
                    transition: all 0.3s;
                    display: inline-block;
                    border: none;
                    cursor: pointer;
                    font-size: 0.9rem;
                }

                .btn-cta:hover {
                    background: var(--accent);
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(59, 130, 246, 0.3);
                }

                /* Modern Hero Carousel */
                .hero-carousel {
                    position: relative;
                    height: 90vh;
                    width: 100%;
                    overflow: hidden;
                    margin-top: 0;
                    padding-top: 80px;
                }

                .carousel-container {
                    height: 100%;
                    display: flex;
                    transition: transform 0.6s cubic-bezier(0.25, 1, 0.5, 1);
                }

                .carousel-slide {
                    min-width: 100%;
                    height: 100%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 0 10%;
                    box-sizing: border-box;
                    gap: 80px;
                }

                .carousel-content {
                    flex: 1;
                    max-width: 500px;
                }

                .carousel-content h1 {
                    font-size: 4rem;
                    line-height: 1.1;
                    margin: 20px 0;
                    font-weight: 800;
                    letter-spacing: -1px;
                    color: black;
                }

                .carousel-content p {
                    font-size: 1.1rem;
                    color: #222;
                    line-height: 1.6;
                    margin-bottom: 30px;
                }

                .badge {
                    display: inline-block;
                    padding: 6px 14px;
                    border-radius: 20px;
                    font-size: 0.85rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 1.5px;
                }

                .carousel-image {
                    flex: 1;
                    text-align: right;
                }

                .carousel-image img {
                    max-width: 100%;
                    max-height: 60vh;
                    object-fit: contain;
                    border-radius: var(--radius-lg);
                    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                    animation: float 6s ease-in-out infinite;
                }

                @keyframes float {
                    0% {
                        transform: translateY(0px);
                    }

                    50% {
                        transform: translateY(-15px);
                    }

                    100% {
                        transform: translateY(0px);
                    }
                }

                /* Carousel Controls */
                .carousel-nav {
                    position: absolute;
                    bottom: 40px;
                    left: 50%;
                    transform: translateX(-50%);
                    display: flex;
                    gap: 10px;
                }

                .nav-dot {
                    width: 12px;
                    height: 12px;
                    border-radius: 50%;
                    background: rgba(0, 0, 0, 0.2);
                    border: none;
                    cursor: pointer;
                    transition: all 0.3s;
                }

                .nav-dot.active {
                    background: var(--primary);
                    width: 24px;
                    border-radius: 12px;
                }

                /* Offers & Grid Sections */
                .section-container {
                    padding: 80px 5%;
                    max-width: 1400px;
                    margin: 0 auto;
                }

                .section-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-end;
                    margin-bottom: 40px;
                }

                .section-header h2 {
                    font-size: 2.5rem;
                    font-weight: 800;
                    margin: 0 0 10px 0;
                }

                .section-header p {
                    margin: 0;
                    color: var(--text-muted);
                    font-size: 1.1rem;
                }

                /* Horizontal Scroller */
                .offers-scroller {
                    display: flex;
                    gap: 24px;
                    overflow-x: auto;
                    padding-bottom: 20px;
                    scroll-behavior: smooth;
                    -ms-overflow-style: none;
                    scrollbar-width: none;
                }

                .offers-scroller::-webkit-scrollbar {
                    display: none;
                }

                /* Product Cards */
                .product-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 30px;
                }

                .minimal-card {
                    background: white;
                    border-radius: var(--radius-lg);
                    overflow: hidden;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
                    transition: transform 0.3s, box-shadow 0.3s;
                    position: relative;
                    display: flex;
                    flex-direction: column;
                }

                .minimal-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
                }

                .minimal-card .img-wrapper {
                    height: 250px;
                    overflow: hidden;
                    background: #f1f5f9;
                    cursor: pointer;
                    padding: 20px;
                }

                .minimal-card .img-wrapper img {
                    width: 100%;
                    height: 100%;
                    object-fit: contain;
                    transition: transform 0.5s;
                    mix-blend-mode: multiply;
                }

                .minimal-card:hover .img-wrapper img {
                    transform: scale(1.08);
                }

                .minimal-card .info {
                    padding: 20px;
                    flex-grow: 1;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                }

                .minimal-card .title {
                    font-weight: 600;
                    font-size: 1.1rem;
                    margin-bottom: 8px;
                    color: var(--primary);
                }

                .minimal-card .price {
                    font-weight: 800;
                    font-size: 1.2rem;
                    color: var(--accent);
                }

                /* Hover Action Overlay */
                .add-to-cart-overlay {
                    padding: 0 20px 20px;
                }

                .add-to-cart-overlay button {
                    width: 100%;
                    padding: 12px;
                    border-radius: 12px;
                    border: 1px solid #e2e8f0;
                    background: white;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .add-to-cart-overlay button:hover:not([disabled]) {
                    background: var(--primary);
                    color: white;
                    border-color: var(--primary);
                }

                /* Footer */
                footer {
                    background: var(--primary);
                    color: white;
                    padding: 80px 5% 40px;
                    margin-top: 100px;
                }

                .footer-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 40px;
                    margin-bottom: 60px;
                }

                .footer-col h4 {
                    font-size: 1.2rem;
                    margin-bottom: 20px;
                }

                .footer-col ul {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                }

                .footer-col ul li {
                    margin-bottom: 12px;
                }

                .footer-col ul li a {
                    color: #cbd5e1;
                    text-decoration: none;
                    transition: color 0.2s;
                }

                .footer-col ul li a:hover {
                    color: white;
                }

                .footer-bottom {
                    text-align: center;
                    padding-top: 30px;
                    border-top: 1px solid rgba(255, 255, 255, 0.1);
                    color: #94a3b8;
                }

                @media (max-width: 768px) {
                    .carousel-slide {
                        flex-direction: column;
                        text-align: center;
                        padding: 0 5%;
                        gap: 20px;
                    }

                    .carousel-image {
                        margin-top: 20px;
                    }

                    .carousel-content h1 {
                        font-size: 2.5rem;
                    }

                    .section-header {
                        flex-direction: column;
                        align-items: flex-start;
                        gap: 15px;
                    }

                    .slider-controls {
                        align-self: flex-end;
                    }
                }

                /* ========== PREMIUM UI ANIMATIONS ========== */

                /* Scroll Reveal Base */
                .reveal {
                    opacity: 0;
                    transform: translateY(40px);
                    transition: opacity 0.7s cubic-bezier(0.16, 1, 0.3, 1), transform 0.7s cubic-bezier(0.16, 1, 0.3, 1);
                }

                .reveal.visible {
                    opacity: 1;
                    transform: translateY(0);
                }

                /* Product card: enhanced hover */
                .minimal-card {
                    transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.4s;
                }

                .minimal-card:hover {
                    transform: translateY(-10px) scale(1.01);
                    box-shadow: 0 24px 48px rgba(0, 0, 0, 0.1), 0 0 0 2px var(--accent);
                }

                .minimal-card .img-wrapper {
                    position: relative;
                }

                .minimal-card .img-wrapper::after {
                    content: '';
                    position: absolute;
                    inset: 0;
                    background: linear-gradient(135deg, rgba(255, 255, 255, 0.15) 0%, transparent 60%);
                    opacity: 0;
                    transition: opacity 0.4s;
                }

                .minimal-card:hover .img-wrapper::after {
                    opacity: 1;
                }

                /* Button ripple */
                .ripple-btn {
                    position: relative;
                    overflow: hidden;
                }

                .ripple-circle {
                    position: absolute;
                    border-radius: 50%;
                    transform: scale(0);
                    background: rgba(255, 255, 255, 0.4);
                    animation: rippleEffect 0.5s linear;
                    pointer-events: none;
                }

                @keyframes rippleEffect {
                    to {
                        transform: scale(4);
                        opacity: 0;
                    }
                }

                /* Hero gradient */
                .hero-carousel {
                    background: linear-gradient(135deg, #f0f4ff 0%, #fdf6ff 50%, #fff7ed 100%);
                }

                /* Floating particles */
                .hero-particles {
                    position: absolute;
                    inset: 0;
                    pointer-events: none;
                    z-index: 0;
                    overflow: hidden;
                }

                .particle {
                    position: absolute;
                    border-radius: 50%;
                    opacity: 0.3;
                    animation: particleFloat linear infinite;
                }

                @keyframes particleFloat {
                    0% {
                        transform: translateY(100vh) scale(0);
                        opacity: 0;
                    }

                    10% {
                        opacity: 0.3;
                    }

                    90% {
                        opacity: 0.15;
                    }

                    100% {
                        transform: translateY(-100px) scale(1.2);
                        opacity: 0;
                    }
                }

                /* Section heading animated underline */
                .section-header h2 {
                    position: relative;
                    display: inline-block;
                }

                .section-header h2::after {
                    content: '';
                    position: absolute;
                    bottom: -6px;
                    left: 0;
                    width: 0;
                    height: 3px;
                    background: linear-gradient(90deg, var(--accent), #6C63FF);
                    border-radius: 2px;
                    transition: width 1s cubic-bezier(0.16, 1, 0.3, 1);
                }

                .section-header h2.animated::after {
                    width: 60%;
                }

                /* Navbar link glow */
                .nav-item:hover {
                    text-shadow: 0 0 12px rgba(204, 153, 102, 0.4);
                }

                /* Cursor spotlight (desktop) */
                .cursor-spotlight {
                    position: fixed;
                    pointer-events: none;
                    width: 300px;
                    height: 300px;
                    border-radius: 50%;
                    background: radial-gradient(circle, rgba(204, 153, 102, 0.07) 0%, transparent 70%);
                    transform: translate(-50%, -50%);
                    transition: left 0.08s, top 0.08s;
                    z-index: 9999;
                    mix-blend-mode: multiply;
                }

                /* Offer card hover */
                .offer-card {
                    transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.4s !important;
                }

                .offer-card:hover {
                    transform: translateY(-8px) !important;
                    box-shadow: 0 20px 40px rgba(204, 153, 102, 0.2) !important;
                }

                /* Smooth page-in */
                @keyframes pageIn {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                body {
                    animation: pageIn 0.5s ease forwards;
                }
            </style>
        </head>

        <body data-is-logged-in="${not empty sessionScope.user}">

            <nav class="nav-glass" id="mainNavbar">
                <div class="nav-container">
                    <a href="${pageContext.request.contextPath}/ProductServlet?action=index" class="nav-brand">
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
                                <a href="${pageContext.request.contextPath}/CartServlet?action=view" class="nav-item"
                                    style="font-size: 1.1rem;">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                    <span id="cartCount"
                                        style="background: var(--accent); color: white; padding: 2px 6px; border-radius: 10px; font-size: 0.75rem; vertical-align: top;">
                                        ${not empty sessionScope.cartSize ? sessionScope.cartSize : '0'}
                                    </span>
                                </a>
                                <c:if test="${sessionScope.user.role == 'admin'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="nav-item"
                                        style="color:var(--accent);">Dashboard</a>
                                </c:if>
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

            <section class="hero-carousel">
                <div class="carousel-container" id="heroCarousel">
                    <div class="carousel-slide" style="background: #e0e7ff;">
                        <div class="carousel-content">
                            <div class="badge" style="background: #4f46e5; color: white;">New Arrival</div>
                            <h1>Elevate Your <br><span>Digital Life.</span></h1>
                            <p>Premium mobile accessories crafted for minimalists. Experience the perfect blend of
                                protection and aesthetics.</p>
                            <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="btn-cta">Shop
                                Collection</a>
                        </div>
                        <div class="carousel-image">
                            <img src="https://images.unsplash.com/photo-1603313011101-320f26a4f6f6?auto=format&fit=crop&q=80&w=800"
                                alt="Premium Case">
                        </div>
                    </div>
                    <div class="carousel-slide" style="background: #f3e8ff;">
                        <div class="carousel-content">
                            <div class="badge" style="background: #9333ea; color: white;">Audio Series</div>
                            <h1>Immersive <br><span>Soundscapes.</span></h1>
                            <p>Crystal clear highs and deep bass. Dive into your music with our next-generation wireless
                                earbuds.</p>
                            <a href="${pageContext.request.contextPath}/ProductServlet?action=list&category=Audio"
                                class="btn-cta">Explore Audio</a>
                        </div>
                        <div class="carousel-image">
                            <img src="https://www.beatsbydre.com/content/dam/beats/web/product/earbuds/solo-buds/pdp/product-carousel/matte-black/black-01-solobuds.jpg"
                                alt="Wireless Earbuds">
                        </div>
                    </div>
                    <div class="carousel-slide" style="background: #fff1f2;">
                        <div class="carousel-content">
                            <div class="badge" style="background: #e11d48; color: white;">Power Hub</div>
                            <h1>Unleash the <br><span>Power.</span></h1>
                            <p>Fast charging, zero clutter. MagSafe simplified for your busy lifestyle.</p>
                            <a href="${pageContext.request.contextPath}/ProductServlet?action=list&category=Power"
                                class="btn-cta">View Chargers</a>
                        </div>
                        <div class="carousel-image">
                            <img src="https://images.unsplash.com/photo-1615526675159-e248c3021d3f?auto=format&fit=crop&q=80&w=800"
                                alt="Wireless Charger">
                        </div>
                    </div>
                </div>
                <div class="carousel-nav" id="carouselDots">
                    <button class="nav-dot active" onclick="goToSlide(0)"></button>
                    <button class="nav-dot" onclick="goToSlide(1)"></button>
                    <button class="nav-dot" onclick="goToSlide(2)"></button>
                </div>
            </section>

            <section class="section-container">
                <div class="section-header">
                    <div>
                        <h2>Today's <span style="color: var(--accent);">Exclusive Offers</span></h2>
                        <p>Curated deals for our premium members.</p>
                    </div>
                    <div class="slider-controls" style="display: flex; gap: 10px;">
                        <button
                            onclick="document.getElementById('offersScroller').scrollBy({left: -350, behavior: 'smooth'})"
                            style="width: 45px; height: 45px; border-radius: 50%; border: 1px solid #cbd5e1; background: white; cursor: pointer;"><i
                                class="fa-solid fa-chevron-left"></i></button>
                        <button
                            onclick="document.getElementById('offersScroller').scrollBy({left: 350, behavior: 'smooth'})"
                            style="width: 45px; height: 45px; border-radius: 50%; border: 1px solid #cbd5e1; background: white; cursor: pointer;"><i
                                class="fa-solid fa-chevron-right"></i></button>
                    </div>
                </div>

                <div class="offers-scroller" id="offersScroller">
                    <div class="minimal-card" style="min-width: 300px;">
                        <div class="img-wrapper"><img
                                src="data:image/jpeg;base64,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"
                                alt="Leather Case"></div>
                        <div class="info">
                            <div class="title">Premium Leather Case</div>
                            <div class="price">₹1,299</div>
                        </div>
                    </div>
                    <div class="minimal-card" style="min-width: 300px;">
                        <div class="img-wrapper"><img
                                src="https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&q=80&w=400"
                                alt="Earbuds"></div>
                        <div class="info">
                            <div class="title">Silk White Earbuds</div>
                            <div class="price">₹4,999</div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="section-container" style="padding-top: 20px;">
                <div class="section-header">
                    <div>
                        <h2>Trending Now</h2>
                        <p>The most loved accessories this season.</p>
                    </div>
                </div>

                <div class="product-grid" id="featuredProducts">
                    <!-- Static Trendsetters -->
                    <div class="minimal-card">
                        <div class="img-wrapper"><img
                                src="https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQr0PM2LCzQDM3Xde4Nk9GB8zjmv4pLlRD3HJTHM-t1mgD3JsrUrcNWxa2zuCARx4WtSeJu91BVS7y-OSF8pZA1se9mAR2Sobilke8IVkvZy9--lqujZmZ4F4s"
                                alt="Earbuds"></div>
                        <div class="info">
                            <div class="title">Studio Buds X</div>
                            <div class="price">₹12,499</div>
                        </div>
                    </div>
                    <div class="minimal-card">
                        <div class="img-wrapper"><img
                                src="https://images.unsplash.com/photo-1592890288564-76628a30a657?auto=format&q=80&w=400"
                                alt="Case"></div>
                        <div class="info">
                            <div class="title">Clear MagSafe Case</div>
                            <div class="price">₹2,499</div>
                        </div>
                    </div>
                    <div class="minimal-card">
                        <div class="img-wrapper"><img
                                src="https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?auto=format&q=80&w=400"
                                alt="Charger"></div>
                        <div class="info">
                            <div class="title">Fast Charging Dock</div>
                            <div class="price">₹3,999</div>
                        </div>
                    </div>
                    <div class="minimal-card">
                        <div class="img-wrapper"><img
                                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP5Tt8yf4Blsmu_Lzk-HBBCE5zZosii1eREw&s"
                                alt="Audio"></div>
                        <div class="info">
                            <div class="title">Premium Audio Cable</div>
                            <div class="price">₹899</div>
                        </div>
                    </div>
                </div>
            </section>

            <footer>
                <div class="section-container" style="padding: 0; max-width: 1200px;">
                    <div class="footer-grid">
                        <div class="footer-col">
                            <a href="index.jsp" class="nav-brand"
                                style="color: white; margin-bottom: 25px; display: inline-block;">
                                ACCESSO<span style="color: var(--accent);">.in</span>
                            </a>
                            <p style="color: #cbd5e1; line-height: 1.6;">Redefining mobile aesthetics with premium
                                materials and minimal design. Join the ACCESSO community.</p>
                            <div style="display: flex; gap: 20px; margin-top: 30px; font-size: 1.5rem;">
                                <a href="#" style="color: white;"><i class="fa-brands fa-instagram"></i></a>
                                <a href="#" style="color: white;"><i class="fa-brands fa-twitter"></i></a>
                                <a href="#" style="color: white;"><i class="fa-brands fa-youtube"></i></a>
                            </div>
                        </div>
                        <div class="footer-col">
                            <h4>Collections</h4>
                            <ul>
                                <li><a href="#">iPhone Series</a></li>
                                <li><a href="#">Android Core</a></li>
                                <li><a href="#">Audio Elite</a></li>
                                <li><a href="#">Power Hub</a></li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h4>Support</h4>
                            <ul>
                                <li><a href="#">Shipping Policy</a></li>
                                <li><a href="#">Returns</a></li>
                                <li><a href="#">Contact Support</a></li>
                                <li><a href="#">Track Order</a></li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h4>Newsletter</h4>
                            <p style="color: #cbd5e1; margin-bottom: 20px;">Join for early access and exclusive drops.
                            </p>
                            <div style="display: flex; gap: 10px;">
                                <input type="email" placeholder="Email address"
                                    style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); padding: 12px; border-radius: 8px; color: white; flex-grow: 1;">
                                <button
                                    style="padding: 0 20px; background: var(--accent); color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">Join</button>
                            </div>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>&copy; 2026 ACCESSO Electronics. All rights reserved.</p>
                    </div>
                </div>
            </footer>

            <script src="js/script.js"></script>
            <script>
                // --- Carousel Logic (Fixed) ---
                let currentSlide = 0;
                const totalSlides = 3;
                const container = document.getElementById('heroCarousel');
                const dots = document.querySelectorAll('.nav-dot');

                function goToSlide(index) {
                    currentSlide = index;
                    container.style.transform = `translateX(-${index * 100}%)`;
                    dots.forEach((dot, i) => {
                        dot.classList.toggle('active', i === index);
                    });
                }

                // Auto-advance carousel
                setInterval(() => {
                    let nextSlide = (currentSlide + 1) % totalSlides;
                    goToSlide(nextSlide);
                }, 5000);

                // Scroll management for professional navbar
                window.addEventListener('scroll', () => {
                    const nav = document.getElementById('mainNavbar');
                    if (window.scrollY > 20) {
                        nav.classList.add('scrolled');
                    } else {
                        nav.classList.remove('scrolled');
                    }
                });

                document.addEventListener('DOMContentLoaded', () => {
                    fetch('${pageContext.request.contextPath}/ProductServlet?action=api_list&limit=8')
                        .then(res => res.json())
                        .then(products => {
                            const grid = document.getElementById('featuredProducts');
                            grid.innerHTML = '';

                            const isLoggedIn = document.body.dataset.isLoggedIn === 'true';

                            products.forEach((p, idx) => {
                                const card = document.createElement('div');
                                card.className = 'minimal-card';

                                card.innerHTML = `
                            <div class="img-wrapper" onclick="location.href='ProductServlet?action=view&id=\${p.id}'">
                                <img src="\${p.image || 'https://images.unsplash.com/photo-1584006682522-dc17d6c0d06c?auto=format&fit=crop&q=80&w=400'}" 
                                     onerror="this.src='https://images.unsplash.com/photo-1584006682522-dc17d6c0d06c?auto=format&fit=crop&q=80&w=400'" 
                                     alt="\${p.name}">
                            </div>
                            <div class="info">
                                <div class="title">\${p.name}</div>
                                <div class="price">₹\${Number(p.price).toLocaleString('en-IN')}</div>
                            </div>
                            <div class="add-to-cart-overlay">
                                \${p.stock > 0 ? 
                                    (isLoggedIn ? 
                                    \`<button type="button" onclick="addToCartAjax(this, '\${p.id}', '${pageContext.request.contextPath}')">Add to Cart</button>\` : 
                                    \`<button onclick="location.href='login.jsp'">Sign in to Buy</button>\`) : 
                                    \`<button style="background:#f1f5f9; color:#94a3b8; border-color:#e2e8f0;" disabled>Out of Stock</button>\`
                                }
                            </div>
                        `;
                                grid.appendChild(card);

                                // Populate the offers scroller with the top 5
                                if (idx < 5) {
                                    const offerCard = card.cloneNode(true);
                                    const btn = offerCard.querySelector('button');
                                    if (btn && isLoggedIn && p.stock > 0) {
                                        btn.onclick = function () { addToCartAjax(this, p.id, '${pageContext.request.contextPath}'); };
                                    } else if (btn && !isLoggedIn) {
                                        btn.onclick = function () { location.href = 'login.jsp'; };
                                    }
                                    document.getElementById('offersScroller').appendChild(offerCard);
                                }
                            });

                            // Remove initial fallback scroller items once API loads
                            const scroller = document.getElementById('offersScroller');
                            if (scroller.children.length > 2) {
                                scroller.removeChild(scroller.children[0]);
                                scroller.removeChild(scroller.children[0]);
                            }
                        })
                        .catch(err => console.error("Error loading products:", err));
                });
            </script>
        </body>

        </html>