<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Basic Layout - jQuery EasyUI Demo</title>
	<link rel="shortcut icon" type="image/x-icon" href="images/logo.ico" />
	<link rel="stylesheet" type="text/css" href="easyui/themes/peppergrinder/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<script type="text/javascript" src="easyui/jquery.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<title>测试Ext</title>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height:80px; text-align: center;">
		<h2 style="width: 100%;">
			<img alt="" width="30px" src="images/logo.png" style="float: left;">EASY LIFE
		</h2>
	</div>
<!-- 	<div data-options="region:'east',split:true" title="East" style="width:100px;"></div> -->
	<div data-options="region:'west',split:true" title="West" style="width:200px;">
		<ul class="easyui-tree" id="menu" data-options="url:'test/tree/tree_data.json',method:'get',animate:true"></ul>
	</div>
	<div data-options="region:'center'" id="mainArea" class="easyui-tabs">
		<div title="Welcome" style="padding:10px">
			<p style="font-size:14px">Make life easier!</p>
		</div>
	</div>
	<div data-options="region:'south',split:true" style="height:50px; text-align: center;">copyright@2015*Nick</div>
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