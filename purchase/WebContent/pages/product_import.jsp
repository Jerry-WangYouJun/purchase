<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/common.jsp"></jsp:include>
<title>Insert title here</title>
<script type="text/javascript">
	function importData() {
		var filename = $("#uploadFile").val().split("\\")[2];
				$('#ImportForm').ajaxSubmit({
					url : '${pageContext.request.contextPath}/report!importExcel.action?filename='+filename,
					dataType : 'text',
					success : resutlMsg,
					error : errorMsg
				});
		};
	
	function resutlMsg(msg) {
		alert(msg);
		$("#uploadFile").val("");
	}
	function errorMsg() {
		alert("导入excel出错！");
	}
</script>
</head>
<body>
  	 <form id="ImportForm" action="${pageContext.request.contextPath}/report!importExcel.action" method="post" enctype="multipart/form-data">
  	 	  	 <input type="file" name="uploadFile" id="uploadFile">
  	 	 	<input type="button" id="btn" value="导入" onclick="importData()">
  	 </form>
</body>
</html>