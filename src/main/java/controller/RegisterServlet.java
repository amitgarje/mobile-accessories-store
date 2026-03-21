package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.UserDAO;
import model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    // Initialize DAO
    public void init() {
        userDAO = new UserDAO();
    }

    // Handle POST request
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters safely
        String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String password = request.getParameter("password");
        String role = request.getParameter("role") != null ? request.getParameter("role").trim() : "customer";

        // Validate input fields
        if (name.isEmpty() || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("register.jsp?error=All fields are required");
            return;
        }

        // Validate role (must match DB ENUM)
        if (!role.equals("admin") && !role.equals("customer") && !role.equals("delivery")) {
            role = "customer";
        }

        // Create User object
        User user = new User(0, name, email, password, role);

        // Register user
        boolean isRegistered = userDAO.registerUser(user);

        if (isRegistered) {
            response.sendRedirect("login.jsp?msg=Registration successful");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed");
        }
    }
}