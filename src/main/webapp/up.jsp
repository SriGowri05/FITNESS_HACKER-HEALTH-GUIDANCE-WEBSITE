<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<html>
<head>
<style>
body{
background-color: #ffa733;}
}
</style></head>
<body>
<%
    String u = request.getParameter("userid");
    String pwd = request.getParameter("password").trim();
    String cpwd = request.getParameter("confirm").trim();
    if (u == null || u.trim().isEmpty() || pwd.isEmpty() || cpwd.isEmpty()) {
        out.println("<h2 style='color:black;'>All fields are required. Please fill in all details.</h2>");
    }
    else if(pwd.length() > 6 || cpwd.length() > 6)
    {
    	out.println("<h2 style='color:black;'>Passwords do not match. Please try again.</h2>");
    }
    else if (!pwd.equals(cpwd)) {
        out.println("<h2 style='color:black;'>Password must be 6 characters or fewer.</h2>");
    } 
    else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gowri", "root", "W7301@jqir#");
            PreparedStatement ps = con.prepareStatement("INSERT INTO sign (userid, password,confirm) VALUES (?, ?,?)");
            ps.setString(1, u);
            ps.setString(2, pwd);
            ps.setString(3, cpwd);

            int result = ps.executeUpdate();

            if (result > 0) {
%>
        		<form action="sign.html" target="about" method="get">
        		<center>
        		<h1>signup succesfull!</h1>
        		<input type = "submit" name = "submit" value = "login" /></center></form>
<%
            } 
            else {
                out.println("<h2 style='color:black;'>Failed to sign up. Try again later.</h2>");
            }
            con.close();
        } 
        catch (Exception e) {
            out.println("<h2 style='color:black;'>Error: " + e.getMessage() + "</h2>");
        }
    }
%>
</body>
</html>