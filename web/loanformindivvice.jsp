<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Loan</title>
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
        input[type="date"],
        textarea {
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
                <a href="vicepresidentdashboard.jsp"><img src="dashboard.jfif" alt="Dashboard">Dashboard</a><br>
                <a href="individualContributionvice.jsp"><img src="guestnew.jfif" alt="Guest">Contribution</a><br>
                <a href="viewIndividualWithvice.jsp"><img src="normal.jfif" alt="Normal Staff"> Withdraw</a><br>
                <a href="individualLoanvice.jsp"><img src="credit comi.png" alt="Credit Committee">Loan</a><br>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Payment</a><br>
                <a href="NormalStaffDashboardvice.jsp"><img src="normal.jfif" alt="Normal Staff">Normal Staff</a><br>
                <a href="creditDashboard.jsp"><img src="credit comi.png" alt="Credit Committee">Credit Committee</a><br>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Accountant</a><br>
                <br>
                <a href="LogoutServlet"><img src="log out.png" alt="Log out">Logout</a><br>
            </nav>
        </aside>
        <main class="main-content">
            <header>
                <h1>FINANCIAL COOPERATIVE AT IPRC KARONGI</h1>
            </header>
            <h1>Request Loan</h1>
            <form action="insertLoanIndivvice" method="post">
                <!-- Retrieve the member ID from session -->
                <%
                     session = request.getSession(false);
                    if (session == null || session.getAttribute("userId") == null) {
                        response.sendRedirect("loginform.jsp");
                        return;
                    }
                    Integer memberId = (Integer) session.getAttribute("userId");
                %>
                
                <!-- Hidden input field for Member ID -->
                <input type="hidden" name="mid" value="<%= memberId %>" />
                
                <label for="loan_amount">Loan Amount:</label>
                <input type="text" id="loan_amount" name="loan_amount" required /><br/>
                
                <label for="interest">Interest:</label>
                <input type="text" id="interest" name="interest" required /><br/>
                
                <label for="request_loan_date">Request Loan Date:</label>
                <input type="date" id="request_loan_date" name="request_loan_date" required /><br/>
                
                <label for="reason_for_loan">Reason for Loan:</label>
                <textarea id="reason_for_loan" name="reason_for_loan" rows="4" required></textarea><br/>
                
                <label for="payment_date">Payment Date:</label>
                <input type="date" id="payment_date" name="payment_date" /><br/>
                 <label for="payment_date">Guarantor Email:</label> <input type="email" name="payment_date" /><br/>
                <label for="payment_date">Remaining Loan:</label> <input type="date" name="payment_date" /><br/>
        <button type="submit">Submit Loan Request</button>
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
