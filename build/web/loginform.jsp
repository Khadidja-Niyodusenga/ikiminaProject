<!--<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 300px;
            text-align: center;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #007BFF;
            border: none;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .links {
            margin-top: 10px;
        }
        .links a {
            color: #007BFF;
            text-decoration: none;
        }
        .links a:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <br>
            <button type="submit">Login</button>
        </form>
        <div class="links">
            <a href="forgotPassword.jsp">Forgot Password?</a>
            <br>
            
        </div>
        <c:if test="${param.error == 'true'}">
            <p class="error">Invalid username or password.</p>
        </c:if>
    </div>
</body>
</html>-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financial Cooperative at IPRC Karongi</title>
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
            flex-direction: column;
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
            padding: 20px;
            background-color: #f0f0f0;
            flex: 1;
                  }
        
        h1 {
            padding:0px;
            font-size: 30px;
            color: #4a90e2; /* Light blue */
            text-align: center;
        }
        
        .dashboard-header {
            margin-bottom: 20px;
        }
        
        .dashboard-header h2 {
            margin-bottom: 5px;
        }
        
        .dashboard-header p {
            color: #888;
            margin-top: 0;
        }
        
        .dashboard-stats {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .stat-box {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 100%;
            max-width: 300px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .stat-box h3 {
            margin-top: 0;
            color: #888;
            font-weight: normal;
        }
        
        .stat-box .value {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 80vh;
        }
        
        .login-form {
            background: #fff;
            padding: 10px 20px; /* Reduced top and bottom padding */
            margin-top: 20px; /* Adjust if necessary */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 300px;
            text-align: center;
        }
        
        input[type="text"], 
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        button {
            width: 100%;
            padding: 10px;
            background-color: #4a90e2; /* Light blue */
            border: none;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }
        
        button:hover {
            background-color: #357abd; /* Darker blue */
        }
        
        .links {
            margin-top: 10px;
        }
        
        .links a {
            color: #4a90e2; /* Light blue */
            text-decoration: none;
        }
        
        .links a:hover {
            text-decoration: underline;
        }
        
        .error {
            color: red;
        }
        
        footer {
            background-color: #4a90e2; /* Light blue */
            color: white;
            text-align: center;
            padding: 10px;
            position: relative;
            width: 100%;
            bottom: 0;
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

            .dashboard-stats {
                flex-direction: column;
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
                <a href="guest.html"><img src="guestnew.jfif" alt="Guest">GUEST</a>
                <a href="loginform.jsp"><img src="dashboard.jfif" alt="Dashboard">LOGIN</a>
                
                <a href="LogoutServlet"><img src="log out.png" alt="Log out">Log out</a>
            </nav>
        </aside>
        
        <main class="main-content">
            <header>
                <h1>Login</h1>
            </header>
            <% if (request.getAttribute("error") != null) { %>
    <div style="color: red;">
        <%= request.getAttribute("error") %>
    </div>
<% } %>
            <div class="login-container">
                <div class="login-form">
                    <form action="LoginServlet" method="post">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" required>
                        <br>
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                        <br>
                        <button type="submit">Login</button>
                    </form>
                    <div class="links">
                        <a href="forgotPassword.jsp">Forgot Password?</a>
                    </div>
                    
                </div>
            </div>
        </main>
    </div>
    
    <footer>
        <p>&copy; 2024 IKIMINA. All rights reserved.</p>
    </footer>
</body>
</html>

