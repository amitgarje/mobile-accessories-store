package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {
        Connection connection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String db = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String pass = System.getenv("MYSQLPASSWORD");

            // Fallback for local testing if not on Railway
            if (host == null) {
                host = "localhost";
                port = "3306";
                db = "mobile_store";
                user = "root";
                pass = "root";
            }

            String url = "jdbc:mysql://" + host + ":" + port + "/" + db + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            connection = DriverManager.getConnection(url, user, pass);
            
            // Auto-initialize tables if connection successful
            if (connection != null) {
                initializeTables(connection);
            }

        } catch (Exception e) {
            System.err.println("Database connection failed: " + e.getMessage());
        }

        return connection;
    }

    private static void initializeTables(Connection conn) {
        try (java.sql.Statement stmt = conn.createStatement()) {
            // Create users table
            stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(100) NOT NULL," +
                    "email VARCHAR(100) NOT NULL UNIQUE," +
                    "password VARCHAR(255) NOT NULL," +
                    "role ENUM('admin', 'customer', 'delivery') DEFAULT 'customer'," +
                    "latitude DOUBLE DEFAULT 0.0, longitude DOUBLE DEFAULT 0.0," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
            
            // Create products table (essential for home page)
            stmt.execute("CREATE TABLE IF NOT EXISTS products (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(200) NOT NULL," +
                    "description TEXT, price DECIMAL(10, 2) NOT NULL," +
                    "category VARCHAR(100), image VARCHAR(255)," +
                    "stock INT DEFAULT 0, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
        } catch (Exception e) {
            System.err.println("Table initialization failed: " + e.getMessage());
        }
    }
}