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
        /* Green button styling */
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
            
            <h1>Contributions List</h1>
            <a href="contributeIndividualPres.jsp" class="back-button">Make Contribution</a>
            <table>
                <thead>
                    <tr>
                        
                        <th>Contribution Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                         <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection con = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        session = request.getSession();
                        Integer userId = (Integer) session.getAttribute("userId");

                        if (userId == null) {
                            response.sendRedirect("loginform.jsp");
                            return;
                        }

                        try {
                            // Load MySQL JDBC driver
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            
                            // Database URL and credentials
                            String url = "jdbc:mysql://localhost:3306/ikimina_iprckarongi";
                            String user = "root"; // Replace with your MySQL username
                            String password = ""; // Replace with your MySQL password

                            // Establish a database connection
                            con = DriverManager.getConnection(url, user, password);
                            
                            // Prepare SQL query with parameterized query
                            String sql = "SELECT * FROM contribution WHERE mid = ?";
                            pstmt = con.prepareStatement(sql);
                            pstmt.setInt(1, userId);
                            rs = pstmt.executeQuery();

                            // Iterate through the result set and display data
                            while (rs.next()) {
                                int contributionId = rs.getInt("contri_id");
                                int memberId = rs.getInt("mid");
                                java.sql.Date date = rs.getDate("contribution_date");
                                double amount = rs.getDouble("amount");
                                String status = rs.getString("status");
                    %>
                    <tr>
                     <td><%= date %></td>
                        <td><%= amount %></td>
                        <td><%= status %></td>
                         <td>
                    <a href="editContriIndivPres.jsp?id=<%=contributionId %>" class="button">Edit</a>
                                    </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                    <tr>
                        <td colspan="5">Error retrieving data: <%= e.getMessage() %></td>
                    </tr>
                    <%
                        } finally {
                            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
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
