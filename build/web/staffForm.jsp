<%-- 
    Document   : staffForm
    Created on : Aug 22, 2024, 3:57:17 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="AddStaff1" method="post">
            <label>Firstname</label>
            <input type="text" name="firstname"><br>
            <label>LastName</label>
            <input type="text" name="lastname"><br>
            <label>EMAIL</label>
            <input type="email" name="email" required><br>
            <label>Phone</label>
            <input type="text" name="phone"><br>
            <label>position</label>
            <select name="position">
                <option>select position</option>
                <option>Normal Staff</option>
                <option>Accountant</option>
                <option>Vice President</option>
                <option>President</option>
            </select>
            <label>status</label>
            <input type="text" name="status"><br>
           
            <input type="submit" value="Add Staff"><br>
        </form>
    </body
</html>
