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
		<div style="margin-bottom:5px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="$('#addRecord').window('open')">新增</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
	</div>
	<div id="addRecord" class="easyui-window" title="新增消费组" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;padding:10px;">
				<form id="recordForm" method="post" theme="simple">
					<input type="hidden" name="record.attachment" id="attachment"/>
					<table style="width: 100%;">
						<tr>
							<td>用户名</td>
							<td>
								<input name="group.groupName" placeholder="组名" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>登录密码</td>
							<td>
								<textarea name="group.mark" placeholder="备注" style="width: 145px;"></textarea>
							</td>
						</tr>	
						<tr>
							<td>用户类型：</td>
							<td>
								<textarea name="members" placeholder="备注" rows="5" style="width: 145px;"></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitData()">保存</a>
								<a href="/cost/list.html" class="easyui-linkbutton">取消</a>
							</td>
						</tr>				
					</table>
				</form>
	</div>
</body>
<script type="text/javascript">
	function submitData(){
		$.ajax({
			url:"groupAction_add",
			type:"POST",
			data:$("#recordForm").serialize(),
			success: function(data){
				if(data == 1){
					layer.msg('保存成功！');
				}else{
					layer.msg('保存失败！');
				}
				$('#addRecord').window('close');
				$("#dg").datagrid('reload');
// 				setTimeout("queryData()",1000);
			}
		});
	}

// 	function queryData(){
// 		$("#dg").datagrid('load',{
// 			  "startTime":$("#startTime").datebox('getValue'),
// 			  "endTime":$("#endTime").datebox('getValue'),
// 			  "userName":$("#userName").combobox('getValue')
// 		});
// 	}
	
// 	function reset(){
// 		$("#startTime").datebox('setValue','');
// 		$("#endTime").datebox('setValue','');
// 		$("#userName").combobox('setValue',0);
// 		queryData();
// 	}
	
	$(function(){
		initGrid();
	});
	
	function initGrid(){
		$('#dg').datagrid({  
			toolbar:'#tb',
		    url:'userAction_listData',  
		    pagination:true,
		    method:'POST',
		    fit:true,
			fitColumns:true,
			rownumbers:true,
			singleSelect:false,
		    columns:[[    
				{field:'id',checkbox:true },
		        {field:'userName',title:'用户名',width:100},    
		        {field:'trueName',title:'真实姓名',width:100},    
		        {field:'email',title:'邮箱',width:100},
		        {field:'phoneNumber',title:'电话',width:100},
		        {field:'status',title:'状态',width:100},
		        {field:'registerDate',title:'注册时间',width:100}
		    ]]    
		});  
	}
</script>
</html>