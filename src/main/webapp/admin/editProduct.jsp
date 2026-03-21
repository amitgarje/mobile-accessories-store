<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="model.Product" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product | ACCESSO</title>
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
            <%
                Product product = (Product) request.getAttribute("product");
                if(product != null) {
            %>
            <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 50px;">
                <div>
                    <h2 style="font-size: 2.2rem; font-weight: 800;">Refine Listing</h2>
                    <p style="color: #AAA; font-weight: 600; margin-top: 5px;">Editing Reference: #ID-<%= product.getId() %></p>
                </div>
                <a href="${pageContext.request.contextPath}/ProductServlet?action=admin_list" class="btn-minimal" style="padding: 10px 20px;">
                    <i class="fa-solid fa-xmark"></i> Abandon Changes
                </a>
            </header>

            <div class="form-card" style="max-width: 900px;">
                <form action="${pageContext.request.contextPath}/ProductServlet" method="POST">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= product.getId() %>">
                    
                    <div class="input-group">
                        <label for="name">Product Title</label>
                        <input type="text" id="name" name="name" value="<%= product.getName() %>" required>
                    </div>
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 20px;">
                        <div class="input-group" style="margin-bottom:0;">
                            <label for="price">Pricing (₹)</label>
                            <input type="number" id="price" name="price" step="0.01" value="<%= product.getPrice() %>" required>
                        </div>
                        <div class="input-group" style="margin-bottom:0;">
                            <label for="stock">Active Stock Level</label>
                            <input type="number" id="stock" name="stock" value="<%= product.getStock() %>" required>
                        </div>
                    </div>
                    
                    <div class="input-group">
                        <label for="category">Collection Segment</label>
                        <select id="category" name="category" required style="width: 100%; padding: 14px 20px; border-radius: 12px; border: 1px solid #E2E8F0; background: #FFFFFF; font-size: 1rem; transition: var(--transition); cursor: pointer; outline: none;">
                            <option value="Cases" <%="Cases".equals(product.getCategory()) ? "selected" : ""%>>Protective Cases</option>
                            <option value="Audio" <%="Audio".equals(product.getCategory()) ? "selected" : ""%>>Audio & Sound</option>
                            <option value="Power" <%="Power".equals(product.getCategory()) ? "selected" : ""%>>Power & Charging</option>
                            <option value="Mounts" <%="Mounts".equals(product.getCategory()) ? "selected" : ""%>>Mounts & Holders</option>
                            <option value="Accessories" <%="Accessories".equals(product.getCategory()) ? "selected" : ""%>>Essential Accessories</option>
                        </select>
                    </div>

                    <div class="input-group">
                        <label for="description">Product Narrative</label>
                        <textarea id="description" name="description" rows="5" style="width: 100%; padding: 15px 20px; border-radius: 12px; border: 1px solid #E2E8F0; resize: vertical; outline: none; transition: var(--transition);"><%= product.getDescription() %></textarea>
                    </div>
                    
                    <div class="input-group">
                        <label for="image">Showcase Media (URL)</label>
                        <input type="text" id="image" name="image" value="<%= product.getImage() %>">
                    </div>
                    
                    <div style="display: flex; gap: 20px; justify-content: flex-end; margin-top: 50px; padding-top: 30px; border-top: 1px solid #F5F5F5;">
                        <button type="submit" class="btn-cta" style="padding: 15px 40px;">Commmit Updates</button>
                    </div>
                </form>
            </div>
            <% } else { %>
                <div class="alert" style="background: rgba(255, 77, 77, 0.1); color: #FF4D4D; padding: 25px; border-radius: 15px; text-align: center;">
                    <i class="fa-solid fa-triangle-exclamation fa-2x" style="margin-bottom: 15px;"></i>
                    <p style="font-weight: 700;">Critical Error: Product context is missing.</p>
                    <a href="${pageContext.request.contextPath}/ProductServlet?action=admin_list" style="color: var(--primary); font-size: 0.9rem; margin-top: 10px; display: inline-block;">Return to Inventory</a>
                </div>
            <% } %>
        </main>
    </div>

</body>
</html>
