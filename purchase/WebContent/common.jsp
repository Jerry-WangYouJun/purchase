<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" scope="request"></c:set>
<script type="text/javascript" src="${basePath}/js/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script> 
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-table.min.css" />  
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.js"></script>
<script type="text/JavaScript" src="${basePath}/js/jquery.form.js"></script>

<link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />  
<script src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>  
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script> 
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script> 


<script type="text/javascript">
		
		function addInfo() {
			$(':input', '#dataForm').not(':button,:submit,:reset').val(
			'').removeAttr('checked').removeAttr('checked');
			$("#myModal").modal("show");
		}
		
		function updateData() {
			var selectRow =  $("#infoTable").bootstrapTable('getSelections')[0];
			SetFromValues($("#dataForm"),selectRow);
			$("#myModal").modal("show");
		}
		function SetFromValues(el, data)
		{
		    for (var p in data)
		    {
		        el.find(":input[name='" + p + "']").val(data[p]);
		    } 
		}
		
		function subInfoAll(name) {
			var path = "${pageContext.request.contextPath}/"+name+"/"+name+"_edit";
			$.ajax({
				url : path,
				type : 'post',
				data : $("#dataForm").serialize(),
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						alert(data.msg);
						$("#infoTable").bootstrapTable("refresh");
						closeModel();
					} else {
						alert(data.msg);
					}
		
				},
				error : function(transport) {
					alert("系统产生错误,请联系管理员!");
				}
			});
		}
		
		function closeModel() {
			$("#myModal").modal("hide");
			$(':input', '#dataForm').not(':button,:submit,:reset').val(
					'').removeAttr('checked').removeAttr('checked');
			
		}
		function deleteDataAll(name) {
			var del = confirm("确认删除？");
			if (!del) {
				return false;
			}
			var selectObj = $("#infoTable").bootstrapTable('getSelections')[0];
			console.info(selectObj);
			var id = selectObj.id;
			if (id > 0) {
				var path = "${basePath}/"+name+"/"+name+"_delete";
				$.ajax({
					url : path,
					type : 'post',
					data:{'id':id},
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							alert( data.msg);
							$("#infoTable").bootstrapTable("refresh");
						} else {
							alert( data.msg);
						}
		
					},
					error : function(transport) {
						alert( "系统产生错误,请联系管理员!");
					}
				});
			}
		}
		
		
		
</script>