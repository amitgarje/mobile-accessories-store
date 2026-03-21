package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {
        Connection connection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Look for environment variables (Production/Railway)
            String rawUrl = System.getenv("DB_URL");
            if (rawUrl == null) {
                rawUrl = System.getenv("MYSQL_URL"); // Try Railway's default name
            }
            
            String user = System.getenv("DB_USER");
            if (user == null) {
                user = System.getenv("MYSQLUSER"); // Try Railway's default name
            }
            
            String pass = System.getenv("DB_PASS");
            if (pass == null) {
                pass = System.getenv("MYSQLPASSWORD"); // Try Railway's default name
            }

            String url;
            if (rawUrl != null) {
                // Production: Convert Railway URL → JDBC format if needed
                if (rawUrl.startsWith("mysql://")) {
                    url = rawUrl.replace("mysql://", "jdbc:mysql://");
                } else {
                    url = rawUrl;
                }
                // Add useful parameters
                if (!url.contains("?")) {
                    url += "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                }
            } else {
                // Local Fallback (Eclipse)
                url = "jdbc:mysql://localhost:3306/mobile_store?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                user = (user != null) ? user : "root";
                pass = (pass != null) ? pass : "root";
            }

            connection = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            System.err.println("Database connection failed during getConnection()!");
            e.printStackTrace();
        }

        return connection;
    }
}