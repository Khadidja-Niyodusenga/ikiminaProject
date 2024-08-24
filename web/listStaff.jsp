<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contributions List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .button {
            padding: 5px 10px;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            border-radius: 3px;
        }
        .button.delete {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <h1>Contributions List</h1>
    <table>
        <thead>
            <tr>
                <th>Staff ID</th>
                <th>FirstName</th>
                <th>LastName</th>
                <th>Email</th>
                <th>phone</th>
                <th>position</th>
                <th>status</th>
                
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    // Load MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Database URL and credentials
                    String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
                    String user = "root"; // Replace with your MySQL username
                    String password = ""; // Replace with your MySQL password

                    // Establish a database connection
                    con = DriverManager.getConnection(url, user, password);
                    
                    // Create a Statement object to execute SQL queries
                    stmt = con.createStatement();
                    String sql = "SELECT * FROM staff";
                    rs = stmt.executeQuery(sql);

                    // Iterate through the result set and display data
                    while (rs.next()) {
                int staffid=rs.getInt(1);
                String fname=rs.getString(2);
                String lname=rs.getString(3);
                String email=rs.getString(4);
                String phone=rs.getString(5);
                String position=rs.getString(6);
                String status=rs.getString(7);
            %>
            <tr>
                <td><%= staffid %></td>
                <td><%= fname %></td>
                <td><%=lname %></td>
                <td><%= email %></td>
                <td><%= phone %></td>
                <td><%= position %></td>
                <td><%= status %></td>
                <td>
                    <a href="editStaff.jsp?id=<%=staffid %>" class="button">Edit</a>
                    <a href="delStaff?id=<%=staffid %>" class="button delete" onclick="return confirm('Are you sure you want to delete this contribution?');">Delete</a>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="6">Error retrieving data: <%= e.getMessage() %></td>
            </tr>
            <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</body>
</html>
