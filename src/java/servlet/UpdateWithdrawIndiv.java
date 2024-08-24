package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class UpdateWithdrawIndiv extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rwid = request.getParameter("rwid");
        String mid = request.getParameter("mid");
        String requestDate = request.getParameter("request_date");
        String amountRequested = request.getParameter("amount_requested");
        String reasonToWithdraw = request.getParameter("reason_to_withdraw");
               String withdrawMethod = request.getParameter("withdraw_method");

        String sql = "UPDATE withdraw SET mid = ?, request_date = ?, amount_requested = ?, reason_to_withdraw = ?, withdraw_method = ? WHERE rwid = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, mid);
            pstmt.setString(2, requestDate);
            pstmt.setDouble(3, Double.parseDouble(amountRequested));
            pstmt.setString(4, reasonToWithdraw);
            pstmt.setString(5, withdrawMethod);
            pstmt.setInt(6, Integer.parseInt(rwid));

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("viewIndividualWith.jsp");
            } else {
                response.sendRedirect("jsp/error.jsp?message=Failed to update data.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp?message=" + e.getMessage());
        }
    }
}
