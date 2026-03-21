<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Product Registration | ACCESSO</title>
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

        .form-card { background: white; padding: 50px; border-radius: 24px; border: 1px solid #EEE; }
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
                <a href="${pageContext.request.contextPath}/ProductServlet?action=admin_list" class="sidebar-link">
                    <i class="fa-solid fa-layer-group"></i> Inventory
                </a>
            </div>
            
            <div class="nav-group">
                <span class="nav-label">Actions</span>
                <a href="${pageContext.request.contextPath}/admin/addProduct.jsp" class="sidebar-link active">
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
                <h2 style="font-size: 2.2rem; font-weight: 800;">Catalog Registration</h2>
                <a href="${pageContext.request.contextPath}/ProductServlet?action=admin_list" class="btn-minimal" style="padding: 10px 20px;">
                    <i class="fa-solid fa-xmark"></i> Dismiss
                </a>
            </header>

            <c:if test="${not empty param.error}">
                <div class="alert" style="background: rgba(197, 48, 48, 0.1); color: #C53030; padding: 15px; border-radius: 12px; margin-bottom: 30px; font-weight: 600;">
                    <i class="fa-solid fa-circle-exclamation"></i> &nbsp;${param.error}
                </div>
            </c:if>

            <div class="form-card" style="max-width: 900px;">
                <form action="${pageContext.request.contextPath}/ProductServlet" method="POST">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="input-group">
                        <label for="name">Product Title</label>
                        <input type="text" id="name" name="name" placeholder="Premium Leather AirPod Case" required>
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 20px;">
                        <div class="input-group" style="margin-bottom:0;">
                            <label for="price">Retail Price (₹)</label>
                            <input type="number" id="price" name="price" step="0.01" placeholder="1299.00" required>
                        </div>
                        <div class="input-group" style="margin-bottom:0;">
                            <label for="stock">Opening Inventory</label>
                            <input type="number" id="stock" name="stock" placeholder="50" required>
                        </div>
                    </div>
                    
                    <div class="input-group">
                        <label for="category">Product Collection</label>
                        <select id="category" name="category" required style="width: 100%; padding: 14px 20px; border-radius: 12px; border: 1px solid #E2E8F0; background: #FFFFFF; font-size: 1rem; transition: var(--transition); cursor: pointer; outline: none;">
                            <option value="Cases">Protective Cases</option>
                            <option value="Audio">Audio & Sound</option>
                            <option value="Power">Power & Charging</option>
                            <option value="Mounts">Mounts & Holders</option>
                            <option value="Accessories">Essential Accessories</option>
                        </select>
                    </div>

                    <div class="input-group">
                        <label for="description">Story & Specifications</label>
                        <textarea id="description" name="description" rows="5" placeholder="Tell the product story..." style="width: 100%; padding: 15px 20px; border-radius: 12px; border: 1px solid #E2E8F0; resize: vertical; outline: none; transition: var(--transition);"></textarea>
                    </div>
                    
                    <div class="input-group">
                        <label for="image">Showcase Image (Link)</label>
                        <input type="text" id="image" name="image" placeholder="https://source.unsplash.com/...">
                        <small style="color: #AAA; font-size: 0.75rem; margin-top: 5px; display: block;">High-resolution direct links (Unsplash/Imgur) work best.</small>
                    </div>
                    
                    <div style="display: flex; gap: 20px; justify-content: flex-end; margin-top: 50px; padding-top: 30px; border-top: 1px solid #F5F5F5;">
                        <button type="submit" class="btn-cta" style="padding: 15px 40px;">Publish to Store</button>
                    </div>
                </form>
            </div>
        </main>
    </div>

</body>
</html>