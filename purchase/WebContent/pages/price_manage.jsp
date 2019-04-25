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
    <jsp:include page="/loadingDiv.jsp"></jsp:include>
	<script src="${basePath}/js/edit.js"></script>
	 <link href="${basePath}/assets/css/style.css" rel="stylesheet" />
  </head>
  
  <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">价格管理</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 30px">
 			 <div >
            
            	查询条件
                <select name="queryCol" id="queryCol" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;" editable="false">
                    <option value="">-选择-</option>
                    	<c:if test="${roleId eq '1'}">
	                	<option value="c.name">公司名称</option>
	                	</c:if>
	                 <option value="g.product">产品</option>
	                	 <option value="p.product">产品类别</option> 
	                	<option value="d.subProduct">产品名称</option>
	                	<option value="d.unit">单位</option>
	                	<option value="d.format">规格</option>
	                	<option value="d.material">材料</option>
                </select>
               		 查询内容
                <input name="queryValue" id = "queryValue"class=" form-control" style="display: inline-block;width: 10%">
                	查询条件：
                <select name="queryCol2" id="queryCol2" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;" editable="false">
                    <option value="">-选择-</option>
                    <c:if test="${roleId eq '1'}">
	                	<option value="c.name">公司名称</option>
	                	</c:if>
	                 <option value="g.product">产品</option>
	                	<!-- <option value="2">产品类别</option> -->
	                	<option value="d.subProduct">产品名称</option>
	                		<option value="d.unit">单位</option>
	                	<option value="d.format">规格</option>
	                	<option value="d.material">材料</option>
                </select>
               查询内容
                <input name="queryValue2" id = "queryValue2"class=" form-control" style="display: inline-block;width: 10%">
                <button onclick="query()"  class="btn btn-default queryBtn" >查询</button>
            </div> 
 		<table id="user_table" class="easyui-datagrid"></table>
 	</div>
 	<div id="toolbar_user" style="padding:2px 5px;">
 		<c:if test="${roleId eq '1'}">
        	<a onclick="price_default()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px">设置为默认报价</a> 
        	<a onclick="markup_many()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px"> 批量加价</a> 
        	<a onclick="markup_many_persent()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px"> 批量加价（百分比）</a>      
 		</c:if>
 		<c:if test="${roleId eq '2'}">
        	<!-- <a onclick="price_many()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px"> 批量设置价格</a>  -->
        	<a onclick="sup_markup_many()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px"> 批量加价</a> 
 		</c:if>
    </div>
	
    <script type="text/javascript">
    function query(){
	    	$('#user_table').datagrid('load', {
	    		colName: $("#queryCol").val(),
	    		colValue: $("#queryValue").val(),
	    		colName2:$("#queryCol2").val(),
	    		colValue2:$("#queryValue2").val()
	    	    
	    	});
	}
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
				pagePosition:'top',
				pageSize: 30,
				toolbar:'#toolbar_user',		
				fitColumns: true,
				striped:true,
				singleSelect: false,
				onDblClickCell:onDblClickCell,
				onUnselect:function(rowIndex, rowData){
				},
				onSelect:function(index,row){
					$("#user_table").datagrid("unselectRow" ,index);
				},
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
					{field:'parentName',title:'产品',width:20,align:'center'},
					{field:'productName',title:'产品类别',width:20,align:'center'},
					{field:'subProduct',title:'产品名称',width:20,align:'center'},
					{field:'material',title:'材料',width:20,align:'center'},
					{field:'price',title:'价格设置',width:20,align:'center',
					editor:{
						type:'text',
						options:{
							valueField:'price',
							textField:'price'
						}
					}},
					{field:'priceUnit',title:'单价',width:20,align:'center',formatter: function(value,row,index){
						
						if(row.price ){
							return  row.price + (row.unit==undefined?"":("/" + row.unit));
						}else{
							return "";
						}
					}},
					{field:'format',title:'规格',width:20,align:'center'},
					{field:'markup',title:'加价设置',width:20,align:'center',
						editor:{
							type:'text',
							options:{
								valueField:'markup',
								textField:'markup'
							}
					}},
					{field:'percent',title:'加价百分比(%)',width:20,align:'center'}
					/* {field:'taxrate',title:'不含税比率',width:20,align:'center',
						editor:{
							type:'text',
							options:{
								valueField:'taxrate',
								textField:'taxrate'
							}
					},formatter: function(value,row,index){
						if(value ){
							return value +  "%";
						}else{
							return "";
						}
					}}, */
					
				]],				
			});
			/* if("${roleId}" == '1'){
				$('#user_table').datagrid({
					singleSelect: false
				});
			} */
			 if('${roleId}' != '1'){
				 $('#user_table').datagrid('hideColumn', 'company');
				 $('#user_table').datagrid('hideColumn', 'level');
				 $('#user_table').datagrid('hideColumn', 'remark');
				 $('#user_table').datagrid('hideColumn', 'status');
				 $('#user_table').datagrid('hideColumn', 'markup');
				 $('#user_table').datagrid('hideColumn', 'percent');
			}
			 $("#loadingDiv").remove();
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
					updatePrice(val, target.productDetailId , target.mapid);
					/* var e = $('#user_table').datagrid('getEditor', {'index':rowIndex,'field':field}).target;  
                    	$(e).textbox('setValue',  Math.round(val * 100) / 100); */
					$('#user_table').datagrid('load');
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
					updatePriceMarkup(val ,  target.mapid , field);
					$('#user_table').datagrid('load');
				}
			});
		}
    	
		function updatePrice(price , detailId , mapid){
			price = Math.round(price * 100) / 100;
				$.ajax({ 
		    			url: '${pageContext.request.contextPath}/productAction!updateMappingPrice.action',
		    			data : {"price":price ,"detailId":detailId , "mapid" : mapid },
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
		
		function updatePriceMarkup(markup , mapid , column){
			markup = Math.round(markup * 100) / 100;
			$.ajax({ 
    			url: '${pageContext.request.contextPath}/productAction!updateMarkupPrice.action',
    			data : {"markup":markup ,"mapid":mapid , "column": column},
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
			var checkedItems = $('#user_table').datagrid('getChecked');
			if(checkedItems.length  == 0){
				return false;
			}
			var flag = confirm("同一种产品只能选择一个,确认选择的信息无误？");
			if(flag){
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
		
		function price_many(){
				var checkedItems = $('#user_table').datagrid('getChecked');
				if(checkedItems.length  == 0){
					return false;
				}
			var flag = confirm("确定进行批量修改价格？");
			if(flag){
				 $.messager.prompt('','请输入金额',function(s){
					if(s){
						$.ajax({ 
			    			url: '${pageContext.request.contextPath}/productAction!updatePriceMany.action',
			    			type:'post',
			    			data : { "obj": JSON.stringify(checkedItems) , price :s},
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
				}); 
			}
		}
		
		function sup_markup_many(){
			var checkedItems = $('#user_table').datagrid('getChecked');
			if(checkedItems.length  == 0){
				return false;
			}
			var flag = confirm("确定进行批量修改加价？");
			if(flag){
				$.messager.prompt('','请输入要加价的金额',function(s){
					if(s){
						$.ajax({ 
			    			url: '${pageContext.request.contextPath}/productAction!updateSupMarkupMany.action',
			    			type:'post',
			    			data : { "obj": JSON.stringify(checkedItems) , markup :s},
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
				});
			}
		}
		
		function markup_many(){
			
			var checkedItems = $('#user_table').datagrid('getChecked');
			if(checkedItems.length  == 0){
				return false;
			}
			var flag = confirm("确定进行批量修改加价？");
			if(flag){
				$.messager.prompt('','请输入要加价的金额',function(s){
					if(s){
						$.ajax({ 
			    			url: '${pageContext.request.contextPath}/productAction!updateMarkupMany.action',
			    			type:'post',
			    			data : { "obj": JSON.stringify(checkedItems) , markup :s},
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
				});
			}
		}
		
		function markup_many_persent(){
			var checkedItems = $('#user_table').datagrid('getChecked');
			if(checkedItems.length  == 0){
				return false;
			}
			var flag = confirm("确定按照百分比进行批量修改加价？");
			if(flag){
				$.messager.prompt('','请输入要加价的百分比，单位%',function(s){
					if(s){
						$.ajax({ 
			    			url: '${pageContext.request.contextPath}/productAction!updateMarkupByPercent.action',
			    			type : 'post',
			    			data : { "obj": JSON.stringify(checkedItems) , markup :s},
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
				});
			}
		}
    </script>
</body>
</html>
