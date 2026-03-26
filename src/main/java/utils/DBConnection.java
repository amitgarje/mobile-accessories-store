package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {
        Connection connection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = null;
            String user = System.getenv("DB_USER");
            if (user == null) user = System.getenv("MYSQLUSER");

            String pass = System.getenv("DB_PASS");
            if (pass == null) pass = System.getenv("MYSQLPASSWORD");

            String dbUrlEnv = System.getenv("DB_URL");
            String mysqlUrlEnv = System.getenv("MYSQL_URL");

            // 1. Explicit DB_URL
            if (dbUrlEnv != null && dbUrlEnv.startsWith("jdbc:mysql://")) {
                url = dbUrlEnv;
            }
            // 2. Parse Railway's mysql:// format
            else if (mysqlUrlEnv != null && mysqlUrlEnv.startsWith("mysql://")) {
                try {
                    java.net.URI dbUri = new java.net.URI(mysqlUrlEnv);
                    String host = dbUri.getHost();
                    int port = dbUri.getPort();
                    String path = dbUri.getPath(); // Includes leading slash e.g. /railway
                    
                    url = "jdbc:mysql://" + host + ":" + (port != -1 ? port : 3306) + path;
                    
                    if (dbUri.getUserInfo() != null) {
                        String[] userInfo = dbUri.getUserInfo().split(":");
                        if (userInfo.length > 0 && user == null) user = userInfo[0];
                        if (userInfo.length > 1 && pass == null) pass = userInfo[1];
                    }
                } catch (Exception e) {
                    System.err.println("Failed to parse MYSQL_URL: " + e.getMessage());
                }
            }
            // 3. Fallback to Railway component variables
            else if (System.getenv("MYSQLHOST") != null) {
                String host = System.getenv("MYSQLHOST");
                String port = System.getenv("MYSQLPORT") != null ? System.getenv("MYSQLPORT") : "3306";
                String db = System.getenv("MYSQLDATABASE") != null ? System.getenv("MYSQLDATABASE") : "railway";
                url = "jdbc:mysql://" + host + ":" + port + "/" + db;
            }
            // 4. Local environment fallback
            else {
                url = "jdbc:mysql://localhost:3306/mobile_store";
                if (user == null) user = "root";
                if (pass == null) pass = "root";
            }

            // Append standard JDBC properties
            if (url != null && !url.contains("?")) {
                url += "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            }

            connection = DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            System.err.println("Database connection failed during getConnection()!");
            e.printStackTrace();
        }

        return connection;
    }
}