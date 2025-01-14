<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
            margin: 0;
            font-size: 24px;
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
        
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            max-width: 600px;
            margin: 0 auto;
        }
        
        input[type="text"], input[type="email"], input[type="number"], input[type="date"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        
        input[type="submit"] {
            background-color: #4a90e2; /* Light blue */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
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
                <h1>FINANCIAL COOPERATIVE AT IPRC KARONGI</h1>
            </header>
            
    
              

<center>
               <div  style="margin-left:3%;margin-top: 4%;">
    <h1>Thank You!</h1>
    <p>Thank you for your request, <%= request.getParameter("lastname") %>!</p>
</body>
</div></center>
    </main>
    </div>
    
    <footer>
        <p>&copy; 2024 IKIMINA. All rights reserved.</p>
    </footer>
</body>
</html>
