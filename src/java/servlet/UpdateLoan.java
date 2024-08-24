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

public class UpdateLoan extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loanId = request.getParameter("loan_id");
        String mid = request.getParameter("mid");
        String loanAmount = request.getParameter("loan_amount");
        String interest = request.getParameter("interest");
        String requestLoanDate = request.getParameter("request_loan_date");
        String loanStatus = request.getParameter("loan_status");
        String reasonForLoan = request.getParameter("reason_for_loan");
        String approval = request.getParameter("approval");
        String paymentDate = request.getParameter("payment_date");

        String sql = "UPDATE loan SET mid = ?, loan_amount = ?, interest = ?, request_loan_date = ?, loan_status = ?, reason_for_loan = ?, approval = ?, payment_date = ? WHERE loan_id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, Integer.parseInt(mid));
            pstmt.setDouble(2, Double.parseDouble(loanAmount));
            pstmt.setDouble(3, Double.parseDouble(interest));
            pstmt.setDate(4, requestLoanDate.isEmpty() ? null : java.sql.Date.valueOf(requestLoanDate));
            pstmt.setString(5, loanStatus);
            pstmt.setString(6, reasonForLoan);
            pstmt.setString(7, approval);
            pstmt.setDate(8, paymentDate.isEmpty() ? null : java.sql.Date.valueOf(paymentDate));
            pstmt.setInt(9, Integer.parseInt(loanId));

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("LoanList.jsp");
            } else {
                response.sendRedirect("jsp/error.jsp?message=Failed to update loan data.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp?message=" + e.getMessage());
        }
    }
}
