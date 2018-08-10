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
		    	</form>   
			    	<table id="table_add" class="easyui-datagrid" fit="true" ></table>              
		</div>
	<div id="company_dlg_buttons" style="width:600px;height: 40px;text-align: center">
			<button onclick="company_close()" type="button" class="btn btn-default btn-dialog-right">关闭</button>
	</div>
	<div id="toolbar_company" style="padding:2px 5px;">
	     <a onclick="order_detail()" class="easyui-linkbutton"  plain="true" iconCls="icon-tip" style="margin: 2px">详情</a>
	    <c:if test="${roleId eq 1 }">
	    		<a onclick="order_edit('admin')" class="easyui-linkbutton"  plain="true" iconCls="icon-edit" style="margin: 2px">修改订单</a>
	    		<a onclick="order_status('2')" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">确认报价</a> 
	  	    <a onclick="order_status('3')" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">确认付款</a>  
	        <a onclick="invoice_status('1')" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">发票已开</a>
	    </c:if>
	    <c:if test="${roleId eq 3 }">
	  	    <a onclick="order_add()" class="easyui-linkbutton"  plain="true" iconCls="icon-add" style="margin: 2px">添加订单</a>    
	        <a onclick="order_edit('')" class="easyui-linkbutton"  plain="true" iconCls="icon-edit" style="margin: 2px">修改订单</a>
	        <a onclick="order_delete()" class="easyui-linkbutton"  plain="true" iconCls="icon-remove" style="margin: 2px">删除订单</a>
	        <a onclick="order_status('4')" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">确认收货</a>
	        <a onclick="invoice_status('2')" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">发票已收</a>
	    </c:if>
    </div>
		   
    <script type="text/javascript">
	
    	$(function(){
    		var  orderUrl = '${pageContext.request.contextPath}/orderAction!loadUrgentOrder.action' ;
			$('#table_order').datagrid({
				url: orderUrl,
				pagination: true,
				fitColumns: true,
				singleSelect: false,
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
					{field:'id', checkbox:'true',editor:'textbox' },
					{field:'companyId', hidden:'true',editor:'textbox' },
					{field:'companyName',title:'公司',width:100,align:'center'},
					{field:'orderNo',title:'订单编号',width:100,align:'center'},
					{field:'startDate',title:'下单时间',width:120,align:'center',
						formatter: function(value,row,index){
							if(value){
								return value.substring(0,16);
							}else{
								return "";
							}
							
						}},
					{field:'amount',title:'订单总金额',width:100,align:'center'},
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
							return getDicValue("status",value , row);
						}
					},{field:'invoice',title:'发票状态',width:100,align:'center',
						formatter : function(value, row, index) {
							return  getDicValue("invoice",value , row);
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
					}
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
		   var json = [];
	    	 var row1 = {value:'1',text:'托管'}
	    	 var row2 = {value:'2',text:'不托管'}
	    	 json.push(row1);
	    	 json.push(row2);  
		   
		   var columnDetail = [[
	   						{field:'product',title:'产品大类',width:100,align:'center'},
	   						{field:'type',title:'产品类型',width:100,align:'center'},
	   						{field:'sub_product',title:'产品名称',width:100,align:'center'},
	   					 	{field:'format',title:'产品规格',width:100,align:'center'},
	   						{field:'materail',title:'材质/标准',width:100,align:'center'},
	   						{field:'brand',title:'品牌',width:100,align:'center'},
	   						{field:'unit',title:'单位',width:100,align:'center'},
	   						{field:'amount',title:'总价',width:100,align:'center',editor:'textbox'},
	   						{field:'acount',title:'数量',width:100,align:'center'},
	   						{field:'price',title:'单价',width:100,align:'center'},
	   						{field:'defaultFlag',title:'托管采购',width:100, formatter: function(value,row,index){
								if(value == '1'){
									return "托管";
								}else{
									return "不托管";
								}
							}
		               		 },
	   						{field:'supplierCompanyId', hidden:'true' },
	   						{field:'detailId', hidden:'true',editor:'textbox' },
	   						{field:'productId', hidden:'true',editor:'textbox' },
	   						/* {field:'base', hidden:'true',editor:'textbox' }, */
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
				                                var product = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'product'});
				                                var initialValue =  $(product.target).textbox('getValue');//产品大类原来的值
				                                 var ed = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'unit'  //根据字段名获取编辑的字段
				                                    });  
				                                $(ed.target).textbox('setValue',  data.unit);   //赋值
				                                $(ed.target).combobox('disable');//不可用
				                              //条目总价不可编辑
				                                 var amount = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'amount'  //根据字段名获取编辑的字段
				                                    });  
				                                $(amount.target).textbox('readonly');   //赋值
				                                //定义要编辑的列
				                                var target = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'type'}).target;  
				                                if(initialValue != data.product){
				                                		target.combobox('clear'); //清除原来的数据  
				                                		//$(target).textbox('setValue',  val);
				                                }
				                                var subtarget = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'sub_product'}).target;  
				                                if(initialValue != data.product){
					                                subtarget.combobox('clear');
				                                		//$(target).textbox('setValue',  val);
				                                }
				                                var url = '${pageContext.request.contextPath}/orderAction!getProductTypeByParentId.action?parentId='+data.id;  
				                                target.combobox('reload', url);//联动下拉列表重载   */
				                                
				                                if("${roleId}" == '1'){
					                                var pro = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'product'  //根据字段名获取编辑的字段
				                                    });
					                                $(pro.target).combobox('disable');
				                                }
				                                
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
				                                if(value != data.product){
					                                target.combobox('clear'); //清除原来的数据  
				                                }
				                                var url = '${pageContext.request.contextPath}/orderAction!getProductDetail.action?productId='+data.id;  
				                                target.combobox('reload', url);//联动下拉列表重载   
				                            } , onLoadSuccess:function(){ //数据加载完成执行该代码
				                                var data= $(this).combobox("getData");
				                                var row = $('#table_add').datagrid('getSelected');  
				                                 var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
				                                /*  var bra = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'base'  
				                                    });  
				                                $(bra.target).textbox('setValue',  data[0].base);  
				                                $(bra.target).combobox('disable');//不可用 */
				                                
				                                //判断为admin时 除了价格都变为不可编辑
				                                if("${roleId}" == '1'){
					                                var pro = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'type'  //根据字段名获取编辑的字段
				                                    });
					                                $(pro.target).combobox('readonly');
					                                var pro = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'sub_product'  //根据字段名获取编辑的字段
				                                    });
					                                $(pro.target).combobox('readonly');
					                                var pro = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'brand'  //根据字段名获取编辑的字段
				                                    });
					                                $(pro.target).combobox('readonly');
					                                
					                                var pro = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'materail'  //根据字段名获取编辑的字段
				                                    });
					                                $(pro.target).textbox('readonly');
					                                var pro = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'acount'  //根据字段名获取编辑的字段
				                                    });
					                                $(pro.target).textbox('readonly');
					                                var pro = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'remark'  //根据字段名获取编辑的字段
				                                    });
					                                $(pro.target).textbox('readonly');
					                                var fmt = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'format'  //根据字段名获取编辑的字段
				                                    });
					                                $(fmt.target).textbox('readonly');
				                                }else{
				                                		var pro = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'price'  //根据字段名获取编辑的字段
				                                    });
					                                $(pro.target).textbox('readonly');
				                                }
				                			}  
				                        }    
				                    }
								},
								{field:'sub_product',title:'产品名称',width:100,align:'center',
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
				                                var fmt = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'format'  
			                                    });  
				                                $(fmt.target).textbox('setValue',  data.format); 
				                                $(fmt.target).combobox('disable');
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
				                 {field:'format',title:'产品规格',width:100,align:'center',editor:'textbox'},
								{field:'materail',title:'材质/标准',width:100,align:'center',editor:'textbox'},
								{field:'brand',title:'品牌',width:100,align:'center',editor:{    
			                        type : 'combobox',    
			                        options : {    
			                           // url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
			                            valueField:'brand' ,   
			                            textField:'brand', 
			                            onSelect:function(data){  
			                                var row = $('#table_add').datagrid('getSelected');  
			                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
			                                var idvalue = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'supplierCompanyId'  
		                                    });  
		                               	 $(idvalue.target).textbox('setValue',  data.supplierCompanyId );   
			                            } ,
			                            onLoadSuccess:function(){ //数据加载完成执行该代码
			                                var data= $(this).combobox("getData");
			                                var row = $('#table_add').datagrid('getSelected');  
			                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
			                                 var bra = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'brand'  
			                                    });  
			                                $(bra.target).textbox('setValue',  data[0].brand); 
			                                if("${roleId}" == '1'){
				                                var pro = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'brand'  //根据字段名获取编辑的字段
			                                    });
				                                $(pro.target).combobox('disable');
			                                }
			                				} 
			                        }   
			                    }},
								{field:'unit',title:'单位',width:100,align:'center',editor:'textbox'},
								{field:'acount',title:'数量',width:100,align:'center',editor:{
									type:'textbox',
									options:{
										valueField:'acount' ,   
			                            textField:'acount',
			                            onChange:function(newValue,oldValue){
			                            		 if(newValue == '' || newValue == '0' || newValue==undefined){
			                            			  return ;
			                            		 }
			                            		 changeAmount();
			                            }
										
									}
								}},
								/* {field:'base', title:'最低采购量',width:100,align:'center',editor:'textbox' }, */
								{field:'price',title:'单价',width:100,align:'center',editor:{
									type:'textbox',
									options:{
										valueField:'price' ,   
			                            textField:'price',
			                            onChange:function(newValue,oldValue){
			                            		 if(newValue == '' || newValue == '0' || newValue==undefined){
			                            			  return ;
			                            		 }
			                            		 changeAmount();
			                            }
										
									}
								}},
								{field:'amount',title:'总价',width:100,align:'center',editor:'textbox'},
								{field:'defaultFlag',title:'托管采购',width:100, editor: {
			                        type: 'combobox',
			                        options: {
			                            data: json ,
			                            valueField: "value",
			                            textField: "text",
			                            editable: false,
			                            onSelect:function(data){  
			                                var row = $('#table_add').datagrid('getSelected');  
			                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
		                                	var bra = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'brand'  
		                                    });  
			                                var pri = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'price'  
		                                    });  
			                                var supplierCompanyId = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'supplierCompanyId'  
		                                    });  
		                                	var brandData = $(bra.target).combobox('getData');
			                                if(data.value == '1' && brandData.length > 0){
				                                $(bra.target).textbox('setValue',  brandData[0].brand); 
				                                $(bra.target).combobox("disable" );
			                              	    $(pri.target).textbox('setValue',  brandData[0].price); 
			                              		$(pri.target).combobox("disable" );
			                              		$(pri.target).textbox('setValue',  brandData[0].supplierCompanyId); 
			                                }else{
			                                	$(bra.target).combobox("enable" );
			                                	$(pri.target).combobox("enable" );
			                                }
			                            }
			                        }
								}, formatter: function(value,row,index){
										if(value == '1'){
											return "托管";
										}else{
											return "不托管";
										}
									}
				                },
								{field:'detailId', hidden:'true',editor:'textbox' },
								{field:'supplierCompanyId', hidden:'true',editor:'textbox' },
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
    	
	    	 $.extend($.fn.datagrid.methods, {
	 	        getEditingRowIndexs: function(jq) {
	 	            var rows = $.data(jq[0], "datagrid").panel.find('.datagrid-row-editing');
	 	            if(rows.length  == 0 ){
	 	            	 return 0 ;
	 	            }
	 	            var indexs = [];
	 	            rows.each(function(i, row) {
	 	                var index = row.sectionRowIndex;
	 	                if (indexs.indexOf(index) == -1) {
	 	                    indexs.push(index);
	 	                }
	 	            });
	 	            return indexs;
	 	        }
	 	   });
	    		
	 		function endEditing(){
	 			if($("#orderNo").val() != ''){
	 				var order = $("#table_order").datagrid('getSelected');
	 				if(order != null &&  order.status != '1'  ){
	 					return false;
	 				} 
	 			}
	 			if (editIndex == undefined){
	 				return true
	 			}
	 			if(!checkDetail()){
	 				 return false;
	 			}
	 			if ($('#table_add').datagrid('validateRow', editIndex)){
	 				$('#table_add').datagrid('endEdit', editIndex);
	 				editIndex = undefined;
	 				return true;
	 			} else {
	 				return false;
	 			}
	 		}
	 		
	 		function checkDetail(){
	 			var index = $('#table_add').datagrid('getEditingRowIndexs');
	 			if(index.length > 0){
	 				  var product = $("#table_add").datagrid('getEditor', {  
	 	                  index : index ,
	 	                  field : 'product'      
	 	              }).target.combobox('getValue');
	 				  var type = $("#table_add").datagrid('getEditor', {  
	 	                  index : index ,
	 	                  field : 'type'      
	 	              }).target.combobox('getValue');
	 				  var sub_product = $("#table_add").datagrid('getEditor', {  
	 	                  index : index ,
	 	                  field : 'sub_product'      
	 	              }).target.combobox('getValue');
	 				  var brand = $("#table_add").datagrid('getEditor', {  
	 	                  index : index ,
	 	                  field : 'brand'      
	 	              }).target.combobox('getValue');
	 			 	 if(product == '' || type  == '' || sub_product == '' ||brand == '' ||acount == '' ){
	 			 		    alert('当前编辑商品数据不全，请仔细核对！');
	 						return false;		 		
	 			 	 } 
	 				  var acount = $("#table_add").datagrid('getEditor', {  
	 	                  index : index ,
	 	                  field : 'acount'      
	 	              }).target.textbox('getValue');
	 				  /* var base = $("#table_add").datagrid('getEditor', {  
	 	                  index : index ,
	 	                  field : 'base'      
	 	              }).target.textbox('getValue'); */
	 				 /* if( acount == 0 || eval(acount) < eval(base) ){
	 		 		    alert('采购数量不应小于最小采购数量');
	 					return false;		 		
	 		 	 	 } */
	 			}
	 			 	 return true;
	 		}
	 		function onClickRow(index){
	 			if (editIndex != index){
	 				if (endEditing()){
	 					$('#table_add').datagrid('selectRow', index)
	 							.datagrid('beginEdit', index);
	 					//订单信息选中行
	 					editIndex = index;
	 				} else {
	 					$('#table_add').datagrid('selectRow', editIndex);
	 				}
	 			}
	 		}
	 		function append(){
	 			
	 			if (endEditing()){
	 				$('#table_add').datagrid('appendRow',{status:'P'});
	 				editIndex = $('#table_add').datagrid('getRows').length-1;
	 				$('#table_add').datagrid('selectRow', editIndex)
	 						.datagrid('beginEdit', editIndex);
	 			}
	 		}
	 		function removeit(){
	 			if (editIndex == undefined){return}
	 			$('#table_add').datagrid('cancelEdit', editIndex)
	 					.datagrid('deleteRow', editIndex);
	 			editIndex = undefined;
	 		}
	 		function accept(){
	 			if (endEditing()){
	 				$('#table_add').datagrid('acceptChanges');
	 			}
	 		}
	 		function reject(){
	 			$('#table_add').datagrid('rejectChanges');
	 			editIndex = undefined;
	 		}
	 		
	 		function isRealNum(val){
	 		    // isNaN()函数 把空串 空格 以及NUll 按照0来处理 所以先去除
	 		    if(val === "" || val ==null){
	 		        return false;
	 		    }
	 		    if(!isNaN(val)){
	 		        return true;
	 		    }else{
	 		        return false;
	 		    }
	 		} 
	 		
	 		/**
	 		 * 
	 		 * @returns  提交订单详情
	 		 */
	 	 	function submitData() {
	 	 		//alert($("#table_add").datagrid('getChanges').length);
	 	 		if($('#table_add').datagrid('getRows').length == 0 ){
	 	 				 alert("请添加订单详情信息");
	 	 				 return false;
	 	 		}
	 	 		if (endEditing()) { 
	 				$.messager.confirm('提示','提交将保存当前所有修改，确定执行？',
	 					function(r) {
	 						if (r) {
	 			                //利用easyui控件本身的getChange获取新添加，删除，和修改的内容  
	 			                    var inserted = $("#table_add").datagrid('getChanges', "inserted");  
	 			                    var deleted = $("#table_add").datagrid('getChanges', "deleted");  
	 			                    var updated = $("#table_add").datagrid('getChanges', "updated");
	 			                		var data = $('#order_form').serialize();
	 			                    var effectRow = new Object();  
	 			                    effectRow["formData"] = data;
	 			                    if (inserted.length) { 
	 			                        effectRow["inserted"] = JSON.stringify(inserted);  
	 			                    }  
	 			                    if (deleted.length) {  
	 			                        effectRow["deleted"] = JSON.stringify(deleted);  
	 			                    }  
	 			                    if (updated.length) {  
	 			                        effectRow["updated"] = JSON.stringify(updated);  
	 			                    } 
	 			                    $.post("${basePath}/orderAction!getChanges.action?"  + data  , effectRow, function(obj) {
	 			                				if(obj.success){
	 			    			    				 	alert(obj.msg);
	 			    			    				 	 $('#order_dlg').dialog('close');	
	 			    			    				 	$('#table_order').datagrid('reload');
	 			    			    				}else{
	 			    			    					alert(obj.msg);
	 			    			    				}
	 			                    }, "JSON");
	 			             }
	 				});
	 	 		}
	 		}
	 	 	
	 	 	 function changeAmount(){
	     		var row = $('#table_add').datagrid('getSelected');  
	         var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
	          var bra = $("#table_add").datagrid('getEditor', {  
	                 index : rowIndex,  
	                 field : 'amount'  
	             }); 
	          var price = $("#table_add").datagrid('getEditor', {  
	              index : rowIndex,  
	              field : 'price'  
	          });
	          
	          var acount = $("#table_add").datagrid('getEditor', {  
	              index : rowIndex,  
	              field : 'acount'  
	          });
	         $(bra.target).textbox('setValue', price.target.textbox('getValue') * acount.target.textbox('getValue'));
	     }
	 		
	 	 	/**关闭子页面重载*/
	     	function company_close(){
	     		var ops =$('#table_add').datagrid("options");
	     		if(ops.toolbar.length > 0 ){
	     			$.messager.confirm('提示','关闭之后当前所做的修改都不会执行，确认关闭？',
	 	   				function(r) {
	 	   					if (r) {
	 	   						//document.getElementById('order_form').reset();
	 	   						$('#order_dlg').dialog('close');	
	 	   						$('#table_order').datagrid('reload');
	 	   					}
	 	   				});
	     		}else{
	     			$('#order_dlg').dialog('close');
	     		}
	     		$('#table_add').datagrid('reload', {
	 				 id: 0
	 			});
	     	}
	     	
	     	
	     	/**
	     	 *  修改订单状态 
	     	 * @param status
	     	 * @returns
	     	 */
	         function order_status(status){
	 			var row = $('#table_order').datagrid('getSelected');
	 			if(status == '3' && row.status != '2'){
	 				  alert("订单状态有误，不能确认付款！");
	 				  return false ;
	 			}else if(status == '4' && row.status != '3'){
	 				 alert("订单状态有误，不能修改为收货状态");
	 				 return false ;
	 			}
	 			 var percent = "";
	 	    	if(row){
	 				if(status == '3'){
	 					$.messager.prompt('','请输入已完成的付款百分比(只输入数字即可)',function(s){
	 						if(Math.round(s) == s){
	 							if(!isRealNum(s)){
	 								return false ;
	 							}
	 							percent = "&percent="   + s;
	 				    			$.messager.confirm(
	 				    				'提示',
	 				    				'确定执行该操作?',
	 				    				function(r) {
	 				    					if (r) {
	 				    						$.ajax({ 
	 				    			    			url: '${basePath}/orderAction!updateStatus.action?status=' + status + percent,
	 				    			    			data : {"id":row.id},
	 				    			    			dataType : 'json',
	 				    			    			success : function(obj){
	 				    			    				if(obj.success){
	 				    			    				 	alert(obj.msg);
	 				    			    				 	$('#table_order').datagrid('reload');
	 				    			    				}else{
	 				    			    					alert(obj.msg);
	 				    			    					$('#table_order').datagrid('reload');
	 				    			    				}
	 				    			    			}
	 				    			    		});
	 				    					}
	 				    				});  		
	 						}
	 					});
	 				}else{
	 					if(status == '4'){
	 						 alert("如果没有收到全部货物请不要点击确认，确认后无法对订单做任何操作!!!");
	 					}
	 					$.messager.confirm(
	 		    				'提示',
	 		    				'确定执行该操作?',
	 		    				function(r) {
	 		    					if (r) {
	 		    						$.ajax({ 
	 		    			    			url: '${basePath}/orderAction!updateStatus.action?status=' + status ,
	 		    			    			data : {"id":row.id},
	 		    			    			dataType : 'json',
	 		    			    			success : function(obj){
	 		    			    				if(obj.success){
	 		    			    				 	alert(obj.msg);
	 		    			    				 	$('#table_order').datagrid('reload');
	 		    			    				}else{
	 		    			    					alert(obj.msg);
	 		    			    					$('#table_order').datagrid('reload');
	 		    			    				}
	 		    			    			}
	 		    			    		});
	 		    					}
	 		    				}); 
	 				}
	 	    	}
	 	    }
	         
	         
	      	function order_delete(){
	 			var row = $('#table_order').datagrid('getSelected');
	 			if(row.status != '1'  ){
	 				    alert("订单状态有误，不能删除！");
	 				    return false ;
	 			}
	     		if(row){
	     			$.messager.confirm(
	     				'提示',
	     				'确定要删除么?',
	     				function(r) {
	     					if (r) {
	     						$.ajax({ 
	     			    			url: '${basePath}/orderAction!deleteOrder.action',
	     			    			data : {"id":row.id},
	     			    			dataType : 'json',
	     			    			success : function(obj){
	     			    				if(obj.success){
	     			    				 	alert(obj.msg);
	     			    				 	$('#table_order').datagrid('reload');
	     			    				}else{
	     			    					alert(obj.msg);
	     			    					$('#table_order').datagrid('reload');
	     			    				}
	     			    			}
	     			    		});
	     					}
	     				});  		
	     			}
	 		}
	      	
	      	function order_add(){
	 			 $('#table_add').datagrid({
	 				 toolbar: toolbarAdd,
	 				 columns:columnEdit
	 			 })
	    		$("#order_dlg").dialog({
	 				onOpen: function () {
	 					 $("#startDate").textbox("setValue" , "");   
	                     $("#orderNo").val("");   
	 					 $("#id").val("");  
	                }
	 			});
	 			$('#order_dlg').dialog('open');	
	 			$('#order_dlg').dialog('setTitle','添加订单');
	 		}
	    	
	      	
	      	function order_edit(type){
	 			var row = $('#table_order').datagrid('getSelected');
	 			if(row.status != '1' && '${roleId}' != '1'  ){
	 			    alert("订单状态有误，不能修改！");
	 			    return false ;
	 			}
	     		if(row){
	     			$("#order_dlg").dialog({
	     				onOpen: function () {
	                         $("#startDate").textbox("setValue",row.startDate.split(" ")[0]);   
	                         $("#orderNo").val(row.orderNo);   
	                         $("#id").val(row.id); 
	                     }
	     			});
	     			$('#order_dlg').dialog('open');	
	     			$('#order_dlg').dialog('setTitle','编辑订单');
	 			$("#startDate").val(row.startDate);
	 			editIndex = undefined;
	 			if(type == 'admin'){
	 				$('#table_add').datagrid({
		 				toolbar: toolbarAdmin,
		 				columns:columnEdit
		 			 })
	 			}else{
		 			 $('#table_add').datagrid({
		 				 toolbar: toolbarAdd,
		 				 columns:columnEdit
		 			 })
	 			}
	 			$('#table_add').datagrid('reload', {
	 				 id: $("#id").val()
	 			});
	 			
	 				$("#company_save").click(function(){
	   					$.ajax({
	 						url : '${basePath}/companyAction!update.action',
	 						data : $('#order_form').serialize(),
	 						dataType : 'json',
	 						success : function(obj) {
	 							if (obj.success) {
	 								alert(obj.msg);
	 								company_close();
	 							} else {
	 								alert(obj.msg);
	 							}
	 						}
	 					});
	 				});
	 			}
	     	}
	     	
	      	
	      	function order_detail(){
	     		var row = $('#table_order').datagrid('getSelected');
	     		if(row){
	     			$("#order_dlg").dialog({
	     				onOpen: function () {
	                         $("#startDate").textbox("setValue",row.startDate.split(" ")[0]);   
	                         $("#orderNo").val(row.orderNo);   
	                         $("#id").val(row.id); 
	                     }
	     			});
	     			$('#order_dlg').dialog('open');	
	     			$('#order_dlg').dialog('setTitle','订单详情');
	 			$("#startDate").val(row.startDate);
	 			editIndex = undefined;
	 			 $('#table_add').datagrid({
	 				 toolbar:[],
	 				 columns:columnDetail
	 			 })
	 			$('#table_add').datagrid('reload', {
	 				 id: $("#id").val()
	 			});
	 			}
	     	}
	    
	      	
	     function query(){
	  	    	$('#table_order').datagrid('load', {
	  	    	    ostatue: $("#ostatue").val(),
	  	    	    ono : $("#ono").val()
	  	    	});
	   	}
	     
	    
    </script>
    
</body>
</html>
