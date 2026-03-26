<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="utils.DBConnection" %>
<%
    try {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            DatabaseMetaData dbmd = conn.getMetaData();
            ResultSet rs = dbmd.getTables(null, null, "%", new String[] {"TABLE"});
            out.println("<h3>Tables:</h3><ul>");
            while (rs.next()) {
                out.println("<li>" + rs.getString("TABLE_NAME") + "</li>");
            }
            out.println("</ul>");
            conn.close();
        } else {
            out.println("Connection returned null! Check Railway Variables.");
        }
    } catch (Exception e) {
        out.println("<h3>Connection failed!</h3>");
        out.println("<p>Error: " + e.getMessage() + "</p>");
        out.println("<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre>");
    }
%>
