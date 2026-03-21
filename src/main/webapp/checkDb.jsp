<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%
    Connection conn = DBConnection.getConnection();
    if (conn != null) {
        try {
            DatabaseMetaData dbmd = conn.getMetaData();
            ResultSet rs = dbmd.getTables(null, null, "%", new String[] {"TABLE"});
            out.println("<h3>Tables:</h3><ul>");
            while (rs.next()) {
                out.println("<li>" + rs.getString("TABLE_NAME") + "</li>");
            }
            out.println("</ul>");
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            conn.close();
        }
    } else {
        out.println("Connection failed!");
    }
%>
