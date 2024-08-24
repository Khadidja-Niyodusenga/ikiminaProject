<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

        .dashboard-links {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .dashboard-link {
            background-color: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            width: 200px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .dashboard-link:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .dashboard-link img {
            width: 48px;
            height: 48px;
            margin-bottom: 10px;
        }

        .dashboard-link a {
            color: #333;
            text-decoration: none;
            font-size: 16px;
            display: block;
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
                <a href="creditDashboardPres.jsp"><img src="credit comi.png" alt="Credit Committee">Credit Committee</a><br>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Accountant</a><br>
                <a href="vicepresidentdashboardPres.jsp"><img src="vice.png" alt="Vice President">Vice President</a><br>
                <a href="LogoutServlet"><img src="log out.png" alt="Log out">Logout</a><br>
            </nav>
        </aside>

        <main class="main-content">
            <header>
                <h1>FINANCIAL COOPERATIVE AT IPRC KARONGI</h1>
            </header>
            
            <h2>List of Membership Requests</h2>
            <table>
                <tr>
                    <th>RMID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Action</th>
                </tr>
                <%
                    try {
                        InitialContext ctx = new InitialContext();
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ikimina_iprckarongi","root","");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT rmid, firstname, lastname, email, phone FROM request_membership WHERE status='pending'");
                        
                        while (rs.next()) {
                            int rmid = rs.getInt("rmid");
                            String firstname = rs.getString("firstname");
                            String lastname = rs.getString("lastname");
                            String email = rs.getString("email");
                            String phone = rs.getString("phone");
                %>
                    <tr>
                        <td><%= rmid %></td>
                        <td><%= firstname %></td>
                        <td><%= lastname %></td>
                        <td><%= email %></td>
                        <td><%= phone %></td>
                        <td><a class="action-link" href="ApproveRequestPres?rmid=<%= rmid %>">Approve</a></td>
                    </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
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
