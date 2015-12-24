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
			border: 1px gray dotted;
		}
		td:HOVER {
			background-color: #EAEAEA;
			cursor: pointer;
		}
		.usingTheme{
			border: 1px green solid;
		}
	</style>
</head>
<body>
	<div style="width: 100%; text-align: center;margin-top: 25px;" >
		<fieldset style="border: 3px gray solid; padding: 10px;">
			<legend>系统风格选择</legend>
				 <div id="imgs" class="imgs">
				<table style="width: 100%;">
					<tr>
						<td class="ui-cupertino" cmd="themeArea" title="单击选择" onclick="selectTheme(this)"><img title="预览主题" alt="ui-cupertino" class="theme-view" onclick="previewImg(this)" src="images/themes/default_theme.png"> </td>
						<td class="metro-orange" cmd="themeArea" title="单击选择" onclick="selectTheme(this)"><img title="预览主题" alt="metro-orange" class="theme-view" onclick="previewImg(this)" src="images/themes/classic_theme.png"></td>
					</tr>
					<tr>
						<td class="black" cmd="themeArea" title="单击选择" onclick="selectTheme(this)"><img title="预览主题" alt="black" class="theme-view" onclick="previewImg(this)" src="images/themes/black_theme.png"></td>
						<td class="metro-gray" cmd="themeArea" title="单击选择" onclick="selectTheme(this)"><img title="预览主题" alt="metro-gray" class="theme-view" onclick="previewImg(this)" src="images/themes/gray_theme.png"> </td>
					</tr>
					<tr>
						<td class="metro-green" cmd="themeArea" title="单击选择" onclick="selectTheme(this)"><img title="预览主题" alt="metro-green" class="theme-view" onclick="previewImg(this)" src="images/themes/green_theme.png"></td>
						<td class="metro" cmd="themeArea" title="单击选择" onclick="selectTheme(this)"><img title="预览主题" alt="metro" class="theme-view" onclick="previewImg(this)" src="images/themes/white_theme.png"> </td>
					</tr>
				</table>
				</div>
		</fieldset>
		<div style="width: 100%; text-align: center; margin-top: 10px;">
			<input type="hidden" id="themeId">
			<a href="javascript:void(0)" onclick="changeTheme()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存设置</a>&emsp;
		</div>
	</div>
</body>
<script type="text/javascript">
	function changeTheme(){
		$.ajax({
			url:"toolAction_changeTheme",
			type:"POST",
			data:{"systemTheme.theme":$("#themeId").val()},
			success:function(data){
				layer.msg(data);
			}
		});
	}
	
	function selectTheme(t){
		var themeArea = $("td[cmd=themeArea]");
		for(var i = 0; i < themeArea.length; i++){
			$(themeArea[i]).removeClass("icon-selected");
		}
		var themeValue = $(t).attr("class");
		$("#themeId").val(themeValue);
		$(t).addClass("icon-selected");
	}
	
	$(function(){
		var themeArea = $("td[cmd=themeArea]");
		for(var i = 0; i < themeArea.length; i++){
			var themeValue = $(themeArea[i]).attr("class");
			if(themeValue == ${sysTheme}){
				$(themeArea[i]).addClass("icon-used");
				$(themeArea[i]).addClass("usingTheme");
			}
		}
	});
	
	function previewImg(t){
		var imgPath = $(t).attr("src");
		layer.open({
		    type: 1,
		    title: false,
		    closeBtn: 0,
		    area: '1000px',
		    skin: 'layui-layer-nobg', //没有背景色
		    shadeClose: true,
		    content: '<img alt="" width="1000px;" src="'+imgPath+'">'
		});
	}
</script>
</html>