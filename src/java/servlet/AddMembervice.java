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
import javax.naming.InitialContext;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class AddMembervice extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rmid = request.getParameter("rmid");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String approvedDate = request.getParameter("approved_date");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String position = request.getParameter("position");

        Connection con = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmtUpdate = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ikimina_iprckarongi", "root", "");

            // Insert into member table
            pstmt = con.prepareStatement(
                "INSERT INTO member (rmid, firstname, lastname, email, phone, approved_date, username, password, position) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, Integer.parseInt(rmid));
            pstmt.setString(2, firstname);
            pstmt.setString(3, lastname);
            pstmt.setString(4, email);
            pstmt.setString(5, phone);
            pstmt.setDate(6, Date.valueOf(approvedDate));
            pstmt.setString(7, username);
            pstmt.setString(8, password);
            pstmt.setString(9, position);
            pstmt.executeUpdate();

            // Update the status of the request
            pstmtUpdate = con.prepareStatement(
                "UPDATE request_membership SET status = 'approved' WHERE rmid = ?");
            pstmtUpdate.setInt(1, Integer.parseInt(rmid));
            pstmtUpdate.executeUpdate();

            // Send email with username and password
            sendEmail(email, username, password);

            response.sendRedirect("ListRequestsvice.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (pstmtUpdate != null) try { pstmtUpdate.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    }

    private void sendEmail(String to, String username, String password) {
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
            message.setSubject("Your Membership Details");

            // Set the actual message
            message.setText("Dear Member,\n\nYour membership has been approved.\n\nUsername: " + username + "\nPassword: " + password + "\n\nBest Regards,\nYour Team");

            // Send message
            Transport.send(message);
            System.out.println("Email sent successfully...");
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}

