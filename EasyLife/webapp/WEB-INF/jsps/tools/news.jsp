<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>历史上的今天</title>
<%@taglib prefix="s" uri="/struts-tags"%>
	<jsp:include page="/WEB-INF/jsps/general/general.jsp"></jsp:include>
	<script type="text/javascript" src="js/Highcharts-4.0.3/js/highcharts.js"></script>
	<style type="text/css">
		.btn{
			background-color: #E3E3E3;
		}
		input {
			width:30%;
			height:40px;
			font-family: "微软雅黑";
			vertical-align:middle;
			font-size: xx-large;
		}
	</style>
</head>
<body>
	<div style="width: 100%; text-align: center;margin-top: 25px;" >
		<div id="news">
		<s:iterator value="%{#news}" var="new">
			<h2><a href="${new.url}" target="blank">${new.title}</a></h2>
			<img src="${new.image_url}"/>
			<p>${new.abstract}</p>
		</s:iterator>
		</div>
	</div>
</body>
</html>