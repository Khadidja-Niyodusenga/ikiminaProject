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

public class displayStaff extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Staff> staff = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String DB_URL = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
            String DB_USER = "root";
            String DB_PASSWORD = "";
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT * FROM staff";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int staffid=rs.getInt(1);
                String fname=rs.getString(2);
                String lname=rs.getString(3);
                String email=rs.getString(4);
                String phone=rs.getString(5);
                String position=rs.getString(6);
                String status=rs.getString(7);
                

                staff.add(new Staff(staffid,fname,lname,email,phone,position,status));
            }

            HttpSession session = request.getSession();
            session.setAttribute("staffList", staff);
            response.sendRedirect("listStaff.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/error.jsp");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (ps != null) try { ps.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    private static class Staff {
   private int staffid;
    private String firstname;
    private String lastname;
    private String email;
    private String phone;
    private String position;
    private String status;
   
   
        public Staff( int staffid,String fname,String lname,String email,String phone,String p,String status) {
        this.staffid=staffid;
        this.firstname=fname;
        this.lastname=lname;
        this.email=email;
        this.phone=phone;
        this.position=p;
        this.status=status;
       
        }

        public int getStaffid() {
            return staffid;
        }

        public void setStaffid(int staffid) {
            this.staffid = staffid;
        }

        public String getFirstname() {
            return firstname;
        }

        public void setFirstname(String firstname) {
            this.firstname = firstname;
        }

        public String getLastname() {
            return lastname;
        }

        public void setLastname(String lastname) {
            this.lastname = lastname;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getPosition() {
            return position;
        }

        public void setPosition(String position) {
            this.position = position;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

     
        
    }
}

