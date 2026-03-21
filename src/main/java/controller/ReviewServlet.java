package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ReviewDAO;
import model.Review;
import model.User;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review review = new Review();
        review.setProductId(productId);
        review.setUserId(user.getId());
        review.setRating(rating);
        review.setComment(comment);

        if (reviewDAO.addReview(review)) {
            response.sendRedirect("ProductServlet?action=view&id=" + productId + "&msg=Review added");
        } else {
            response.sendRedirect("ProductServlet?action=view&id=" + productId + "&error=Failed to add review");
        }
    }
}
