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
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="$('#addRecord').window('open')">新增</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-email" plain="true" onclick="sendCostInfo()" style="float: right;">&emsp;发送本月消费信息到邮箱</a>
		</div>
	</div>
	<div id="addRecord" class="easyui-window" title="新增消费组" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;padding:10px;">
				<form id="addUserForm" method="post">
					<table style="width: 100%;">
						<tr>
							<td>用户名</td>
							<td>
								<input name="user.userName" placeholder="用户名" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>真实姓名</td>
							<td>
								<input name="user.trueName" placeholder="真实姓名" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>邮箱</td>
							<td>
								<input name="user.email" placeholder="邮箱" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>登录密码</td>
							<td>
								<input name="user.password" placeholder="密码" style="width: 145px;"/>
							</td>
						</tr>	
						<tr>
							<td>电话</td>
							<td>
								<input name="user.phoneNumber" placeholder="电话" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>用户类型：</td>
							<td>
								<select name="user.type" style="width: 145px;">
									<option value="1">普通用户</option>
									<option value="0">管理员</option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="submitData()">保存</a>
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
			url:"userAction_addUser",
			type:"POST",
			data:$("#addUserForm").serialize(),
			success: function(data){
				layer.msg(data);
				$('#addRecord').window('close');
				$("#dg").datagrid('reload');
// 				setTimeout("queryData()",1000);
			}
		});
	}
	
	function deleteUser(){
		layer.confirm('确认删除选中用户？一旦删除,不可恢复!', {
			 btn: ['确认','取消'] //按钮
		}, function(){
			deleteSelectedUser();
		}, function(){
		    
		});
	}
	
	function deleteSelectedUser(){
		var data = $("#dg").datagrid("getSelections");
		if(data.length == 0){
			layer.msg('请选则需要删除的用户');
		}else{
			var ids = "";
			for(var i = 0; i < data.length; i++){
				ids += data[i].id+",";
			}
			$.ajax({
				url:"userAction_deleteUser",
				type:"POST",
				data:{"userIds":ids},
				success: function(data){
					layer.msg(data);
					$("#dg").datagrid('reload');
				}
			});
		}
	}
	
	function sendCostInfo(){
		layer.confirm('确认发送本月消费信息到选中用户的邮箱？', {
			 btn: ['确认','取消'] //按钮
		}, function(){
			sendEmailToSelectedUser();
		}, function(){
		    
		});
	}
	
	function sendEmailToSelectedUser(){
		var data = $("#dg").datagrid("getSelections");
		if(data.length == 0){
			layer.msg('请选择发送邮件的用户');
		}else{
			layer.load(1, {
			    shade: [0.1,'#fff'] //0.1透明度的白色背景
			});
			var ids = "";
			for(var i = 0; i < data.length; i++){
				ids += data[i].id+",";
			}
			$.ajax({
				url:"userAction_sendEmail",
				type:"POST",
				data:{"userIds":ids},
				success: function(data){
					layer.closeAll("loading");
					layer.msg(data);
				}
			});
		}
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
		        {field:'registerDate',title:'注册时间',
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