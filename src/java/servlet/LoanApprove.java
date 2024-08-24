package servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;


public class LoanApprove extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int loanId = Integer.parseInt(request.getParameter("loan_id"));
        int memberId = Integer.parseInt(request.getParameter("member_id"));

        Connection con = null;
        PreparedStatement pstmt = null;
        try {
            // Database URL and credentials
            String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
            String user = "root";
            String password = "";

            // Establish a database connection
            con = DriverManager.getConnection(url, user, password);

            // Update the approval status
            String updateSQL = "UPDATE loan SET approval = 'Approved' WHERE loan_id = ?";
            pstmt = con.prepareStatement(updateSQL);
            pstmt.setInt(1, loanId);
            pstmt.executeUpdate();

           
            response.sendRedirect("superadmindashboard.jsp"); // Redirect to the updated page

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp"); // Redirect to an error page if needed
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    private String getMemberEmail(Connection con, int memberId) throws SQLException {
        // Query to fetch member email by member ID
        String query = "SELECT email FROM members WHERE member_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, memberId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }
        }
        return null;
    }

    
}
