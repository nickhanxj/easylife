<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@taglib prefix="s" uri="/struts-tags"%>
	<jsp:include page="/WEB-INF/jsps/general/general.jsp"></jsp:include>
	<script type="text/javascript" src="js/Highcharts-4.0.3/js/highcharts.js"></script>
	<style type="text/css">
		.theme-view{
			width: 50%;
			cursor: pointer;
		}
		td{
			border: 1px gray solid;
		}
	</style>
</head>
<body>
	<div style="width: 100%; text-align: center;margin-top: 25px;" >
		<fieldset style="border: 5px lightblue solid;">
			<legend>系统风格选择</legend>
				 <div id="imgs" class="imgs">
				<table style="width: 100%;">
					<tr>
						<td><img alt="" class="theme-view"  src="images/themes/default_theme.png"> </td>
						<td><img alt="" class="theme-view" src="images/themes/classic_theme.png"></td>
					</tr>
					<tr>
						<td><img alt="" class="theme-view" src="images/themes/black_theme.png"></td>
						<td><img alt="" class="theme-view" src="images/themes/gray_theme.png"> </td>
					</tr>
					<tr>
						<td><img alt="" class="theme-view" src="images/themes/green_theme.png"></td>
						<td><img alt="" class="theme-view" src="images/themes/white_theme.png"> </td>
					</tr>
				</table>
				</div>
		</fieldset>
		<table style="width: 100%; text-align: center;">
			<tr>
				<td colspan="2">
					<a href="javascript:void(0)" onclick="changeTheme()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存设置</a>&emsp;
				</td>
			</tr>
		</table>
	</div>
</body>
<script type="text/javascript">
	function changeTheme(){
		$.ajax({
			url:"toolAction_changeTheme",
			type:"POST",
			data:{"systemTheme.theme":$("#themeVal").combobox('getValue')},
			success:function(data){
				layer.msg(data);
			}
		});
	}
	
	$(function(){
		$("#themeVal").combobox('setValue',${sysTheme});
	});
</script>
</html>