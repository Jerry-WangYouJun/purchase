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
    <title>加急订单管理</title>
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
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:60px" >
 		<h3>加急订单管理</h3>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 20px">
 			<div >
            		订单编号：
                <input name="ono" id = "ono"class=" form-control" style="display: inline-block;width: 10%">
            		订单状态：
                <select name="ostatue" id="ostatue" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;" editable="false">
                    <option value="">-选择-</option>
	                	<option value="1">新订单</option>
	                	<!-- <option value="2">已报价</option> -->
	                	<option value="3">已付款</option>
	                	<option value="5">提交采购</option>
	                	<option value="4">已收货</option>
                </select>
                <button onclick="query()">查询</button>
            </div> 
 				<table id="table_order" class="easyui-datagrid" fit="true" ></table>
 	</div>
 	<div  id="order_dlg" closed="true" class="easyui-dialog" style="width:800px;height: 450px"
			data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
		    	<form id="order_form" role="form" style="padding: 20px">
				<input type="hidden"  id = "id"  name = "id">
				<input type="hidden"  id = "urgent"  name = "urgent" value ="1">
		    		<div class="form-group col-md-6">
		            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">订单编号：</label>
		                <input name="orderNo" id="orderNo" class="form-control" required style="display: inline-block;width: 40%" disabled="disabled">
		        </div>
		        <div class="form-group col-md-6">
		                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">下单时间：</label>
		                <input name="startDate" id = "startDate" class="easyui-datebox" style="display: inline-block;width: 40%">
		        </div>
		        <div class="form-group col-md-8">
		                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">请选择采购日：</label>
		               <!-- login时获取list存入session中 -->
		                <select name="confirmId" id= "confirmId" class="easyui-combobox" 
		                 editable="false" style="display: inline-block;width: 20%">
		                	 <c:forEach items="${confirm}" var="it">
		                	 	<c:if test=""></c:if>
		                	 	 <option value="${it.id}"  > ${it.confirmDate}日</option>
		                	 </c:forEach>
		                </select>
		        </div>
		    	</form>   
			    	<table id="table_add" class="easyui-datagrid" fit="true" ></table>              
		</div>
	<div id="company_dlg_buttons" style="width:600px;height: 40px;text-align: center">
			<button onclick="company_close()" type="button" class="btn btn-default btn-dialog-right">关闭</button>
	</div>
	<div id="toolbar_company" style="padding:2px 5px;">
	     <a onclick="order_detail()" class="easyui-linkbutton"  plain="true" iconCls="icon-tip" style="margin: 2px">详情</a>
	    <c:if test="${roleId eq 1 }">
	  	    <a onclick="order_status('3')" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">确认付款</a>    
	        <a onclick="invoice_status('1')" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">发票已开</a>
	    </c:if>
	    <c:if test="${roleId eq 3 }">
	  	    <a onclick="order_add()" class="easyui-linkbutton"  plain="true" iconCls="icon-add" style="margin: 2px">添加订单</a>    
	        <a onclick="order_edit()" class="easyui-linkbutton"  plain="true" iconCls="icon-edit" style="margin: 2px">修改订单</a>
	        <a onclick="order_delete()" class="easyui-linkbutton"  plain="true" iconCls="icon-remove" style="margin: 2px">删除订单</a>
	        <a onclick="order_status('4')" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">确认收货</a>
	        <a onclick="invoice_status('2')" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">发票已收</a>
	    </c:if>
    </div>
		   
    <script type="text/javascript">
	
    	$(function(){
    		$("#order_form").validate();
   		 $("#confirmId").combobox({
   		       required:true
   		  });
    		var  orderUrl = '${pageContext.request.contextPath}/orderAction!loadUrgentOrder.action' ;
			$('#table_order').datagrid({
				url: orderUrl,
				pagination: true,
				fitColumns: true,
				singleSelect: true,
				striped:true,
				toolbar: '#toolbar_company',
				rowStyler: function(index,row){
					if (row.status  == '4'){
						return 'background-color:#6293BB;color:#fff;'; // return inline style
						// the function can return predefined css class and inline style
						// return {class:'r1', style:{'color:#fff'}};	
					}
				},
				columns:[[
					{field:'id', hidden:'true',editor:'textbox' },
					{field:'companyId', hidden:'true',editor:'textbox' },
					{field:'confirmId', hidden:'true',editor:'textbox' },
					{field:'companyName',title:'公司',width:100,align:'center'},
					{field:'orderNo',title:'订单编号',width:100,align:'center'},
					{field:'conirmDate',title:'采购批次',width:100,align:'center',
						formatter: function(value,row,index){
							if(row.confirmDate ){
								return row.confirmDate
							}else{
								<c:forEach items="${confirm}" var="item"  >  
									if(row.confirmId == '${item.id}'){
								        return "${item.confirmDate}";  //获得值,加引号
									}
						    		</c:forEach>
							}
					}},
					{field:'startDate',title:'下单时间',width:120,align:'center',
						formatter: function(value,row,index){
							if(value){
								return value.substring(0,16);
							}else{
								return "";
							}
							
						}},
					{field:'pillDate',title:'付款时间',width:120,align:'center',
						formatter: function(value,row,index){
							if(value){
								return value.substring(0,16);
							}else{
								return "";
							}
						}},
					{field:'endDate',title:'收货时间',width:120,align:'center',
						formatter: function(value,row,index){
							if(value){
								return value.substring(0,16);
							}else{
								return "";
							}
						}},
						
					{field:'status',title:'订单状态',width:100,align:'center',
						formatter : function(value, row, index) {
							if (value == '1') {
								return "新订单";
							} else if (value == '2') {
								return "已报价";
							} else if(value =='3' ){
								if(row.percent != undefined){
									return  "已付款" + row.percent + "%";
								}
								 return "已付款";
							} else if(value == "4"){
								return "已收货";
							} else if(value == "5"){
								return "已提交采购";
							}
	
						}
					},{field:'invoice',title:'发票状态',width:100,align:'center',
						formatter : function(value, row, index) {
							if (value == '1') {
								return "发票已开";
							}  else if(value == "2"){
								return "发票已收";
							}else {
								return "发票未开";
							}
	
						}
					},{field:'invoice_date',title:'开票/接收时间',width:120,align:'center',
							formatter : function(value, row, index) {
								if (row.invoice == '1') {
									return   row.invoiceDate.substring(0,16);
								}  else if(row.invoice == "2"){
									return  row.invoiceGet.substring(0,16);
								}else {
									return "";
								}
							}
					},
					{field:'remark',title:'备注',width:100,align:'center'}
				]],
				
			});
		
			$('#dlg-frame').dialog( {
				title : '新增订单',
				width :  909,
				height : 600,
				top:50,
				left:100,
				closed : true,
				cache : false,
				modal : true,
				buttons : [ {
					text : '确定',iconCls : 'icon-ok',
					handler : function() {
						if (confirm("确定执行下一步操作？")) {
							frameContent.window.doServlet();
						}
					}
				}, {
					text : '关闭',iconCls : 'icon-cancel',
					handler : function() {
						$('#dlg-frame').dialog("close");
					}
				} ]
			});
			
			$('#startDate').datebox({
			     formatter: function(date){
			    		return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
			    	}
			   
			});
			if("${roleId}" == '3'){
		    		$('#table_order').datagrid('hideColumn', 'companyName');
	    		}
			$(".datagrid-row-alt").css("backgroundColor" , "#a9f9f9")
		});
    	
    	var editIndex = undefined;
    	 var toolbarAdd =  [{
				text:'添加产品条目',iconCls: 'icon-add',
				handler: function(){append();}
			},'-',{
				text:'删除',iconCls: 'icon-remove',
				handler: function(){removeit();}
			},'-',{
				text:'重置',iconCls: 'icon-undo',
				handler: function(){reject();}
			},'-',{
				text:'提交',iconCls: 'icon-ok',
				handler: function(){submitData();}
			}];
		   
		   var toolbarAdmin = [{
					text:'重置',iconCls: 'icon-undo',
					handler: function(){reject();}
				},'-',{
					text:'提交',iconCls: 'icon-ok',
					handler: function(){submitData();}
				}];
		   
		   var columnDetail = [[
	   						{field:'product',title:'产品大类',width:100,align:'center'},
	   						{field:'type',title:'产品类型',width:100,align:'center'},
	   						{field:'sub_product',title:'产品规格',width:100,align:'center'},
	   						{field:'materail',title:'材质/标准',width:100,align:'center'},
	   						{field:'brand',title:'品牌',width:100,align:'center'},
	   						{field:'acount',title:'数量',width:100,align:'center'},
	   						{field:'unit',title:'单位',width:100,align:'center'},
	   						{field:'detailId', hidden:'true',editor:'textbox' },
	   						{field:'productId', hidden:'true',editor:'textbox' },
	   						{field:'base', hidden:'true',editor:'textbox' },
	   						{field:'remark',title:'备注',width:100,align:'center'},
	   						{field:'id', hidden:'true',editor:'textbox' }
	   					]];
		   var columnEdit = [[
								{field:'product',title:'产品大类',width:100,align:'center',
									editor : {    
				                        type : 'combobox',    
				                        options : {    
				                            url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
				                            valueField:'product' ,   
				                            textField:'product',  
				                            onSelect:function(data){ 
				                            	//选择的行
				                                var row = $('#table_add').datagrid('getSelected');  
				                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
				                                 var ed = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'unit'  //根据字段名获取编辑的字段
				                                    });  
				                                $(ed.target).textbox('setValue',  data.unit);   //赋值
				                                $(ed.target).combobox('disable');//不可用
				                                
				                                //定义要编辑的列
				                                var target = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'type'}).target;  
				                                target.combobox('clear'); //清除原来的数据  
				                                var subtarget = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'sub_product'}).target;  
				                                subtarget.combobox('clear');
				                                var url = '${pageContext.request.contextPath}/orderAction!getProductTypeByParentId.action?parentId='+data.id;  
				                                target.combobox('reload', url);//联动下拉列表重载   */
				                                
				                            }  
				                        }    
				                    	}
								},
								{field:'type',title:'产品类型',width:100,align:'center',
									editor : {    
				                        type : 'combobox',    
				                        options : {    
				                           // url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
				                            valueField:'product' ,   
				                            textField:'product',  
				                            onSelect:function(data){  
				                                var row = $('#table_add').datagrid('getSelected');  
				                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
				                                var thisTarget = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'type'}).target;  
				                                var value = thisTarget.combobox('getValue');  
				                                var idvalue = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'productId'  
			                                    });  
			                                $(idvalue.target).textbox('setValue',  data.id ); 
				                                var target = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'sub_product'}).target;  
				                                target.combobox('clear'); //清除原来的数据  
				                                var url = '${pageContext.request.contextPath}/orderAction!getProductDetail.action?productId='+data.id;  
				                                target.combobox('reload', url);//联动下拉列表重载   
				                            } , onLoadSuccess:function(){ //数据加载完成执行该代码
				                                var data= $(this).combobox("getData");
				                                var row = $('#table_add').datagrid('getSelected');  
				                                 var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
				                                 var bra = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'base'  
				                                    });  
				                                $(bra.target).textbox('setValue',  data[0].base);  
				                                $(bra.target).combobox('disable');//不可用
				                			}  
				                        }    
				                    }
								},
								{field:'sub_product',title:'产品规格',width:100,align:'center',
									editor : {    
				                        type : 'combobox',    
				                        options : {    
				                           // url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
				                            valueField:'subProduct' ,   
				                            textField:'subProduct',  
				                            onSelect:function(data){  
				                                var row = $('#table_add').datagrid('getSelected');  
				                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
				                                 var ed = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'materail'  
				                                    });  
				                                $(ed.target).textbox('setValue',  data.material); 
				                                $(ed.target).combobox('disable');
				                                var idvalue = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'detailId'  
			                                    });  
			                               	 $(idvalue.target).textbox('setValue',  data.id );   
				                               	var target = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'brand'}).target;  
				                                target.combobox('clear'); //清除原来的数据  
				                                var url = '${pageContext.request.contextPath}/orderAction!getProductBrand.action?detailId='+data.id;  
				                                target.combobox('reload', url);//联动下拉列表重载   
				                                target.combobox({    
				                                    required:true,    
				                                    multiple:false, //多选
				                                    editable:false  //是否可编辑
				                                    });  
				                            }  
				                        },
				                    	}},
								{field:'materail',title:'材质/标准',width:100,align:'center',editor:'textbox'},
								{field:'brand',title:'品牌',width:100,align:'center',editor:{    
			                        type : 'combobox',    
			                        options : {    
			                           // url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
			                            valueField:'brand' ,   
			                            textField:'brand',  
			                            onLoadSuccess:function(){ //数据加载完成执行该代码
			                                var data= $(this).combobox("getData");
			                                var row = $('#table_add').datagrid('getSelected');  
			                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
			                                 var bra = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'brand'  
			                                    });  
			                                $(bra.target).textbox('setValue',  data[0].brand); 
			                			} 
			                        }   
			                    }},
								{field:'acount',title:'数量',width:100,align:'center',editor:'textbox'},
								{field:'base', title:'最低采购量',width:100,align:'center',editor:'textbox' },
								{field:'unit',title:'单位',width:100,align:'center',editor:'textbox'},
								{field:'detailId', hidden:'true',editor:'textbox' },
								{field:'productId', hidden:'true',editor:'textbox' },
								{field:'remark',title:'备注',width:100,align:'center',editor:'textbox'},
								{field:'id', hidden:'true',editor:'textbox' }
							]];
    	$(function(){
    		   if("${roleId}" == '3'){
				$('#table_add').datagrid({
					url:'${pageContext.request.contextPath}/orderAction!searchDetail.action' ,
					pagination: true,
					fitColumns: true,
					singleSelect: true,
					striped:true,
					onClickRow: onClickRow,//选中行是，调用onClickRow js方法（397行）
					toolbar:toolbarAdd,
					columns:columnEdit
				});
    		   }else if("${roleId}" == '1'){
    			   $('#table_add').datagrid({
   					url:'${pageContext.request.contextPath}/orderAction!searchDetail.action' ,
   					pagination: true,
   					fitColumns: true,
   					singleSelect: true,
   					striped:true,
   					onClickRow: onClickRow,//选中行是，调用onClickRow js方法（397行）
   					toolbar: toolbarAdmin,
   					columns:columnDetail
   				});
    		   }
			//$("#table_add").datagrid("hideColumn","amount");
		});
    	
   
    </script>
    
</body>
</html>
