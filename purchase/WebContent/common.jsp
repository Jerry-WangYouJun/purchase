<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="basePath" value="${pageContext.request.contextPath}" scope="request"></c:set>
<script type="text/javascript" src="${basePath}/js/jquery-3.1.1.min.js"></script>
<script src="${basePath}/js/jquery.validate.min.js"></script>
<script src="${basePath}/js/jquery.metadata.js"></script>
<script src="${basePath}/js/messages_zh.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link href="${basePath}/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css">
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script> 
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-table.min.css" />  
<link href="${basePath}/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
<link href="${basePath}/vendor/dist/css/sb-admin-2.css" rel="stylesheet">
<link href="${basePath}/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-table-zh-CN.js"></script>
<script type="text/JavaScript" src="${basePath}/js/jquery.form.js"></script>

<link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />  
<script src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>  
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script> 
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script> 

<script src="${basePath}/vendor/metisMenu/metisMenu.min.js"></script>
<script src="${basePath}/vendor/dist/js/sb-admin-2.js"></script>

<script src="${basePath}/vendor/easyui/jquery.easyui.min.js"></script>
<script src="${basePath}/vendor/easyui/locale/easyui-lang-zh_CN.js"></script>
<link href="${basePath}/vendor/easyui/themes/material/easyui.css" rel="stylesheet" type="text/css">
<link href="${basePath}/vendor/easyui/themes/icon.css" rel="stylesheet" type="text/css">
<link href="${basePath}/css/dialog_head.css" rel="stylesheet" type="text/css">

<style>
.error{
	 color:red;
}
</style>


<script type="text/javascript">

	function submitData() {
		if($("#addressId").combobox("getValue") ==''){
			 alert("送货地址为必填项，不能为空。如您没有添加送货地址，请到‘客户管理’模块中添加收货地址");
			$("#addressId").focus();
			return false ;
		}
		if($("#confirmId").combobox("getValue") ==''){
			 alert("采购日为必填项，不能为空");
			$("#confirmId").focus();
			return false ;
		}
		//alert($("#table_add").datagrid('getChanges').length);
		if($('#table_add').datagrid('getRows').length == 0 ){
				 alert("请添加订单详情信息");
				 return false;
		}
		if (endEditing()) { 
		$.messager.confirm('提示','提交将保存当前所有修改，确定执行？',
			function(r) {
				if (r) {
					var rows=$('#table_add').datagrid('getRows');
					var sum =parseFloat(0) ;
					for(var index in rows){
						sum+=  parseFloat(rows[index].amount);
					}
					if(sum < "${base}"){
						alert("订单总额必须超过RMB:${base}(元)才能下单！当前总额:" + sum + "元");
						return false;
					}
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
	    			    				 	alert(obj.msg + ";订单总金额包含运费${trans}元");
	    			    				 	
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
	
	
  	/**
	 * 修改发票状态
	 * @param invoice
	 * @returns
	 */
	function invoice_status(invoice){
		var rows = $('#table_order').datagrid('getChecked');
			var goonflag =  true ;
			$.messager.confirm(
					'提示',
					'确定执行该操作?',
					function(r) {
						if (r) {
							for(index in rows){
								row = rows[index];
								if(invoice ==  row.invoice){//当前状态与要修改的状态相同，不操作
									continue;
								}else if(invoice == '1' && (row.status == '2' || row.status == '1')){
									  alert("订单" + row.orderNo + "未付款，不能开具发票，请核对！");
									  continue ;
								}else if(invoice == '2' && row.invoice != '1'){
									 alert("订单" + row.orderNo + "发票未开，不能执行该操作！");
									 continue ;
								}else if(invoice == '1' && row.invoice == '2'){
									// alert("订单" + row.orderNo + "发票已收，不能执行该操作！");
									 continue ;
								} 
								
						    		if(row){
										$.ajax({ 
								    			url: '${basePath}/orderAction!updateInvoiceStatus.action?invoice=' + invoice,
								    			data : {"id":row.id},
								    			dataType : 'json',
								    			success : function(obj){
					   			    				if(obj.success){
					   			    				 	//alert(obj.msg);
					   			    				}else{
					   			    					alert("订单" + row.orderNo + "操作失败：" + obj.msg);
					   			    				}
					   			    			}
					   			    		});
						    		}
							 }
					   		$('#table_order').datagrid('reload');
						}
			});
			
    	}
	
	/**
	 *  修改订单状态 
	 * @param status
	 * @returns
	 */
    function order_status(status){
		var row = $('#table_order').datagrid('getSelected');
		if(status == '3' && row.status != '1'){
			  alert("订单状态有误，不能确认付款！");
			  return false ;
		}else if(status == '4' && row.status != '5'){
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
						if(Math.round(s) > 100 || Math.round(s) <=0){
								alert("只能填写1-100内的数字");
								return false;
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
				 $('#confirmId').combobox('setValue', "${warnFlag.id}");
           }
		});
		$("img").attr("src","") 
		$('#order_dlg').dialog('open');	
		$('#order_dlg').dialog('setTitle','添加订单');
	}
	
 	
 	function order_edit(){
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
                    //$('#confirmId').combobox('setValue', row.confirmId);
                    $('#confirmId').combobox('select', row.confirmId);
                }
			});
			$('#order_dlg').dialog('open');	
			$('#order_dlg').dialog('setTitle','编辑订单');
		$("#startDate").val(row.startDate);
		editIndex = undefined;
		 $('#table_add').datagrid({
			 toolbar: toolbarAdd,
			 columns:columnEdit
		 })
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
 	
 	function getDicValue(name , value , row){
 		 if( name == 'status'){
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
 		 }else if(name == 'invoice'){
 			if (value == '1') {
				return "发票已开";
			}  else if(value == "2"){
				return "发票已收";
			}else {
				return "发票未开";
			}

 		 }
 	}
	
 	
</script>