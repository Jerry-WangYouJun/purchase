<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML >
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
   
	 <%-- <script src="<%=path%>/vendor/jquery/jquery.min.js"></script> --%>
	<%--  <link href="<%=path%>/vendor/zTree/css/demo.css" type="text/css" rel="stylesheet"> --%>
	 <link href="<%=path%>/vendor/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css" rel="stylesheet">
	 <script type="text/javascript" src="<%=path%>/vendor/zTree/js/jquery-1.4.4.min.js"></script>
	 <script type="text/javascript" src="<%=path%>/vendor/zTree/js/jquery.ztree.core.js"></script>
	 <script type="text/javascript" src="<%=path%>/vendor/zTree/js/jquery.ztree.excheck.js"></script>	
	 <script type="text/javascript" src="<%=path%>/vendor/zTree/js/jquery.ztree.exedit.js"></script>	
     <script type="text/javascript">
		var setting = {
			check: {
				enable: true
			},
			data: {
				  simpleData : {  
		                enable : true,  
		                idKey : "id",  
		                pIdKey : "pid",  
		                rootPId : 0  
		            } 
			}
		};
			
		var treeNodes; 
		var code;
		
		function setCheck() {
			var zTree = $.fn.zTree.getZTreeObj("tree"),
			py = $("#py").attr("checked")? "p":"",
			sy = $("#sy").attr("checked")? "s":"",
			pn = $("#pn").attr("checked")? "p":"",
			sn = $("#sn").attr("checked")? "s":"",
			type = { "Y":"s", "N":"s"};
			zTree.setting.check.chkboxType = type;
			showCode('setting.check.chkboxType = { "Y" : "' + type.Y + '", "N" : "' + type.N + '" };');
		}
		function showCode(str) {
			if (!code) code = $("#code");
			code.empty();
			code.append("<li>"+str+"</li>");
		}		

		$(document).ready(function(){
			
		  $.ajax({  
	            async : false,//是否异步  
	            cache : false,//是否使用缓存  
	            type : 'POST',//请求方式：post  
	            dataType : 'json',//数据传输格式：json  
	            url : "<%=path%>/productAction!loadTreeByCompanyId.action",  
	            error : function() {  
	                //请求失败处理函数  
	                alert('网页有错误，请联系管理员！');  
	            },  
	            success : function(data) {  
	                treeNodes = data;//把后台封装好的简单Json格式赋给treeNodes  
                
	            }  
	        });  
			 
			$.fn.zTree.init($("#tree"), setting,treeNodes);
			setCheck();
			$("#py").bind("change", setCheck);
			$("#sy").bind("change", setCheck);
			$("#pn").bind("change", setCheck);
			$("#sn").bind("change", setCheck);
		});
		
		
		function select_save()
		{
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			
			var nodes = treeObj.getCheckedNodes(true);
			var productlist ="" ;
			
			for (var i = 0; i < nodes.length; i++) {
				var temp = nodes[i];
				if(temp.id.indexOf("detail_")!=-1)
					{
					
						productlist += temp.id.substr(temp.id.length-1)+",";
					}
			}
			productlist = productlist.substr(0,productlist.length-1);
			
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
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			treeObj.checkAllNodes(false);
		}
    </script>
  
  </head>
  
 <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<span style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">订单类别选择</span>
 		<a onclick="select_save()" id="select_save" style="background-color:#e05447;color:#fff;float: right;width:60px;height: 30px;line-height: 30px;text-align: center;margin-top: 5px">保存</a>
 		<a onclick="reset()" id="reset" style="background-color:#007FFF;color:#fff;float: right;width:60px;height: 30px;line-height: 30px;text-align: center;margin-top: 5px;margin-right:10px">重置</a>
 		
 	</div>
 	
<!-- 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 3px" class="production-menu" id="pro_datalist" fit="true">
 		<div class='menu' id='firstMenu'>

  		</div>
  		<div class="sub-menu easyui-panel" fit="true" id="secondMenu" style="padding-bottom: 20px" >

  		</div>
 	</div>
	<div data-options="region:'south',border:false"  style="height:20px" ></div> -->
	 <div>
	   <ul id="tree" class="ztree"></ul>
	</div> 
 
	
</div>
</body>
</html>
