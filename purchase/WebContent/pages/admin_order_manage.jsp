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
   <script src="${basePath}/js/edit.js"></script>
   <script language="javascript" src="${basePath}/js/jquery.jqprint-0.3.js"></script>
   <script src="<%=path%>/vendor/layer/layer.js"></script> 
   <link href="${basePath}/assets/css/style.css" rel="stylesheet" />
   <style type="text/css">
   
   	.form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
	    cursor: not-allowed;
	    background-color: #252525 !important;
	    opacity: 1;
	}
   </style>
   <script type="text/javascript">
  /*  var index = layer.load(1, {
		  shade: [1,'#fff'] //0.1透明度的白色背景
		}); */
   </script>
  </head>
 <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:60px" >
 		<h3>订单管理</h3>
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
	                	<option value="invoice">发票未开</option>
	                	<option value="confirmId">采购批次</option>
	                	<option value="startDate">下单日期 </option>
	                <option value="pillDate">付款日期 </option>
	                	<option value="endDate">收货日期 </option>
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
                <button onclick="query()"  class="btn btn-default queryBtn" >查询</button>
            </div> 
 				<table id="table_order" class="easyui-datagrid" fit="true" ></table>
 	</div>
 	<div  id="order_dlg" closed="true" class="easyui-dialog" style="width:1000px;height: 90%"
			data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
		    	<form id="order_form" role="form" style="padding: 20px">
				<input type="hidden"  id = "id"  name = "id">
				<div class="row">
						<div class="col-md-6">
					    		<div class="form-group col-md-12">
					            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">订单编号：</label>
					                <input  name="orderNo" id="orderNo" required class="form-control"  style="display: inline-block;width: 40%" disabled="disabled">
					        </div>
						        <div class="form-group col-md-12">
						                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">下单时间：</label>
						                <input name="startDate" id = "startDate" class="easyui-datebox" style="display: inline-block;width: 40%;background:black;">
						        </div>
						        <div class="form-group col-md-12">
						                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">选择采购日：</label>
						               <!-- login时获取list存入session中,加载数据是根据给select赋值confirmID -->
						                <select name="confirmId" id= "confirmId"   class="form-control" 
						                 editable="false" style="display: inline-block;width: 40%" disabled="disabled" >
							                	 <c:forEach items="${confirm}" var="it" >
							                	 	 <option value="${it.id}"> ${it.confirmDate}日</option>
							                	 </c:forEach>
						                </select>
						        </div>
						        <div class="form-group col-md-12">
						                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">配送地址：</label>
						               <!-- login时获取list存入session中,加载数据是根据给select赋值confirmID -->
						                <select name="addressId"  id= "addressId" class="form-control" 
						                 editable="false" style="display: inline-block;width: 40%"  disabled="disabled">
							                	 <c:forEach items="${addressList}" var="address" >
								                	 	 <option value="${address.id}"> ${address.address}</option>
							                	 </c:forEach>
						                </select>
						         </div> 
						</div>
		         </div>
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
  	     <a onclick="order_status('3')" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">确认付款</a>    
         <a onclick="invoice_status('1')" class="easyui-linkbutton"  plain="true"  style="margin: 2px">发票已开</a>
          <a onclick="exportOrder()" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">导出Excel</a>
         <a onclick="printSign()" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">带印章打印</a>
          <a onclick="print()" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">打印</a>
    </div>
		   
    <script type="text/javascript">
    function exportOrder(){
    		window.location.href='${pageContext.request.contextPath}/report!exportExcel.action' ;
    }
    	$(function(){
    		/* $.ajax({ 
    			url: '${pageContext.request.contextPath}/confirm!loadAll.action' ,
    			dataType : 'json',
    			success : function(obj){
    				 var data,json;
    				 data = [];
    				console.info(obj)
    				for (var i = 0; i < obj.length; i++) {
    				 	data.push({ "text": obj[i].confirmDate + "日" , "id": obj[i].id });
					}
    				 $("#confirmId").combobox("loadData", data);
    			}
    		});  */
    	})
	function print(){
			 order_detail();
	    		var row = $('#table_order').datagrid('getSelected');
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
    
    	$(function(){
    		
    		var  orderUrl = '${pageContext.request.contextPath}/orderAction!loadAll.action' ;
			$('#table_order').datagrid({
				url: orderUrl,
				pagination: true,
				pagePosition:'top',
				pageSize: 30,
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
					{field:'confirmId', hidden:'true',editor:'textbox' },
					{field:'companyName',title:'公司',width:100,align:'center'},
					{field:'orderNo',title:'订单编号',width:100,align:'center'},
					{field:'amount',title:'订单总价',width:100,align:'center'},
					{field:'conirmDate',title:'采购批次',width:100,align:'center',
						formatter: function(value,row,index){
							if(row.confirmDate){
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
					}
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
			$(".datagrid-row-alt").css("backgroundColor" , "#a9f9f9")
		});
    	
    	var editIndex = undefined;
		   
		   var toolbarAdmin = [];
		   
		   var columnDetail = [[
	   						{field:'product',title:'产品大类',width:100,align:'center'},
	   						{field:'type',title:'产品类型',width:100,align:'center'},
	   						{field:'sub_product',title:'产品规格',align:'center'},
	   						
	   						{field:'brand',title:'品牌',width:100,align:'center'},
	   						/* {field:'boxnum',title:'包装件数',width:100, hidden:'true',align:'center'}, */
	   						{field:'price',title:'价格',width:100,align:'center'},
	   						{field:'acount',title:'数量',width:100,align:'center'},
	   						{field:'format',title:'单位',width:100,align:'center'},
	   						{field:'amount',title:'条目总价',width:100,align:'center'},
	   						/* {field:'sprice',title:'供应商报价',width:100,align:'center',editor:'textbox'}, */
	   						{field:'detailId', hidden:'true',editor:'textbox' },
	   						{field:'productId', hidden:'true',editor:'textbox' },
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
   					toolbar: toolbarAdmin,
   					columns:columnDetail
   				});
			//$("#table_add").datagrid("hideColumn","amount");
		});
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
