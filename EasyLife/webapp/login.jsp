<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Easy Life | Login</title>
	<link rel="shortcut icon" type="image/x-icon" href="images/logo.ico" />
	<jsp:include page="WEB-INF/jsps/general/general.jsp"></jsp:include>
<title>测试Ext</title>
<style type="text/css">
	.back-img{
		z-index: -999; 
		position: absolute; 
		top: 0; 
		left: 0;
		width: 100%;
		height: 100%;
	}
	
	.login{
		width: 300px;
		margin-left: 980px;
		margin-top: 290px;
		border: 4px #B0C4DE solid;
		text-align: center;
	}
	
	.inputLebel{
		text-align: right;
		font-family: "微软雅黑";
		margin-right: 5px;
	}
	
	.loginBtn{
		border: 1px gray solid;
		background-color: lightblue;
		font-family: "微软雅黑";
		padding: 3px 10px 3px 10px;
		cursor: pointer;
	}
	.loginBtn:HOVER{
		background-color: #77D2FE;
		cursor: pointer;
	}
	
	input{
		height: 30px;
		width: 200px;
	}
	table {  
		border-collapse:   separate;   
		border-spacing:   15px;   
		width: 100%;
	} 
	.msg{
		font-size: x-small;
	}
</style>
</head>
<body>
	<div>
		<img src="images/login.jpg" class="back-img"/>
		<div class="login">
			<form id="loginForm">
			<table>
				<tr>
					<td><input type="text" placeholder="请输入用户名或邮箱" name="user.userName"></td>
				</tr>
				<tr>
					<td><input type="password" placeholder="请输入密码" name="user.password"></td>
				</tr>
				<tr>
					<td style="text-align: center;">
						<span class="loginBtn" onclick="sumitForm()">登录</span><br><br><br>
						<span id="message" class="msg"></span>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	function sumitForm(){
		$.ajax({
			url:"userAction_login",
			type:"POST",
			data:$("#loginForm").serialize(),
			success: function(data){
				if(data == "SUCCESS"){
					$("#message").html("<font color='green'>登录成功！正在跳转...</font>");
					window.location.href="index.jsp";
				}else{
					$("#message").html("<font color='red'>"+data+"</font>");
				}
			}
		});
	}
</script>
</html>