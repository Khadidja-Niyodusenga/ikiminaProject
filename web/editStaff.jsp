<%-- 
    Document   : staffForm
    Created on : Aug 22, 2024, 3:57:17 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int id = Integer.parseInt(request.getParameter("id"));

        String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
        String user = "root"; // Replace with your MySQL username
        String password = ""; // Replace with your MySQL password

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish a database connection
            con = DriverManager.getConnection(url, user, password);

            // Fetch the existing contribution details
            String sql = "SELECT staff_id, firstname,lastname,email,phone,position,status FROM staff WHERE staff_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                
                String fname=rs.getString(2);
                String lname=rs.getString(3);
                String email=rs.getString(4);
                String phone=rs.getString(5);
                String position=rs.getString(6);
                String status=rs.getString(7);
    %>
        
        <form action="updateStaff" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <label>Firstname</label>
            <input type="text" name="firstname" value="<%= fname %>"><br>
            <label>LastName</label>
            <input type="text" name="lastname" value="<%= lname %>"><br>
            <label>EMAIL</label>
            <input type="email" name="email" value="<%= email %>" required ><br>
            <label>Phone</label>
            <input type="text" name="phone" value="<%= phone %>"><br>
            <label>position</label>
            <select name="position">
                <option>select position</option>
                <option>Normal Staff</option>
                <option>Accountant</option>
                <option>Vice President</option>
                <option>President</option>
            </select>
            <label>status</label>
            <input type="text" name="status" value="<%= status %>"><br>
           
            <input type="submit" value="Update Staff"><br>
        </form>
     <%
            } else {
    %>
    <p>Contribution not found.</p>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
    <p>Error: <%= e.getMessage() %></p>
    <%
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    %>
    </body>
</html>
