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
    <title>订单管理</title>
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
   <link href="${basePath}/assets/css/style.css" rel="stylesheet" />

   <script src="${basePath}/js/edit.js"></script>
   <script language="javascript" src="${basePath}/js/jquery.jqprint-0.3.js"></script>
   
      <style type="text/css" media="screen">
      .form-group {
		    margin-bottom: 5px;
		}
		
	 img{max-height:150px;}
    </style>
  </head>
 <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:60px" >
 		<h3> 快速下单</h3>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 30px">
 			<div >
            
            	查询条件
                <select name="queryCol" id="queryCol" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;" editable="false">
                    <option value="">-选择-</option>
	                	<option value="orderNo">订单编号</option>
	                 <option value="amount">订单金额</option>
	                	<!-- <option value="2">已报价</option> -->
	                	<option value="state">订单状态</option>
	                	<option value="companyName">采购公司</option>
	                	<option value="startDate">下单日期 </option>
	                <option value="pillDate">付款日期</option>
	                	<option value="endDate">收货日期</option>
                </select>
                查询内容
                <input name="queryValue" id = "queryValue"class=" form-control" style="display: inline-block;width: 10%">
                	订单状态：
                <select name="ostatue" id="ostatue" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;" editable="false">
                    <option value="">-选择-</option>
	                	<option value="1">新订单</option>
	                	<option value="3">已付款</option>
	                	<option value="5">提交采购</option>
	                	<option value="4">已收货</option>
                </select>
                	发票状态：
                <select name="oinvoice" id="oinvoice" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;" editable="false">
                    <option value="">-选择-</option>
	                	<option value="1">发票已开</option>
	                	 <option value="2">发票已收到</option> 
                </select>
               
                <button onclick="query()">查询</button>
            </div> 
 				<table id="table_order" class="easyui-datagrid" fit="true" ></table>
 	</div>
 	<div  id="order_dlg" closed="true" class="easyui-dialog" style="width:1000px;height:90%"
			data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
		    	<form id="order_form" role="form" style="padding: 5px;margin-bottom:0px">
				<input type="hidden"  id = "id"  name = "id">
				<div class="row">
						<div class="col-md-6">
					    		<div class="form-group col-md-12">
					            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">订单编号：</label>
					                <input  name="orderNo" id="orderNo" required class="form-control"  style="display: inline-block;width: 40%">
					        </div>
						        <div class="form-group col-md-12">
						                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">下单时间：</label>
						                <input name="startDate" id = "startDate" class="easyui-datebox" style="display: inline-block;width: 40%;background:black;">
						        </div>
						        <div class="form-group col-md-12">
						                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">选择采购日：</label>
						               <!-- login时获取list存入session中,加载数据是根据给select赋值confirmID -->
						                <select name="confirmId" id= "confirmId"   class="form-control" 
						                 editable="false" style="display: inline-block;width: 40%"  >
							                	 <c:forEach items="${confirm}" var="it" >
							                	 	 <option value="${it.id}"> ${it.confirmDate}日</option>
							                	 </c:forEach>
						                </select>
						        </div>
						        <div class="form-group col-md-12">
						                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">配送地址：</label>
						               <!-- login时获取list存入session中,加载数据是根据给select赋值confirmID -->
						                <select name="addressId"  id= "addressId" class="form-control" 
						                 editable="false" style="display: inline-block;width: 40%" >
							                	 <c:forEach items="${addressList}" var="address" >
							                	 	<c:if test="${companyId eq address.cid }">
								                	 	 <option value="${address.id}"> ${address.address}</option>
							                	 	</c:if>
							                	 </c:forEach>
						                </select>
						         </div> 
						</div>
						<div class="col-md-6">
					    		<div class="form-group col-md-12 imgdiv">
					            	  <img alt="" src="##"  class="img-responsive img-thumbnail" >
					        </div>
						</div>
				</div>
		       <%-- <div class="form-group col-md-6">
		                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">是否含税：</label>
		                <select name="taxrate" id= "taxrate" class="easyui-combobox" 
		                 editable="false" style="display: inline-block;width: 40%" 
		                 class="form-control select2 easyui-combobox" onchange="test()">
			                	 	 <option value="1"> 含税</option>
			                	 	 <option value="0"> 不含税</option>
		                </select>
		        </div> --%>
		    	</form>  
		    	<div>
				<table  id="table_print"  class="table" style="display: none">
			    		 <tr>
			    		 	 <td id="companyNamePrt">公司：<span></span></td>
			    		 	 <td id="orderNoPrt">订单编号：<span></span></td>
			    		 </tr>
			    		 <tr>
			    		 	 <td id="amountPrt">订单总价：<span></span></td>
			    		 	 <td id="confirmIdPrt">采购批次：<span></span></td>
			    		 </tr>
			    		 <tr>
			    		 	 <td id="statusPrt">订单状态：<span></span></td>
			    		 	 <td id="invoicePrt">发票状态：<span></span></td>
			    		 </tr>
			    		 <tr>
			    		 	 <td id="startDatePrt">下单时间：<span></span></td>
			    		 	 <td id="pillDatePrt">付款时间：<span></span></td>
			    		 </tr>
			    		 <tr>
			    		 	 <td id="addressPrt" colspan="2">发货地址：<span></span></td>
			    		 </tr>
			    	</table>
		    	</div> 
			    	<table id="table_add" class="easyui-datagrid" fit="true" ></table>              
		</div>
	<div id="company_dlg_buttons" style="width:600px;height: 40px;text-align: center">
			<button onclick="company_close()" type="button" class="btn btn-default btn-dialog-right">关闭</button>
			<!-- <button onclick="print()" type="button" class="btn btn-default btn-dialog-right">打印</button>  -->
	</div>
	<div id="toolbar_company" style="padding:2px 5px;">
	     <a onclick="order_detail()" class="easyui-linkbutton"  plain="true" iconCls="icon-tip" style="margin: 2px">详情</a>
	    <c:if test="${roleId eq 3 }">
	  	    <a onclick="order_add()" class="easyui-linkbutton"  plain="true" iconCls="icon-add" style="margin: 2px">添加订单</a>    
	        <a onclick="order_edit()" class="easyui-linkbutton"  plain="true" iconCls="icon-edit" style="margin: 2px">修改订单</a>
	        <a onclick="order_delete()" class="easyui-linkbutton"  plain="true" iconCls="icon-remove" style="margin: 2px">删除订单</a>
	        <a onclick="order_status('4')" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">确认收货</a>
	        <a onclick="invoice_status('2')" class="easyui-linkbutton"  plain="true"  style="margin: 2px">发票已收</a>
	        <a onclick="printSign()" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">带印章打印</a>
	         <a onclick="print()" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">打印</a>
	    </c:if>
    </div>
		   
    <script type="text/javascript">
    	
    
    function update_confirm(){
    			$.messager.confirm(
				'提示',
				'确定执行该操作?',
				function(r) {
					if (r) {
						$.ajax({ 
			    			url: getProjectUrl() + 'orderAction!updateInvoiceStatus.action?invoice=' + invoice,
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
    
    	$(function(){
    		$("#order_form").validate();
    		 
    		var  orderUrl = '${pageContext.request.contextPath}/orderAction!loadAll.action';
			$('#table_order').datagrid({
				url: orderUrl,
				pagination: true,
				pagePosition:'top',
				pageSize: 30,
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
					{field:'id', checkbox:'true',editor:'textbox' },
					{field:'companyId', hidden:'true',editor:'textbox' },
					{field:'confirmId', hidden:'true',editor:'textbox' },
					//{field:'companyName',title:'公司',width:100,align:'center'},
					{field:'orderNo',title:'订单编号',width:100,align:'center'},
					{field:'amount',title:'订单总金额',width:100,align:'center'},
					{field:'conirmDate',title:'采购批次',width:120,align:'center',
						formatter: function(value,row,index){
							if(row.confirmDate ){
								return row.confirmDate
							}else{
								<c:forEach items="${confirm}" var="item"  >  
									if(row.confirmId == '${item.id}'){
								        return "${item.confirmDate}" + "日";  //获得值,加引号
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
					},
					{field:'addressId', hidden:'true'}
				]],
				
			});
			$("#loadingDiv").remove();
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
			$("#_easyui_textbox_input5").css("background","rgb(85, 85, 85)");
			$("#_easyui_textbox_input5").attr("readonly", "readonly"); 
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
    	 var json = [];

    	 var row1 = {value:'1',text:'托管'}

    	 var row2 = {value:'2',text:'不托管'}

    	 json.push(row1);

    	 json.push(row2);  
    	 
		   var columnDetail = [[
	   						{field:'defaultFlag',title:'托管采购',width:100 ,align:'center', formatter: function(value,row,index){
									if(value == '1'){
										return "托管";
									}else{
										return "不托管";
									}
								}
			                },
	   						{field:'product',title:'产品大类',width:100,align:'center'},
	   						{field:'type',title:'产品类型',width:100,align:'center'},
	   						{field:'sub_product',title:'产品信息',width:'25%',align:'center'},
	   						/* {field:'format',title:'产品规格',width:100,align:'center'},
	   						{field:'materail',title:'材质/标准',width:100,align:'center'}, */
	   						{field:'brand',title:'品牌',width:100,align:'center'},
	   						{field:'price',title:'价格',width:100,align:'center'},
	   						{field:'format',title:'单位',width:100,align:'center'},
	   						{field:'acount',title:'数量',width:100,align:'center'},
	   						/* {field:'boxnum',title:'包装件数',width:100, hidden:'true',align:'center'}, */
	   						{field:'amount',title:'总价',width:100,align:'center'},
	   						/* {field:'sprice',title:'供应商报价',width:100,align:'center',editor:'textbox'}, */
	   						{field:'detailId', hidden:'true',editor:'textbox' },
	   						{field:'productId', hidden:'true',editor:'textbox' },
	   						{field:'address',hidden:'true'},
	   						{field:'base', hidden:'true',editor:'textbox' },
	   						{field:'remark',title:'备注',width:100,align:'center'},
	   						{field:'id', hidden:'true',editor:'textbox' }
	   					]];
		   var columnEdit = [[
							{field:'defaultFlag',title:'托管采购',align:'center',width:100, editor: {
							    type: 'combobox',
							    options: {
							        data: json ,
							        valueField: "value",
							        textField: "text",
							        editable: false,
							        onSelect:function(data){ 
							            var row = $('#table_add').datagrid('getSelected');  
							            var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
							            var pri = $("#table_add").datagrid('getEditor', {  
							                index : rowIndex,  
							                field : 'price'  
							            });  
							            var supplierCompanyId = $("#table_add").datagrid('getEditor', {  
							                index : rowIndex,  
							                field : 'supplierCompanyId'  
							            });  
							        	var bra = $("#table_add").datagrid('getEditor', {  
							                index : rowIndex,  
							                field : 'brand'  
							            });  
							        	var brandData = $(bra.target).combobox('getData');
							            if(data.value == '1' && brandData.length > 0){
							                $(bra.target).textbox('setValue',  brandData[0].brand); 
							                $(bra.target).combobox("disable" );
							          	    $(pri.target).textbox('setValue',  brandData[0].price); 
							          		$(supplierCompanyId.target).textbox('setValue',  brandData[0].supplierCompanyId); 
							            }else{
							            	$(bra.target).combobox("enable" );
							            }
							            if(data.value == '1' ){
							           	 	$(bra.target).combobox("disable" );
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
								{field:'product',title:'产品大类',width:100,align:'center',
									editor : {    
				                        type : 'combobox',    
				                        options : {    
				                            url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
				                            valueField:'product' ,   
				                            textField:'product',  
				                            onSelect:function(data){ 
				                            	//console.info(data);
				                            	//选择的行
				                                var row = $('#table_add').datagrid('getSelected'); 
				                            	if(row == null){
				                            		return false;
				                            	}
				                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
				                                var product = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'product'});
				                                var initialValue =  $(product.target).textbox('getValue');//产品大类原来的值
				                                //条目总价不可编辑
				                                 var amount = $("#table_add").datagrid('getEditor', {  
				                                        index : rowIndex,  
				                                        field : 'amount'  //根据字段名获取编辑的字段
				                                    }); 
				                                $(amount.target).combobox('disable');//不可用
				                                
				                               /*  var boxnum = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'boxnum'  //根据字段名获取编辑的字段
			                                    });  
			                                	$(boxnum.target).textbox('readonly');   //赋值 */
				                                
				                                //定义要编辑的列
				                                var target = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'type'}).target;  
				                                var val = target.combobox("getValue");
												if(initialValue != data.product){
				                                		target.combobox('clear'); //清除原来的数据  
				                                		//$(target).textbox('setValue',  val);
				                                }
				                                var url = '${pageContext.request.contextPath}/orderAction!getProductTypeByParentId.action?parentId='+data.id;  
				                                target.combobox('reload', url);//联动下拉列表重载   */
				                                var subtarget = $('#table_add').datagrid('getEditor', {'index':rowIndex,'field':'sub_product'}).target;  
												if(initialValue != data.product){
					                                subtarget.combobox('clear');
				                                		//$(target).textbox('setValue',  val);
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
			                                var ed = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'unit'  //根据字段名获取编辑的字段
		                                    });  
			                                $(ed.target).textbox('setValue',  data.format);   //赋值
			                                $(ed.target).combobox('disable');//不可用
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
								{field:'sub_product',title:'产品信息',align:'center' ,width:'20%',
									editor : {    
				                        type : 'combobox',    
				                        options : {    
				                           // url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
				                            valueField:'subProduct' ,   
				                            textField:'subProduct',  
				                            onSelect:function(data){  
				                                var row = $('#table_add').datagrid('getSelected');  
				                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号 
				                                /*  var ed = $("#table_add").datagrid('getEditor', {  
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
				                                $(fmt.target).combobox('disable'); */
				                                var ed = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'unit'  //根据字段名获取编辑的字段
			                                    });  
				                                $(ed.target).textbox('setValue',  data.format);   //赋值
				                                $(ed.target).combobox('disable');//不可用
				                                
				                                var idvalue = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'detailId'  
			                                    });  
			                               	    $(idvalue.target).textbox('setValue',  data.id );  
			                               		 var formatNum = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'formatNum'  
			                                    });  
			                               	    $(formatNum.target).textbox('setValue',  data.formatNum );  
			                               	    
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
				                /*  {field:'format',title:'产品规格',width:100,align:'center',editor:'textbox'},
								{field:'materail',title:'材质/标准',width:100,align:'center',editor:'textbox'}, */
								{field:'brand',title:'品牌',width:100,align:'center',editor:{    
			                        type : 'combobox',    
			                        options : {    
			                           // url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
			                            valueField:'brand' ,   
			                            textField:'brand',  
			                            onSelect:function(data){  
			                                var row = $('#table_add').datagrid('getSelected');  
			                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
			                                 var ed = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'price'  
			                                    });  
			                                $(ed.target).textbox('setValue',  data.price ); 
			                                $(ed.target).combobox('disable');
			                               /*  var taxrate = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'taxrate'  
		                                    });  
		                                $(taxrate.target).textbox('setValue',  data.taxrate); 
		                                $(taxrate.target).combobox('disable'); */
			                                var idvalue = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'supplierCompanyId'  
		                                    });  
		                               	 $(idvalue.target).textbox('setValue',  data.supplierCompanyId );  
		                               	 if(data.imgUrl){
			                               	$("img").attr("src","/ring/upload/"+data.imgUrl)
		                               	 }else{
		                               		$("img").attr("src","") 
		                               	 }
			                            } ,onLoadSuccess:function(){ //数据加载完成执行该代码
			                                var data= $(this).combobox("getData");
			                                var row = $('#table_add').datagrid('getSelected');  
			                                var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
			                                 var bra = $("#table_add").datagrid('getEditor', {  
			                                        index : rowIndex,  
			                                        field : 'brand'  
			                                    });  
			                                $(bra.target).textbox('setValue',  data[0].brand); 
			                                
			                                
			                                var formatNum = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'formatNum'  
		                                    });  
		                                		var num  = $(formatNum.target).textbox('getValue'); 
		                                		
			                                var pri = $("#table_add").datagrid('getEditor', {  
		                                        index : rowIndex,  
		                                        field : 'price'  
		                                    });  
			                               
			                                  	$(pri.target).textbox('setValue',  data[0].price ); 
			                               
			                                
		                              		 $(pri.target).combobox('disable');
		                              		 
			                			} 
			                        }   
			                    }},
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
			                            		// changeBoxnum();
			                            }
										
									}
								}},
								//{field:'boxnum',title:'包装件数',width:100,align:'center',hidden:'true',editor:'textbox'},
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
								{field:'unit',title:'单位',width:100,align:'center',editor:'textbox'},
								{field:'base', title:'最低采购量',width:100,align:'center',editor:'textbox' },
								{field:'detailId', hidden:'true',editor:'textbox' },
								{field:'formatNum', hidden:'true',editor:'textbox' },
								{field:'supplierCompanyId', hidden:'true',editor:'textbox' },
								{field:'productId', hidden:'true',editor:'textbox' },
							//	{field:'taxrate',title:'不含税(%)',width:100,align:'center',editor:'textbox'},
								{field:'amount',title:'总价',width:100,align:'center',editor:'textbox'},
								
								{field:'remark',title:'备注',width:100,align:'center',editor:'textbox'},
								{field:'id', hidden:'true',editor:'textbox' }
							]];
		 $(function(){
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
			//$("#table_add").datagrid("hideColumn","amount");
		});
		 
		 function print(){
			 order_detail();
	    		var row = $('#table_order').datagrid('getSelected');
	    		if(row){
		    		setTimeout( function(){
			    		$("#order_form").hide();
			    		$("#table_print").show();
			    		$("#companyNamePrt>span").append(row.companyName);
			    		$("#orderNoPrt>span").append(row.orderNo);
			    		$("#amountPrt>span").append(row.amount);
			    		$("#confirmIdPrt>span").append($("#confirmId").find("option:selected").text());
			    		$("#statusPrt>span").append(getDicValue('status',row.status ,row));
			    		$("#invoicePrt>span").append(getDicValue('invoice',row.invoice ,row));
			    		$("#startDatePrt>span").append(row.startDate);
			    		$("#pillDatePrt>span").append(row.pillDate);
			    		var rows = $('#table_add').datagrid('getData');
			    		$("#addressPrt>span").append($("#addressId").find("option:selected").text()); 
					 $("#order_dlg").jqprint({
						 debug: false,
						 importCSS: true,
						 printContainer: true,
						 operaSupport: false
					 });
			    		$("#order_form").show();
			    		$("#table_print").hide();
			    		$("#table_print  span").text('');
				 	 company_close();
					 },1000)
	    		}
		 }
		 
		 function printSign(){
	    		var row = $('#table_order').datagrid('getSelected');
	    		if(row){
		    		var str= "?falg=1";
		    		for(col in row){
		    			 str  += ("&" + col + "=" + row[col])
		    			 if(col == 'addressId'){
		    				 <c:forEach items="${addressList}" var="address" >
		                	 	 if("${address.cid}"  ==  row.companyId && "${address.id}" == row.addressId)
							    		str += ("&address=${address.address}")
		                	 </c:forEach>
		    			 }
		    			 if(col == 'confirmId' && row.confirmDate == undefined ){
		    				 <c:forEach items="${confirm}" var="it">
		    				 if( "${it.id}" == row.confirmId)
						    		str += ("&confirmDate=${it.confirmDate}日")
	                	 	</c:forEach>
		    			 }
		    		}
		    		window.open("${pageContext.request.contextPath}/orderAction!loadByOrderId.action" + str);
	    		}
		 }

    </script>
</body>
</html>
