<%-- 
    Document   : payfee
    Created on : Apr 1, 2026, 7:32:14 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
Integer studentId = (Integer) session.getAttribute("student_id");

if(studentId == null){
    response.sendRedirect("studentlogin.jsp");
    return;
}

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

double pending = 0;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelmanagement_db","root","");

    ps = con.prepareStatement("SELECT * FROM student WHERE id=?");
    ps.setInt(1, studentId);
    rs = ps.executeQuery();

    if(rs.next()){
        pending = rs.getDouble("pending_fee");
    }
}catch(Exception e){
    out.println(e);
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Pay Fee</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
body{
    font-family: Arial;
    background:#eef2f7;
}

.box{
    width:400px;
    margin:80px auto;
    background:white;
    padding:25px;
    border-radius:10px;
    text-align:center;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}

img{
    width:200px;
}

button{
    margin-top:15px;
    padding:10px 20px;
    background:green;
    color:white;
    border:none;
    border-radius:5px;
    cursor:pointer;
}
</style>

</head>

<body>

<div class="box">

<h2>Pay Pending Fee</h2>

<h3>Amount: ₹ <%= pending %></h3>

<img src="images/QR.jpeg" alt="QR Code">

<form action="payfeeservlet" method="post">

<input type="hidden" name="amount" value="<%= pending %>">

<br><br>

<input type="checkbox" name="paid" required> I have paid the amount

<br>

<button type="submit">Confirm Payment</button>

</form>

</div>

</body>
</html>