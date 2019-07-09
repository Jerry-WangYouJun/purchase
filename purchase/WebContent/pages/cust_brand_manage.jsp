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
    
    <title>用户常用采购信息管理</title>
    
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
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">常用品牌管理</p>
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
        	<a onclick="updateBrand_many()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px"> 批量设置品牌</a>
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
	 
	 var brandJson = {} ;
	 $.ajax({ 
			url: '${pageContext.request.contextPath}/companyAction!loadAllBrand.action?colName=roleId&colValue=2',
			dataType : 'json',
			success : function(obj){
				brandJson = obj
			}
		});
	 
    	$(function(){
			$('#user_table').datagrid({
				url:'${pageContext.request.contextPath}/productAction!loadProducntDetailByCompany.action?colName=roleId&colValue=3',
				pagination: true,
				pagePosition:'top',
				pageSize: 30,
				toolbar:'#toolbar_user',		
				fitColumns: true,
				striped:true,
				singleSelect: false,
				checkOnSelect:false,
				onDblClickCell:onDblClickCell,
				onUnselect:function(rowIndex, rowData){
				},
				onSelect:function(index,row){
					$("#user_table").datagrid("unselectRow" ,index);
				},
				onAfterEdit:function(rowIndex, rowData, changes	){
					 if(changes.brand){
						 var rows=$('#user_table').datagrid('getRows');
					     	$.ajax({ 
				    			url: '${pageContext.request.contextPath}/userProAction!updateMapperBrand.action',
				    			data : {"mapid":rows[editIndex].mapid ,"brand": changes.brand  },
				    			dataType : 'json',
				    			success : function(obj){
				    				if(obj.success){
				    					//alert(obj.msg)
				    				}else{
				    					alert(obj.msg);
				    				}
				    			}
				    		});
					 }
				},
				columns:[[
					{field:'id', checkbox:'true'},
					{field:'companyId',hidden:'true'},
					{field:'mapId',hidden:'true'},
					{field:'productDetailId',title:'productDetailId',width:20,align:'center', hidden:'true'},
					{field:'company',title:'公司',width:20,align:'center'},
					{field:'level',title:'企业星级',width:20,align:'center'},
					{field:'parentName',title:'产品',width:20,align:'center'},
					{field:'productName',title:'产品类别',width:20,align:'center'},
					{field:'subProduct',title:'产品名称',width:20,align:'center'},
					{field:'material',title:'材料',width:20,align:'center'},
					{field:'brandStatus',title:'是否系统品牌',width:20,align:'center',
						formatter: function(value,row,index){
						var flag = false ; 
						for( var i = 0 ; i < brandJson.length ; i++){
							 if(brandJson[i].brand == row.brand){
								  flag = true ; 
								  break;
							 }
						}
						if(flag){
							return "系统内品牌";
						}else{
							return "非系统内品牌";
						}
					}}, 
					{field:'brand',title:'品牌',width:20,align:'center',
					editor:{
					    type: 'combobox',
					    options: {
					  	  	url:'${pageContext.request.contextPath}/companyAction!loadAllBrand.action?colName=roleId&colValue=2', 
					        valueField: "brand",
					        textField: "brand"
					    },
					}},
					{field:'format',title:'规格',width:20,align:'center'}
					
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
			}
			 $("#loadingDiv").remove();
		});
    	
    	function onDblClickCell(rowIndex, field){
    		var rows=$('#user_table').datagrid('getRows');//获取所有当前加载的数据行
    		var target=rows[rowIndex];///
    		for(var i in rows){
    			if(i != rowIndex){
	    			$("#user_table").datagrid('endEdit',i);
    			}
    		}
			$('#user_table').datagrid('selectRow', rowIndex)
			.datagrid('editCell', {index:rowIndex,field:field});
			editIndex = rowIndex ;
		}
    	
		
		
		function updateBrand_many(){
				var checkedItems = $('#user_table').datagrid('getChecked');
				if(checkedItems.length  == 0){
					return false;
				}
			var flag = confirm("确定进行批量修改品牌名？");
			if(flag){
				 $.messager.prompt('','请输入品牌名',function(s){
					if(s){
						$.ajax({ 
			    			url: '${pageContext.request.contextPath}/userProAction!updateMapperBrandMany.action',
			    			type:'post',
			    			data : { "obj": JSON.stringify(checkedItems) , brand :s},
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
