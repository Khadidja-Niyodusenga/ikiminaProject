package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("loginform.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Contribution> contributions = new ArrayList<>();

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish database connection
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ikimina_iprckarongi", "root", "");
            
            // Query to fetch contributions for the logged-in member
            String sql = "SELECT contri_id, contribution_date, amount, status FROM contribution WHERE mid = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            // Process result
            while (rs.next()) {
                int contriId = rs.getInt("contri_id");
                String contributionDate = rs.getString("contribution_date");
                double amount = rs.getDouble("amount");
                String status = rs.getString("status");
                
                Contribution contribution = new Contribution(contriId, userId, contributionDate, amount, status);
                contributions.add(contribution);
            }

            // Set contributions list in request and forward to JSP
            request.setAttribute("contributions", contributions);
            request.getRequestDispatcher("userData.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching user data.");
            request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
        } finally {
            // Clean up resources
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    }
}
    