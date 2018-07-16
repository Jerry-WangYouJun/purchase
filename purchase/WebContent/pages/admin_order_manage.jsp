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
  </head>
 <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:60px" >
 		<h3>admin订单管理</h3>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 20px">
 				<table id="table_order" class="easyui-datagrid" fit="true" ></table>
 	</div>
 	<div  id="order_dlg" closed="true" class="easyui-dialog" style="width:800px;height: 450px"
			data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
		    	<form id="order_form" role="form" style="padding: 20px">
				<input type="hidden"  id = "id"  name = "id">
		    		<div class="form-group col-md-6">
		            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">订单编号：</label>
		                <input name="orderNo" id="orderNo" class="form-control" style="display: inline-block;width: 40%" disabled="disabled">
		        </div>
		        <div class="form-group col-md-6">
		                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">下单时间：</label>
		                <input name="startDate" id = "startDate" class="easyui-datebox" style="display: inline-block;width: 40%"  disabled="disabled">
		        </div>
		        <div class="form-group col-md-8">
		                	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">请选择采购日：</label>
		                <select name="confirmId" id= "confirmId" class="easyui-combobox" style="display: inline-block;width: 20%"  disabled="disabled">
		                	 <c:forEach items="${confirm}" var="it">
		                	 	 <option value="${it.id}"> ${it.confirmDate}日</option>
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
  	     <a onclick="order_status('3')" class="easyui-linkbutton"  plain="true" iconCls="icon-ok" style="margin: 2px">确认付款</a>    
         <a onclick="invoice_status('1')" class="easyui-linkbutton"  plain="true" iconCls="icon-print" style="margin: 2px">发票已开</a>
    </div>
		   
    <script type="text/javascript">
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
    
    	$(function(){
    		var  orderUrl = '${pageContext.request.contextPath}/orderAction!loadAll.action' ;
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
			
			$(".datagrid-row-alt").css("backgroundColor" , "#a9f9f9")
		});
    	
    	var editIndex = undefined;
		   
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
	   						{field:'price',title:'单价',width:100,align:'center'},
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
    	
    	
	    function order_status(status){
			var row = $('#table_order').datagrid('getSelected');
			if(status == '3' && row.status != '1'){
				  alert("订单状态有误，不能确认付款！");
				  return false ;
			}else if(status == '4' && row.status != '3'){
				 alert("订单未付款，不能修改为收货状态");
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
				    			    			url: '${pageContext.request.contextPath}/orderAction!updateStatus.action?status=' + status + percent,
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
					$.messager.confirm(
		    				'提示',
		    				'确定执行该操作?',
		    				function(r) {
		    					if (r) {
		    						$.ajax({ 
		    			    			url: '${pageContext.request.contextPath}/orderAction!updateStatus.action?status=' + status ,
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
    	
    	function invoice_status(invoice){
    		var row = $('#table_order').datagrid('getSelected');
    		if(invoice == '1' && (row.status == '2' || row.status == '1')){
    			  alert("订单未付款，不能开具发票，请核对！");
    			  return false ;
    		}else if(invoice == '2' && row.invoice != '1'){
    			 alert("发票未开，不能执行该操作！");
    			 return false ;
    		}
        		if(row){
        			$.messager.confirm(
        				'提示',
        				'确定执行该操作?',
        				function(r) {
        					if (r) {
        						$.ajax({ 
        			    			url: '${pageContext.request.contextPath}/orderAction!updateInvoiceStatus.action?invoice=' + invoice,
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
    	
    	
    	function company_close(){
    		var ops =$('#table_add').datagrid("options");
    		if(ops.toolbar.length > 0 ){
    			$.messager.confirm('提示','关闭之后当前所做的修改都不会执行，确认关闭？',
	   				function(r) {
	   					if (r) {
	   						document.getElementById('order_form').reset();
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
    </script>
    
    <script type="text/javascript">
		
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
	 </script>
</body>
</html>
