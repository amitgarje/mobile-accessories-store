<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%
    Connection conn = DBConnection.getConnection();
    String msg = "";
    if (conn != null) {
        try {
            Statement stmt = conn.createStatement();
            
            // 0. Base Tables
            try {
                stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                             "id INT AUTO_INCREMENT PRIMARY KEY, " +
                             "name VARCHAR(100) NOT NULL, " +
                             "email VARCHAR(100) NOT NULL UNIQUE, " +
                             "password VARCHAR(255) NOT NULL, " +
                             "role ENUM('admin', 'customer', 'delivery') DEFAULT 'customer', " +
                             "latitude DOUBLE DEFAULT 0.0, " +
                             "longitude DOUBLE DEFAULT 0.0, " +
                             "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
                msg += "Users table ready. ";
            } catch (Exception e) { msg += "Users error: " + e.getMessage() + ". "; }

            try {
                stmt.execute("CREATE TABLE IF NOT EXISTS products (" +
                             "id INT AUTO_INCREMENT PRIMARY KEY, " +
                             "name VARCHAR(200) NOT NULL, " +
                             "description TEXT, " +
                             "price DECIMAL(10, 2) NOT NULL, " +
                             "category VARCHAR(100), " +
                             "image VARCHAR(255), " +
                             "stock INT DEFAULT 0, " +
                             "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
                msg += "Products table ready. ";
            } catch (Exception e) { msg += "Products error: " + e.getMessage() + ". "; }

            try {
                stmt.execute("CREATE TABLE IF NOT EXISTS cart (" +
                             "id INT AUTO_INCREMENT PRIMARY KEY, " +
                             "user_id INT NOT NULL, " +
                             "product_id INT NOT NULL, " +
                             "quantity INT DEFAULT 1, " +
                             "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, " +
                             "FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE)");
                msg += "Cart table ready. ";
            } catch (Exception e) { msg += "Cart error: " + e.getMessage() + ". "; }

            // 1. Core Schema Setup
            try {
                stmt.execute("CREATE TABLE IF NOT EXISTS orders (" +
                             "id INT PRIMARY KEY AUTO_INCREMENT, " +
                             "user_id INT NOT NULL, " +
                             "total_price DOUBLE DEFAULT 0.0, " +
                             "status VARCHAR(50) DEFAULT 'pending', " +
                             "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
                msg += "Orders table verified. ";
            } catch (Exception e) {}

            try { stmt.execute("ALTER TABLE orders ADD COLUMN assigned_to VARCHAR(150)"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE orders ADD COLUMN estimated_delivery VARCHAR(100)"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE orders ADD COLUMN total_price DOUBLE DEFAULT 0.0"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE orders ADD COLUMN discount DOUBLE DEFAULT 0.0"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE orders ADD COLUMN latitude DOUBLE DEFAULT 0.0"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE orders ADD COLUMN longitude DOUBLE DEFAULT 0.0"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE orders ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE orders ADD COLUMN delivery_address TEXT"); msg += "Delivery address column added. "; } catch (Exception e) {}
            
            try { stmt.execute("ALTER TABLE users ADD COLUMN latitude DOUBLE DEFAULT 0.0"); stmt.execute("ALTER TABLE users ADD COLUMN longitude DOUBLE DEFAULT 0.0"); } catch (Exception e) {}
            try { stmt.execute("ALTER TABLE users MODIFY COLUMN role ENUM('admin', 'customer', 'delivery') DEFAULT 'customer'"); } catch (Exception e) {}

            // 2. New updates for Order System
            try {
                stmt.execute("CREATE TABLE IF NOT EXISTS order_items (" +
                             "id INT PRIMARY KEY AUTO_INCREMENT, " +
                             "order_id INT NOT NULL, " +
                             "product_id INT NOT NULL, " +
                             "quantity INT NOT NULL, " +
                             "price DOUBLE NOT NULL, " +
                             "FOREIGN KEY (order_id) REFERENCES orders(id), " +
                             "FOREIGN KEY (product_id) REFERENCES products(id))");
                msg += "Order Items table ready. ";
            } catch (Exception e) { msg += "Order Items error: " + e.getMessage() + ". "; }

            try {
                stmt.execute("CREATE TABLE IF NOT EXISTS coupons (" +
                             "id INT PRIMARY KEY AUTO_INCREMENT, " +
                             "code VARCHAR(50) UNIQUE NOT NULL, " +
                             "type ENUM('percentage', 'fixed') NOT NULL, " +
                             "value DOUBLE NOT NULL, " +
                             "min_order DOUBLE DEFAULT 0.0, " +
                             "active BOOLEAN DEFAULT TRUE)");
                msg += "Coupons table ready. ";
                
                // Seed some coupons if empty
                ResultSet rs = stmt.executeQuery("SELECT count(*) FROM coupons");
                if (rs.next() && rs.getInt(1) == 0) {
                    stmt.execute("INSERT INTO coupons (code, type, value, min_order) VALUES " +
                                 "('SAVE10', 'percentage', 10.0, 500.0), " +
                                 "('FLAT100', 'fixed', 100.0, 1000.0)");
                }
            } catch (Exception e) { msg += "Coupons error: " + e.getMessage() + ". "; }

            try {
                stmt.execute("CREATE TABLE IF NOT EXISTS reviews (" +
                             "id INT PRIMARY KEY AUTO_INCREMENT, " +
                             "product_id INT NOT NULL, " +
                             "user_id INT NOT NULL, " +
                             "rating INT NOT NULL, " +
                             "comment TEXT, " +
                             "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                             "FOREIGN KEY (product_id) REFERENCES products(id), " +
                             "FOREIGN KEY (user_id) REFERENCES users(id))");
                msg += "Reviews table ready. ";
            } catch (Exception e) { msg += "Reviews error: " + e.getMessage() + ". "; }

            msg += "Database update completed successfully.";
        } catch (Exception e) {
            msg = "DB Error: " + e.getMessage();
        } finally {
            try { conn.close(); } catch (Exception e) {}
        }
    } else {
        msg = "Connection failed!";
    }
%>
<%= msg %>
