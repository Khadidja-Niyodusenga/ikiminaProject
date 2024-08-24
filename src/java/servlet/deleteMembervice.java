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

public class deleteMembervice extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int mid = Integer.parseInt(request.getParameter("id"));
        
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String DB_URL="jdbc:mysql://localhost:3306/ikimina_iprckarongi";
            String DB_USER="root";
            String DB_PASSWORD="";
           Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM member WHERE mid = ?");
              pstmt.setInt(1, mid);
            pstmt.executeUpdate();
            response.sendRedirect("listMembersIndivvice.jsp");
            
        } 
             catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}
