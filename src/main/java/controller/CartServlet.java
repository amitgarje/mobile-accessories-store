package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.User;
import dao.CartDAO;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;

    public void init() {
        cartDAO = new CartDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "add":
                addToCart(request, response);
                break;
            case "remove":
                removeFromCart(request, response);
                break;
            case "view":
            default:
                viewCart(request, response);
                break;
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            if ("true".equals(request.getParameter("ajax"))) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Login required");
            } else {
                response.sendRedirect("login.jsp?msg=Please login to add to cart");
            }
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));
        cartDAO.addToCart(user.getId(), productId);

        if ("true".equals(request.getParameter("ajax"))) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendRedirect("CartServlet?action=view");
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));
        cartDAO.removeFromCart(user.getId(), productId);

        response.sendRedirect("CartServlet?action=view");
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp?msg=Please login to view cart");
            return;
        }

        List<Map<String, Object>> cartItems = cartDAO.getCartItems(user.getId());
        double total = cartDAO.getCartTotal(user.getId());

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
    }
}
