<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery Portal | ACCESSO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Shared Dashboard Layout for minimal feel */
        .dashboard-layout { display: flex; min-height: 100vh; background: #FAFAFA; }
        .sidebar { 
            width: 280px; background: #FFFFFF; border-right: 1px solid #EEE; 
            padding: 40px 20px; position: fixed; height: 100vh;
            display: flex; flex-direction: column;
        }
        .main-content { flex: 1; margin-left: 280px; padding: 60px 80px; }
        
        .sidebar-brand { font-size: 1.8rem; font-weight: 800; margin-bottom: 50px; text-decoration: none; color: var(--primary); }
        .sidebar-brand span { color: var(--accent); }
        
        .nav-group { margin-bottom: 30px; }
        .nav-label { font-size: 0.75rem; text-transform: uppercase; color: #AAA; letter-spacing: 0.1em; margin-bottom: 15px; display: block; font-weight: 700; }
        .sidebar-link { 
            display: flex; align-items: center; gap: 12px; padding: 12px 15px;
            color: #555; text-decoration: none; border-radius: 12px; transition: var(--transition);
            font-weight: 600; margin-bottom: 5px;
        }
        .sidebar-link:hover, .sidebar-link.active { background: #F5F5F5; color: var(--primary); }
        .sidebar-link.active { background: var(--primary); color: white; }

        .delivery-card { background: white; padding: 30px; border-radius: 20px; border: 1px solid #EEE; margin-bottom: 25px; transition: var(--transition); }
        .delivery-card:hover { transform: translateY(-5px); box-shadow: var(--shadow-soft); }
        
        .loc-badge { background: #F0F4FF; color: #5A67D8; padding: 5px 12px; border-radius: 100px; font-size: 0.75rem; font-weight: 700; display: inline-flex; align-items: center; gap: 5px; }
    </style>
</head>
<body>

    <div class="dashboard-layout">
        <aside class="sidebar">
            <a href="${pageContext.request.contextPath}/index.jsp" class="sidebar-brand">
                ACCESSO<span>.in</span>
            </a>
            
            <div class="nav-group">
                <span class="nav-label">Deliveries</span>
                <a href="${pageContext.request.contextPath}/OrderServlet?action=delivery_list" class="sidebar-link active">
                    <i class="fa-solid fa-truck-fast"></i> Assigned Tasks
                </a>
                <a href="#" class="sidebar-link">
                    <i class="fa-solid fa-clock-rotate-left"></i> History
                </a>
            </div>
            
            <div style="margin-top: auto;">
                <div style="padding: 15px; background: #F9F9F9; border-radius: 15px; display: flex; align-items: center; gap: 12px; margin-bottom: 20px;">
                    <div style="width: 40px; height: 40px; background: var(--accent); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-weight: 800;">D</div>
                    <div>
                        <div style="font-weight: 700; font-size: 0.85rem;">${sessionScope.user.name}</div>
                        <div style="font-size: 0.75rem; color: #AAA;">Delivery Partner</div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout.jsp" class="sidebar-link" style="color: #FF4D4D;">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Sign Out
                </a>
            </div>
        </aside>

        <main class="main-content">
            <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 50px;">
                <h2 style="font-size: 2.2rem; font-weight: 800;">Partner Portal</h2>
                <div style="background: #EBF8FF; color: #2B6CB0; padding: 10px 18px; border-radius: 100px; font-weight: 700; font-size: 0.85rem; display: flex; align-items: center; gap: 8px;">
                    <i class="fa-solid fa-circle" style="font-size: 0.6rem;"></i> ACTIVE & ONLINE
                </div>
            </header>

            <section style="max-width: 900px;">
                <c:if test="${empty orders}">
                    <div style="text-align: center; padding: 100px 40px; background: white; border-radius: 30px; border: 1px solid #EEE;">
                        <i class="fa-solid fa-clipboard-check fa-4x" style="color: #EEE; margin-bottom: 25px;"></i>
                        <h3 style="font-size: 1.5rem; font-weight: 800; color: #111;">Everything's Delivered</h3>
                        <p style="color: #AAA; margin-bottom: 30px;">You are currently all caught up. Check back soon for new assignments.</p>
                        <button class="btn-minimal" style="padding: 12px 25px;" onclick="location.reload()">Check for Tasks</button>
                    </div>
                </c:if>

                <c:if test="${not empty orders}">
                    <div style="background: rgba(59, 130, 246, 0.1); border: 1px solid var(--accent); color: var(--accent); padding: 15px 25px; border-radius: 15px; margin-bottom: 30px; display: flex; align-items: center; justify-content: space-between;">
                        <span style="font-weight: 700;"><i class="fa-solid fa-bell"></i> New Tasks Available!</span>
                        <span style="font-size: 0.8rem; font-weight: 600;">Check details below and pick up your orders.</span>
                    </div>
                    
                    <h3 style="font-size: 1.3rem; font-weight: 800; margin-bottom: 30px;">Current Assignments</h3>
                    
                    <c:forEach var="order" items="${orders}">
                        <div class="delivery-card">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 25px;">
                                <div>
                                    <div style="font-size: 0.8rem; color: #AAA; text-transform: uppercase; font-weight: 700; letter-spacing: 1px; margin-bottom: 5px;">Order Reference</div>
                                    <h4 style="font-size: 1.6rem; font-weight: 800;">#ORD-${order.id}</h4>
                                    <div class="loc-badge" style="margin-top: 10px;">
                                        <i class="fa-solid fa-location-dot"></i> Checkpoint: ${order.latitude}, ${order.longitude}
                                    </div>
                                </div>
                                <div style="text-align: right;">
                                    <div style="font-size: 0.8rem; color: #AAA; margin-bottom: 5px;">Payment Collected</div>
                                    <div style="font-size: 1.5rem; font-weight: 800; color: var(--primary);">₹${order.totalPrice}</div>
                                    <div style="margin-top: 10px; font-weight: 700; font-size: 0.8rem; text-transform: uppercase; color: var(--accent);">${order.status}</div>
                                </div>
                            </div>
                            
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; padding-top: 25px; border-top: 1px solid #F5F5F5;">
                                <form action="${pageContext.request.contextPath}/OrderServlet" method="POST" style="margin:0;">
                                    <input type="hidden" name="action" value="update_status">
                                    <input type="hidden" name="orderId" value="${order.id}">
                                    <input type="hidden" name="status" value="shipped">
                                    <input type="hidden" name="from" value="delivery">
                                    <button type="submit" class="btn-minimal" style="width: 100%; border: 1px solid #EEE; background: white; color: #555;">
                                        <i class="fa-solid fa-truck-moving"></i> Set Transit Mode
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/OrderServlet" method="POST" style="margin:0;">
                                    <input type="hidden" name="action" value="update_status">
                                    <h3 style="font-weight: 800; margin: 0;">Order #ORD-${order.id}</h3>
                                    <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 5px;"><i class="fa-solid fa-location-dot"></i> Delivery Location</p>
                                </div>
                                <span class="badge" style="background: var(--accent); color: white; padding: 8px 15px; border-radius: 10px;">${order.status}</span>
                            </div>

                            <div style="display: flex; gap: 15px; margin-top: 30px;">
                                <c:choose>
                                    <c:when test="${order.status eq 'assigned'}">
                                        <form action="${pageContext.request.contextPath}/OrderServlet" method="POST" style="flex: 1;">
                                            <input type="hidden" name="action" value="update_status">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <input type="hidden" name="status" value="out for delivery">
                                            <input type="hidden" name="from" value="delivery">
                                            <button type="submit" class="btn-cta" style="width: 100%; justify-content: center; background: #3498DB;">
                                                <i class="fa-solid fa-truck"></i> Pick Up Order
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:when test="${order.status eq 'out for delivery'}">
                                        <form action="${pageContext.request.contextPath}/OrderServlet" method="POST" style="flex: 1;">
                                            <input type="hidden" name="action" value="update_status">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <input type="hidden" name="status" value="delivered">
                                            <input type="hidden" name="from" value="delivery">
                                            <button type="submit" class="btn-cta" style="width: 100%; justify-content: center; background: #00C851;">
                                                <i class="fa-solid fa-house-circle-check"></i> Mark Delivered
                                            </button>
                                        </form>
                                    </c:when>
                                </c:choose>
                                <a href="https://maps.google.com/?q=${order.latitude},${order.longitude}" target="_blank" class="btn-minimal" style="width: auto; padding: 0 20px; border: 1px solid #DDD; display: flex; align-items: center; justify-content: center;">
                                    <i class="fa-solid fa-map-location-dot" style="margin: 0;"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </section>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>