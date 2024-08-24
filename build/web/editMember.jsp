<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Member</title>
    <style>
        form {
            max-width: 500px;
            margin: auto;
        }
        label {
            display: block;
            margin: 8px 0 4px;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            padding: 10px 15px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .button.cancel {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <h1>Edit Member</h1>
    <%
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String memberId = request.getParameter("id");

        if (memberId != null && !memberId.isEmpty()) {
            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Database URL and credentials
                String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
                String user = "root"; // Replace with your MySQL username
                String password = ""; // Replace with your MySQL password

                // Establish a database connection
                con = DriverManager.getConnection(url, user, password);

                // Retrieve member details
                String sql = "SELECT * FROM member WHERE mid = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(memberId));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String rmid = rs.getString("rmid");
                    String firstname = rs.getString("firstname");
                    String lastname = rs.getString("lastname");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    java.sql.Date approvedDate = rs.getDate("approved_date");
            %>
            <form action="UpdateMember" method="post">
                <input type="hidden" name="mid" value="<%= memberId %>">
                <label for="rmid">RMID</label>
                <input type="text" id="rmid" name="rmid" value="<%= rmid %>" required>
                
                <label for="firstname">First Name</label>
                <input type="text" id="firstname" name="firstname" value="<%= firstname %>" required>
                
                <label for="lastname">Last Name</label>
                <input type="text" id="lastname" name="lastname" value="<%= lastname %>" required>
                
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= email %>" required>
                
                <label for="phone">Phone</label>
                <input type="text" id="phone" name="phone" value="<%= phone %>" required>
                
                <label for="approved_date">Approved Date</label>
                <input type="date" id="approved_date" name="approved_date" value="<%= approvedDate.toLocalDate() %>" required>
                
                <button type="submit">Update</button>
                <a href="listMembers.jsp" class="button cancel">Cancel</a>
            </form>
            <%
                } else {
                    out.println("<p>Member not found.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error retrieving member details: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        } else {
            response.sendRedirect("listMembers.jsp");
        }
    %>
</body>
</html>
