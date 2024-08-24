package servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class insertIndivWithNormal extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Register the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Get form parameters
            String mid = request.getParameter("mid");
            String requestDate = request.getParameter("request_date");
            String amountRequested = request.getParameter("amount_requested");
            String reasonToWithdraw = request.getParameter("reason_to_withdraw");
            String approvalDate = request.getParameter("approval_date");
            String withdrawMethod = request.getParameter("withdraw_method");
String status= "pending";
            // SQL query to insert data
            String sql = "INSERT INTO withdraw (mid, request_date, amount_requested, reason_to_withdraw, withdraw_method,status) VALUES (?, ?, ?, ?, ?,?)";

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setString(1, mid);
                pstmt.setString(2, requestDate);
                pstmt.setDouble(3, Double.parseDouble(amountRequested));
                pstmt.setString(4, reasonToWithdraw);
                  pstmt.setString(5, withdrawMethod);
 pstmt.setString(6 ,status);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("thanks.jsp");
                } else {
                    response.sendRedirect("jsp/error.jsp?message=Failed to insert data.");
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp?message=" + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp?message=" + e.getMessage());
        }
    }
}
