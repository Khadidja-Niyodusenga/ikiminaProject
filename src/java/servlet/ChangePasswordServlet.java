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
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            response.sendRedirect("loginform.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ikimina_iprckarongi", "root", "");

            // Check if old password is correct
            String query = "SELECT password FROM member WHERE username = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String encryptedOldPassword = encryptPassword(oldPassword);

                // Compare the stored password with the encrypted old password
                if (!storedPassword.equals(encryptedOldPassword)) {
                    request.setAttribute("errorMessage", "Current password does not match.");
                    request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                    return;
                }

                // Update with new encrypted password
                query = "UPDATE member SET password = ? WHERE username = ?";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, encryptPassword(newPassword));
                stmt.setString(2, username);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    request.setAttribute("successMessage", "Password updated successfully.");
                } else {
                    request.setAttribute("errorMessage", "Password update failed.");
                }
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);

            } else {
                request.setAttribute("errorMessage", "Username not found.");
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating password.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private String encryptPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(password.getBytes());
        byte[] byteData = md.digest();

        StringBuilder sb = new StringBuilder();
        for (byte b : byteData) {
            sb.append(String.format("%02x", b));
        }

        return sb.toString();
    }
}
