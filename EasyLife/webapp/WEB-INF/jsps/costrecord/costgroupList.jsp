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
		.authUser{
			border: 1px gray solid;
			height: 300px;
			width: 200px;
		}
	</style>
</head>
<body>
	<table id="dg"></table>
	<div id="tb" style="padding:5px;height:auto">
		<div style="margin-bottom:5px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="$('#addRecord').window('open')">新增组</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="getCheckedRecord()">编辑组</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="getCheckedRecordAndDelete()">删除组</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-authUser" plain="true" title="将消费组与用户关联" onclick="getCheckedRecordAndAuth()">授权用户</a>
		</div>
	</div>
	<div id="addRecord" class="easyui-window" title="新增消费组" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;padding:10px;">
				<form id="recordForm" method="post" theme="simple">
					<table style="width: 100%;">
						<tr>
							<td>消费组名</td>
							<td>
								<input name="group.groupName" placeholder="组名" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>组员：</td>
							<td>
								<textarea name="members" placeholder="消费组成员，用逗号(英文)隔开" rows="5" style="width: 145px;" id="inputMember"></textarea>
							</td>
						</tr>
						<tr>
							<td>备注</td>
							<td>
								<textarea name="group.mark" placeholder="备注" style="width: 145px;"></textarea>
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
	<div id="editRecord" class="easyui-window" title="编辑消费组" data-options="modal:true,closed:true,iconCls:'icon-edit'" style="width:500px;padding:10px;">
				<form id="editRecordForm" method="post" theme="simple">
					<input type="hidden" name="group.id" id="groupId"/>
					<table style="width: 100%;">
						<tr>
							<td>消费组名</td>
							<td>
								<input name="group.groupName" id="editGroupName" placeholder="组名" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>已有组员：</td>
							<td id="gmembers">
							</td>
						</tr>
						<tr>
							<td>新增组员：</td>
							<td>
								<textarea name="members" placeholder="消费组成员，用逗号(英文)隔开" rows="5" style="width: 145px;" id="newMembers"></textarea>
							</td>
						</tr>
						<tr>
							<td>备注</td>
							<td>
								<textarea name="group.mark" id="editMark" placeholder="备注" style="width: 145px;"></textarea>
							</td>
						</tr>	
						<tr>
							<td colspan="2">
								<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="updateRecord()">保存更改</a>
								<a href="/cost/list.html" class="easyui-linkbutton">取消</a>
							</td>
						</tr>				
					</table>
				</form>
	</div>
	<div id="authUser" class="easyui-window" title="关联用户" data-options="modal:true,closed:true,iconCls:'icon-authUser',maximizable:false,minimizable:false,collapsible:false" style="width:500px;padding:10px;">
		<h3 id="curGroup" style="width: 100%; text-align: center;"></h3>
		<table style="width: 100%;">
			<tr>
				<td>所有用户</td>
				<td></td>
				<td>已关联用户</td>
			</tr>
			<tr>
				<td>
					<div class="authUser">
						<select multiple="multiple" size="12" style="width:200px;height:300px" id="allUser" title="按住Ctl多选">
						</select>
					</div>
				</td>
				<td>
					<a href="#" title="关联选中用户" class="easyui-linkbutton" style="width: 50px;" onclick="moveOptions('#allUser','#authUserDiv')">></a><br>
					<a href="#" title="关联所有用户" class="easyui-linkbutton" style="width: 50px;" onclick="moveAllOptions('#allUser','#authUserDiv')">>></a><br>
					<a href="#" title="移除所有已关联用户" class="easyui-linkbutton" style="width: 50px;" onclick="moveAllOptions('#authUserDiv','#allUser')"><<</a><br>
					<a href="#" title="移除选中已关联用户" class="easyui-linkbutton" style="width: 50px;" onclick="moveOptions('#authUserDiv','#allUser')"><</a><br>
				</td>
				<td>
					<div class="authUser">
						<select multiple="multiple" size="12" style="width:200px;height:300px" id="authUserDiv"  title="按住Ctl多选"></select>
					</div>
				</td>
			</tr>
		</table>
		<div style="width: 100%; text-align: center;">
			<a href="#" class="easyui-linkbutton" iconCls="icon-save" onclick="authUser()">确定</a>
		</div>
	</div>
</body>
<script type="text/javascript">
	function authUser(){
		var group = $("#dg").datagrid("getSelections");
		var groupId = group[0].id;
		var users = $("#authUserDiv").find("option");
		var ids = "-";
		for(var i = 0; i < users.length; i++){
			ids += users[i].value+"-";
		}
		$.ajax({
			url:"groupAction_signUser",
			type:"POST",
			data:{"signUsers":ids,"group.id":groupId},
			success:function(data){
				if(data == 1){
					layer.msg('授权成功！');
				}else{
					layer.msg('授权失败！');
				}
				$("#authUser").window('close');
				initGrid();
			}
		});
	}

	function moveOptions(e1,e2){
		var options = $(e1).find("option:selected");
		for(var i=0;i<options.length;i++){
			var e = options[i];
			$(e).attr("selected",false);
			$(e2).append(e);
			$(e1+" option[value="+e.value+"]").remove();
		}
	}
	
	function moveAllOptions(e1,e2){
		var options = $(e1).find("option");
		for(var i=0;i<options.length;i++){
			var e = options[i];
			$(e).attr("selected",false);
			$(e2).append(e);
			$(e1+" option[value="+e.value+"]").remove();
		}
	}

	function submitData(){
		var inputMember = $("#inputMember").val();
		if(inputMember.indexOf("，") > -1){
			layer.msg('多个组员之间请用英文状态下的逗号隔开!');
			return;
		}
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
				initGrid();
// 				setTimeout("queryData()",1000);
			}
		});
	}
	
	function getCheckedRecord(){
		var data = $("#dg").datagrid("getSelections");
		if(data.length == 0){
			layer.msg('请选则需要修改的记录');
		}else if(data.length > 1){
			layer.msg('同时只能编辑一条记录');
		}else{
			$("#editGroupName").val(data[0].groupName);
			$("#editMark").val(data[0].mark);
			$("#groupId").val(data[0].id);
			var members = data[0].members;
			if(members){
				var m = members.split(" ");
				var mstr = "";
				for(var i = 0; i < m.length; i++){
					if(m[i]){
						mstr += "<input value='"+m[i]+"' name='checkMember' type='checkbox' checked='true'>"+m[i];
					}
				}
			}
			$("#gmembers").html(mstr);
			$('#editRecord').window('open');
		}
	}
	
	function getCheckedRecordAndDelete(){
		layer.confirm('确认删除选中消费组？一旦删除,不可恢复!', {
			 btn: ['确认','取消'] //按钮
		}, function(){
			var data = $("#dg").datagrid("getSelections");
			if(data.length == 0){
				layer.msg('请选则需要删除的记录');
			}else{
				var ids = "";
				for(var i = 0; i < data.length; i++){
					ids += data[i].id+",";
				}
				$.ajax({
					url:"groupAction_deleteGroup",
					type:"POST",
					data:{"ids":ids},
					success:function(data){
						layer.msg(data);
						initGrid();
					}
				});
			}
		}, function(){
		    
		});
	}
	
	function getCheckedRecordAndAuth(){
		$("#allUser").html("");
		$("#authUserDiv").html("");
		var data = $("#dg").datagrid("getSelections");
		if(data.length == 0){
			layer.msg('请选则需要关联用户的消费组');
		}else{
			$.ajax({
				url:"groupAction_getAuthUser",
				type:"POST",
				data:{"group.id":data[0].id},
				success:function(data){
					var allUser = data.allUsers;
					var authedUser = data.authedUsers;
					for(var i = 0; i < allUser.length; i++){
						$("#allUser").append('<option value="'+allUser[i].id+'">'+allUser[i].userName+'&ensp;('+allUser[i].trueName+')</option>');
					}
					for(var i = 0; i < authedUser.length; i++){
						$("#authUserDiv").append('<option value="'+authedUser[i].id+'">'+authedUser[i].userName+'&ensp;('+authedUser[i].trueName+')</option>');
					}
				}
			});
			$("#curGroup").html(data[0].groupName);			
			$("#authUser").window("open");
		}
	}
	
	function updateRecord(){
		var c = $("input:checkbox[name=checkMember]:checked");
		var cstr = "";
		for(var i = 0; i < c.length; i++){
			if(c[i]){
				cstr += c[i]+",";
			}
		}
		$("#editMembers").val(cstr);
		$.ajax({
			url:"groupAction_update",
			type:"POST",
			data:$("#editRecordForm").serialize(),
			success: function(data){
				if(data == 1){
					layer.msg('更改成功！');
				}else{
					layer.msg('更改失败！');
				}
				$('#editRecord').window('close');
				initGrid();
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
		    url:'groupAction_listData',  
		    pagination:true,
		    method:'POST',
		    fit:true,
			fitColumns:true,
			rownumbers:true,
			singleSelect:true,
		    columns:[[    
				{field:'id',checkbox:true },
		        {field:'groupName',title:'组名',width:100},  
		        {field:'members',title:'组员',width:100},  
		        {field:'authUser',title:'授权用户',width:100},
		        {field:'createTime',title:'创建时间',width:100},    
		        {field:'mark',title:'备注',width:100}
		    ]]    
		});  
	}
</script>
</html>