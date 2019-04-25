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
    <title>常用采购物料预订单</title>
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
 	<div  id="pre_order_dlg" closed="true" class="easyui-dialog" style="width:1000px;height:90%"
			data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
		    	<form id="pre_order_form" role="form" style="padding: 5px;margin-bottom:0px">
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
	     <a onclick="pre_order_detail()" class="easyui-linkbutton"  plain="true" iconCls="icon-tip" style="margin: 2px">临时订单详情</a>
	    <c:if test="${roleId eq 3 }">
	  	    <a onclick="pre_order_add()" class="easyui-linkbutton"  plain="true" iconCls="icon-add" style="margin: 2px">添加到临时订单中</a>    
	        <a onclick="pre_order_edit()" class="easyui-linkbutton"  plain="true" iconCls="icon-edit" style="margin: 2px">修改临时订单</a>
	        <a onclick="pre_order_delete()" class="easyui-linkbutton"  plain="true" iconCls="icon-remove" style="margin: 2px">删除临时订单</a>
	        <a onclick="pre_order_delete()" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">提交正式订单</a>
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
    		$("#pre_order_form").validate();
    		 
    		var  orderUrl = '${pageContext.request.contextPath}/orderAction!getOrderDetailHistory.action';
			$('#table_order').datagrid({
				url: orderUrl,
				pagination: true,
				pagePosition:'top',
				pageSize: 30,
				fitColumns: true,
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
					{field:'ids',checkbox:true,},
					{field:'cname',title:'品牌',width:100,align:'center'},
					{field:'firstPro',title:'产品大类',width:100,align:'center'},
					{field:'secPro',title:'产品类型',width:100,align:'center'},
					{field:'thirdPro',title:'产品信息',width:'25%',align:'center'},
					{field:'price',title:'单价',width:100,align:'center',
						formatter: function(value,row,index){
							if(row.unit ){
								return row.price + "/" + row.unit ;
							}else{
								return row.price 
							}
							
						}},
					{field:'format',title:'规格',width:100,align:'center'},
					{field:'productDetailId', hidden:'true',editor:'textbox' },
					{field:'brand', hidden:'true',editor:'textbox' },
					{field:'formatNum', hidden:'true',editor:'textbox' }
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
				text:'删除条目',iconCls: 'icon-remove',
				handler: function(){removeit();}
			},'-',{
				text:'提交新订单',iconCls: 'icon-ok',
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
		 $(function(){
				$('#table_add').datagrid({
					url:'${pageContext.request.contextPath}/orderAction!searchDetail.action' ,
					pagination: true,
					fitColumns: true,
					singleSelect: true,
					striped:true,
					onClickRow: onClickRow,//选中行是，调用onClickRow js方法（397行）
					toolbar:toolbarAdd,
					columns:columnDetail
				});
			//$("#table_add").datagrid("hideColumn","amount");
		});
		 
		 function pre_order_edit(){
				var row = $('#table_order').datagrid('getSelected');
				if(row){
					$('#pre_order_dlg').dialog('open');	
					$('#pre_order_dlg').dialog('setTitle','编辑订单');
				$("#startDate").val(row.startDate);
				 $('#table_add').datagrid({
					 toolbar: toolbarAdd,
					 columns:columnDetail
				 })
				$('#table_add').datagrid('reload', {
					 id: $("#id").val()
				});
				}
			}

		 function pre_order_add(){
				var checkedItems = $('#table_order').datagrid('getChecked');
				if(checkedItems.length  == 0){
					return false;
				}
				console.info(checkedItems);
				var flag = confirm("确定将选定的物料明细添加到临时订单中（总价含运费）？");
				if(flag){
					var urgent = "";
					 layer.confirm('请选择订单类型', {
						  btn: ['普通','加急'] //按钮
						}, function(index){
						     	 layer.close(index)
						         insertPreOrder(checkedItems , urgent)
						},function(){
							  urgent = "1"
								  insertPreOrder(checkedItems , urgent)  
						});
							
				}
		 }
		 
		 function insertPreOrder(checkedItems , urgent){
			 $.ajax({ 
	    			url: '${pageContext.request.contextPath}/orderAction!insertPreOrder.action',
	    			type:'post',
	    			data : { "obj": JSON.stringify(checkedItems)  , urgent : urgent },
	    			dataType : 'json',
	    			success : function(obj){
	    				if(obj.success){
	    					layer.alert( obj.msg + "，请在快速下单中添加每种产品的数量");
	    				 	$('#user_table').datagrid('reload');
	    				}else{
	    					layer.alert(obj.msg);
	    					$('#user_table').datagrid('reload');
	    				}
	    			}
	    		});
		 }
    </script>
</body>
</html>
