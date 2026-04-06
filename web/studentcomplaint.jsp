<%-- 
    Document   : studentcomplaint
    Created on : Feb 17, 2026, 9:25:03 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String name = (String) session.getAttribute("student_name");
    String room = (String) session.getAttribute("room_no");
    Integer studentId = (Integer) session.getAttribute("student_id");

    if(name == null){
        response.sendRedirect("studentlogin.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Complaint</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
      *{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#1e3c72,#2a5298);
}

.container{
    width:420px;
    background:#ffffff;
    padding:35px;
    border-radius:15px;
    box-shadow:0 15px 40px rgba(0,0,0,0.3);
    position:relative;
    transition:0.3s ease;
}

.container:hover{
    transform:translateY(-6px);
}

.container::before{
    content:"";
    position:absolute;
    top:0;
    left:0;
    width:100%;
    height:6px;
    background:linear-gradient(to right,#4e73df,#1cc88a);
    border-radius:15px 15px 0 0;
}

h2{
    text-align:center;
    margin-bottom:25px;
    color:#333;
    font-size:24px;
    letter-spacing:1px;
}

label{
    font-size:14px;
    font-weight:600;
    color:#444;
    margin-bottom:5px;
    display:block;
}

input, textarea{
    width:100%;
    padding:12px;
    margin-bottom:15px;
    border-radius:8px;
    border:1px solid #ccc;
    font-size:14px;
    transition:0.3s;
}

input:focus, textarea:focus{
    border-color:#4e73df;
    outline:none;
    box-shadow:0 0 6px rgba(78,115,223,0.3);
}

textarea{
    resize:none;
    height:110px;
}

.btn{
    width:100%;
    padding:12px;
    background:#4e73df;
    border:none;
    color:white;
    font-size:16px;
    border-radius:8px;
    cursor:pointer;
    transition:0.3s;
    margin-bottom: 40px;
    font-weight:500;
}

.btn:hover{
    background:#2e59d9;
    transform:scale(1.03);
}

.success{
    background:#d4edda;
    color:#155724;
    padding:12px;
    margin-bottom:15px;
    border-radius:8px;
    text-align:center;
    font-weight:500;
}

.error{
    background:#f8d7da;
    color:#721c24;
    padding:12px;
    margin-bottom:15px;
    border-radius:8px;
    text-align:center;
    font-weight:500;
}
a{
    padding:12px 25px;
    background:#4e73df;
    color:#fff;
    text-decoration:none;
    border-radius:8px;
    font-weight:500;
    transition:0.3s;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
    margin-left: 120px; 
}

a:hover{
    background:#2e59d9;
    transform:scale(1.05);
}
    </style>
</head>

<body>

<div class="container">

    <h2>Complaint Form</h2>

    <% if(request.getAttribute("success") != null){ %>
        <div class="success">
            <%= request.getAttribute("success") %>
        </div>
    <% } %>

    <form action="studentcomplaintservlet" method="post">

        <input type="hidden" name="student_id" value="<%=studentId%>">
        <input type="hidden" name="student_name" value="<%=name%>">
        <input type="hidden" name="room_no" value="<%=room%>">

        <label>Subject</label>
        <input type="text" name="subject" required>

        <label>Message</label>
        <textarea name="message" required></textarea>

        <input type="submit" value="Submit Complaint" class="btn">

            </form>

        
<a href="studentdashboard.jsp">⬅ Back</a>


</div>

</body>
</html>