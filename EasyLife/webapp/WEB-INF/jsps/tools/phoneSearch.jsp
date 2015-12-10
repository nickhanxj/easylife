<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>电话归属地查询</title>
<%@taglib prefix="s" uri="/struts-tags"%>
	<jsp:include page="/WEB-INF/jsps/general/general.jsp"></jsp:include>
	<script type="text/javascript" src="js/Highcharts-4.0.3/js/highcharts.js"></script>
	<style type="text/css">
		.btn{
			background-color: #E3E3E3;
		}
		input {
			width:30%;
			height:40px;
			font-family: "微软雅黑";
			vertical-align:middle;
			font-size: xx-large;
		}
	</style>
</head>
<body>
	<div style="width: 100%; text-align: center;margin-top: 25px;" >
		<input placeholder="请输入电话号码" class="easyui-textbox" id="phoneNumber"><br>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px; margin-top: 15px;" onclick="searchPhoneNumber()">查询</a>
	</div>
	<div  style="width: 50%; text-align: center;margin-top: 45px; border: 1px solid lightgray; margin-left: auto; margin-right: auto; padding: 15px;" >
		<table style="width: 100%;">
			<tr>
				<td style="font-weight: bold;">归属地</td>
				<td id="gsd">无</td>
			</tr>
			<tr>
				<td style="font-weight: bold;">运营商</td>
				<td id="yys">无</td>
			</tr>
		</table>
	</div>
</body>
<script type="text/javascript">
	function searchPhoneNumber(){
		$.ajax({
			url : "toolAction_searchPhoneNumber",
			type : "POST",
			data : {"phoneNumber":$("#phoneNumber").val()},
			success : function(data){
				data = $.parseJSON(data);
				console.debug(data);
				if(data.errNum == 0){
					var ret = data.retData;
					$("#gsd").html("<font color='blue'>"+ret.province+"</font>");
					$("#yys").html("<font color='blue'>"+ret.carrier+"</font>");
				}else{
					var errorMsg = "<font color='red'>网络错误</font>";
					$("#gsd").html(errorMsg);
					$("#yys").html(errorMsg);
				}
			}
		});
	}
</script>
</html>