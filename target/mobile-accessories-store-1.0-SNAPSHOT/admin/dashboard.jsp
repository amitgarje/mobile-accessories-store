<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="model.User, model.Order, model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | ACCESSO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', 'Segoe UI', sans-serif; background: #F8F9FA; }
        
        .dashboard-layout { display: flex; min-height: 100vh; }
        
        /* Sidebar */
        .sidebar {
            width: 260px; background: #fff; border-right: 1px solid #EAEAEA;
            padding: 35px 18px; position: fixed; height: 100vh;
            display: flex; flex-direction: column; z-index: 100;
        }
        .sidebar-brand { font-size: 1.6rem; font-weight: 900; text-decoration: none; color: #111; margin-bottom: 40px; display: block; }
        .sidebar-brand span { color: #6C63FF; }
        .nav-label { font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.12em; color: #AAA; font-weight: 700; margin: 20px 0 8px; display: block; }
        .sidebar-link {
            display: flex; align-items: center; gap: 10px; padding: 11px 14px;
            color: #555; text-decoration: none; border-radius: 10px;
            font-weight: 600; font-size: 0.88rem; margin-bottom: 4px; transition: 0.2s;
        }
        .sidebar-link:hover { background: #F4F4F8; color: #111; }
        .sidebar-link.active { background: #6C63FF; color: #fff; }
        .sidebar-link i { width: 18px; text-align: center; }
        .sidebar-footer { margin-top: auto; }
        
        /* Main */
        .main-content { flex: 1; margin-left: 260px; padding: 50px 60px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .page-header h1 { font-size: 1.8rem; font-weight: 800; color: #111; }
        .admin-badge { background: #EEF0FF; color: #6C63FF; padding: 8px 16px; border-radius: 100px; font-size: 0.8rem; font-weight: 700; }

        /* Stat Cards */
        .stat-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 50px; }
        .stat-card { background: #fff; padding: 24px; border-radius: 16px; border: 1px solid #EAEAEA; }
        .stat-card .label { font-size: 0.78rem; color: #999; font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 10px; }
        .stat-card .big-num { font-size: 2rem; font-weight: 800; color: #111; }
        .stat-card .sub { font-size: 0.8rem; color: #AAA; margin-top: 4px; }
        .stat-card.accent .big-num { color: #6C63FF; }
        .stat-card.green .big-num { color: #10B981; }
        .stat-card.red .big-num { color: #EF4444; }

        /* Section */
        .section-title { font-size: 1.1rem; font-weight: 800; color: #111; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .badge-count { background: #6C63FF; color: white; font-size: 0.7rem; padding: 2px 8px; border-radius: 100px; font-weight: 700; }

        /* Orders Table */
        .orders-wrapper { background: #fff; border: 1px solid #EAEAEA; border-radius: 18px; overflow: hidden; margin-bottom: 50px; }
        .orders-table { width: 100%; border-collapse: collapse; }
        .orders-table th { background: #F9F9FB; padding: 14px 20px; text-align: left; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.08em; color: #999; font-weight: 700; border-bottom: 1px solid #EAEAEA; }
        .orders-table td { padding: 18px 20px; border-bottom: 1px solid #F4F4F8; vertical-align: top; }
        .orders-table tr:last-child td { border-bottom: none; }
        .orders-table tr:hover td { background: #FAFAFA; }
        
        .order-id { font-weight: 800; font-size: 1rem; color: #111; }
        .order-amount { font-weight: 800; color: #6C63FF; font-size: 0.95rem; }
        .order-date { font-size: 0.78rem; color: #999; margin-top: 3px; }
        
        /* Customer */
        .customer-name { font-weight: 700; font-size: 0.9rem; color: #111; }
        .customer-email { font-size: 0.78rem; color: #999; margin-top: 3px; }

        /* Status Pill */
        .status-pill { display: inline-block; padding: 4px 12px; border-radius: 100px; font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; }
        .status-pending { background: #FFF7ED; color: #D97706; }
        .status-approved { background: #EFF6FF; color: #2563EB; }
        .status-assigned { background: #F5F3FF; color: #7C3AED; }
        .status-delivered { background: #ECFDF5; color: #059669; }
        .status-cancelled { background: #FEF2F2; color: #DC2626; }
        .status-shipped, .status-out { background: #F0FDF4; color: #16A34A; }

        /* Order Items inside table */
        .item-list { margin-top: 10px; }
        .item-row { display: flex; align-items: center; gap: 8px; margin-bottom: 6px; }
        .item-img { width: 28px; height: 28px; border-radius: 6px; object-fit: cover; background: #F4F4F8; }
        .item-name { font-size: 0.8rem; color: #555; }
        .item-qty { font-weight: 700; color: #6C63FF; font-size: 0.8rem; }

        /* Action column */
        .action-form { display: flex; flex-direction: column; gap: 8px; }
        .btn-approve { background: #10B981; color: white; border: none; padding: 9px 16px; border-radius: 8px; font-weight: 700; font-size: 0.8rem; cursor: pointer; transition: 0.2s; width: 100%; }
        .btn-approve:hover { background: #059669; }
        .btn-assign { background: #6C63FF; color: white; border: none; padding: 9px 16px; border-radius: 8px; font-weight: 700; font-size: 0.8rem; cursor: pointer; transition: 0.2s; width: 100%; }
        .btn-assign:hover { background: #5B52E8; }
        select.rider-select { width: 100%; padding: 8px 12px; border: 1px solid #DDD; border-radius: 8px; font-size: 0.8rem; font-family: inherit; color: #333; outline: none; }
        
        /* Empty state */
        .empty-state { text-align: center; padding: 80px 40px; }
        .empty-state i { font-size: 3rem; color: #DDD; margin-bottom: 20px; display: block; }
        .empty-state h3 { font-size: 1.2rem; color: #555; font-weight: 700; }
        .empty-state p { color: #AAA; margin-top: 8px; font-size: 0.9rem; }

        /* Stock Alert */
        .stock-table { width: 100%; border-collapse: collapse; }
        .stock-table th { background: #FFF7ED; padding: 12px 18px; text-align: left; font-size: 0.75rem; text-transform: uppercase; color: #D97706; font-weight: 700; border-bottom: 1px solid #FED7AA; }
        .stock-table td { padding: 14px 18px; font-size: 0.85rem; border-bottom: 1px solid #FEF3C7; }
        .stock-table tr:last-child td { border-bottom: none; }
        .stock-level { font-weight: 800; }
        .stock-level.low { color: #DC2626; }
        .stock-level.medium { color: #D97706; }
    </style>
</head>
<body>

<%
    // Session Guard
    User adminUser = (User) session.getAttribute("user");
    if (adminUser == null || !"admin".equals(adminUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    List<Order> orderList = (List<Order>) request.getAttribute("orders");
    if (orderList == null) orderList = new ArrayList<>();
    
    List<User> deliveryBoyList = (List<User>) request.getAttribute("deliveryBoys");
    if (deliveryBoyList == null) deliveryBoyList = new ArrayList<>();
    
    List<Product> lowStockList = (List<Product>) request.getAttribute("lowStockProducts");
    if (lowStockList == null) lowStockList = new ArrayList<>();
    
    double totalRevenue = request.getAttribute("totalRevenue") != null ? (Double) request.getAttribute("totalRevenue") : 0.0;
    
    int pendingCount = 0, approvedCount = 0;
    for (Order o : orderList) {
        if ("pending".equals(o.getStatus())) pendingCount++;
        else if ("approved".equals(o.getStatus())) approvedCount++;
    }
    
    pageContext.setAttribute("orderList", orderList);
    pageContext.setAttribute("deliveryBoyList", deliveryBoyList);
    pageContext.setAttribute("lowStockList", lowStockList);
    pageContext.setAttribute("totalRevenue", totalRevenue);
    pageContext.setAttribute("pendingCount", pendingCount);
    pageContext.setAttribute("approvedCount", approvedCount);
    pageContext.setAttribute("adminName", adminUser.getName());
%>

<div class="dashboard-layout">
    <!-- Sidebar -->
    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/OrderServlet?action=admin_list" class="sidebar-brand">
            ACCESSO<span>.in</span>
        </a>
        
        <span class="nav-label">Main</span>
        <a href="${pageContext.request.contextPath}/OrderServlet?action=admin_list" class="sidebar-link active">
            <i class="fa-solid fa-house"></i> Overview
        </a>
        <a href="${pageContext.request.contextPath}/OrderServlet?action=admin_list" class="sidebar-link">
            <i class="fa-solid fa-box"></i> Orders
        </a>
        
        <span class="nav-label">Catalogue</span>
        <a href="${pageContext.request.contextPath}/ProductServlet?action=list" class="sidebar-link">
            <i class="fa-solid fa-tags"></i> Products
        </a>
        
        <div class="sidebar-footer">
            <div style="padding: 14px; background: #F4F4F8; border-radius: 12px; display: flex; align-items: center; gap: 12px; margin-bottom: 12px;">
                <div style="width: 36px; height: 36px; background: #6C63FF; border-radius: 9px; display:flex; align-items:center; justify-content:center; color:white; font-weight:800; font-size:0.9rem;">A</div>
                <div>
                    <div style="font-weight: 700; font-size: 0.85rem;">${adminName}</div>
                    <div style="font-size: 0.72rem; color: #AAA;">Administrator</div>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/logout.jsp" class="sidebar-link" style="color: #EF4444;">
                <i class="fa-solid fa-arrow-right-from-bracket"></i> Sign Out
            </a>
        </div>
    </aside>

    <!-- Main -->
    <main class="main-content">
        <div class="page-header">
            <h1>Dashboard Overview</h1>
            <div class="admin-badge"><i class="fa-solid fa-shield-halved"></i> Admin</div>
        </div>

        <!-- Stat Cards -->
        <div class="stat-grid">
            <div class="stat-card">
                <div class="label">Total Orders</div>
                <div class="big-num">${orderList.size()}</div>
                <div class="sub">All time</div>
            </div>
            <div class="stat-card green">
                <div class="label">Revenue</div>
                <div class="big-num">₹<c:out value="${String.format('%.0f', totalRevenue)}" default="${totalRevenue}"/></div>
                <div class="sub">Excluding cancelled</div>
            </div>
            <div class="stat-card accent">
                <div class="label">Pending Approval</div>
                <div class="big-num">${pendingCount}</div>
                <div class="sub">Need action</div>
            </div>
            <div class="stat-card">
                <div class="label">Delivery Partners</div>
                <div class="big-num">${deliveryBoyList.size()}</div>
                <div class="sub">Available</div>
            </div>
        </div>

        <!-- Orders Table -->
        <div class="section-title">
            Customer Orders 
            <c:if test="${pendingCount > 0}">
                <span class="badge-count">${pendingCount} pending</span>
            </c:if>
        </div>

        <div class="orders-wrapper">
            <c:choose>
                <c:when test="${empty orderList}">
                    <div class="empty-state">
                        <i class="fa-solid fa-inbox"></i>
                        <h3>No orders yet</h3>
                        <p>Customer orders will appear here once they are placed.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="orders-table">
                        <thead>
                            <tr>
                                <th>Order</th>
                                <th>Customer</th>
                                <th>Items Ordered</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <!-- Order ID + Amount -->
                                    <td>
                                        <div class="order-id">#ORD-${order.id}</div>
                                        <div class="order-amount">₹${order.totalPrice}</div>
                                        <div class="order-date">${order.createdAt}</div>
                                    </td>
                                    
                                    <!-- Customer Info -->
                                    <td>
                                        <div class="customer-name">
                                            <i class="fa-solid fa-user" style="color:#CCC; margin-right:5px;"></i>
                                            <c:choose>
                                                <c:when test="${not empty order.customerName}">${order.customerName}</c:when>
                                                <c:otherwise>User #${order.userId}</c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="customer-email">${order.customerEmail}</div>
                                    </td>
                                    
                                    <!-- Items -->
                                    <td>
                                        <div class="item-list">
                                            <c:choose>
                                                <c:when test="${not empty order.items}">
                                                    <c:forEach var="item" items="${order.items}">
                                                        <div class="item-row">
                                                            <img src="${not empty item.product.image ? item.product.image : 'https://via.placeholder.com/28'}" 
                                                                 class="item-img" 
                                                                 onerror="this.src='https://via.placeholder.com/28'">
                                                            <span class="item-name">${item.product.name}</span>
                                                            <span class="item-qty">×${item.quantity}</span>
                                                        </div>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color:#CCC; font-size:0.8rem;">No items recorded</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    
                                    <!-- Status -->
                                    <td>
                                        <span class="status-pill 
                                            ${order.status == 'pending' ? 'status-pending' : 
                                              order.status == 'approved' ? 'status-approved' : 
                                              order.status == 'assigned' ? 'status-assigned' : 
                                              order.status == 'delivered' ? 'status-delivered' :
                                              order.status == 'cancelled' ? 'status-cancelled' : 'status-shipped'}">
                                            ${order.status}
                                        </span>
                                        <c:if test="${not empty order.assignedTo}">
                                            <div style="font-size:0.75rem; color:#999; margin-top:6px;">
                                                <i class="fa-solid fa-motorcycle"></i> ${order.assignedTo}
                                            </div>
                                        </c:if>
                                    </td>
                                    
                                    <!-- Action -->
                                    <td>
                                        <div class="action-form">
                                            <c:choose>
                                                <c:when test="${order.status == 'pending'}">
                                                    <form action="${pageContext.request.contextPath}/OrderServlet" method="POST" style="margin:0;">
                                                        <input type="hidden" name="action" value="update_status">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <input type="hidden" name="status" value="approved">
                                                        <input type="hidden" name="from" value="admin">
                                                        <button type="submit" class="btn-approve">
                                                            <i class="fa-solid fa-check"></i> Approve
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.status == 'approved'}">
                                                    <form action="${pageContext.request.contextPath}/OrderServlet" method="POST" style="margin:0;">
                                                        <input type="hidden" name="action" value="update_status">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <input type="hidden" name="status" value="assigned">
                                                        <input type="hidden" name="from" value="admin">
                                                        <select name="assigned_to" class="rider-select" required>
                                                            <option value="">— Select Rider —</option>
                                                            <c:forEach var="rider" items="${deliveryBoyList}">
                                                                <option value="${rider.name}">${rider.name}</option>
                                                            </c:forEach>
                                                            <c:if test="${empty deliveryBoyList}">
                                                                <option value="Delivery Partner">Delivery Partner (default)</option>
                                                            </c:if>
                                                        </select>
                                                        <button type="submit" class="btn-assign" style="margin-top:6px;">
                                                            <i class="fa-solid fa-motorcycle"></i> Assign &amp; Ship
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="font-size:0.78rem; color:#AAA; font-style:italic;">No action needed</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Low Stock Alert -->
        <c:if test="${not empty lowStockList}">
            <div class="section-title" style="color: #D97706;">
                <i class="fa-solid fa-triangle-exclamation"></i> Low Stock Alerts
                <span class="badge-count" style="background:#D97706;">${lowStockList.size()}</span>
            </div>
            <div class="orders-wrapper" style="border-color: #FED7AA;">
                <table class="stock-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Category</th>
                            <th>Stock Left</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${lowStockList}">
                            <tr>
                                <td style="font-weight:600;">${product.name}</td>
                                <td style="color:#999;">${product.category}</td>
                                <td>
                                    <span class="stock-level ${product.stock == 0 ? 'low' : 'medium'}">
                                        ${product.stock} units
                                        <c:if test="${product.stock == 0}"> — OUT</c:if>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </main>
</div>

</body>
</html>