<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="images/logo.ico" />
	<link rel="stylesheet" type="text/css" href="easyui/themes/peppergrinder/easyui.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<link rel="stylesheet" href="js/layer/skin/layer.css" type="text/css" media="screen" />
	<script type="text/javascript" src="easyui/jquery.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/layer/extend/layer.ext.js"></script>
	<style type="text/css">
		table th,td{
			text-align: center;
		}
	</style>
</head>
<body>
	<table id="dg"></table>
<!-- 	<table class="easyui-datagrid" title="消费记录" -->
<!-- 			data-options=" -->
<!-- 			rownumbers:true, -->
<!-- 			singleSelect:true, -->
<!-- 			url:'costAction_listData', -->
<!-- 			method:'POST', -->
<!-- 			toolbar:'#tb', -->
<!-- 			fit:true, -->
<!-- 			fitColumns:true, -->
<!-- 			pagination:true"> -->
<!-- 		<thead> -->
<!-- 			<tr> -->
<!-- 				<th data-options="field:'user',width:80">消费人</th> -->
<!-- 				<th data-options="field:'cost',width:100">消费金额</th> -->
<!-- 				<th data-options="field:'costFor',width:80,align:'right'">消费用途</th> -->
<!-- 				<th data-options="field:'costdate',width:80,align:'right'">消费时间</th> -->
<!-- 				<th data-options="field:'status',width:240">状态</th> -->
<!-- 				<th data-options="field:'attachment',width:60,align:'center'">附件</th> -->
<!-- 				<th data-options="field:'mark',width:60,align:'center'">备注</th> -->
<!-- 			</tr> -->
<!-- 		</thead> -->
<!-- 	</table> -->
	<div id="tb" style="padding:5px;height:auto">
		<div>
			消费日期: <input class="easyui-datebox" style="width:150px">
			到: <input class="easyui-datebox" style="width:150px">
			消费人: 
			<select class="easyui-combobox" panelHeight="auto" style="width:100px">
				<option value="java">韩晓军</option>
				<option value="c">胡丰盛</option>
				<option value="basic">李洪亮</option>
			</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		initGrid();
	});
	
	function initGrid(){
		$('#dg').datagrid({    
			toolbar:'#tb',
		    url:'costAction_listData',  
		    pagination:true,
		    method:'POST',
		    fit:true,
			fitColumns:true,
			rownumbers:true,
			singleSelect:true,
		    columns:[[    
		        {field:'user',title:'消费人',width:100},    
		        {field:'cost',title:'消费金额',width:100},    
		        {field:'costFor',title:'消费用途',width:100},    
		        {field:'costdate',title:'消费时间',width:100},    
		        {field:'status',title:'状态',width:100},    
		        {field:'attachment',title:'附件',width:100},    
		        {field:'mark',title:'备注',width:100} 
		    ]]    
		});  
	}
</script>
</html>