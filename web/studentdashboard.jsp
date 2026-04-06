<%-- 
    Document   : studentdashboard
    Created on : Feb 19, 2026, 7:34:53 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<%
    String name = (String) session.getAttribute("student_name");
    if(name == null){
        response.sendRedirect("studentlogin.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
background:#0f172a;
color:white;
}

.navbar{
display:flex;
justify-content:space-between;
align-items:center;
padding:15px 30px;
background:#020617;
}

.logout{
background:#ef4444;
padding:6px 12px;
border-radius:6px;
text-decoration:none;
color:white;
}

.hero{
padding:40px;
background:linear-gradient(135deg,#6366f1,#06b6d4);
border-radius:20px;
margin:30px;
box-shadow:0 10px 30px rgba(0,0,0,0.4);
}

.hero h1{
font-size:30px;
margin-bottom:10px;
}

.hero p{
opacity:0.9;
}

.actions{
margin:80px;
display:grid;
grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
gap:20px;
}

.action{
padding:25px;
border-radius:18px;
background:linear-gradient(135deg,#1e293b,#334155);
text-align:center;
transition:0.3s;
box-shadow:0 5px 20px rgba(0,0,0,0.3);
}

.action:hover{
transform:translateY(-8px);
}

.action i{
font-size:32px;
margin-bottom:10px;
color:#38bdf8;
}

.action h3{
margin-bottom:10px;
}

.action a{
text-decoration:none;
color:white;
font-size:14px;
opacity:0.8;
}

.action a:hover{
opacity:1;
}


</style>
</head>

<body>

<div class="navbar">
<h2>🎓 Student Panel</h2>

<div>
👤 <%= name %>
<a href="studentlogoutservlet" class="logout">Logout</a>
</div>
</div>

<div class="hero">
<h1>Welcome, <%= name %> 👋</h1>
</div>

<div class="actions">

<div class="action">
<i class="fa fa-user"></i>
<h3>My Profile</h3>
<a href="viewprofile.jsp">Open</a>
</div>

<div class="action">
<i class="fa fa-comment"></i>
<h3>Complaint</h3>
<a href="studentcomplaint.jsp">Open</a>
</div>

<div class="action">
    <i class="fa fa-comment"></i>
    <h3>Fees Section</h3>
    <a href="fees.jsp" class="btn">
        Go to Fees
    </a>

</div>


</body>
</html>