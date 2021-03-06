<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人消费统计图</title>
<%@taglib prefix="s" uri="/struts-tags"%>
	<jsp:include page="/WEB-INF/jsps/general/general.jsp"></jsp:include>
	<script type="text/javascript" src="js/Highcharts-4.0.3/js/highcharts.js"></script>
	<style type="text/css">
		.btn{
			background-color: #E3E3E3;
		}
		.costgroup{
			padding: 5px;
			background-color: lightgray;
			margin-left: 5px;
			text-decoration: none;
			color: gray;
		}
		.costgroup:HOVER {
			background-color:lightblue;
			border-radius:5px;
		}
		.curGroup{
			background-color:lightblue;
			border-radius:5px;
		}
	</style>
</head>
<body>
	<div style="width: 100%; text-align: right;">
		<select class="easyui-combobox" panelHeight="auto" style="width:100px" id="graphic">
			<option value="column">柱形</option>
			<option value="line">折线</option>
			<option value="spline">弧线</option>
			<option value="area">区域</option>
		</select>
	</div>
	<br>
	<div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
</body>
<script type="text/javascript">
var chart;

$(function() {
	$("#graphic").combobox({
		editable: false,
		onChange: function (newVal,oldVal) {
			var gId = $(".curGroup").attr("id");
			init(newVal,gId);
		}
	});
	init("column", ${groupId});
});

function changeGroup(groupId, curgroup){
	var allGroup = $(".costgroup");
	for(var i = 0; i < allGroup.length; i++){
		$(allGroup[i]).removeClass("curGroup");
		$(curgroup).addClass("curGroup");
	}
	init("column", groupId);
}

function init(type, groupId){
	var data;
	$.ajax({
		url: "costAction_statisticDataForColumn",
		type: "GET",
		async: false,
		success: function(rdata){
			data = rdata;
		}
	});
	var curDate = new Date();
	var year = curDate.getFullYear();

	chart = new Highcharts.Chart({

	chart: {

		renderTo: 'container',

		type: type

	},

		title: {

		text: '个人消费记录统计图-'+year

	},

	subtitle: {

		text: '来源：www.personalspace.cn'

	},

	xAxis: {
		title: {

			text: '时间'
		
		},

		categories: [

			'一月',
		
			'二月',
			
			'三月',
			
			'四月',
			
			'五月',
			
			'六月',
			
			'七月',
			
			'八月',
		
			'九月',
			
			'十月',
			
			'十一月',
			
			'十二月'

		]
	
	},

	yAxis: {

		min: 0,

		title: {

			text: '金额 (￥)'
		
		}
		
	},

	legend: {

		layout: 'vertical',

		backgroundColor: '#FFFFFF',
		
		align: 'left',
		
		verticalAlign: 'top',
		
		x: 100,

		y: 70,
		
		floating: true,
		
		shadow: true
		
	},

	tooltip: {

		formatter: function() {
		
			return ''+this.x +': '+ this.y +' 元';
		
		}

	},

	plotOptions: {

		column: {

			pointPadding: 0.2,
	
			borderWidth: 0

		}

	},

	series: data

	});
}

</script>
</html>