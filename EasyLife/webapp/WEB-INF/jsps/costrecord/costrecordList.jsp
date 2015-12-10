<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="images/logo.ico" />
	<link rel="stylesheet" href="js/layer/skin/layer.css" type="text/css" media="screen" />
	<jsp:include page="/WEB-INF/jsps/general/general.jsp"></jsp:include>
	<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="js/layer/layer.js"></script>
	<script type="text/javascript" src="js/layer/extend/layer.ext.js"></script>
	
<!-- 	<link href="js/bootstrap/css/bootstrap.min.css" rel="stylesheet"> -->
	<link href="js/bootstrap/css/font-awesome.min.css" rel="stylesheet">
	<link rel="stylesheet" href="js/bootstrap/css/bootstrap-theme.css">
	<link rel="stylesheet" href="js/jQuery-File-Upload-9.11.2/css/jquery.fileupload.css">
	<link rel="stylesheet" href="js/jQuery-File-Upload-9.11.2/css/jquery.fileupload-ui.css">
	<script type="text/javascript" src="js/ajaxfileupload.js"></script>
	<script type="text/javascript" src="js/jQuery-File-Upload-9.11.2/js/vendor/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="js/jQuery-File-Upload-9.11.2/js/jquery.fileupload.js"></script>
	<script type="text/javascript" src="js/jQuery-File-Upload-9.11.2/js/jquery.iframe-transport.js"></script>
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
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="$('#addRecord').window('open')">新增记录</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true">编辑记录</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除记录</a>
		</div>
		<div>
			消费日期: <input class="easyui-datebox" style="width:150px" id="startTime">
			到: <input class="easyui-datebox" style="width:150px" id="endTime">
			消费人: 
			<select class="easyui-combobox" panelHeight="auto" style="width:100px" id="userName">
				<option value="0">--请选择--</option>
				<option value="1">韩晓军</option>
				<option value="2">胡丰盛</option>
				<option value="3">李洪亮</option>
			</select>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryData()">搜索</a>
			<a href="#" class="easyui-linkbutton" onclick="reset()">重置</a>
		</div>
	</div>
	<div id="addRecord" class="easyui-window" title="新增记录" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;padding:10px;">
				<form id="recordForm" method="post" theme="simple">
					<input type="hidden" name="record.attachment" id="attachment"/>
					<table style="width: 100%;">
						<tr>
							<td>消费人：</td>
							<td>
								<select class="easyui-combobox" panelHeight="auto" style="width:145px" name="record.user" data-options="editable:false">
									<option value="0">--请选择--</option>
									<option value="1">韩晓军</option>
									<option value="2">胡丰盛</option>
									<option value="3">李洪亮</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>消费金额：</td>
							<td>
								<input name="record.cost" placeholder="消费金额" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>消费用途：</td>
							<td>
								<input name="record.costFor" placeholder="消费用途" style="width: 145px;"/>
							</td>
						</tr>	
						<tr>
							<td>消费时间：</td>
							<td>
								<input name="record.costdate" class="easyui-datebox" style="width: 145px;"/>
							</td>
						</tr>
						<tr>
							<td>备注：</td>
							<td>
								<textarea name="record.mark" placeholder="消费备注" rows="5" style="width: 145px;"></textarea>
							</td>
						</tr>
						<tr>
							<td>选择附件：</td>
							<td>
								 <img id="weixin_show" style="height:50px;margin-top:10px;margin-bottom:8px;" data-holder-rendered="true">
								<div class="row fileupload-buttonbar" style="padding-left:15px;padding-right:20px;">  
								    <div class="thumbnail ">  
									    <div class="progress progress-striped active" role="progressbar" aria-valuemin="10" aria-valuemax="100" aria-valuenow="0">
									    	<div id="weixin_progress" class="progress-bar progress-bar-success" style="width:0%;"></div>
									    </div>  
									    <div class="caption" align="center">  
									    <span id="weixin_upload" class="btn btn-primary fileinput-button">  
									    <a href="#" class="easyui-linkbutton">选择图片</a>
									    <input type="file" id="weixin_image" name="file" multiple>  
									    </span>  
									    <a id="weixin_cancle" href="javascript:void(0)" class="btn btn-warning" role="button" onclick="cancleUpload('weixin')" style="display:none">删除</a>  
									    </div>  
								    </div>  
							    </div> 
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
	function showImg(img){
		var imgPath = $(img).attr("src");
		layer.msg('<img src="'+imgPath+'" width="300px">', {
		    time: 20000, //20s后自动关闭
		    btn: ['关闭']
		});
	}

	function submitData(){
		$.ajax({
			url:"costAction_add",
			type:"POST",
			data:$("#recordForm").serialize(),
			success: function(data){
				if(data == 1){
					layer.msg('保存成功！');
				}else{
					layer.msg('保存失败！');
				}
				$('#addRecord').window('close');
				queryData();
// 				setTimeout("queryData()",1000);
			}
		});
	}

	function queryData(){
		$("#dg").datagrid('load',{
			  "startTime":$("#startTime").datebox('getValue'),
			  "endTime":$("#endTime").datebox('getValue'),
			  "userName":$("#userName").combobox('getValue')
		});
	}
	
	function reset(){
		$("#startTime").datebox('setValue','');
		$("#endTime").datebox('setValue','');
		$("#userName").combobox('setValue',0);
		queryData();
	}
	
	$(function(){
		initGrid();
		initFileUpload();
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
			singleSelect:false,
		    columns:[[    
				{field:'id',checkbox:true },
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
	
	function initFileUpload(){
		$("#weixin_image").fileupload({  
	        url: 'costAction_uploadPhoto',  
	        sequentialUploads: true  
	    }).bind('fileuploadprogress', function (e, data) {  
	        var progress = parseInt(data.loaded / data.total * 100, 10);  
	        $("#weixin_progress").css('width',progress + '%');  
	        $("#weixin_progress").html(progress + '%');  
	    }).bind('fileuploaddone', function (e, data) { 
	    	$("#attachment").val(data.result.url);
	        $("#weixin_show").attr("src",data.result.url);  
	        $("#weixin_upload").css({display:"none"});  
	        $("#weixin_cancle").css({display:"none"}); 
	        $("#uploadBtn").html("<font color='blue'>上传成功！</font>");
	        $('#uploadFile').window('close');
	    });  
	}
</script>
</html>