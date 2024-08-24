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
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean validUser = false;
        String position = null;
        int userId = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ikimina_iprckarongi", "root", "");
            
            String sql = "SELECT mid, position FROM member WHERE username = ? AND password = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                validUser = true;
                position = rs.getString("position");
                userId = rs.getInt("mid");
            }

            if (validUser) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("position", position);
                session.setAttribute("userId", userId);

                if ("admin".equalsIgnoreCase(position)) {
                    response.sendRedirect("superadmindashboard.jsp");
                } else if ("normal staff".equalsIgnoreCase(position)) {
                    response.sendRedirect("NormalStaffDashboard.jsp");
                } else if ("member".equalsIgnoreCase(position)) {
                    response.sendRedirect("MemberDashboard.jsp");
                }
                else if ("credit commit".equalsIgnoreCase(position)) {
                    response.sendRedirect("creditDashboard.jsp");
                }
                else if ("president".equalsIgnoreCase(position)) {
                    response.sendRedirect("presidentdashboard.jsp");
                }else if ("vice president".equalsIgnoreCase(position)) {
                    response.sendRedirect("vicepresidentdashboard.jsp");
                }
                else {
                    request.setAttribute("error", "User role is not recognized.");
                    request.getRequestDispatcher("loginform.jsp").forward(request, response);
                }
                
            } else {
                request.setAttribute("error", "Invalid username or password.");
                request.getRequestDispatcher("loginform.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database driver not found.");
            request.getRequestDispatcher("loginform.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error.");
            request.getRequestDispatcher("loginform.jsp").forward(request, response);
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    }
}
