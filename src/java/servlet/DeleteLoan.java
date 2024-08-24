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

public class DeleteLoan extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loanId = request.getParameter("loan_id");

        String sql = "DELETE FROM loan WHERE loan_id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, Integer.parseInt(loanId));

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("LoanList.jsp");
            } else {
                response.sendRedirect("jsp/error.jsp?message=Failed to delete data.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp?message=" + e.getMessage());
        }
    }
}
