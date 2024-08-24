package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class AddStaff1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String fname=request.getParameter("firstname");
       String lname=request.getParameter("lastname");
       String email=request.getParameter("email");
       String phone=request.getParameter("phone");
       String position=request.getParameter("position");
       String status=request.getParameter("status");
      Timestamp time = Timestamp.valueOf(LocalDateTime.now());
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
            String DB_USER = "root";
            String DB_PASSWORD = "";
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO staff (firstname,lastname,email,phone,position,status,timestamp) VALUES (?, ?, ?, ?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, position);
            ps.setString(6, status);
            ps.setTimestamp(7, time);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                
                response.sendRedirect("listStaff.jsp");
            } else {
                response.sendRedirect("jsp/error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
