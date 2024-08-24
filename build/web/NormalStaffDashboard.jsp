<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Normal Staff Dashboard</title>
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
            justify-content: center;
            gap: 20px;
        }

        .dashboard-link {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            width: 200px;
            transition: transform 0.3s, box-shadow 0.3s;
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

        .dashboard-link:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
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
      session = request.getSession(false);
        String position = (session != null) ? (String) session.getAttribute("position") : null;

        if (session == null || !"normal staff".equalsIgnoreCase(position)) {
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
                <a href="NormalStaffDashboard.jsp"><img src="dashboard.jfif" alt="Dashboard">Dashboard</a><br/>
                <a href="individualContributionNormal.jsp"><img src="guestnew.jfif" alt="Guest">Contribution</a><br/>
                <a href="viewIndividualWithNormal.jsp"><img src="normal.jfif" alt="Normal Staff"> Withdraw</a><br/>
                <a href="individualLoanNormal.jsp"><img src="credit comi.png" alt="Credit Committee">loan</a><br/>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Payment</a><br/>
                 
<!--                <a href="vicepresidentdashboard.html"><img src="vice.png" alt="Vice President">Vice President</a>
                <a href="presidentdashboard.html"><img src="pres.jfif" alt="President">President</a>
                <a href="superadmin.html"><img src="adnew.jfif" alt="Super Admin">Super Admin</a>-->
                
                <a href="LogoutServlet"><img src="log out.png" alt="Log out">Logout</a>
            </nav>
        </aside>
        

        <main class="main-content">
            <header>
                <h1>Normal Staff Dashboard</h1>
            </header>
            
            <div class="dashboard-links">
                <div class="dashboard-link">
                    <img src="cont.jpg" alt="Contribution">
                    <a href="ListContributionIndiv.jsp">View Contributions</a>
                </div>
                <div class="dashboard-link">
                    <img src="loa.jpg" alt="Loan">
                    <a href="LoanLisIndiv.jsp">Manage Loans</a>
                </div>
                <div class="dashboard-link">
                    <img src="memb.jpg" alt="Member">
                    <a href="listMembersIndivNormal.jsp">Manage Members</a>
                </div>
                <div class="dashboard-link">
                    <img src="paym.jpg" alt="Payment">
                    <a href="payment.html">View Payments</a>
                </div>
                <div class="dashboard-link">
                    <img src="profit.jpg" alt="Profit">
                    <a href="profit.html">View Profit</a>
                </div>
<!--                <div class="dashboard-link">
                    <img src="requestm.jpg" alt="Request Membership">
                    <a href="ListRequests.jsp">Manage Membership Requests</a>
                </div>-->
                <div class="dashboard-link">
                    <img src="staff.png" alt="Staff">
                    <a href="staff.html">Manage Staff</a>
                </div>
                <div class="dashboard-link">
                    <img src="withdraw-7012514-5747081.webp" alt="Withdraw">
                    <a href="ListWithIndividualNormal.jsp">Manage Withdrawals</a>
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
