<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Easy Life</title>
	<link rel="shortcut icon" type="image/x-icon" href="images/logo.ico" />
	<jsp:include page="WEB-INF/jsps/general/general.jsp"></jsp:include>
	<link rel="stylesheet" href="js/layer/skin/layer.css" type="text/css" media="screen" />
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/layer/extend/layer.ext.js"></script>
<title>测试Ext</title>
<style type="text/css">
	.welcome{
		float: right;
		margin-top: 30px;
		margin-right: 50px;
		font-family: "微软雅黑";
	}
	a{
		color: white;
		text-decoration: none;
	}
	a:HOVER {
		color: #ADD8E6;
	}
</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height:86px; background-image: url('images/header.jpg'); background-repeat:no-repeat;background-size:100%;">
		<span>
		<img alt="" src="images/header_logo.jpg">
		</span>
		<span class="welcome">
			<a href="javascript:void(0)" onclick="viewMyInfo()" title="查看我的信息"><font color="#ADD8E6" style="text-transform: capitalize;"><b>
			<img alt="" src="images/user_head.png" height="15px;" style="vertical-align:middle;">
			<s:property value="#session.authUser.userName"/></b></font></a>&ensp;<font color="white">欢迎您！</font>|
			<a href="javascript:void(0)" onclick="$('#changePassword').window('open')"><img alt="" src="images/password.png" height="15px;" style="vertical-align:middle;"> 修改密码</a> |
			<a href="javascript:void(0)" onclick="confirmLogout()"><img alt="" src="images/logout.png" height="12px;" style="vertical-align:middle;"> 安全退出</a>
			<br><br><div style="text-align: right;"><img alt="" src="images/time.png" height="15px;" style="vertical-align:middle;"> <div id="sysTime" style=" color: white; display: inline;"></div></div>
		</span>
	</div>
<!-- 	<div data-options="region:'east',split:true" title="East" style="width:100px;"></div> -->
	<div data-options="region:'west'" title="系统菜单" style="width:200px;">
		<ul class="easyui-tree" id="menu" data-options="url:'test/tree/tree_data.json',method:'get',animate:true"></ul>
	</div>
	<div data-options="region:'center'" id="mainArea" class="easyui-tabs">
		<div title="首页" style="padding:10px">
			<div style="margin-left: auto; margin-right: auto; text-align: center; margin-top: 200px;">
				<table style="margin-left: auto; margin-right: auto;">
					<tr>
						<td style="text-align: right;">当前登录用户：</td>
						<td style="text-transform: uppercase;"><s:property value="#session.authUser.userName"/></td>
					</tr>
					<tr>
						<td style="text-align: right;">当前登录IP：</td>
						<td>127.0.0.1</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div data-options="region:'south'" style="height:50px; text-align: center;">
		<div style="margin-top: 5px;">copyright@2015*Nick</div>
		<div style="margin-top: 5px;">欢迎交流：471026023@qq.com</div>
	</div>
	<div id="changePassword" class="easyui-window" title="修改密码" data-options="modal:true,closed:true,iconCls:'icon-changepassword'" style="width:500px;padding:10px;">
		<table class="table table-condensed" style="width: 50%; margin-left: auto; margin-right: auto;">
			<s:hidden name="id" value="%{#selectedUser.id}"/>
			<tr>
				<td class="tabHead">原密码:</td>
				<td><s:password onblur="checkOriginPasswd(this)" value="%{#selectedUser.userName}" cssClass="form-control edit-input"/></td>
			</tr>
			<tr>
				<td class="tabHead">新密码:</td>
				<td><s:password  id="newPassword" onblur="validatePwd()" value="%{#selectedUser.trueName}" cssClass="form-control edit-input"/></td>
			</tr>
			<tr>
				<td class="tabHead">确认新密码:</td>
				<td><s:password  id="reNewPassword" onblur="validatePwd()" value="%{#selectedUser.email}" cssClass="form-control edit-input"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="color: red; font-size: x-small;margin-top: 30px;" align="center" id="errorField">
					</div>
					<div style="color: green; font-size: x-small;margin-top: 30px; font-weight: bold;" align="center" id="successField">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<a href="javascript:void(0)" onclick="resetPassword()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">确认修改</a>&emsp;
					<a href="javascript:void(0)" onclick="$('#changePassword').window('close')" class="easyui-linkbutton">取消</a>
				</td>
			</tr>
		</table>
	</div>
</body>
<script type="text/javascript">
	function addTab(title, url){
		if ($('#mainArea').tabs('exists', title)){
			$('#mainArea').tabs('select', title);
		} else {
			var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
			$('#mainArea').tabs('add',{
				title:title,
				content:content,
				closable:true
			});
		}
	}
	$(function(){
		$('#menu').tree({	
		    onClick: function(node){
		       if($('#menu').tree('isLeaf',node.target)){//判断是否是叶子节点
		    	   addTab(node.text, node.attributes.url);
		        }
		    }
		});
	});
	
	function viewMyInfo(){
		addTab("我的信息","userAction_userInfo");
	}
	
	function confirmLogout(){
		layer.confirm('确认退出系统？', {
			 btn: ['确认','取消'] //按钮
		}, function(){
			logout();
		}, function(){
		    
		});
	}
	
	function logout(){
		window.location.href="userAction_logout";
	}
	
	$(function(){
		getCurTime();
		setInterval("getCurTime()",1000);
	});
	
	function getCurTime(){
		var dateStr;
		var dayStr;
		var curDate = new Date();
		var year = curDate.getFullYear();    //获取完整的年份(4位,1970-????)
		var month = curDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
		var date = curDate.getDate();        //获取当前日(1-31)
		var day = curDate.getDay();     //获取当前星期X(0-6,0代表星期天)
		var hour = curDate.getHours();       //获取当前小时数(0-23)
		var minute = curDate.getMinutes();     //获取当前分钟数(0-59)
		var second = curDate.getSeconds();    
		if(day == 0){
			dayStr = "星期天";
		}else if(day == 1){
			dayStr = "星期一";
		}else if(day == 2){
			dayStr = "星期二";
		}else if(day == 3){
			dayStr = "星期三";
		}else if(day == 4){
			dayStr = "星期四";
		}else if(day == 5){
			dayStr = "星期五";
		}else if(day == 6){
			dayStr = "星期六";
		}
		dateStr = year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second+"/"+dayStr;
		$("#sysTime").html(dateStr);
	}
	
	function validatePwd(){
		var originPwd = $("#newPassword").val();
		var rePwd = $("#reNewPassword").val();
		if(originPwd.length < 6){
			$("#errorField").html("密码长度至少大于6位");	
		}else{
			$("#errorField").html("");
		}
		if(originPwd && rePwd){
			if(originPwd != rePwd){
				$("#errorField").html("两次输入密码不一致");	
			}else{
				$("#errorField").html("");
				$("#successField").html("请记好密码，以免造成不必要的麻烦！");
			}
		}
	}
	
	function validateForm(){
		var f = $(".edit-input");
		for(var i = 0; i < f.length; i++){
			if(!$(f[i]).val()){
				return false;
			}
		}
		return true;
	}
	
	function resetPassword(){
		console.debug(validateForm());
		if(!validateForm()){
			layer.msg('请将信息填写完整。');
		}else{
			var newPassword = $("#newPassword").val();
			$.ajax({
				url: 'userAction_resetPwd',
				type: "POST",
				data:{"password":newPassword},
				success: function(data){
					if(data == 2){
						$("#errorField").html("密码重置失败！未知错误！请<a href='#'>联系我们</a>！");
						$("#successField").html("");
					}else if(data == 1){
						$("#errorField").html("");
						$("#successField").html("密码重置成功!");
						layer.msg('密码重置成功！请重新登录,正在跳转到登录页面...');
						setInterval("logout()",2000);
					}
				}
			});
		}
	}
	
	function checkOriginPasswd(t){
		var originPasswd = $(t).val();
		$.ajax({
			url: 'userAction_validateOriginPasswd',
			type: "POST",
			data:{"originPassword":originPasswd},
			success: function(data){
				if(data == 2){
					$("#errorField").html("旧密码错误！");
					$("#successField").html("");
				}else if(data == 1){
					$("#errorField").html("");
					$("#successField").html("旧密码验证通过");
				}
			}
		});
	}
</script>
</html>