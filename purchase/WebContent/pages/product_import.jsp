<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}" scope="request"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${basePath}/media/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="${basePath}/media/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="${basePath}/media/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="${basePath}/media/css/bootstrap-fileupload.css" />
<script src="${basePath}/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script src="${basePath}/media/js/jquery-migrate-1.2.1.min.js"
	type="text/javascript"></script>
<script src="${basePath}/media/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${basePath}/media/js/bootstrap-fileupload.js"></script>
<script type="text/JavaScript" src="${basePath}/js/jquery.form.js"></script>
<script src="${basePath}/vendor/layer/layer.js"></script>
<style type="text/css">
	 .controls{
	 	 margin-left:30px !important;
	 	 margin-top: 20px; 
	 }
</style>
<title>Insert title here</title>
<script type="text/javascript">
	function importData() {
		var filename = $("#uploadFile").val().split("\\")[2];
		$('#ImportForm')
				.ajaxSubmit(
						{
							url : '${pageContext.request.contextPath}/report!importExcel.action?filename='
									+ filename,
							dataType : 'text',
							success : resutlMsg,
							error : errorMsg
						});
	};

	function resutlMsg(data) {
		var json = JSON.parse(data) ;
		var index = parent.layer.getFrameIndex(window.name); 
		if(json.success){
			alert(json.msg);
			parent.location.reload();  
			parent.layer.close(index);
		}else{
			alert(json.msg);
		}
		$("#uploadFile").val("");
		$(".fileupload-preview").text("");
	}
	function errorMsg() {
		alert("导入excel出错！");
	}
</script>
</head>
<body>
		<!-- <input type="file" name="uploadFile" id="uploadFile" class="default">
		<input type="button" id="btn" value="导入" onclick="importData()"> -->
	<form id="ImportForm" action="${pageContext.request.contextPath}/report!importExcel.action"
			 method="post" enctype="multipart/form-data" class="form-horizontal">
		<div class="control-group">
			<div class="controls">
				<div class="fileupload fileupload-new" data-provides="fileupload">
					<div class="input-append">
						<div class="uneditable-input">
							<i class="icon-file fileupload-exists"></i> <span
								class="fileupload-preview"></span>
						</div>
						<span class="btn btn-file">
						 	<span class="fileupload-new">选择文件</span> 
						 	<span class="fileupload-exists">修改文件</span> 
							<input type="file" class="default" name="uploadFile" id="uploadFile"/>
						</span> <a href="#" class="btn fileupload-exists"
							data-dismiss="fileupload" >清空</a>
					</div>
				</div>
			</div>
			<div class="controls">
				<a href="#" class="btn"
				data-dismiss="fileupload" onclick="importData()">导入</a>
			</div>
		</div>
	</form>
</body>
</html>