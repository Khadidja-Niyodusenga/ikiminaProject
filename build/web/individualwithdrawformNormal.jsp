<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.text.SimpleDateFormat" %>
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
        select,
        textarea {
            width: calc(100% - 22px); /* Adjust width for padding */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }
        input[type="submit"],
        button {
            background-color: #4a90e2; /* Light blue */
            color: white;
            border: none;
            padding: 15px 20px;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover,
        button:hover {
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
        
        .hidden {
            display: none;
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
                <a href="NormalStaffDashboard.jsp"><img src="dashboard.jfif" alt="Dashboard">Dashboard</a>
                <a href="individualContributionNormal.jsp"><img src="guestnew.jfif" alt="Guest">Contribution</a>
                <a href="viewIndividualWithNormal.jsp"><img src="normal.jfif" alt="Normal Staff"> Withdraw</a>
                <a href="individualLoanNormal.jsp"><img src="credit comi.png" alt="Credit Committee">loan</a>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Payment</a>
                
<!--                <a href="vicepresidentdashboard.html"><img src="vice.png" alt="Vice President">Vice President</a>
                <a href="presidentdashboard.html"><img src="pres.jfif" alt="President">President</a>
                <a href="superadmin.html"><img src="adnew.jfif" alt="Super Admin">Super Admin</a>-->
                <a href="settings.html"><img src="sett.png" alt="Settings">Settings</a>
                <a href="LogoutServlet"><img src="log out.png" alt="Log out">Logout</a>
            </nav>
        </aside>


        <main class="main-content">
            <header>
                <h1>FINANCIAL COOPERATIVE AT IPRC KARONGI</h1>
            </header>
            <h2>Submit Withdraw Request</h2>
            <form action="insertIndivWithNormal" method="post">
                <!-- Retrieve the member ID from session -->
                <%
                    Integer memberId = (Integer) session.getAttribute("userId");
                    if (memberId == null) {
                        response.sendRedirect("loginform.jsp");
                        return;
                    }

                    // Get the current date in yyyy-MM-dd format
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String currentDate = sdf.format(new java.util.Date());
                %>
                
                <!-- Hidden input field for Member ID -->
                <input type="hidden" id="mid" name="mid" value="<%= memberId %>"/>
                
                                
                <label for="request_date">Request Date:</label>
                <input type="date" id="request_date" name="request_date" required /><br/>
                
                <label for="amount_requested">Amount Requested:</label>
                <input type="number" id="amount_requested" name="amount_requested" step="0.01" required /><br/>
                
                <label for="reason_to_withdraw">Reason to Withdraw:</label>
                <textarea id="reason_to_withdraw" name="reason_to_withdraw" rows="4" required></textarea><br/>
                
                <label for="withdraw_method">Withdraw Method:</label>
                <input type="text" id="withdraw_method" name="withdraw_method" required /><br/>
                
                <button type="submit">Submit Request</button>
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
