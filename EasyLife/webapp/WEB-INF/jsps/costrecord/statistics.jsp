<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="/images/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/jsps/general/general.jsp"></jsp:include>
<%@taglib prefix="s" uri="/struts-tags"%>
<link rel="stylesheet" type="text/css" href="css/style.css">
<title>消费统计信息</title>
<style type="text/css">
	.generalStatistics{
		width:70%;
		margin-left: auto;
		margin-right: auto;
		margin-top: 10px;
	}
	.cost-detail{
		margin-left: auto;
		margin-right: auto;
	}
	.detail-table{
		padding: 10px;
		text-align: center;
		width: 100%;
	}
	.detail-table td{
		width: 50%;
	}
	
	.subTable{
		width: 100%;
		text-align: center;
	}
	.subTable th{
		border: 1px solid gray;
	}
	
	.searchParam{
		height: 34px;
	}
</style>
</head>
<body>
	<div class="main-container">
		<div class="body-container">
			<s:form id="searchForm" action="costAction_statisticsTable" method="post">
				<div style="width: 100%; text-align: right;">
					<select class="searchParam" name="groupId">
						<c:forEach items="${groups}" var="group">
							<option value="${group.id}">${group.groupName}</option>
						</c:forEach>
					</select>
					<s:select name="year" placeholder="年份" cssClass="searchParam"  value="%{#request.year}"
						list="#{0:'--选择年--',2010:'2010年',2011:'2011年',2012:'2012年',2013:'2013年',2014:'2014年',2015:'2015年',2016:'2016年',2017:'2017年',2018:'2018年',2019:'2019年',2020:'2020年'}">
						</s:select>
						<s:select name="month" placeholder="月份" cssClass="searchParam" value="%{#request.month}"
						list="#{0:'--选择月--',1:'1月',2:'2月',3:'3月',4:'4月',5:'5月',6:'6月',7:'7月',8:'8月',9:'9月',10:'10月',11:'11月',12:'12月'}"></s:select>
						<s:submit value="查看统计信息" cssClass="easyui-linkbutton" cssStyle="height:32px;"/>
				</div>
			</s:form>
			<div class="statistics">
				<h3 style="width: 100%; text-align: center;">2016年3月7日</h3>
				<div class="generalStatistics">
					<div class="easyui-panel cost-detail" title="概况">
					<table class="detail-table">
						<tr>
							<td>月总消费</td>
							<td>${monthTotal.monthTotalExceptSettled} 元</td>
						</tr>
						<tr>
							<td>人均消费</td>
							<td>${monthTotal.monthTotalExceptSettled/count} 元</td>
						</tr>
					</table>
					</div>
				</div>
				<c:forEach items="${result}" var="result" varStatus="status">
					<div class="generalStatistics">
						<div class="easyui-panel cost-detail" title="${result.user}">
							<table class="detail-table">
							<tr>
								<td>月总消费</td>
								<td>${result.statisticResult.costTotal.csum} 元</td>
							</tr>
							<tr>
								<td>消费次数</td>
								<td>${result.statisticResult.costTimes}<a href="javascript:void(0);" onclick="tableSlideDown('${status.index}_tab')">点击详情</a></td>
							</tr>
							<tr>
								<td>本月收支情况</td>
								<td>
									<c:set var="presult" value="${result.statisticResult.costTotal.csum - (monthTotal.monthTotalExceptSettled/count)}"></c:set>
									<c:if test="${presult > 0}">
										<font color="blue" size="5">${presult} 元</font>
									</c:if>
									<c:if test="${presult == 0}">
										<font size="5">收支平衡</font>
									</c:if>
									<c:if test="${presult < 0}">
										<font color="red" size="5">${presult} 元</font>
									</c:if>
								</td>
							</tr>
						</table>
						</div>
					</div>
					<div title="${result.user}的当月消费记录" style="width:1000px;" id="${status.index}_tab"  class="easyui-window" data-options="closed:true,maximized:false,minimizable:false,maximizable:false">
						<table class="subTable" id="subTable">
							<tr >
								<th class="subTableLine">消费人</th>
								<th class="subTableLine">消费金额（元）</th>
								<th class="subTableLine">消费用途</th>
								<th class="subTableLine">消费时间</th>
								<th class="subTableLine">状态</th>
								<th class="subTableLine">备注</th>
							</tr>
							<c:forEach items="${result.statisticResult.records}" var="record">
								<tr>
									<td class="subTableLine">
										${record.user}
									</td>
									<td class="subTableLine">${record.cost}</td>
									<td class="subTableLine">${record.costFor}</td>
									<td class="subTableLine">${record.costdate}</td>
									<td class="subTableLine">
										<c:if test="${record.status == 0}">
											未结
										</c:if>
										<c:if test="${record.status == 1}">
											<font color="green">已结</font>
										</c:if>
									</td>
									<td class="subTableLine" style="text-align: left;">${record.mark}</td>
								</tr>
							</c:forEach>
						</table>
						</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	function tableSlideDown(tableId){
		$('#'+tableId).window('open');
// 		$('#'+tableId).slideDown(1000);
// 		$("#"+tableId+"_view").html("收起");
// 		$(t).attr("onclick","tableSlideUp('"+tableId+"',this)");
	}
	
	function tableSlideUp(tableId,t){
		$('#'+tableId).slideUp(1000);
		$("#"+tableId+"_view").html("查看");
		$(t).attr("onclick","tableSlideDown('"+tableId+"',this)");
	}
</script>
</html>