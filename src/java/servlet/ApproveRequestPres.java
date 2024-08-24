
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
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class ApproveRequestPres extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int rmid = Integer.parseInt(request.getParameter("rmid"));
        String firstname = "";
        String lastname = "";
        String email = "";
        String phone = "";
        String username = "";
        String password = "";
        try {
            // Load database driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ikimina_iprckarongi", "root", "");

            // Retrieve user details from the database
            PreparedStatement pstmt = con.prepareStatement(
                "SELECT firstname, lastname, email, phone FROM request_membership WHERE rmid = ?");
            pstmt.setInt(1, rmid);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                firstname = rs.getString("firstname");
                lastname = rs.getString("lastname");
                email = rs.getString("email");
                phone = rs.getString("phone");
                
                // Send email with credentials
                sendEmail(email, username, password);

                // Set attributes for JSP
                request.setAttribute("rmid", rmid);
                request.setAttribute("firstname", firstname);
                request.setAttribute("lastname", lastname);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                 // Forward to EnterDetails.jsp
                request.getRequestDispatcher("EnterDetailsPres.jsp").forward(request, response);
            }

            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred: " + e.getMessage());
        }
    }

    private void sendEmail(String recipient, String username, String password) {
        final String fromEmail = "niyokhad@gmail.com"; // Replace with your email
        final String emailPassword = "Niha*55666"; // Replace with your email password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // Gmail SMTP host
        props.put("mail.smtp.port", "587"); // Gmail SMTP port

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, emailPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("Your Account Credentials");

            String msgContent = String.format("Dear \n\n" +
                    "Your account has been approved.\n" +
                    "Username: %s\n" +
                    "Password: %s\n\n" +
                    "Best regards,\n" +
                    "The Team",  username, password);

            message.setText(msgContent);

            Transport.send(message);
            System.out.println("Email sent successfully.");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
