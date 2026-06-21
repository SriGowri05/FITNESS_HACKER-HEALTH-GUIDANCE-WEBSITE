<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="java.io.PrintWriter" %>  
<html>
<head>
    <style>
        body {
            background-color:  #ffa733;
            font-family: Arial;
        }
        h2 {
            color: black;
            text-align: center;
        }
    </style>
</head>
<body>
<%
    String userId = request.getParameter("userid");
    String feedback = request.getParameter("feedback");
    String[] ratings = request.getParameterValues("ratings");
    String rating = "";
    if (ratings != null) {
      for (String r : ratings) {
            rating += r + " ";
        }
    }
    else{
    	rating="";
    }
    
    if (userId == null || userId.trim().isEmpty() || feedback == null || feedback.trim().isEmpty() || rating.isEmpty()) {
        out.println("<h2>All fields (User ID, Feedback, and Rating) are required!</h2>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gowri", "root", "W7301@jqir#");

            PreparedStatement ps = con.prepareStatement("INSERT INTO feedback (userid, feedback, rating) VALUES (?, ?, ?)");
            ps.setString(1, userId);
            ps.setString(2, feedback.trim());
            ps.setString(3, rating.trim());

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<h2>Thank you! Your feedback has been submitted successfully.</h2>");
%>
     <form action="thank.html" target="about" method="get">
		<center>
		<input type = "submit" name = "submit" value = "Done" /></center></form>
<%  
            } else {
                out.println("<h2 style='color:black;'>Failed to submit feedback. Please try again.</h2>");
            }

            con.close();
        } catch (Exception e) {
            out.println("<h2 style='color:black;'>Error: " + e.getMessage() + "</h2>");
        }
    }
%>
</body>
</html>