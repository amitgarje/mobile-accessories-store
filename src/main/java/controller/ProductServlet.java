package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.google.gson.Gson; // Added json support from maven.

import dao.ProductDAO;
import dao.ReviewDAO;
import model.Product;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewProduct(request, response);
                break;
            case "api_list":
                apiListProducts(request, response);
                break;
            case "admin_list":
                adminListProducts(request, response);
                break;
            case "edit":
                editProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "index":
                indexProducts(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    private void indexProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> exclusive = productDAO.getProducts(8);
        List<Product> trending = productDAO.getProducts(12);
        request.setAttribute("exclusiveOffers", exclusive);
        request.setAttribute("trendingProducts", trending);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Product> products;
        if (category != null && !category.isEmpty()) {
            products = productDAO.getProductsByCategory(category);
        } else {
            products = productDAO.getAllProducts();
        }
        request.setAttribute("products", products);
        request.getRequestDispatcher("customer/products.jsp").forward(request, response);
    }
    
    // Quick API for AJAX fetching on index
    private void apiListProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String limitStr = request.getParameter("limit");
        int limit = 0;
        try {
            if (limitStr != null) limit = Integer.parseInt(limitStr);
        } catch (NumberFormatException e) {}
        
        List<Product> products = limit > 0 ? productDAO.getProducts(limit) : productDAO.getAllProducts();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(products));
        out.flush();
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product p = productDAO.getProductById(id);
        if (p != null) {
            ReviewDAO reviewDAO = new ReviewDAO();
            request.setAttribute("product", p);
            request.setAttribute("reviews", reviewDAO.getReviewsByProductId(id));
            request.getRequestDispatcher("customer/productDetails.jsp").forward(request, response);
        } else {
            response.sendRedirect("ProductServlet?action=list&error=Product not found");
        }
    }

    private void adminListProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("admin/manageProducts.jsp").forward(request, response);
    }
    
    private void editProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        if (productDAO.deleteProduct(id)) {
            response.sendRedirect(request.getContextPath() + "/ProductServlet?action=admin_list&msg=Product deleted perfectly");
        } else {
            response.sendRedirect(request.getContextPath() + "/ProductServlet?action=admin_list&error=Failed to delete");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String image = request.getParameter("image"); // Typically handle file upload, using string URL for demo
            int stock = Integer.parseInt(request.getParameter("stock"));

            Product product = new Product(0, name, description, price, category, image, stock);
            
            if (productDAO.addProduct(product)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp?msg=Product added");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/addProduct.jsp?error=Failed to add");
            }
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String image = request.getParameter("image");
            int stock = Integer.parseInt(request.getParameter("stock"));

            Product product = new Product(id, name, description, price, category, image, stock);
            
            if (productDAO.updateProduct(product)) {
                response.sendRedirect(request.getContextPath() + "/ProductServlet?action=admin_list&msg=Product updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/ProductServlet?action=edit&id=" + id + "&error=Failed to update");
            }
        }
    }
}
