package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class DisApproveWithdrawvice extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rwidStr = request.getParameter("rwid");

        if (rwidStr == null || rwidStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Request ID is missing.");
            return;
        }

        int rwid = Integer.parseInt(rwidStr);
        Connection con = null;
        PreparedStatement pstmtSelect = null;
        PreparedStatement pstmtUpdate = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ikimina_iprckarongi", "root", "");

            // Fetch withdrawal request details
            pstmtSelect = con.prepareStatement("SELECT * FROM withdraw WHERE rwid = ?");
            pstmtSelect.setInt(1, rwid);
            rs = pstmtSelect.executeQuery();

            if (!rs.next()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Withdrawal request not found.");
                return;
            }

            int memberId = rs.getInt("mid");
            String reasonToWithdraw = rs.getString("reason_to_withdraw");

            // Update withdrawal request status
            pstmtUpdate = con.prepareStatement("UPDATE withdraw SET status = 'Rejected' WHERE rwid = ?");
            pstmtUpdate.setInt(1, rwid);
            pstmtUpdate.executeUpdate();

            // Fetch member email based on memberId
            pstmtSelect = con.prepareStatement("SELECT email FROM member WHERE rmid = ?");
            pstmtSelect.setInt(1, memberId);
            rs = pstmtSelect.executeQuery();

            if (!rs.next()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Member not found.");
                return;
            }

            String email = rs.getString("email");

            // Send email notification
            sendEmail(email, rwid, reasonToWithdraw);

            response.sendRedirect("listWithdrawvice.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (pstmtSelect != null) try { pstmtSelect.close(); } catch (SQLException ignored) {}
            if (pstmtUpdate != null) try { pstmtUpdate.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    }

    private void sendEmail(String to, int rwid, String reasonToWithdraw) {
        final String from = "niyokhad@example.com"; // Sender's email address
        final String host = "smtp.gmail.com"; // SMTP server address
        final String user = "niyokhad@gmail.com"; // Your Gmail address
        final String pass = "rlkodrpfvvxjihrn"; // Your Gmail password or app-specific password

        // Setup mail server properties
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.port", "587"); // Port for TLS/STARTTLS
        properties.setProperty("mail.smtp.starttls.enable", "true"); // Enable STARTTLS

        // Get the Session object
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, pass);
            }
        });

        try {
            // Create a default MimeMessage object
            MimeMessage message = new MimeMessage(session);

            // Set From: header field
            message.setFrom(new InternetAddress(from));

            // Set To: header field
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set Subject: header field
            message.setSubject("Withdrawal Request Approved");

            // Set the actual message
            message.setText("Dear Member,\n\nYour withdrawal request  has not been Approved.\n\nReason for withdrawal: " + reasonToWithdraw + "\n\nBest Regards,\nYour Team");

            // Send message
            Transport.send(message);
            System.out.println("Email sent successfully...");
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}
