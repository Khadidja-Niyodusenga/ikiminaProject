
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
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
                <a href="MemberDashboard.jsp"><img src="dashboard.jfif" alt="Dashboard">Dashboard</a>
                <a href="individualContribution.jsp"><img src="guestnew.jfif" alt="Guest">View Contribution</a>
                <a href="WithdrawForm.jsp"><img src="normal.jfif" alt="Normal Staff">Make Withdraw</a>
                <a href="individualLoan.jsp"><img src="credit comi.png" alt="Credit Committee">View loan</a>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Payment</a>
<!--                <a href="vicepresidentdashboard.html"><img src="vice.png" alt="Vice President">Vice President</a>
                <a href="presidentdashboard.html"><img src="pres.jfif" alt="President">President</a>
                <a href="superadmin.html"><img src="adnew.jfif" alt="Super Admin">Super Admin</a>-->
                
                <a href="logout.html"><img src="log out.png" alt="Log out">Log out</a>
            </nav>
        </aside>

        <main class="main-content">
            <h2>Add Contribution</h2>
            <form action="AddContributionIndividual" method="post">
                <!-- Retrieve the member ID from session -->
                <%
                    Integer memberId = (Integer) session.getAttribute("userId");
                    if (memberId == null) {
                        response.sendRedirect("loginform.jsp");
                        return;
                    }
                %>
                
                <!-- Hidden input field for Member ID -->
                <input type="hidden" id="mid" name="mid" value="<%= memberId %>"/>
                
                <label for="contribution_date">Contribution Date:</label>
                <input type="date" id="contribution_date" name="contribution_date" required/><br/><br/>

                <label for="amount">Amount:</label>
                <input type="number" id="amount" name="amount" step="0.01" required/><br/><br/>

                <input type="submit" value="Add Contribution"/>
            </form>
        </main>
    </div>

    <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 IKIMINA. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
