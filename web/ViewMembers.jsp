<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Members</title>
</head>
<body>
    <h2>Members List</h2>
    <a href="ViewRequests.jsp">View Requests</a>
    <a href="LogoutServlet">Logout</a>
    <!-- Add your logic to display members here -->
</body>
</html>
