package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ListContributions extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Contribution> contributions = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
            String DB_USER = "root";
            String DB_PASSWORD = "";
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT * FROM contribution";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int contriId = rs.getInt("contri_id");
                int mid = rs.getInt("mid");
                String contributionDate = rs.getString("contribution_date");
                double amount = rs.getDouble("amount");
                String status = rs.getString("status");

                contributions.add(new Contribution(contriId, mid, contributionDate, amount, status));
            }

            HttpSession session = request.getSession();
            session.setAttribute("contributions", contributions);
            response.sendRedirect("ListContribution.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}

class Contribution {
    private int contriId;
    private int mid;
    private String contributionDate;
    private double amount;
    private String status;

    // Constructor, Getters, and Setters
    public Contribution(int contriId, int mid, String contributionDate, double amount, String status) {
        this.contriId = contriId;
        this.mid = mid;
        this.contributionDate = contributionDate;
        this.amount = amount;
        this.status = status;
    }

    // Getters and Setters
    public int getContriId() { return contriId; }
    public void setContriId(int contriId) { this.contriId = contriId; }
    public int getMid() { return mid; }
    public void setMid(int mid) { this.mid = mid; }
    public String getContributionDate() { return contributionDate; }
    public void setContributionDate(String contributionDate) { this.contributionDate = contributionDate; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
