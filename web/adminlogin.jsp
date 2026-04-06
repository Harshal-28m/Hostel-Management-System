<%-- 
    Document   : adminlogin
    Created on : 20-Feb-2026, 11:08:25 pm
    Author     : Harshal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - Hostel Management</title>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, sans-serif;
        }

        body{
            height:100vh;
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                        url("images/h1..jpg");
            background-size: cover;
            background-position: center;
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .login-box{
            background:white;
            padding:40px;
            width:350px;
            border-radius:10px;
            box-shadow:0px 5px 15px rgba(0,0,0,0.3);
            text-align:center;
        }

        .login-box h2{
            margin-bottom:25px;
            color:#333;
        }

        .input-box{
            margin-bottom:20px;
            text-align:left;
        }

        .input-box label{
            font-weight:bold;
            display:block;
            margin-bottom:5px;
        }

        .input-box input{
            width:100%;
            padding:10px;
            border:1px solid #ccc;
            border-radius:5px;
            font-size:14px;
        }

        .btn{
            width:100%;
            padding:12px;
            background:#ff9800;
            border:none;
            border-radius:5px;
            color:white;
            font-size:16px;
            cursor:pointer;
            transition:0.3s;
        }

        .btn:hover{
            background:#e68900;
        }

        .back{
            display:block;
            margin-top:15px;
            text-decoration:none;
            color:#2196f3;
            font-size:14px;
        }

        .back:hover{
            text-decoration:underline;
        }

    </style>
</head>

<body>

    <div class="login-box">
        <h2>Admin Login</h2>

       <form action="adminloginservlet" method="Post">

            <div class="input-box">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>

            <div class="input-box">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <input type="submit" value="Login" class="btn">

        </form>

        <a href="index.html" class="back">← Back to Home</a>

    </div>

</body>
</html>
