<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Panel</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

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
font-size:32px;
margin-bottom:10px;
}

.hero p{
opacity:0.9;
}

.stats{
display:flex;
gap:20px;
margin:0 30px;
flex-wrap:wrap;
}

.stat-box{
flex:1;
min-width:180px;
background:#1e293b;
padding:20px;
border-radius:15px;
text-align:center;
transition:0.3s;
}

.stat-box:hover{
transform:scale(1.05);
}

.stat-box h2{
font-size:26px;
color:#38bdf8;
}

.actions{
margin-top:100px;
display:grid;
grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
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
font-size:30px;
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

.back{
    display:block;
    width:150px;
    margin:20px auto;
    text-align:center;
    padding:10px;
    background:#4e73df;
    color:white;
    text-decoration:none;
    border-radius:5px;
}

</style>
</head>

<body>

<div class="navbar">
<h2>Hostel Admin</h2>

<div>
👤 <%= username %>
<a href="adminlogoutservlet" class="logout">Logout</a>
</div>
</div>

<div class="hero">
<h1>Welcome back, <%= username %> 👋</h1>
<p>Manage students, rooms, and hostel operations efficiently.</p>
</div>


<div class="stats">



</div>


<div class="actions">

<div class="action">
<i class="fa fa-user-plus"></i>
<h3>Add Student</h3>
<a href="studentregister.jsp">Open</a>
</div>

<div class="action">
<i class="fa fa-users"></i>
<h3>View Students</h3>
<a href="viewstudent.jsp">Open</a>
</div>

<div class="action">
<i class="fa fa-bed"></i>
<h3>Rooms</h3>
<a href="roomavailability.jsp">Open</a>
</div>

<div class="action">
<i class="fa fa-money-bill"></i>
<h3>Fees</h3>
<a href="viewstudentfees.jsp">Open</a>
</div>

<div class="action">
<i class="fa fa-comment"></i>
<h3>Complaints</h3>
<a href="viewcomplaints.jsp">Open</a>
</div>

</div>

<a href="adminlogin.jsp" class="back">Back</a>


</body>
</html>