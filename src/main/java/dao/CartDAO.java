package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Product;
import utils.DBConnection;

public class CartDAO {

    public boolean addToCart(int userId, int productId) {
        String checkQuery = "SELECT * FROM cart WHERE user_id=? AND product_id=?";
        String updateQuery = "UPDATE cart SET quantity = quantity + 1 WHERE user_id=? AND product_id=?";
        String insertQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, 1)";

        try (Connection conn = DBConnection.getConnection()) {
            boolean exists = false;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
                checkStmt.setInt(1, userId);
                checkStmt.setInt(2, productId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        exists = true;
                    }
                }
            }

            if (exists) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, userId);
                    updateStmt.setInt(2, productId);
                    return updateStmt.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, productId);
                    return insertStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFromCart(int userId, int productId) {
        String deleteQuery = "DELETE FROM cart WHERE user_id=? AND product_id=?";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return false;
            try (PreparedStatement pstmt = conn.prepareStatement(deleteQuery)) {
                pstmt.setInt(1, userId);
                pstmt.setInt(2, productId);
                return pstmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Map<String, Object>> getCartItems(int userId) {
        List<Map<String, Object>> cartItems = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();
        String query = "SELECT product_id, quantity FROM cart WHERE user_id=?";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return cartItems;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, userId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        int productId = rs.getInt("product_id");
                        int quantity = rs.getInt("quantity");
    
                        Product product = productDAO.getProductById(productId);
                        if (product != null) {
                            Map<String, Object> item = new HashMap<>();
                            item.put("product", product);
                            item.put("quantity", quantity);
                            double itemTotal = product.getPrice() * quantity;
                            item.put("itemTotal", itemTotal);
                            cartItems.add(item);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public double getCartTotal(int userId) {
        double total = 0.0;
        String query = "SELECT c.quantity, p.price FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return 0.0;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setInt(1, userId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        total += rs.getInt("quantity") * rs.getDouble("price");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    
    public void clearCart(int userId, Connection conn) throws SQLException {
        String clearCartQuery = "DELETE FROM cart WHERE user_id = ?";
        try (PreparedStatement clearCartStmt = conn.prepareStatement(clearCartQuery)) {
            clearCartStmt.setInt(1, userId);
            clearCartStmt.executeUpdate();
        }
    }
}
