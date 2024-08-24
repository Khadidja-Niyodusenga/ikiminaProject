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
        .back-button {
    display: inline-block;
    background-color: #28a745; /* Green background */
    color: white;
    padding: 10px 20px;
    border-radius: 4px;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    margin: 20px 0;
    transition: background-color 0.3s;
}

.back-button:hover {
    background-color: #218838; /* Darker green on hover */
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
                <a href="MemberDashboard.jsp"><img src="dashboard.jfif" alt="Dashboard">Dashboard</a><br/>
                <a href="individualContribution.jsp"><img src="guestnew.jfif" alt="Guest">Contribution</a><br/>
                <a href="viewIndividualWith.jsp"><img src="normal.jfif" alt="Normal Staff"> Withdraw</a><br/>
                <a href="individualLoan.jsp"><img src="credit comi.png" alt="Credit Committee">loan</a><br/>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Payment</a><br/>
<!--                <a href="vicepresidentdashboard.html"><img src="vice.png" alt="Vice President">Vice President</a>
                <a href="presidentdashboard.html"><img src="pres.jfif" alt="President">President</a>
                <a href="superadmin.html"><img src="adnew.jfif" alt="Super Admin">Super Admin</a>-->
<!--                <a href="settings.html"><img src="sett.png" alt="Settings">Settings</a>-->
                <a href="LogoutServlet"><img src="log out.png" alt="Log out">Log out</a>
            </nav>
        </aside>

        <main class="main-content">
            <header>
                <h1>FINANCIAL COOPERATIVE AT IPRC KARONGI</h1>
            </header>
    <h1>Withdraw List</h1>
    <a href="individualwithdrawform.jsp" class="back-button">Request Withdraw</a>
    <table>
        <thead>
            <tr>
                <th>Request Date</th>
                <th>Amount Requested</th>
                <th>Reason to Withdraw</th>
                <th>Withdraw Method</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                Integer userId = (Integer) session.getAttribute("userId");

                if (userId == null) {
                    response.sendRedirect("loginform.jsp");
                    return;
                }

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
                    String user = "root"; 
                    String password = ""; 

                    con = DriverManager.getConnection(url, user, password);
                    
                    stmt = con.createStatement();
                    String sql = "SELECT * FROM withdraw WHERE mid = " + userId;
                    rs = stmt.executeQuery(sql);

                    // Iterate through the result set and display data
                    while (rs.next()) {
                        java.sql.Date requestDate = rs.getDate("request_date");
                        double amountRequested = rs.getDouble("amount_requested");
                        String reasonToWithdraw = rs.getString("reason_to_withdraw");
                        String withdrawMethod = rs.getString("withdraw_method");
                        String status = rs.getString("status");
            %>
            <tr>
                <td><%= requestDate %></td>
                <td><%= amountRequested %></td>
                <td><%= reasonToWithdraw %></td>
                <td><%= withdrawMethod %></td>
                   <td><%= status %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="4">Error retrieving data: <%= e.getMessage() %></td>
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
</main>
    </div>

    <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 IKIMINA. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
