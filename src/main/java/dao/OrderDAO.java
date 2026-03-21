package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderItem;
import model.Product;
import utils.DBConnection;

public class OrderDAO {

    public int placeOrder(int userId, double totalPrice, double discount, String estimatedDelivery, String deliveryAddress) {
        int orderId = -1;
        String insertOrderQuery = "INSERT INTO orders (user_id, total_price, discount, status, estimated_delivery, delivery_address, latitude, longitude) VALUES (?, ?, ?, 'pending', ?, ?, ?, ?)";
        String getCartQuery = "SELECT * FROM cart WHERE user_id = ?";
        String insertOrderItemQuery = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        String getProductPriceQuery = "SELECT price FROM products WHERE id = ?";
        String clearCartQuery = "DELETE FROM cart WHERE user_id = ?";
        
        Connection conn = DBConnection.getConnection();
        if (conn == null) return -1;
        
        try {
            conn.setAutoCommit(false); // Start transaction
            
            // 1. Insert into orders table
            try (PreparedStatement pstmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, userId);
                pstmt.setDouble(2, totalPrice);
                pstmt.setDouble(3, discount);
                pstmt.setString(4, estimatedDelivery);
                pstmt.setString(5, deliveryAddress);
                pstmt.setDouble(6, 0.0);
                pstmt.setDouble(7, 0.0);

                pstmt.executeUpdate();
                
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }
            
            if (orderId == -1) {
                conn.rollback();
                return -1;
            }
            
            // 2. Get cart items and move to order_items
            try (PreparedStatement cartStmt = conn.prepareStatement(getCartQuery)) {
                cartStmt.setInt(1, userId);
                try (ResultSet rs = cartStmt.executeQuery()) {
                    while (rs.next()) {
                        int productId = rs.getInt("product_id");
                        int quantity = rs.getInt("quantity");
                        double price = 0.0;
                        
                        // Get current product price
                        try (PreparedStatement priceStmt = conn.prepareStatement(getProductPriceQuery)) {
                            priceStmt.setInt(1, productId);
                            try (ResultSet priceRs = priceStmt.executeQuery()) {
                                if (priceRs.next()) {
                                    price = priceRs.getDouble("price");
                                }
                            }
                        }
                        
                        // Insert into order_items
                        try (PreparedStatement itemStmt = conn.prepareStatement(insertOrderItemQuery)) {
                            itemStmt.setInt(1, orderId);
                            itemStmt.setInt(2, productId);
                            itemStmt.setInt(3, quantity);
                            itemStmt.setDouble(4, price);
                            itemStmt.executeUpdate();
                        }
                    }
                }
            }
            
            // 3. Clear cart
            try (PreparedStatement clearCartStmt = conn.prepareStatement(clearCartQuery)) {
                clearCartStmt.setInt(1, userId);
                clearCartStmt.executeUpdate();
            }
            
            conn.commit(); // Commit transaction
            
        } catch (SQLException e) {
            System.err.println("CRITICAL ERROR: Order placement failed for user ID: " + userId);
            e.printStackTrace();
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return -1;
        } finally {
            try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        
        return orderId;
    }

    public List<Order> getOrdersForAdmin() {
        return getOrders("SELECT o.*, u.name as customer_name, u.email as customer_email FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.created_at DESC");
    }

    public double getTotalRevenue() {
        double total = 0.0;
        String query = "SELECT SUM(total_price) as total FROM orders WHERE status != 'cancelled'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                total = rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Order> getOrdersForDelivery(String riderName) {
        String query = "SELECT o.*, u.name as customer_name, u.email as customer_email FROM orders o JOIN users u ON o.user_id = u.id WHERE o.assigned_to=? AND o.status IN ('assigned', 'out for delivery') ORDER BY o.created_at ASC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, riderName);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setStatus(rs.getString("status"));
                    order.setCreatedAt(rs.getTimestamp("created_at"));
                    order.setAssignedTo(rs.getString("assigned_to"));
                    order.setEstimatedDelivery(rs.getString("estimated_delivery"));
                    order.setLatitude(rs.getDouble("latitude"));
                    order.setLongitude(rs.getDouble("longitude"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setCustomerEmail(rs.getString("customer_email"));
                    
                    fetchOrderItems(conn, order);
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    public List<Order> getOrdersByUserId(int userId) {
        String query = "SELECT * FROM orders WHERE user_id=? ORDER BY created_at DESC";
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setStatus(rs.getString("status"));
                    order.setCreatedAt(rs.getTimestamp("created_at"));
                    order.setAssignedTo(rs.getString("assigned_to"));
                    order.setEstimatedDelivery(rs.getString("estimated_delivery"));
                    order.setLatitude(rs.getDouble("latitude"));
                    order.setLongitude(rs.getDouble("longitude"));
                    try { order.setDeliveryAddress(rs.getString("delivery_address")); } catch (Exception ignore) {}
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    private void fetchOrderItems(Connection conn, Order order) throws SQLException {
        String query = "SELECT oi.*, p.name, p.image FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, order.getId());
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    
                    Product p = new Product();
                    p.setName(rs.getString("name"));
                    p.setImage(rs.getString("image"));
                    item.setProduct(p);
                    
                    order.getItems().add(item);
                }
            }
        }
    }

    private List<Order> getOrders(String query) {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
             
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setAssignedTo(rs.getString("assigned_to"));
                order.setEstimatedDelivery(rs.getString("estimated_delivery"));
                order.setLatitude(rs.getDouble("latitude"));
                order.setLongitude(rs.getDouble("longitude"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerEmail(rs.getString("customer_email"));
                
                // Fetch Items for this order
                fetchOrderItems(conn, order);
                
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    public boolean updateOrderStatus(int orderId, String status) {
        boolean isSuccess = false;
        String query = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    public boolean updateOrderStatusAndAssignment(int orderId, String status, String assignedTo) {
        boolean isSuccess = false;
        String query = "UPDATE orders SET status = ?, assigned_to = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setString(2, assignedTo);
            pstmt.setInt(3, orderId);
            isSuccess = pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
}
