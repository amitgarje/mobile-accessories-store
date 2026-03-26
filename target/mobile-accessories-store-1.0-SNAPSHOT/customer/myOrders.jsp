<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | ACCESSO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root { --primary: #0f172a; --accent: #3b82f6; --bg-light: #f8fafc; --text-muted: #64748b; }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', 'Segoe UI', sans-serif; background: var(--bg-light); color: var(--primary); }

        /* Navbar */
        .nav-glass {
            position: fixed; top: 20px; left: 50%; transform: translateX(-50%);
            width: auto; min-width: 600px; max-width: 900px; height: 70px; padding: 0 30px;
            display: flex; align-items: center; justify-content: center;
            background: rgba(255,255,255,0.92); backdrop-filter: blur(12px);
            border-radius: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); z-index: 1000;
        }
        .nav-container { display: flex; align-items: center; justify-content: center; gap: 40px; }
        .nav-brand { font-size: 1.6rem; font-weight: 900; text-decoration: none; color: #000; }
        .nav-brand span { color: var(--accent); }
        .nav-links { display: flex; gap: 25px; align-items: center; }
        .nav-item { text-decoration: none; color: #444; font-weight: 600; font-size: 0.95rem; transition: 0.2s; }
        .nav-item:hover { color: #000; }
        .btn-cta { background: #000; color: white !important; padding: 10px 24px; border-radius: 8px; text-decoration: none; font-weight: 700; font-size: 0.9rem; }

        /* Order Card */
        .order-card {
            background: white; border-radius: 20px; border: 1px solid #EAEAEA;
            margin-bottom: 28px; overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .order-card:hover { transform: translateY(-4px); box-shadow: 0 16px 40px rgba(0,0,0,0.07); }

        .order-header {
            background: #FAFAFA; padding: 22px 32px; border-bottom: 1px solid #EAEAEA;
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px;
        }
        .header-item span { font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.08em; color: #AAA; font-weight: 700; display: block; margin-bottom: 4px; }
        .header-item div { font-weight: 700; font-size: 0.9rem; }

        .order-body { display: flex; gap: 30px; padding: 28px 32px; }

        /* Status Badge */
        .status-badge {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 6px 14px; border-radius: 100px;
            font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em;
        }
        .status-pending   { background: #FFF7ED; color: #D97706; }
        .status-approved  { background: #EFF6FF; color: #2563EB; }
        .status-assigned  { background: #F5F3FF; color: #7C3AED; }
        .status-delivered  { background: #ECFDF5; color: #059669; }
        .status-cancelled { background: #FEF2F2; color: #DC2626; }

        /* Order Timeline Track */
        .order-timeline {
            display: flex; align-items: center; gap: 0;
            margin: 18px 0; width: 100%;
        }
        .tl-step {
            display: flex; flex-direction: column; align-items: center;
            flex: 1; position: relative;
        }
        .tl-step:not(:last-child)::after {
            content: ''; position: absolute; top: 13px; left: calc(50% + 13px);
            width: calc(100% - 26px); height: 2px;
            background: #E5E7EB; z-index: 0;
        }
        .tl-step.done:not(:last-child)::after { background: #10B981; }
        .tl-dot {
            width: 26px; height: 26px; border-radius: 50%;
            background: #E5E7EB; border: 2px solid #FFF;
            display: flex; align-items: center; justify-content: center;
            font-size: 0.6rem; color: white; font-weight: 800;
            z-index: 1; transition: background 0.4s;
        }
        .tl-step.done .tl-dot { background: #10B981; }
        .tl-step.active .tl-dot { background: #3B82F6; box-shadow: 0 0 0 4px rgba(59,130,246,0.2); }
        .tl-label { font-size: 0.7rem; font-weight: 700; color: #AAA; margin-top: 6px; text-align: center; }
        .tl-step.done .tl-label, .tl-step.active .tl-label { color: #111; }

        /* Address display */
        .delivery-address {
            background: #F8FAFF; border: 1px solid #DBEAFE; border-radius: 12px;
            padding: 12px 16px; font-size: 0.82rem; color: #334155; margin-top: 12px; line-height: 1.6;
        }
        .delivery-address strong { color: #1D4ED8; display: block; margin-bottom: 2px; font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.05em; }

        /* Items list */
        .item-row { display: flex; align-items: center; gap: 10px; margin-bottom: 10px; }
        .item-img { width: 40px; height: 40px; border-radius: 8px; object-fit: cover; background: #F4F4F8; }
        .item-name { font-size: 0.84rem; font-weight: 600; }
        .item-qty { font-size: 0.78rem; color: #AAA; }

        /* Cancel button */
        .btn-cancel {
            width: 100%; padding: 10px; border-radius: 10px; border: 1px solid rgba(220,38,38,0.2);
            background: white; color: #DC2626; font-weight: 700; font-size: 0.82rem;
            cursor: pointer; margin-top: 10px; transition: 0.2s;
        }
        .btn-cancel:hover { background: #FEF2F2; }

        .empty-box { text-align: center; padding: 100px 20px; }
        .empty-box i { font-size: 4rem; opacity: 0.1; display: block; margin-bottom: 30px; }
    </style>
</head>
<body>

    <nav class="nav-glass" id="mainNavbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="nav-brand">ACCESSO<span>.in</span></a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="nav-item">Shop</a>
                <a href="${pageContext.request.contextPath}/CartServlet?action=view" class="nav-item">
                    <i class="fa-solid fa-cart-shopping"></i>
                </a>
                <a href="${pageContext.request.contextPath}/logout.jsp" class="nav-item" style="color:#ef4444; margin-left:10px;">Sign Out</a>
            </div>
        </div>
    </nav>

    <main class="container" style="padding-top: 150px; padding-bottom: 100px; max-width: 1000px; margin: 0 auto;">
        <header style="margin-bottom: 50px;">
            <h1 style="font-size: 2.8rem; font-weight: 800;">My Orders</h1>
            <p style="color: var(--text-muted); margin-top: 8px;">Track and manage your purchases.</p>
        </header>

        <c:if test="${not empty param.msg}">
            <div style="background: rgba(16,185,129,0.1); color: #059669; padding: 15px 20px; border-radius: 12px; margin-bottom: 30px; font-weight: 700; border: 1px solid rgba(16,185,129,0.2);">
                <i class="fa-solid fa-circle-check"></i>&nbsp;${param.msg}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-box">
                    <i class="fa-solid fa-box-open"></i>
                    <h2 style="font-weight: 800; color: #111;">No orders yet.</h2>
                    <p style="color: #AAA; margin-top: 10px 0 40px;">Your journey starts here.</p>
                    <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="btn-cta" style="margin-top:30px; display:inline-block;">Explore Collection</a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="order" items="${orders}">
                    <div class="order-card">
                        <!-- Header -->
                        <div class="order-header">
                            <div class="header-item">
                                <span>Order Placed</span>
                                <div>${order.createdAt}</div>
                            </div>
                            <div class="header-item">
                                <span>Total</span>
                                <div style="color: #3B82F6;">₹${order.totalPrice}</div>
                            </div>
                            <div class="header-item">
                                <span>Status</span>
                                <div>
                                    <span class="status-badge
                                        ${order.status == 'delivered'  ? 'status-delivered'  :
                                          order.status == 'cancelled'  ? 'status-cancelled'  :
                                          order.status == 'assigned'   ? 'status-assigned'   :
                                          order.status == 'approved'   ? 'status-approved'   : 'status-pending'}">
                                        ${order.status}
                                    </span>
                                </div>
                            </div>
                            <div class="header-item" style="text-align:right;">
                                <span>Reference</span>
                                <div>#ORD-${order.id}</div>
                            </div>
                        </div>

                        <!-- Body -->
                        <div class="order-body">
                            <!-- Left: timeline + address -->
                            <div style="flex: 1; min-width: 0;">
                                <div style="font-size: 0.78rem; font-weight: 700; color: #AAA; text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 10px;">Delivery Progress</div>

                                <!-- Timeline -->
                                <div class="order-timeline">
                                    <%-- Placed --%>
                                    <div class="tl-step done">
                                        <div class="tl-dot"><i class="fa-solid fa-check"></i></div>
                                        <span class="tl-label">Placed</span>
                                    </div>
                                    <%-- Approved --%>
                                    <div class="tl-step ${order.status == 'approved' || order.status == 'assigned' || order.status == 'out for delivery' || order.status == 'delivered' ? 'done' : ''}">
                                        <div class="tl-dot"><i class="fa-solid fa-check"></i></div>
                                        <span class="tl-label">Approved</span>
                                    </div>
                                    <%-- Dispatched --%>
                                    <div class="tl-step ${order.status == 'assigned' || order.status == 'out for delivery' || order.status == 'delivered' ? 'done' : (order.status == 'approved' ? 'active' : '')}">
                                        <div class="tl-dot"><i class="fa-solid fa-motorcycle"></i></div>
                                        <span class="tl-label">Dispatched</span>
                                    </div>
                                    <%-- Out for delivery --%>
                                    <div class="tl-step ${order.status == 'out for delivery' || order.status == 'delivered' ? 'done' : (order.status == 'assigned' ? 'active' : '')}">
                                        <div class="tl-dot"><i class="fa-solid fa-truck"></i></div>
                                        <span class="tl-label">Out for Delivery</span>
                                    </div>
                                    <%-- Delivered --%>
                                    <div class="tl-step ${order.status == 'delivered' ? 'done' : (order.status == 'out for delivery' ? 'active' : '')}">
                                        <div class="tl-dot"><i class="fa-solid fa-house"></i></div>
                                        <span class="tl-label">Delivered</span>
                                    </div>
                                </div>

                                <!-- Delivery Address -->
                                <c:if test="${not empty order.deliveryAddress}">
                                    <div class="delivery-address">
                                        <strong>Delivery Address</strong>
                                        ${order.deliveryAddress}
                                    </div>
                                </c:if>

                                <c:if test="${not empty order.assignedTo}">
                                    <div style="margin-top: 12px; font-size: 0.8rem; color: #7C3AED; font-weight: 700;">
                                        <i class="fa-solid fa-motorcycle"></i>&nbsp; Assigned to: ${order.assignedTo}
                                    </div>
                                </c:if>
                                <c:if test="${not empty order.estimatedDelivery}">
                                    <div style="margin-top: 6px; font-size: 0.8rem; color: #555; font-weight: 600;">
                                        <i class="fa-regular fa-calendar"></i>&nbsp; Est. Arrival: ${order.estimatedDelivery}
                                    </div>
                                </c:if>
                            </div>

                            <!-- Right: items + cancel -->
                            <div style="width: 240px; flex-shrink: 0;">
                                <div style="font-size: 0.78rem; font-weight: 700; color: #AAA; text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 12px;">Items</div>

                                <c:choose>
                                    <c:when test="${not empty order.items}">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="item-row">
                                                <img src="${not empty item.product.image ? item.product.image : 'https://via.placeholder.com/40'}"
                                                     class="item-img"
                                                     onerror="this.src='https://via.placeholder.com/40'">
                                                <div>
                                                    <div class="item-name">${item.product.name}</div>
                                                    <div class="item-qty">Qty: ${item.quantity}</div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p style="font-size:0.8rem; color:#CCC;">No item details.</p>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Cancel button — only for pending or approved -->
                                <c:if test="${order.status == 'pending' || order.status == 'approved'}">
                                    <form action="${pageContext.request.contextPath}/OrderServlet" method="POST">
                                        <input type="hidden" name="action" value="update_status">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <input type="hidden" name="status" value="cancelled">
                                        <button type="submit" class="btn-cancel" onclick="return confirm('Cancel this order?')">
                                            <i class="fa-solid fa-xmark"></i> Cancel Order
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </main>

    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
