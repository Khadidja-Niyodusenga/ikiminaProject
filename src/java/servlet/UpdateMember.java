package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateMember extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        int id = Integer.parseInt(request.getParameter("mid"));
        int rmid = Integer.parseInt(request.getParameter("rmid"));
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String approvedDate = request.getParameter("approved_date");
        
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Initialize database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
            String DB_USER = "root";
            String DB_PASSWORD = "";
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to update member details
            String sql = "UPDATE member SET rmid=?, firstname=?, lastname=?, email=?, phone=?, approved_date=? WHERE mid=?";
            pstmt = conn.prepareStatement(sql);

            // Set parameters
            pstmt.setInt(1, rmid);
            pstmt.setString(2, firstname);
            pstmt.setString(3, lastname);
            pstmt.setString(4, email);
            pstmt.setString(5, phone);
            pstmt.setDate(6, java.sql.Date.valueOf(approvedDate)); // Convert String to java.sql.Date
            pstmt.setInt(7, id);         

            // Execute update
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect to success page or list members page
                response.sendRedirect("listMembers.jsp");
            } else {
                // Handle case where update was not successful
                response.sendRedirect("jsp/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp"); // Redirect to error page on exception
        } finally {
            // Clean up
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
