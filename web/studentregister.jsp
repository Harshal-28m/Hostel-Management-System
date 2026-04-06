<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Register Student</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
background:linear-gradient(135deg,#1e3c72,#2a5298);
min-height:100vh;
display:flex;
justify-content:center;
align-items:center;
padding:30px;
}

.container{
width:950px;
background:white;
border-radius:15px;
padding:35px;
box-shadow:0 10px 30px rgba(0,0,0,0.3);
}

h2{
text-align:center;
margin-bottom:20px;
}

.form-row{
display:flex;
gap:15px;
margin-bottom:15px;
}

.form-group{
flex:1;
display:flex;
flex-direction:column;
}

label{
font-size:14px;
font-weight:600;
margin-bottom:5px;
}

input, select, textarea{
padding:10px;
border:1px solid #ccc;
border-radius:6px;
font-size:14px;
}

textarea{
resize:none;
height:70px;
}

.btn{
width:100%;
padding:12px;
background:#2a5298;
color:white;
border:none;
border-radius:6px;
font-size:16px;
cursor:pointer;
margin-top:10px;
}

.btn:hover{
background:#1e3c72;
}

.back{
display:block;
text-align:center;
margin-top:15px;
color:#2a5298;
text-decoration:none;
}

.alert{
padding:10px;
margin-bottom:15px;
border-radius:5px;
text-align:center;
font-weight:bold;
}

.success{
background:#d4edda;
color:#155724;
}

.error{
background:#f8d7da;
color:#721c24;
}

.error-text{
color:red;
font-size:12px;
}

</style>

<script>

function calculateFee(){
let months = document.getElementById("duration").value;
let total = months * 2000;

document.getElementById("fee").value = total;
document.getElementById("paid_fee").value = "";
document.getElementById("pending_fee").value = "";
}

function calculatePending(){
let total = parseInt(document.getElementById("fee").value) || 0;
let paid = parseInt(document.getElementById("paid_fee").value) || 0;

if(paid > total){
    alert("Paid amount cannot exceed total fee!");
    document.getElementById("paid_fee").value="";
    return;
}

document.getElementById("pending_fee").value = total - paid;
}

function validateYear(){
let year = document.getElementById("academicyear").value;
let error = document.getElementById("yearError");

let pattern = /^\d{4}-\d{2}$/;

if(!pattern.test(year)){
    error.innerText = "Format: 2025-26";
    return;
}

let start = parseInt(year.substring(0,4));
let end = parseInt(year.substring(5,7));

if((start+1)%100 !== end){
    error.innerText = "Invalid year";
}else{
    error.innerText = "";
}
}

</script>

</head>

<body>

<div class="container">

<%
String msg = request.getParameter("msg");
if(msg != null){
%>
<div class="alert <%= msg.equals("success") ? "success" : "error" %>">
<%= msg.equals("success") ? "✅ Student Registered Successfully!" : "❌ Registration Failed!" %>
</div>
<% } %>

<h2>Register Student</h2>

<form action="studentregisterservlet" method="post" enctype="multipart/form-data">

<div class="form-row">
<div class="form-group">
<label>Name</label>
<input type="text" name="name" required>
</div>

<div class="form-group">
<label>Email</label>
<input type="email" name="email" required>
</div>
</div>

<div class="form-row">
<div class="form-group">
<label>Password</label>
<input type="password" name="password" required>
</div>

<div class="form-group">
    <label>Phone</label>
    <input type="text" name="phone" 
           pattern="[0-9]{10}" 
           maxlength="10" 
           minlength="10" 
           required
           title="Enter exactly 10 digits">
</div>
</div>

<div class="form-row">
<div class="form-group">
<label>PRN</label>
<input type="text" name="prn" required>
</div>

<div class="form-group">
<label>Upload Photo</label>
<input type="file" name="photo" accept="image/*" required>
</div>
</div>

<div class="form-row">
<div class="form-group">
<label>Select Room</label>

<select name="room_no" required>
<option value="">Select Room</option>

<%
Connection conn=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{
Class.forName("com.mysql.cj.jdbc.Driver");
conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/hostelmanagement_db","root","");
ps=conn.prepareStatement("SELECT room_no,type FROM room WHERE Available='Available'");
rs=ps.executeQuery();

while(rs.next()){
%>

<option value="<%=rs.getInt("room_no")%>">
Room <%=rs.getInt("room_no")%> - <%=rs.getString("type")%>
</option>

<%
}
}catch(Exception e){
out.println(e);
}finally{
if(rs!=null) rs.close();
if(ps!=null) ps.close();
if(conn!=null) conn.close();
}
%>

</select>
</div>

<div class="form-group">
<label>Duration</label>
<select name="duration" id="duration" onchange="calculateFee()" required>
<option value="">Select</option>
<option value="3">3 Months</option>
<option value="6">6 Months</option>
<option value="9">9 Months</option>
<option value="12">12 Months</option>
</select>
</div>
</div>

<div class="form-row">
<div class="form-group">
<label>Total Fee</label>
<input type="text" id="fee" name="fee" readonly>
</div>

<div class="form-group">
<label>Paid Fee</label>
<input type="number" id="paid_fee" name="paid_fee" oninput="calculatePending()" required>
</div>

<div class="form-group">
<label>Pending Fee</label>
<input type="text" id="pending_fee" name="pending_fee" readonly>
</div>
</div>

<div class="form-row">
<div class="form-group">
<label>Course</label>
<select name="course" required>
<option>BCA</option>
<option>MCA</option>
<option>BBA</option>
<option>MBA</option>
</select>
</div>

<div class="form-group">
<label>Year</label>
<select name="year" required>
<option>FY</option>
<option>SY</option>
<option>TY</option>
</select>
</div>

<div class="form-group">
<label>Academic Year</label>
<input type="text" name="academicyear" id="academicyear" placeholder="2025-26" oninput="validateYear()" required>
<span id="yearError" class="error-text"></span>
</div>
</div>

<div class="form-row">
<div class="form-group">
<label>Date of Birth</label>
<input type="date" name="dob" required>
</div>

<div class="form-group">
<label>Parents Contact</label>
<input type="text" name="parents_no" required>
</div>
</div>

<div class="form-group">
<label>City</label>
<input type="text" name="city" required>
</div>

<div class="form-group">
<label>Address</label>
<textarea name="address" required></textarea>
</div>

<input type="submit" value="Register Student" class="btn">

</form>

<a href="admindashboard.jsp" class="back">← Back to Dashboard</a>

</div>

</body>
</html>