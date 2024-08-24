package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

public class SelectWithdraw extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rwid = request.getParameter("rwid");

        String sql = "SELECT * FROM withdraw WHERE rwid = " + rwid;

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h2>Withdraw Details</h2>");
            while (rs.next()) {
                out.println("RWID: " + rs.getInt("rwid") + "<br/>");
                out.println("Member ID: " + rs.getString("mid") + "<br/>");
                out.println("Request Date: " + rs.getDate("request_date") + "<br/>");
                out.println("Amount Requested: " + rs.getDouble("amount_requested") + "<br/>");
                out.println("Reason to Withdraw: " + rs.getString("reason_to_withdraw") + "<br/>");
                out.println("Approval Date: " + rs.getDate("approval_date") + "<br/>");
                out.println("Withdraw Method: " + rs.getString("withdraw_method") + "<br/>");
            }
            out.println("</body></html>");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp?message=" + e.getMessage());
        }
    }
}
