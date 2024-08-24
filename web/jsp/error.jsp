<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
            text-align: center;
            color: #333;
        }
        .container {
            max-width: 600px;
            margin: 100px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #e74c3c;
        }
        p {
            font-size: 18px;
        }
        a {
            color: #3498db;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Oops!</h1>
        <p>Something went wrong while processing your request. Please try again later.</p>
        <p>If the problem persists, please <a href="contact.jsp">contact support</a>.</p>
        <p><a href="/final/index.html">Return to Home</a></p>
    </div>
</body>
</html>
