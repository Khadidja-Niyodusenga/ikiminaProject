<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Credit Commit Dashboard</title>
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
    </style>
</head>
<body>
    <%
        HttpSession session = request.getSession(false);
        String position = (session != null) ? (String) session.getAttribute("position") : null;

        if (session == null || !"credit commit".equalsIgnoreCase(position)) {
            response.sendRedirect("loginform.jsp");
            return;
        }
    %>
    <div class="container">
        <aside class="sidebar">
            <div class="logo">
                <img src="one.png" alt="KIMINA"> &nbsp;
                <span>KIMINA</span>
            </div>
            <nav>
                <a href="creditDashboard.jsp"><img src="dashboard.jfif" alt="Dashboard">Dashboard</a><br>
                <a href="individualContributionCred.jsp"><img src="guestnew.jfif" alt="Guest">Contribution</a><br>
                <a href="viewIndividualWithCred.jsp"><img src="normal.jfif" alt="Normal Staff"> Withdraw</a><br>
                <a href="individualLoanCred.jsp"><img src="credit comi.png" alt="Credit Committee">Loan</a><br>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Payment</a><br>
                <a href="NormalStaffDashboardCred.jsp"><img src="normal.jfif" alt="Normal Staff">Normal Staff</a><br>
                
                                <a href="LogoutServlet"><img src="log out.png" alt="Log out">Logout</a><br>
            </nav>
        </aside>

        <main class="main-content">
            <header>
                <h1>Credit Dashboard</h1>
            </header>
            
            <div class="dashboard-links">
                               
                <div class="dashboard-link">
                    <img src="profit.jpg" alt="View Profit for the Entire Group">
                    <a href="#">View Profit </a>
                </div>
                <div class="dashboard-link">
                    <img src="loa.jpg" alt="Final Approve Loan Request">
                    <a href="LoanLisPres.jsp"> Approve Loan Request</a>
                </div>
                <div class="dashboard-link">
                    <img src="loanst.jpg" alt="View Loan Status Report">
                    <a href="LoanLisCred.jsp">View Loan  </a>
                </div>
                <div class="dashboard-link">
                    <img src="cont.jpg" alt="View Contribution Status Report">
                    <a href="ListContributionCred.jsp">View Contribution </a>
                </div>
            </div>
        </main>
    </div>

    <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 IKIMINA. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
