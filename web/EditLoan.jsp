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
                <a href="index.html"><img src="dashboard.jfif" alt="Dashboard">Dashboard</a><br>
                <a href="guest.html"><img src="guestnew.jfif" alt="Guest">Guest</a><br>
                <a href="normalstaff.html"><img src="normal.jfif" alt="Normal Staff">Normal Staff</a><br>
                <a href="makingdecision.html"><img src="credit comi.png" alt="Credit Committee">Credit Committee</a><br>
                <a href="listContribution"><img src="acc.png" alt="Accountant">Accountant</a><br>
                <a href="vicepresidentdashboard.html"><img src="vice.png" alt="Vice President">Vice President</a><br>
                <a href="presidentdashboard.html"><img src="pres.jfif" alt="President">President</a><br>
                <a href="superadmin.html"><img src="adnew.jfif" alt="Super Admin">Super Admin</a><br><br><br><br>
                <a href="settings.html"><img src="sett.png" alt="Settings">Settings</a><br>
                <a href="logout.html"><img src="log out.png" alt="Log out">Log out</a><br>
            </nav>
        </aside>

        <main class="main-content">
            <header>
                <h1>FINANCIAL COOPERATIVE AT IPRC KARONGI</h1>
            </header>
    <h1>Edit Loan Request</h1>
    <%
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int loanId = Integer.parseInt(request.getParameter("loan_id"));

        String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
        String user = "root"; // Replace with your MySQL username
        String password = ""; // Replace with your MySQL password

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish a database connection
            con = DriverManager.getConnection(url, user, password);

            // Fetch the existing loan request details
            String sql = "SELECT loan_id, mid, loan_amount, interest, request_loan_date, loan_status, reason_for_loan, approval, payment_date FROM loan WHERE loan_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, loanId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int mid = rs.getInt("mid");
                double loanAmount = rs.getDouble("loan_amount");
                double interest = rs.getDouble("interest");
                java.sql.Date requestLoanDate = rs.getDate("request_loan_date");
                String loanStatus = rs.getString("loan_status");
                String reasonForLoan = rs.getString("reason_for_loan");
                String approval = rs.getString("approval");
                java.sql.Date paymentDate = rs.getDate("payment_date");
    %>
    <form action="UpdateLoan" method="post">
        <input type="hidden" name="loan_id" value="<%= loanId %>">
        <label for="mid">Member ID:</label>
        <input type="text" id="mid" name="mid" value="<%= mid %>" required>
        <label for="loan_amount">Loan Amount:</label>
        <input type="number" id="loan_amount" name="loan_amount" step="0.01" value="<%= loanAmount %>" required>
        <label for="interest">Interest:</label>
        <input type="number" id="interest" name="interest" step="0.01" value="<%= interest %>" required>
        <label for="request_loan_date">Request Loan Date:</label>
        <input type="date" id="request_loan_date" name="request_loan_date" value="<%= requestLoanDate != null ? requestLoanDate.toLocalDate() : "" %>" required>
        <label for="loan_status">Loan Status:</label>
        <input type="text" id="loan_status" name="loan_status" value="<%= loanStatus %>" required>
        <label for="reason_for_loan">Reason for Loan:</label>
        <textarea id="reason_for_loan" name="reason_for_loan" rows="4" required><%= reasonForLoan %></textarea>
        <label for="approval">Approval:</label>
        <input type="text" id="approval" name="approval" value="<%= approval %>" required>
        <label for="payment_date">Payment Date:</label>
        <input type="date" id="payment_date" name="payment_date" value="<%= paymentDate != null ? paymentDate.toLocalDate() : "" %>">
        <button type="submit">Update</button>
    </form>
    <%
            } else {
    %>
    <p>Loan request not found.</p>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
    <p>Error: <%= e.getMessage() %></p>
    <%
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    %>
</main>
    </div>

    <footer>
        <div class="footer-bottom">
            <p>&copy; 2024 IKIMINA. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
