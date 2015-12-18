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
</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height:84px; background-image: url('images/header.jpg'); background-repeat:no-repeat;background-size:100%;">
		<span>
		<img alt="" src="images/header_logo.jpg">
		</span>
		<span class="welcome">
			系统时间：<span id="sysTime"></span>&emsp;&emsp;
			<font color="blue" style="text-transform: capitalize;"><s:property value="#session.authUser.userName"/></font>&ensp;欢迎您！
			<a href="javascript:void(0)" onclick="confirmLogout()">退出</a>
		</span>
	</div>
<!-- 	<div data-options="region:'east',split:true" title="East" style="width:100px;"></div> -->
	<div data-options="region:'west'" title="系统菜单" style="width:200px;">
		<ul class="easyui-tree" id="menu" data-options="url:'test/tree/tree_data.json',method:'get',animate:true"></ul>
	</div>
	<div data-options="region:'center'" id="mainArea" class="easyui-tabs">
		<div title="Welcome" style="padding:10px">
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
	
	function confirmLogout(){
		layer.confirm('确认退出系统？', {
			 btn: ['确认','取消'] //按钮
		}, function(){
			window.location.href="userAction_logout";
		}, function(){
		    
		});
	}
	
	$(function(){
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
</script>
</html>