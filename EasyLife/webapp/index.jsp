<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Easy Life</title>
	<link rel="shortcut icon" type="image/x-icon" href="images/logo.ico" />
	<jsp:include page="WEB-INF/jsps/general/general.jsp"></jsp:include>
<title>测试Ext</title>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height:80px; padding: 25px; background-image: url('images/head_background.jpg');">
			<img alt="" width="30px" src="images/logo.png" style="float: left; margin-left: 50px;"><h2 style="display: inline;">EASY LIFE</h2>
			<div style="float: right;display: inline;">当前登录：Admin</div>
	</div>
<!-- 	<div data-options="region:'east',split:true" title="East" style="width:100px;"></div> -->
	<div data-options="region:'west'" title="West" style="width:200px; background-image: url('images/head_background.jpg');">
		<ul class="easyui-tree" id="menu" data-options="url:'test/tree/tree_data.json',method:'get',animate:true"></ul>
	</div>
	<div data-options="region:'center'" id="mainArea" class="easyui-tabs">
		<div title="Welcome" style="padding:10px">
			<div style="margin-left: auto; margin-right: auto; text-align: center; margin-top: 200px;">
				<table style="margin-left: auto; margin-right: auto;">
					<tr>
						<td style="text-align: right;">当前登录用户：</td>
						<td>Admin</td>
					</tr>
					<tr>
						<td style="text-align: right;">当前登录IP：</td>
						<td>127.0.0.1</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div data-options="region:'south'" style="height:50px; text-align: center; background-image: url('images/head_background.jpg');">
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
</script>
</html>