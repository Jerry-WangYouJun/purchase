<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>订单管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    
    
     
     <link href="<%=path%>/vendor/select-tree/base.css" rel="stylesheet" type="text/css" />
     <link href="<%=path%>/vendor/select-tree/style.css" rel="stylesheet" type="text/css" />
    
	 <link href="<%=path%>/vendor/easyui/themes/material/easyui.css" rel="stylesheet" type="text/css">
     <link href="<%=path%>/vendor/easyui/themes/icon.css" rel="stylesheet" type="text/css">
     
	<script src="<%=path%>/vendor/jquery/jquery.min.js"></script>
	
    <script src="<%=path%>/vendor/select-tree/select-tree.js" type="text/javascript"></script>
	<script src="<%=path%>/vendor/easyui/jquery.easyui.min.js"></script>

  </head>
  
 <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<span style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">订单类别选择</span>
 		<a onclick="select_save()" id="select_save" style="background-color:#e05447;color:#fff;float: right;width:60px;height: 30px;line-height: 30px;text-align: center;margin-top: 5px">保存</a>
 	</div>
 	
	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 3px" class="production-menu" id="pro_datalist" fit="true">
 		<div class='menu' id='firstMenu'>
			<!-- <div id='result' style='display:none' ></div> -->
  		</div>
  		<div class="sub-menu easyui-panel" fit="true" id="secondMenu" style="padding-bottom: 20px" >

  		</div>
 	</div>
	<div data-options="region:'south',border:false"  style="height:20px" ></div>
    <script type="text/javascript">
    	$(function(){
    		refresh();
		});
		function select_save(){
			var productlist = getSelected();
			if(productlist ==null || productlist =='' )
				{
					alert('请选择一个产品');
					return;
				}
			$.ajax({ 
				url: '${pageContext.request.contextPath}/productAction!saveUserProduct.action',	
				data : {'productlist':productlist},		
				dataType : 'json',
				success : function(obj){
					if (obj.success) {
						alert(obj.msg);
						//refresh();
					} else {
						alert(obj.msg);
					}
				}
			});			
		}
		
		function reset()
		{
			$(".sele").attr("class","");
			//$("#secondMenu dd").hide();			
			//$(firstMenu).find("ul li:first").trigger("click");
		}
		
		function refresh(){
			$.ajax({ 
				url: '${pageContext.request.contextPath}/productAction!loadByCompanyId.action',			
				dataType : 'json',
				success : function(obj){
					initMenu("pro_datalist", obj);
				 }
			});
		}
    </script>
</body>
</html>
