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

public class DeleteContribution extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int contributionId = Integer.parseInt(request.getParameter("id"));
                // Database connection settings
        String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi"; // Replace with your database
        String DB_USER = "root"; // Replace with your database username
        String DB_PASSWORD = ""; // Replace with your database password

        try {
            // Load the database driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish a connection to the database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Prepare the SQL DELETE statement
            String sql = "DELETE FROM contribution WHERE contri_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, contributionId);

            // Execute the DELETE statement
            int rowsAffected = pstmt.executeUpdate();

            // Check if a row was deleted
            if (rowsAffected > 0) {
                // Redirect to a page showing the list of contributions (or another appropriate page)
                response.sendRedirect("listContributions.jsp");
            } else {
                // Handle the case where no rows were affected (e.g., ID not found)
                response.sendRedirect("jsp/error.jsp?message=Contribution%20not%20found");
            }

            // Close resources
            pstmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}
