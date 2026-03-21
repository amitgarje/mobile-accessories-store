package utils;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebFilter(urlPatterns = {"/admin/*", "/delivery/*"})
public class SecurityFilter implements Filter {

    public void init(FilterConfig fConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String path = httpRequest.getRequestURI();
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        boolean authorized = false;
        
        if (user != null) {
            String role = user.getRole();
            if (path.contains("/admin/") && "admin".equals(role)) {
                authorized = true;
            } else if (path.contains("/delivery/") && "delivery".equals(role)) {
                authorized = true;
            }
        }
        
        if (authorized) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=Access Denied. Please login with appropriate credentials.");
        }
    }

    public void destroy() {}
}
