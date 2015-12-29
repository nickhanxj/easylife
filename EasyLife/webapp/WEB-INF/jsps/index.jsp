<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Easy Life</title>
	<link rel="shortcut icon" type="image/x-icon" href="images/net.ico" />
	<jsp:include page="/WEB-INF/jsps/general/general.jsp"></jsp:include>
	<link rel="stylesheet" href="js/layer/skin/layer.css" type="text/css" media="screen" />
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/layer/extend/layer.ext.js"></script>
	<script type="text/javascript" src="js/Highcharts-4.0.3/js/highcharts.js"></script>
	<script type="text/javascript" src="js/Highcharts-4.0.3/js/highcharts-3d.js"></script>
	<script type="text/javascript" src="js/Highcharts-4.0.3/js/modules/exporting.js"></script>
<title>测试Ext</title>
<style type="text/css">
	.welcome{
		float: right;
		margin-top: 30px;
		margin-right: 50px;
		font-family: "微软雅黑";
	}
	span>a{
		color: white;
		text-decoration: none;
	}
	span>a:HOVER {
		color: #ADD8E6;
	}
	li>a{
		text-decoration: none;
		font-weight: bold;
		color: #303030;
	}
	ul,li{
		margin: 0px;
		padding: 0px;
	}
	li{
		list-style-type: none;
		margin-top: 5px;
/* 		background-color: #ADD8E6; */
/* 		text-align: center; */
		height: 25px;
		cursor: pointer;
		padding-top: 11px;
		font-family: "微软雅黑";
		padding-left: 20px;
		font-weight: bold;
	}
	li:HOVER {
		background-color: #1E90FF;
	}
	
	td{
		width: 50%;
	}
	
	.tabHead{
		padding-left: 20px;
	}
</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height:86px; background-image: url('images/header.jpg'); background-repeat:no-repeat;background-size:100%;">
		<span>
		<img alt="" src="images/header_logo.png" style="margin-left: 10px;">
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
	<div data-options="region:'west',iconCls:'icon-sysmenu'" title="系统菜单" style="width:200px;">
		<div class="easyui-accordion" style="width:198px;">
			<div title="消费" data-options="iconCls:'icon-cost'" style="overflow:auto;padding:10px;text-align: left;">
				<ul>
					<li class="icon-costgroup" onclick="addTab('消费组', 'groupAction_groupList')">消费组</li>
					<li class="icon-costrecord" onclick="addTab('消费记录', 'costAction_list')">消费记录</li>
				</ul>
			</div>
			<div title="用户" data-options="iconCls:'icon-usermenu'" style="overflow:auto;padding:10px; ">
				<ul>
					<li class="icon-userlist" onclick="addTab('用户列表', 'userAction_list')">用户列表</li>
				</ul>
			</div>
			<div title="统计" data-options="iconCls:'icon-statistics'" style="overflow:auto;padding:10px;">
				<ul>
					<li class="icon-form" onclick="addTab('消费统计-表格', 'costAction_statisticsTable')">消费统计-表格</li>
					<li class="icon-chart" onclick="addTab('消费统计-图表', 'costAction_personalCostChart')">消费统计-图表</li>
				</ul>
			</div>
			<div title="常用" data-options="iconCls:'icon-tool'" style="overflow:auto;padding:10px;">
				<ul>
					<li class="icon-baidu" onclick="addTab('百度', 'toolAction_baidu')">百度</li>
					<li class="icon-sina" onclick="addTab('新浪新闻', 'toolAction_sina')">新浪新闻</li>
				</ul>
			</div>
			<div title="系统" data-options="iconCls:'icon-system'" style="overflow:auto;padding:10px;">
				<ul>
					<li class="icon-theme" onclick="addTab('主题设置', 'toolAction_systemSettings')">主题设置</li>
					<li class="icon-log" onclick="addTab('系统日志', 'toolAction_log')">系统日志</li>
				</ul>
			</div>
		</div>
	</div>
	<div data-options="region:'center'" id="mainArea" class="easyui-tabs">
		<div title="首页" style="padding:10px">
			<div style="margin-left: auto; margin-right: auto; text-align: center;">
				<table style="margin-left: auto; margin-right: auto;width: 100%;">
					<tr>
						<td>
							<div class="easyui-panel" title="待定" style="height: 300px;">
							</div>
						</td>
						<td>
							<div class="easyui-panel" title="统计"  style="height: 300px;">
								<div id="pie" style="height: 266px;"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="easyui-panel" title="待定" style="height: 300px;">内容二</div>
						</td>
						<td>
							<div class="easyui-panel" title="待定" style="height: 300px;">待定</div>
						</td>
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
		<table class="table table-condensed" style="width: 80%; margin-left: auto; margin-right: auto;">
			<s:hidden name="id" value="%{#selectedUser.id}"/>
			<tr>
				<td class="tabHead" id="oldPwd">原密码:</td>
				<td><s:password onblur="checkOriginPasswd(this)" value="%{#selectedUser.userName}" cssClass="form-control edit-input"/></td>
			</tr>
			<tr>
				<td class="tabHead" id="newPwd">新密码:</td>
				<td><s:password  id="newPassword" onblur="validatePwd()" value="%{#selectedUser.trueName}" cssClass="form-control edit-input"/></td>
			</tr>
			<tr>
				<td class="tabHead"  id="reNewPwd">确认新密码:</td>
				<td><s:password  id="reNewPassword" onblur="validatePwd()" value="%{#selectedUser.email}" cssClass="form-control edit-input"/></td>
			</tr>
			<tr>
				<td colspan="3">
					<div style="color: red; font-size: x-small;margin-top: 30px;" align="center" id="errorField">
					</div>
					<div style="color: green; font-size: x-small;margin-top: 30px; font-weight: bold;" align="center" id="successField">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<a href="javascript:void(0)" id="submitReset" onclick="resetPassword()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">确认修改</a>&emsp;
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
		initPie();
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
			showError("newPwd");
		}else{
			$("#errorField").html("");
			showOk("newPwd");
			if(originPwd && rePwd){
				if(originPwd != rePwd){
					$("#errorField").html("两次输入密码不一致");	
					showError("reNewPwd");
				}else{
					$("#errorField").html("");
					$("#successField").html("请记好密码，以免造成不必要的麻烦！");
					showOk("reNewPwd");
				}
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
			var inputError = $(".icon-input-error");
			if(inputError.length == 0){
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
	}
	
	function checkOriginPasswd(t){
		var originPasswd = $(t).val();
		$.ajax({
			url: 'userAction_validateOriginPasswd',
			type: "POST",
			data:{"originPassword":originPasswd},
			success: function(data){
				if(data == 2){
					showError("oldPwd");
				}else if(data == 1){
					showOk("oldPwd");
				}
			}
		});
	}
	
	function showError(elId){
		$("#"+elId).removeClass("icon-input-ok");
		$("#"+elId).addClass("icon-input-error");
	}
	
	function showOk(elId){
		$("#"+elId).removeClass("icon-input-error");
		$("#"+elId).addClass("icon-input-ok");
	}
	
	function initPie() {
		var data;
// 		$.ajax({
// 			url: "costAction_statisticDataForPie",
// 			type: "GET",
// 			async: false,
// 			success: function(rdata){
// 				data = rdata;
// 			}
// 		});
	    $('#pie').highcharts({
	        chart: {
	            type: 'pie',
	            options3d: {
					enabled: true,
	                alpha: 45,
	                beta: 0
	            }
	        },
	        title: {
	            text: '本月消费情况'
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                depth: 35,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.name}'
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '本月消费比例',
	            data: data
	        }]
	    });
	}
</script>
</html>