<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page language="java" import="java.sql.*"   errorPage=""%>
<%@page import="java.io.PrintWriter" %>  
<html>
<head>
<style>
body{
background-color: #ffa733;}
}
</style></head>
<body>
<%
	String u=request.getParameter("userid");
	String pwd=request.getParameter("password");
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/gowri","root","W7301@jqir#");
	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select * from sign where userid='"+u+"'and password='"+pwd+"'");
	if (u == null || u.trim().isEmpty() || pwd.isEmpty()) {
        out.println("<h2 style='color:black;'>All fields are required. Please fill in all details.</h2>");
    }
	else if(rs.next())
	{
%>
		<form action="serv.html" target="about" method="get">
		<center>
		<h1>login succesfull!</h1>
		<input type = "submit" name = "submit" value = "continue" /></center></form>
<%
	}
	else
	{
		out.println("<h1>login unsuccessful</h1>");
		out.println("<h1>Invalid username or password...</h1>");
	}
	con.close();
%>
</body>
</html>