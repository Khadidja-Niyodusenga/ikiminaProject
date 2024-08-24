package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateContribution extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String contriIdStr = request.getParameter("contri_id");
        String contributionDateStr = request.getParameter("contribution_date");
        String amountStr = request.getParameter("amount");
        String status = request.getParameter("status");

        // Validate parameters
        if (contriIdStr == null || contributionDateStr == null || amountStr == null || status == null ||
            contriIdStr.isEmpty() || contributionDateStr.isEmpty() || amountStr.isEmpty() || status.isEmpty()) {
            response.getWriter().println("Error: One or more parameters are missing or empty.");
            return;
        }

        int contriId = 0;
        java.sql.Date contributionDate = null;
        double amount = 0;

        try {
            // Parse parameters
            contriId = Integer.parseInt(contriIdStr);
            contributionDate = java.sql.Date.valueOf(contributionDateStr);
            amount = Double.parseDouble(amountStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Error parsing numeric values: " + e.getMessage());
            return;
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Error parsing date value: " + e.getMessage());
            return;
        }

        // Database connection details
        String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
        String user = "root"; // Replace with your MySQL username
        String password = ""; // Replace with your MySQL password

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a database connection
            con = DriverManager.getConnection(url, user, password);

            // Update the contribution details
            String sql = "UPDATE contribution SET contribution_date = ?, amount = ?, status = ? WHERE contri_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setDate(1, contributionDate);
            pstmt.setDouble(2, amount);
            pstmt.setString(3, status);
            pstmt.setInt(4, contriId);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("listContributions.jsp"); // Redirect to the list page or a success page
            } else {
                response.getWriter().println("Error updating contribution. No rows updated.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close resources in the reverse order of opening
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
