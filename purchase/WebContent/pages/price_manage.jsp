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
	<script src="${basePath}/js/edit.js"></script>
  </head>
  
  <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">价格管理</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 3px">
 		<table id="user_table" class="easyui-datagrid"></table>
 	</div>
 	<div id="toolbar_user" style="padding:2px 5px;">
 		<c:if test="${roleId eq '1'}">
        	<a onclick="price_default()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px">设置为默认报价</a>    
 		</c:if>
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
				singleSelect: false,
				onDblClickCell:onDblClickCell,
				columns:[[
					{field:'id', checkbox:'true'},
					{field:'companyId',hidden:'true'},
					{field:'mapId',hidden:'true'},
					{field:'productDetailId',title:'productDetailId',width:20,align:'center', hidden:'true'},
					{field:'company',title:'公司',width:20,align:'center'},
					{field:'remark',title:'品牌',width:20,align:'center'},
					{field:'level',title:'企业星级',width:20,align:'center'},
					{field:'status',title:'状态',width:20,align:'center',formatter: function(value,row,index){
						if(value == '1'){
							return "默认报价";
						}else{
							return "";
						}
					}},
					{field:'productName',title:'产品类别',width:20,align:'center'},
					{field:'subProduct',title:'小类名称',width:20,align:'center'},
					{field:'format',title:'规格',width:20,align:'center'},
					{field:'material',title:'材料',width:20,align:'center'},
					{field:'price',title:'价格设置',width:20,align:'center',
					editor:{
						type:'text',
						options:{
							valueField:'price',
							textField:'price'
						}
					}},
					{field:'markup',title:'加价设置',width:20,align:'center',
						editor:{
							type:'text',
							options:{
								valueField:'markup',
								textField:'markup'
							}
					}},
					{field:'unit',title:'单位',width:20,align:'center'}
				]],				
			});
			if("${roleId}" == '1'){
				$('#user_table').datagrid({
					singleSelect: false
				});
			}
			 if('${roleId}' != '1'){
				 $('#user_table').datagrid('hideColumn', 'company');
				 $('#user_table').datagrid('hideColumn', 'level');
				 $('#user_table').datagrid('hideColumn', 'remark');
				 $('#user_table').datagrid('hideColumn', 'status');
				 $('#user_table').datagrid('hideColumn', 'markup');
			}
		});
    	
    	function onDblClickCell(rowIndex, field){
    		if('${roleId}' == '1' && field == 'price'){
				 return false ;
			}
    		if('${roleId}' == '2' && field == 'markup'){
				 return false ;
			}
    		var rows=$('#user_table').datagrid('getRows');//获取所有当前加载的数据行
    		for(var i in rows){
    			if(i != rowIndex){
	    			$("#user_table").datagrid('endEdit',i);
    			}
    		}
    		var target=rows[rowIndex];///
			$('#user_table').datagrid('selectRow', rowIndex)
			.datagrid('editCell', {index:rowIndex,field:field});
			$("input.datagrid-editable-input").bind("change",function(evt){
				reg=/^[-\+]?\d+(\.\d+)?$/;
				var val  = $("input.datagrid-editable-input").val();
				if(field == 'price'){
					if(val  == '' || val  == 0){
						 alert("不能为空或0 ,请重新填写");
						 return false;
					}
					if(!reg.test(val)){
						alert("不是数字格式，请重新输入~");
						$("input.datagrid-editable-input").val('');
						$("input.datagrid-editable-input").focus();
						return false ;
					}
					updatePrice(val, target.productDetailId);
				}else{
					if(val  == '' ){
						 alert("不能为空,请重新填写");
						 return false;
					}
					if(!reg.test(val)){
						alert("不是数字格式，请重新输入~");
						$("input.datagrid-editable-input").val('');
						$("input.datagrid-editable-input").focus();
						return false ;
					}
					updatePriceMarkup(val , target.mapid);
				}
				$("input.datagrid-editable-input").val(Number(val));
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
		
		function updatePriceMarkup(markup , mapid){
			$.ajax({ 
    			url: '${pageContext.request.contextPath}/productAction!updateMarkupPrice.action',
    			data : {"markup":markup ,"mapid":mapid },
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
		
		function price_default(){
			var flag = confirm("同一种产品只能选择一个,确认选择的信息无误？");
			if(flag){
				var checkedItems = $('#user_table').datagrid('getSelections');
				$.ajax({ 
	    			url: '${pageContext.request.contextPath}/productAction!updateMappingStatus.action',
	    			data : { "obj": JSON.stringify(checkedItems)},
	    			dataType : 'json',
	    			success : function(obj){
	    				if(obj.success){
	    				 	alert(obj.msg);
	    				 	$('#user_table').datagrid('reload');
	    				}else{
	    					alert(obj.msg);
	    					$('#user_table').datagrid('reload');
	    				}
	    			}
	    		});
			}
		}
    </script>
</body>
</html>
