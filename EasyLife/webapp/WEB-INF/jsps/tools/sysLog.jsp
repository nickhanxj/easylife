<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="images/logo.ico" />
	<link rel="stylesheet" href="js/layer/skin/layer.css" type="text/css" media="screen" />
	<s:include value="/WEB-INF/jsps/general/general.jsp"></s:include>
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
	<div id="tb" style="padding:5px;height:auto">
		<div style="text-align: right;">
			<input id="operationParam" placeholder="根据操作模糊查询">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryData()">搜索</a>
			<a href="#" class="easyui-linkbutton" onclick="reset()">重置</a>
		</div>
	</div>
</body>
<script type="text/javascript">
	function queryData(){
		$("#dg").datagrid('load',{
			"operation":$("#operationParam").val()
		});
	}
	
	function reset(){
		$("#operationParam").val("");
		queryData();
	}

	$(function(){
		initGrid();
	});
	
	function initGrid(){
		$('#dg').datagrid({  
			toolbar:'#tb',
		    url:'toolAction_sysLog',  
		    pagination:true,
		    method:'POST',
		    fit:true,
			fitColumns:true,
			rownumbers:true,
			singleSelect:false,
		    columns:[[    
// 				{field:'id',checkbox:true },
		        {field:'user',title:'用户',width:100},    
		        {field:'operation',title:'操作',width:100},    
		        {field:'operationResult',title:'操作结果',width:100},
		        {field:'causation',title:'备注',width:100},
		        {field:'operationDate',title:'操作时间',
		        	 formatter:function(value,row,index){  
                         var unixTimestamp = new Date(value);  
                         return unixTimestamp.toLocaleString();  
                         },
		        	width:100}
		    ]]    
		});  
	}
</script>
</html>