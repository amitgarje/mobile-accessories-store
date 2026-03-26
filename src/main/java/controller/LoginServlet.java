package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.UserDAO;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Hardcoded checks for specific roles (as requested by user)
        if ("admin123@gmail.com".equals(email) && "admin123".equals(password)) {
            User admin = new User(0, "Administrator", email, password, "admin");
            request.getSession().setAttribute("user", admin);
            response.sendRedirect(request.getContextPath() + "/OrderServlet?action=admin_list");
            return;
        }

        if ("delivery123@gmail.com".equals(email) && "delivery123".equals(password)) {
            User delivery = new User(0, "Delivery Partner", email, password, "delivery");
            request.getSession().setAttribute("user", delivery);
            response.sendRedirect(request.getContextPath() + "/delivery/deliveryDashboard.jsp");
            return;
        }

        User user = userDAO.loginUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            String role = user.getRole();
            if ("admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/OrderServlet?action=admin_list");
            } else if ("delivery".equals(role) || "delivery_boy".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/delivery/deliveryDashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/customer/products.jsp");
            }
        } else {
            // Check if connection was the problem
            if (utils.DBConnection.getConnection() == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=Database Connection Failed. Please check Railway logs or environment variables.");
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid credentials. No user found with this email/password.");
            }
        }
    }
}
