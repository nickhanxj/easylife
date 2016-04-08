<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Easy Life | Login</title>
	<link rel="shortcut icon" type="image/x-icon" href="images/net.ico" />
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
		background: rgba(224, 255, 255, 0.5);
/* 		background-color:lightblue; */
/*  	border: 3px #D1EEEE solid;  */
		text-align: center;
		border-radius: 15px;
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
	.login-input{
		padding-left: 20px;
	}
	
	.myButton {
		-moz-box-shadow:inset 0px 39px 0px -24px #9fb4f2;
		-webkit-box-shadow:inset 0px 39px 0px -24px #9fb4f2;
		box-shadow:inset 0px 39px 0px -24px #9fb4f2;
		background-color:#7892c2;
		-moz-border-radius:4px;
		-webkit-border-radius:4px;
		border-radius:4px;
		border:1px solid #4e6096;
		display:inline-block;
		cursor:pointer;
		color:#ffffff;
		font-family:Arial;
		font-size:15px;
		padding:6px 15px;
		text-decoration:none;
		text-shadow:0px 1px 0px #283966;
	}
	.myButton:hover {
		background-color:#476e9e;
	}
	.myButton:active {
		position:relative;
		top:1px;
	}
	
	.resetBtn {
		-moz-box-shadow:inset 0px 39px 0px -24px #ffffff;
		-webkit-box-shadow:inset 0px 39px 0px -24px #ffffff;
		box-shadow:inset 0px 39px 0px -24px #ffffff;
		background-color:#ffffff;
		-moz-border-radius:4px;
		-webkit-border-radius:4px;
		border-radius:4px;
		border:1px solid #dcdcdc;
		display:inline-block;
		cursor:pointer;
		color:#666666;
		font-family:Arial;
		font-size:15px;
		padding:6px 15px;
		text-decoration:none;
		text-shadow:0px 1px 0px #ffffff;
	}
	.resetBtn:hover {
		background-color:#f6f6f6;
	}
	.resetBtn:active {
		position:relative;
		top:1px;
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
					<td style="text-align: left;"><input class="icon-user-login login-input" type="text" placeholder="请输入用户名或邮箱" name="user.userName" value="nick"></td>
				</tr>
				<tr>
					<td style="text-align: left;"><input class="icon-password-login login-input" type="password" placeholder="请输入密码" name="user.password" value="nick471026023"></td>
				</tr>
				<tr>
					<td style="text-align: left;">
						<div>
						<input class="validateCode icon-code-login login-input" type="text" placeholder="请输入验证码" name="vcode">
						<img alt="" title="换一张" onclick="reloadImg()" src="" class="validateCode refreshCode">
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<a href="javascript:void(0)" class="myButton" onclick="sumitForm()" id="submitBtn">登录</a>
						<a href="javascript:void(0)" class="resetBtn" onclick="reset()">重置</a>
						<button type="reset" class="loginBtn" onclick="reloadImg()" style="display: none;" id="resetBtn"></button><br>
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
	
	function reset(){
		$("#resetBtn").click();
	}
	
	$(document).bind("keydown",function(event){
		if(event.keyCode==13){
			$("#submitBtn").click();
		}
	});
	
	if(top!=window){
		top.location.href = window.location.href;
	}
	
	function enterSystem(){
		window.location.href="toolAction_index";
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