<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>价格管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    
    
   <jsp:include page="/common.jsp"></jsp:include>

  </head>
  
  <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">价格管理</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 3px">
 		<table id="user_table" class="easyui-datagrid"></table>
 	</div>
	
    <script type="text/javascript">
    $.extend($.fn.datagrid.methods, {
		editCell: function(jq,param){
			return jq.each(function(){
				var opts = $(this).datagrid('options');
				var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
				for(var i=0; i<fields.length; i++){
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor1 = col.editor;
					if (fields[i] != param.field){
						col.editor = null;
					}
				}
				$(this).datagrid('beginEdit', param.index);
				for(var i=0; i<fields.length; i++){
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor = col.editor1;
				}
			});
		}
	});
	var editIndex = undefined;
    
    	$(function(){
			$('#user_table').datagrid({
				url:'${pageContext.request.contextPath}/productAction!loadProducntDetailByCompany.action',
				pagination: true,
				toolbar:'#toolbar_user',		
				fitColumns: true,
				striped:true,
				singleSelect: true,
				onDblClickCell:onDblClickCell,
				columns:[[
					{field:'id',title:'id',width:20,align:'center', hidden:'true'},
					{field:'productName',title:'产品类别',width:20,align:'center',formatter:function(row,value){
						return value.product.type;
					}},
					{field:'subProduct',title:'小类名称',width:20,align:'center'},
					{field:'format',title:'规格',width:20,align:'center'},
					{field:'material',title:'材料',width:20,align:'center'},
					{field:'price',title:'价格',width:20,align:'center',formatter:function(row,value){
						return value.mapper.price;
					},
					editor:{
						type:'text',
						options:{
							valueField:'price',
							textField:'price'
						}
					}}
				]],				
			});
		});
    	
    	function onDblClickCell(rowIndex, field){
    		var rows=$('#user_table').datagrid('getRows');//获取所有当前加载的数据行
    		var target=rows[rowIndex];///
			$('#user_table').datagrid('selectRow', rowIndex)
			.datagrid('editCell', {index:rowIndex,field:field});
			$("input.datagrid-editable-input").val(target.mapper.price).bind("blur",function(evt){
				target.mapper.price = $("input.datagrid-editable-input").val();
				if(target.mapper.price  == '' || target.mapper.price  == 0){
					 alert("不能为空或0 ,请重新填写");
					 return false;
				}
				updatePrice(target.mapper.price , target.mapper.productDetailId);
				$("#user_table").datagrid('endEdit',rowIndex);
			});
		}
    	
		function updatePrice(price , detailId){
			$.ajax({ 
    			url: '${pageContext.request.contextPath}/productAction!updateMappingPrice.action',
    			data : {"price":price ,"detailId":detailId },
    			dataType : 'json',
    			success : function(obj){
    				if(obj.success){
    				 	//alert(obj.msg);
    				 	//$('#user_table').datagrid('reload');
    				}else{
    					alert(obj.msg);
    					$('#user_table').datagrid('reload');
    				}
    			}
    		});
		}
    </script>
</body>
</html>
