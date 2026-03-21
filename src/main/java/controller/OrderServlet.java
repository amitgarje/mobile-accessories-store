package controller;

import java.io.IOException;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.CartDAO;
import dao.CouponDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import dao.UserDAO;
import model.Order;
import model.Product;
import model.User;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;
    private UserDAO userDAO;
    private ProductDAO productDAO;

    public void init() {
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "admin_list":
                adminListOrders(request, response);
                break;
            case "delivery_list":
                deliveryListOrders(request, response);
                break;
            case "my_orders":
                myOrders(request, response);
                break;
            case "cancel":
                cancelOrder(request, response);
                break;
            case "checkout":
                checkout(request, response);
                break;
            case "confirmation":
                request.getRequestDispatcher("customer/orderConfirmation.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("place".equals(action)) {
            placeOrder(request, response);
        } else if ("update_status".equals(action)) {
            updateStatus(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Please login to place order");
            return;
        }

        int userId = user.getId();
        CartDAO cartDAO = new CartDAO();
        double total = cartDAO.getCartTotal(userId);

        if (total <= 0.0) {
            response.sendRedirect(request.getContextPath() + "/CartServlet?action=view&error=Cart is empty");
            return;
        }

        double discount = 0.0;
        String couponCode = request.getParameter("couponCode");
        if (couponCode != null && !couponCode.trim().isEmpty()) {
            CouponDAO couponDAO = new CouponDAO();
            model.Coupon coupon = couponDAO.getCouponByCode(couponCode);
            if (coupon != null && total >= coupon.getMinOrder()) {
                if ("percentage".equals(coupon.getType())) {
                    discount = (total * coupon.getValue()) / 100.0;
                } else {
                    discount = coupon.getValue();
                }
            }
        }

        String estimatedDelivery = LocalDate.now().plusDays(3).format(DateTimeFormatter.ofPattern("MMM dd, yyyy"));
        String deliveryAddress = request.getParameter("deliveryAddress");
        if (deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            deliveryAddress = "Address not provided";
        }

        int orderId = orderDAO.placeOrder(userId, total, discount, estimatedDelivery, deliveryAddress);
        if (orderId > 0) {
            // Success - Clear any session cached cart size
            request.getSession().setAttribute("cartSize", 0);
            response.sendRedirect(request.getContextPath() + "/customer/orderConfirmation.jsp?orderId=" + orderId);
        } else {
            response.sendRedirect(request.getContextPath() + "/OrderServlet?action=checkout&error=Failed to place order");
        }
    }

    private void adminListOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Order> orders = orderDAO.getOrdersForAdmin();
        List<User> deliveryBoys = userDAO.getUsersByRole("delivery");
        double totalRevenue = orderDAO.getTotalRevenue();
        List<Product> lowStockProducts = productDAO.getLowStockProducts();
        
        request.setAttribute("orders", orders);
        request.setAttribute("deliveryBoys", deliveryBoys);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
    }

    private void deliveryListOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String riderName = (user != null) ? user.getName() : "";
        List<Order> orders = orderDAO.getOrdersForDelivery(riderName);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("delivery/deliveryDashboard.jsp").forward(request, response);
    }
    
    private void myOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Please login to view orders");
            return;
        }
        List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("customer/myOrders.jsp").forward(request, response);
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        String assignedTo = request.getParameter("assigned_to"); // Fixed: matches dashboard.jsp
        
        String from = request.getParameter("from");

        boolean success = false;
        try {
            if (assignedTo != null && !assignedTo.trim().isEmpty()) {
                success = orderDAO.updateOrderStatusAndAssignment(orderId, status, assignedTo);
            } else {
                success = orderDAO.updateOrderStatus(orderId, status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (success) {
            if ("admin".equals(from)) {
                response.sendRedirect(request.getContextPath() + "/OrderServlet?action=admin_list&msg=Status updated");
            } else if ("delivery".equals(from)) {
                response.sendRedirect(request.getContextPath() + "/OrderServlet?action=delivery_list&msg=Status updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            if ("admin".equals(from)) {
                response.sendRedirect(request.getContextPath() + "/OrderServlet?action=admin_list&error=Failed to update status");
            } else if ("delivery".equals(from)) {
                response.sendRedirect(request.getContextPath() + "/OrderServlet?action=delivery_list&error=Failed to update status");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        if (orderDAO.updateOrderStatus(orderId, "cancelled")) {
            response.sendRedirect(request.getContextPath() + "/OrderServlet?action=my_orders&msg=Order cancelled successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/OrderServlet?action=my_orders&error=Failed to cancel order");
        }
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Please login to checkout");
            return;
        }
        CartDAO cartDAO = new CartDAO();
        List<java.util.Map<String, Object>> cartItems = cartDAO.getCartItems(user.getId());
        double total = cartDAO.getCartTotal(user.getId());
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("customer/checkout.jsp").forward(request, response);
    }
}
