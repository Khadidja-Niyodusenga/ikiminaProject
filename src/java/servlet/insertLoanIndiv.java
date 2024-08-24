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


public class insertLoanIndiv extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int mid = Integer.parseInt(request.getParameter("mid"));
        double loanAmount = Double.parseDouble(request.getParameter("loan_amount"));
        double interest = Double.parseDouble(request.getParameter("interest"));
        String requestLoanDate = request.getParameter("request_loan_date");
        String loanStatus = "pending";
        String reasonForLoan = request.getParameter("reason_for_loan");
        String approval = "Not Approved";
        String paymentDate = request.getParameter("payment_date");

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish connection
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL insert statement
            String sql = "INSERT INTO loan (mid, loan_amount, interest, request_loan_date, loan_status, reason_for_loan, approval, payment_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, mid);
            pstmt.setDouble(2, loanAmount);
            pstmt.setDouble(3, interest);
            pstmt.setString(4, requestLoanDate);
            pstmt.setString(5, loanStatus);
            pstmt.setString(6, reasonForLoan);
            pstmt.setString(7, approval);
            pstmt.setString(8, paymentDate);

            // Execute update
            pstmt.executeUpdate();
            
            // Redirect to a success page or loan list
            response.sendRedirect("thankkloanIndiv.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Redirect to an error page
            response.sendRedirect("jsp/error.jsp");
        } finally {
            // Clean up resources
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
