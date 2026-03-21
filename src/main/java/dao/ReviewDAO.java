package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Review;
import utils.DBConnection;

public class ReviewDAO {

    public boolean addReview(Review review) {
        String query = "INSERT INTO reviews (product_id, user_id, rating, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, review.getProductId());
            pstmt.setInt(2, review.getUserId());
            pstmt.setInt(3, review.getRating());
            pstmt.setString(4, review.getComment());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT r.*, u.name as user_name FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.product_id = ? ORDER BY r.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, productId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setId(rs.getInt("id"));
                    review.setProductId(rs.getInt("product_id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setUserName(rs.getString("user_name"));
                    review.setRating(rs.getInt("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setCreatedAt(rs.getTimestamp("created_at"));
                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
}
