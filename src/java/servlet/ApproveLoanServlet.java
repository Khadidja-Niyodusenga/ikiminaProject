//package servlet;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
//import java.sql.PreparedStatement;
//import java.sql.SQLException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import javax.mail.*;
//import javax.mail.internet.*;
//import java.util.Properties;
//
//
//public class ApproveloanServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int loanId = Integer.parseInt(request.getParameter("loan_id"));
//        int memberId = Integer.parseInt(request.getParameter("member_id"));
//
//        Connection con = null;
//        PreparedStatement pstmt = null;
//        try {
//            // Database URL and credentials
//            String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
//            String user = "root";
//            String password = "";
//
//            // Establish a database connection
//            con = DriverManager.getConnection(url, user, password);
//
//            // Update the approval status
//            String updateSQL = "UPDATE loan SET approval = 'Approved' WHERE loan_id = ?";
//            pstmt = con.prepareStatement(updateSQL);
//            pstmt.setInt(1, loanId);
//            pstmt.executeUpdate();
//
//            // Send email
//            String memberEmail = getMemberEmail(con, memberId);
//            sendApprovalEmail(memberEmail, loanId);
//
//            response.sendRedirect("presidentdashboardsuper.jsp"); // Redirect to the updated page
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.sendRedirect("jsp/error.jsp"); // Redirect to an error page if needed
//        } finally {
//            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
//            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
//        }
//    }
//
//    private String getMemberEmail(Connection con, int memberId) throws SQLException {
//        // Query to fetch member email by member ID
//        String query = "SELECT email FROM members WHERE member_id = ?";
//        try (PreparedStatement pstmt = con.prepareStatement(query)) {
//            pstmt.setInt(1, memberId);
//            ResultSet rs = pstmt.executeQuery();
//            if (rs.next()) {
//                return rs.getString("email");
//            }
//        }
//        return null;
//    }
//
//    private void sendApprovalEmail(String toEmail, int loanId) {
//        final String fromEmail = "niyokhad@example.com"; // Replace with your email
//        final String password = "rlkodrpfvvxjihrn"; // Replace with your email password
//
//        Properties properties = new Properties();
//        properties.put("mail.smtp.auth", "true");
//        properties.put("mail.smtp.starttls.enable", "true");
//        properties.put("mail.smtp.host", "smtp.gmail.com"); // Replace with your SMTP server
//        properties.put("mail.smtp.port", "587");
//
//        Session session = Session.getInstance(properties, new Authenticator() {
//            @Override
//            protected PasswordAuthentication getPasswordAuthentication() {
//                return new PasswordAuthentication(fromEmail, password);
//            }
//        });
//
//        try {
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(fromEmail));
//            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
//            message.setSubject("Loan Approval Notification");
//            message.setText("Dear Member,\n\nYour loan request with ID " + loanId + " has been approved.\n\nThank you.");
//
//            Transport.send(message);
//        } catch (MessagingException e) {
//            e.printStackTrace();
//        }
//    }
//}
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ApproveLoanServlet")
public class ApproveLoanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int loanId = Integer.parseInt(request.getParameter("loan_id"));
        int memberId = Integer.parseInt(request.getParameter("member_id"));

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
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
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Successfully updated, redirect to success page
                response.sendRedirect("LoanList.jsp"); // Redirect to a success page
            } else {
                // No rows updated, redirect to an error page
                response.sendRedirect("jsp/error.jsp"); // Redirect to an error page
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page if exception occurs
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    private String getReasonForLoan(Connection con, int loanId) throws SQLException {
        String query = "SELECT reason_for_loan FROM loan WHERE loan_id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, loanId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("reason_for_loan");
            }
        }
        return null;
    }
}
