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
		width: 400px;
		float:right;
		margin-right:50px;
		margin-top: 15%;
		border: 8px #B0C4DE solid;
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
		font-weight: bolder;
	}
	table {  
		border-collapse:   separate;   
		border-spacing:   15px;   
		width: 100%;
	} 
	.msg{
		font-size: x-small;
	}
	.validateCode{
		height: 30px;
		margin-top: 0;
		width: 95px;
		vertical-align:middle;
	}
	.refreshCode{
		cursor: pointer;
	}
</style>
</head>
<body>
	<div>
		<img src="images/login.jpg" class="back-img"/>
		<img alt="" src="images/11.jpg" style="margin-top: 18%;margin-left: 100px;">
		<div class="login">
			<form id="loginForm">
			<table>
				<tr>
					<td colspan="2">
						<div style="margin-top: 15px; font-weight: bold; font-family: '微软雅黑'">用户登录</div>
					</td>
				</tr>
				<tr>
					<td rowspan="3"><img alt="" src="images/user.png"> </td>
					<td style="text-align: left;"><input type="text" placeholder="请输入用户名或邮箱" name="user.userName"></td>
				</tr>
				<tr>
					<td style="text-align: left;"><input type="password" placeholder="请输入密码" name="user.password"></td>
				</tr>
				<tr>
					<td style="text-align: left;">
						<div>
						<input class="validateCode" type="text" placeholder="请输入验证码" name="vcode">
						<img alt="" title="换一张" onclick="reloadImg()" src="" class="validateCode refreshCode">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<span class="loginBtn" onclick="sumitForm()">登录</span>
						<button type="reset" class="loginBtn" onclick="reloadImg()">重置</button><br>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
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
					$("#message").html("<font color='green'>登录成功！正在进入系统...</font>");
					setTimeout("enterSystem()",1000);
				}else{
					reloadImg();
					$("#message").html("<font color='red'>"+data+"</font>");
				}
			}
		});
	}
	
	function enterSystem(){
		window.location.href="index.jsp";
	}
	
	$(function(){
		reloadImg();
	});
	
	function reloadImg(){
		$.ajax({
			url:"userAction_getImageCode?rnd="+Math.random(),
			type:"POST",
			success: function(data){
				$(".refreshCode").attr("src",data);
			}
		});
	}
</script>
</html>