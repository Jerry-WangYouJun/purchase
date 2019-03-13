<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>色卡管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->    
    
   <jsp:include page="/common.jsp"></jsp:include>
    <jsp:include page="/loadingDiv.jsp"></jsp:include>
    <script src="${basePath}/vendor/layer/layer.js"></script> 
     <link href="${basePath}/assets/css/style.css" rel="stylesheet" /> 
  </head>
  <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">
 				<c:choose >
									<c:when test="${roleId eq '1' }">
										 色卡管理
									</c:when>
									<c:when test="${roleId eq '2' }">
										供应商色卡
									</c:when>
									<c:when test="${roleId eq '3' }">
										客户查看色卡
									</c:when>
							 </c:choose>
 		</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 30px">
 		<table id="company_table" class="easyui-datagrid" fit="true" ></table>
 	</div>
	<div id="toolbar_company" style="padding:2px 5px;">
	<c:if test="${roleId eq 1 }">
     	<a onclick="company_add()" class="easyui-linkbutton"  plain="true" iconCls="" style="margin: 2px">新增色卡</a>
     	<a onclick="company_edit()" class="easyui-linkbutton"  plain="true" iconCls="" style="margin: 2px">更换色卡</a>
	</c:if>
	<c:if test="${roleId ne 2 }">
        <a onclick="getimgUrl()" class="easyui-linkbutton"  plain="true" iconCls="" style="margin: 2px">预览</a>    
   </c:if>
    <c:if test="${roleId eq 1 }">
        <a onclick="company_delete()" class="easyui-linkbutton"  plain="true" iconCls="" style="margin: 2px">删除</a>
    </c:if>
    </div>
	
    <script type="text/javascript">
    function getimgUrl(){
  	  var row = $('#company_table').datagrid('getSelected');
  	  var img = "<div><button type='button' onclick='xuanzhuan()'>旋转90°</button></div><div id='imgDiv' style='margin:20px' ><img src='/ring/upload/"+row.imgUrl+"' id='img1' width='90%' height='90%' /><div>"
  	      layer.tab({
  	        area: ['90%', '90%'],
  	        tab: [{
  	          title: '色卡', 
  	          content: img
  	        }]
  	      }); 
    }
    function getNaturalSize (Domlement) {
    	 var natureSize = {};
    	 if(window.naturalWidth && window.naturalHeight) {
    	  natureSize.width = Domlement.naturalWidth;
    	  natureSize.height = Domlement.naturalHeight;
    	 } else {
    	  var img = new Image();
    	  img.src = Domlement.src;
    	  natureSize.width = img.width;
    	  natureSize.height = img.height;
    	 }
    	 return natureSize;
    	}
    	 
    
    
    	var current =  0 ;
    function xuanzhuan(){
    	 current = (current+90)%360;
        /*  alert($("#imgDiv")); */
         var img = $("#img1")[0];
         // 打印
         //alert('width:'+img.offsetWidth +',height:'+img.offsetHeight);
         if(img.offsetWidth > img.offsetHeight){
        	 		$("#img1")[0].style.transform = 'rotate('+current+'deg)scale('+ img.offsetHeight/img.offsetWidth +' , ' + img.offsetHeight/img.offsetWidth + ')';
         }else{
	         $("#img1")[0].style.transform = 'rotate('+current+'deg)';
         }
    }
    
    function query(){
	    	$('#company_table').datagrid('load', {
	    	    name: $("#cname").val(),
	    	    brand: $("#brand").val(),
	    	    business:$("#business").val(),
	    	    address:$("#address").val()
	    	});
    }
    
    	$(function(){
    		var role = '${role}';
    		var flag = true;
    		if(role != '1'){
    			 flag = false;
    		}
			$('#company_table').datagrid({
				url:'${pageContext.request.contextPath}/companyAction!loadColor.action?roleId=2'  ,
				pagination: true,
				toolbar:'#toolbar_company',		
				pagePosition:'top',
				pageSize: 30,
				fitColumns: true,
				striped:true,
				singleSelect: true,
				columns:[[
					{field:'id', checkbox:'true',editor:'textbox' },
					{field:'brand',title:'品牌',width:'20%',align:'center'},
					{field:'imgUrl',title:'色卡图片',width:'20%',align:'center',
						formatter:function(value,row,index){
							if(row.imgUrl){
								 return "<img   width='' height='50px' src='/ring/upload/"+value+"' >";
							}
						 }
				     },
				     {field:'descrip',title:'描述',width:'20%',align:'center'}
				]]	
			});	 
			
		});
		function company_add(){
			var row = $('#company_table').datagrid('getSelected');
				layer.open({
					  type: 2,
					  title: '导入色卡图片',
					  shadeClose: true,
					  shade: 0.8,
					  area: ['450px', '40%'],
					  content: '<%=path%>/report!importColorInit.action'//iframe的url
				});
		}
		
		
		
		function company_edit(){
			var row = $('#company_table').datagrid('getSelected');
    		if(row){
    			layer.open({
					  type: 2,
					  title: '导入色卡图片',
					  shadeClose: true,
					  shade: 0.8,
					  area: ['450px', '40%'],
					  content: '<%=path%>/report!importColorInit.action?id='+row.id//iframe的url
				});
			}
    	}
		function company_delete(){
			var row = $('#company_table').datagrid('getSelected');
    		if(row){
    			$.messager.confirm(
    				'提示',
    				'确定要删除么?',
    				function(r) {
    					if (r) {
    						$.ajax({ 
    			    			url: '${pageContext.request.contextPath}/companyAction!updateColor.action',
    			    			data : {"id":row.id},
    			    			dataType : 'json',
    			    			success : function(obj){
    			    				if(obj.success){
    			    				 	alert(obj.msg);
    			    				 	$('#company_table').datagrid('reload');
    			    				}else{
    			    					alert(obj.msg);
    			    					$('#company_table').datagrid('reload');
    			    				}
    			    			}
    			    		});
    					}
    				});  		
    			}
		}
		function company_close(){
			$('#company_form').form('reset');
			$('#company_form').form('clear');
			$('#company_dlg').dialog('close');	
			$('#company_table').datagrid('reload');
			$('label.error').remove();
			$('.error').removeClass("error");
		}
		
		
		$(function(){
			$("#company_form").validate();
			$('#roleId').combobox({
				onChange:function(n,o){
					 if(n == '2'){
						  $(".brand").show();
						  $(".business").css("margin-bottom" , "0px");
					 }else {
						 $(".brand").hide(); 
						 $(".business").css("margin-bottom" , "15px");
					 }
			    }
			});
		})
		
		function checkOnly(val){
		$.ajax({
			url : '${pageContext.request.contextPath}/userAction!checkUserOnly.action',
			data : $('#company_form').serialize(),
			dataType : 'json',
			success : function(obj) {
				if (!obj.success) {
					alert(obj.msg);
					$("#userName").val("");
				} 
			}
		});
	}
		
		function importImg() {
			var filename = $("#uploadFile").val().split("\\")[2];
			$('#ImportForm')
					.ajaxSubmit(
							{
								url : '${pageContext.request.contextPath}/report!importImage.action?filename='
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
    
    <div id="company_dlg_buttons" style="width:800px;height: 40px;text-align: center">
		<button id="company_save" type="button" class="btn btn-primary btn-dialog-left">保存</button>
		<button onclick="company_close()" type="button" class="btn btn-default btn-dialog-right">取消</button>
	</div>
	
	
	<div  id="company_dlg" closed="true" class="easyui-dialog" style="width:750px;height: 450px"
	data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
    	<form id="ImportForm" action="${pageContext.request.contextPath}/report!importExcel.action"
			 method="post" enctype="multipart/form-data" class="form-horizontal">
			 <input type="hidden" name="proId" value="${proId}">
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
				data-dismiss="fileupload" onclick="importImg()">导入</a>
			</div>
		</div>
	</form>                
    </div>
</body>
</html>
