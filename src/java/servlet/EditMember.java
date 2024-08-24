package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EditMember extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberId = request.getParameter("id");

        if (memberId != null && !memberId.isEmpty()) {
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Database URL and credentials
                String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
                String user = "root"; // Replace with your MySQL username
                String password = ""; // Replace with your MySQL password

                // Establish a database connection
                con = DriverManager.getConnection(url, user, password);

                // Retrieve member details
                String sql = "SELECT * FROM member WHERE mid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(memberId));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Set member details as request attributes
                    request.setAttribute("member", rs);
                    // Forward to the JSP page
                    request.getRequestDispatcher("/editMember.jsp").forward(request, response);
                } else {
                    // Member not found
                    response.sendRedirect("listMembers.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Handle errors
                response.getWriter().println("Error retrieving member details: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        } else {
            // No memberId provided, redirect to list
            response.sendRedirect("listMembers.jsp");
        }
    }
}
