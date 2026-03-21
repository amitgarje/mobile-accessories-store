<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management | ACCESSO</title>
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

        .clean-table { width: 100%; border-collapse: separate; border-spacing: 0 10px; }
        .clean-table th { text-align: left; padding: 0 20px 10px; color: #AAA; font-size: 0.8rem; text-transform: uppercase; }
        .clean-table tr td { background: white; padding: 20px; border-top: 1px solid #EEE; border-bottom: 1px solid #EEE; vertical-align: middle; }
        .clean-table tr td:first-child { border-left: 1px solid #EEE; border-top-left-radius: 15px; border-bottom-left-radius: 15px; }
        .clean-table tr td:last-child { border-right: 1px solid #EEE; border-top-right-radius: 15px; border-bottom-right-radius: 15px; }
        
        .stock-badge { padding: 6px 12px; border-radius: 100px; font-size: 0.75rem; font-weight: 700; }
        .stock-in { background: #E6FFFA; color: #319795; }
        .stock-low { background: #FFF9E6; color: #D69E2E; }
        .stock-out { background: #FFF5F5; color: #C53030; }
    </style>
</head>
<body>

    <div class="dashboard-layout">
        <aside class="sidebar">
            <a href="${pageContext.request.contextPath}/index.jsp" class="sidebar-brand">
                ACCESSO<span>.in</span>
            </a>
            
            <div class="nav-group">
                <span class="nav-label">Main</span>
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="sidebar-link">
                    <i class="fa-solid fa-house"></i> Overview
                </a>
                <a href="${pageContext.request.contextPath}/OrderServlet?action=admin_list" class="sidebar-link">
                    <i class="fa-solid fa-shopping-bag"></i> Orders
                </a>
                <a href="${pageContext.request.contextPath}/ProductServlet?action=admin_list" class="sidebar-link active">
                    <i class="fa-solid fa-layer-group"></i> Inventory
                </a>
            </div>
            
            <div class="nav-group">
                <span class="nav-label">Actions</span>
                <a href="${pageContext.request.contextPath}/admin/addProduct.jsp" class="sidebar-link">
                    <i class="fa-solid fa-plus"></i> Add Product
                </a>
            </div>
            
            <div style="margin-top: auto;">
                <div style="padding: 15px; background: #F9F9F9; border-radius: 15px; display: flex; align-items: center; gap: 12px; margin-bottom: 20px;">
                    <div style="width: 40px; height: 40px; background: var(--accent); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-weight: 800;">A</div>
                    <div>
                        <div style="font-weight: 700; font-size: 0.85rem;">${sessionScope.user.name}</div>
                        <div style="font-size: 0.75rem; color: #AAA;">Administrator</div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout.jsp" class="sidebar-link" style="color: #FF4D4D;">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Sign Out
                </a>
            </div>
        </aside>

        <main class="main-content">
            <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 50px;">
                <h2 style="font-size: 2.2rem; font-weight: 800;">Inventory Tracking</h2>
                <a href="${pageContext.request.contextPath}/admin/addProduct.jsp" class="btn-minimal" style="background: var(--primary); color: white; padding: 12px 25px;">
                    <i class="fa-solid fa-plus"></i> New Product
                </a>
            </header>

            <c:if test="${not empty param.msg}">
                <div class="alert" style="background: rgba(47, 133, 90, 0.1); color: #2F855A; padding: 15px; border-radius: 12px; margin-bottom: 30px; font-weight: 600; display: flex; justify-content: space-between;">
                    <span><i class="fa-solid fa-circle-check"></i> &nbsp;${param.msg}</span>
                    <i class="fa-solid fa-xmark" style="cursor: pointer;" onclick="this.parentElement.remove()"></i>
                </div>
            </c:if>

            <div class="admin-table-container">
                <c:if test="${empty products}">
                    <div style="text-align: center; padding: 100px; color: #AAA;">
                        <i class="fa-solid fa-box-open fa-4x" style="margin-bottom: 20px;"></i>
                        <p>No products in inventory yet.</p>
                    </div>
                </c:if>

                <c:if test="${not empty products}">
                    <table class="clean-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Category</th>
                                <th>Pricing</th>
                                <th>Stock Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 15px;">
                                            <div style="width: 50px; height: 50px; background: #F8F9FA; border-radius: 10px; display: flex; align-items: center; justify-content: center; overflow: hidden; border: 1px solid #EEE;">
                                                <img src="${not empty p.image ? p.image : 'https://via.placeholder.com/50'}" alt="" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                            </div>
                                            <div style="font-weight: 800; color: var(--primary);">${p.name}</div>
                                        </div>
                                    </td>
                                    <td>
                                        <div style="font-size: 0.85rem; color: #777;">${p.category}</div>
                                    </td>
                                    <td>
                                        <div style="font-weight: 800; color: var(--accent);">₹${p.price}</div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.stock > 10}"><span class="stock-badge stock-in">${p.stock} Units</span></c:when>
                                            <c:when test="${p.stock > 0}"><span class="stock-badge stock-low">Only ${p.stock} left</span></c:when>
                                            <c:otherwise><span class="stock-badge stock-out">Sold Out</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 10px;">
                                            <a href="${pageContext.request.contextPath}/ProductServlet?action=edit&id=${p.id}" class="btn-minimal" style="padding: 8px; background: #F5F5F5; border: 1px solid #EEE; color: #555;">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/ProductServlet?action=delete&id=${p.id}" onclick="return confirm('Archive this product?')" class="btn-minimal" style="padding: 8px; background: rgba(255, 77, 77, 0.1); border: 1px solid rgba(255, 77, 77, 0.2); color: #FF4D4D;">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </main>
    </div>

</body>
</html>
