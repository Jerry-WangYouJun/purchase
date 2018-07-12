<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" scope="request"></c:set>
<script type="text/javascript" src="${basePath}/js/jquery-3.1.1.min.js"></script>
<script src="${basePath}/js/jquery.validate.min.js"></script>
<script src="${basePath}/js/jquery.metadata.js"></script>
<script src="${basePath}/js/messages_zh.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link href="${basePath}/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script> 
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-table.min.css" />  
<link href="${basePath}/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="${basePath}/vendor/dist/css/sb-admin-2.css" rel="stylesheet">
<link href="${basePath}/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.js"></script>
<script type="text/JavaScript" src="${basePath}/js/jquery.form.js"></script>

<link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />  
<script src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>  
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script> 
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script> 

<script src="${basePath}/vendor/metisMenu/metisMenu.min.js"></script>
<script src="${basePath}/vendor/dist/js/sb-admin-2.js"></script>

<script src="${basePath}/vendor/easyui/jquery.easyui.min.js"></script>
<script src="${basePath}/vendor/easyui/locale/easyui-lang-zh_CN.js"></script>
<link href="${basePath}/vendor/easyui/themes/material/easyui.css" rel="stylesheet" type="text/css">
<link href="${basePath}/vendor/easyui/themes/icon.css" rel="stylesheet" type="text/css">
<link href="${basePath}/css/dialog_head.css" rel="stylesheet" type="text/css">

<style>
.error{
	 color:red;
}
</style>