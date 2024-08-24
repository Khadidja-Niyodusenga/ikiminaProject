<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>President Dashboard</title>
    <style>
        body, html {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100%;
            box-sizing: border-box;
        }

        .container {
            display: flex;
            flex-direction: row;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: #4a90e2; /* Light blue */
            color: white;
            padding: 20px;
            box-sizing: border-box;
            border-top-right-radius: 30px;
            border-bottom-right-radius: 30px;
            position: fixed;
            height: 100%;
            overflow-y: auto;
        }
        
        .sidebar .logo {
            font-size: 24px;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
        }
        
        .sidebar .logo::before {
            color: #ffd700; /* Gold */
            margin-right: 10px;
            font-size: 28px;
        }
        
        .sidebar a {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .sidebar a img {
            border-radius: 50%;
            width: 24px;
            height: 24px;
            margin-right: 10px;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px 40px;
            background-color: #f0f0f0;
            flex: 1;
            box-sizing: border-box;
        }

        h1 {
            color: #4a90e2; /* Light blue */
            font-size: 24px;
            text-align: center;
            margin: 20px 0;
        }

        h2 {
            color: #333;
            font-size: 20px;
            margin-bottom: 20px;
        }

        form {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"],
        input[type="date"],
        select {
            width: calc(100% - 22px); /* Adjust width for padding */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4a90e2; /* Light blue */
            color: white;
            border: none;
            padding: 15px 20px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #357abd; /* Darker blue */
        }

        footer {
            text-align: center;
            background-color: #4a90e2; /* Light blue */
            color: white;
            padding: 10px 0;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: static;
                border-radius: 0;
            }

            .main-content {
                margin-left: 0;
            }
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
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

        th {
            background-color: #4a90e2; /* Light blue */
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        a.action-link {
            color: #4a90e2; /* Light blue */
            text-decoration: none;
            font-weight: bold;
        }

        a.action-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
     <aside class="sidebar">
            <div class="logo">
                <img src="one.png" alt="KIMINA"> &nbsp;
                <span>KIMINA</span>
            </div>
            <nav>
                <a href="presidentdashboard.jsp"><img src="dashboard.jfif" alt="Dashboard">Dashboard</a><br>
                <a href="individualContributionPres.jsp"><img src="guestnew.jfif" alt="Guest">Contribution</a><br>
                <a href="viewIndividualWithPres.jsp"><img src="normal.jfif" alt="Normal Staff"> Withdraw</a><br>
                <a href="individualLoanPres.jsp"><img src="credit comi.png" alt="Credit Committee">Loan</a><br>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Payment</a><br>
                <a href="NormalStaffDashboardPres.jsp"><img src="normal.jfif" alt="Normal Staff">Normal Staff</a><br>
                <a href="credit.jsp"><img src="credit comi.png" alt="Credit Committee">Credit Committee</a><br>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Accountant</a><br>
                <a href="vicepresidentdashboard.html"><img src="vice.png" alt="Vice President">Vice President</a><br>
                <a href="LogoutServlet"><img src="log out.png" alt="Log out">Logout</a><br>
            </nav>
        </aside>
        <main class="main-content">
            <header>
                <h1>FINANCIAL COOPERATIVE AT IPRC KARONGI</h1>
            </header>
    <h1>Members List</h1>
    <table>
        <thead>
            <tr>
                <th>Mid</th>
                <th>Rmid</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Approved Date</th>
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
                    String sql = "SELECT mid, rmid, firstname, lastname, email, phone, approved_date FROM member";
                    rs = stmt.executeQuery(sql);

                    // Iterate through the result set and display data
                    while (rs.next()) {
                        int mid = rs.getInt("mid");
                        String rmid = rs.getString("rmid");
                        String firstname = rs.getString("firstname");
                        String lastname = rs.getString("lastname");
                        String email = rs.getString("email");
                        String phone = rs.getString("phone");
                        java.sql.Date approvedDate = rs.getDate("approved_date");
            %>
            <tr>
                <td><%= mid %></td>
                <td><%= rmid %></td>
                <td><%= firstname %></td>
                <td><%= lastname %></td>
                <td><%= email %></td>
                <td><%= phone %></td>
                <td><%= approvedDate %></td>
                <td>
                    <a href="editMemberPres.jsp?id=<%= mid %>" class="button">Edit</a>
                    <a href="deleteMemberPres?id=<%= mid %>" class="button delete" onclick="return confirm('Are you sure you want to delete this member?');">Delete</a>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="8">Error retrieving data: <%= e.getMessage() %></td>
            </tr>
            <%
                } 
finally {
                    if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                    if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</main>
    </div>

    <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 IKIMINA. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>