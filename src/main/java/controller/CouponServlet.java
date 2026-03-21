package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.CouponDAO;
import dao.CartDAO;
import model.Coupon;
import model.User;

@WebServlet("/CouponServlet")
public class CouponServlet extends HttpServlet {
    private CouponDAO couponDAO = new CouponDAO();
    private CartDAO cartDAO = new CartDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        User user = (User) request.getSession().getAttribute("user");
        
        if (user == null || code == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid request\"}");
            return;
        }

        Coupon coupon = couponDAO.getCouponByCode(code);
        double cartTotal = cartDAO.getCartTotal(user.getId());

        if (coupon != null) {
            if (cartTotal >= coupon.getMinOrder()) {
                double discount = 0;
                if ("percentage".equals(coupon.getType())) {
                    discount = (cartTotal * coupon.getValue()) / 100.0;
                } else {
                    discount = coupon.getValue();
                }
                response.getWriter().write("{\"success\": true, \"discount\": " + discount + ", \"type\": \"" + coupon.getType() + "\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Minimum order of ₹" + coupon.getMinOrder() + " required\"}");
            }
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid or expired coupon\"}");
        }
    }
}
