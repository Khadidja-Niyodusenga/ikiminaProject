package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class updateStaff extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       int id=Integer.parseInt(request.getParameter("id"));
       String fname=request.getParameter("firstname");
       String lname=request.getParameter("lastname");
       String email=request.getParameter("email");
       String phone=request.getParameter("phone");
       String position=request.getParameter("position");
       String status=request.getParameter("status");
      

        String sql = "UPDATE staff SET firstname = ?, lastname = ?, email = ?, phone = ?, position = ?, status = ?WHERE staff_id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, position);
            ps.setString(6, status);
            ps.setInt(7, id);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("listStaff.jsp");
            } else {
                response.sendRedirect("jsp/error.jsp?message=Failed to update loan data.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp?message=" + e.getMessage());
        }
    }
}
