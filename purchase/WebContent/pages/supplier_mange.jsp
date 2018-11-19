<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>供应商订单管理</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<jsp:include page="/common.jsp"></jsp:include>
   <script language="javascript" src="${basePath}/js/jquery.jqprint-0.3.js"></script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false,showHeader:false"
		style="height: 60px">
		<h3>供应商订单管理</h3>
	</div>
	<div data-options="region:'center',border:false,showHeader:false"
		style="padding-bottom: 30px">
		<%	
			if (Integer.valueOf(session.getAttribute("roleId").toString()) == 1) {
		%>
		<div style="text-align: left">
			<button class="btn btn-default" iconCls="icon-search"
				onclick="getSupOrder()">重新生成供应商订单</button>
		</div>
		<%	
			}
		%>
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
	                	<option value="4">已收货</option>
	                	<option value="5">提交采购</option>
                </select>
                <button onclick="query()">查询</button>
            </div>
		<table id="table_order" class="easyui-datagrid" fit="false"></table>
	</div>
	<div  id="order_dlg" closed="true" class="easyui-dialog" style="width:800px;height: 650px"
			data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
		    <form id="order_form" role="form" style="padding: 20px">
			<input type="hidden" id="id" name="id">
			<!-- <div class="form-group col-md-6">
				<label class="col-md-4"
					style="display: inline-block; height: 34px; line-height: 34px; text-align: left; width: 30%">订单编号：</label>
				<input name="orderNo" id="orderNo" class="form-control"
					style="display: inline-block; width: 30%">
			</div>
			<div class="form-group col-md-6">
				<label class="col-md-4"
					style="display: inline-block; height: 34px; line-height: 34px; text-align: left; width: 30%">下单时间：</label>
				<input name="startDate" id="startDate" class="easyui-datebox"
					style="display: inline-block; width: 30%">
			</div> -->
		</form>
		<div>
				<table  id="table_print"  class="table" style="display: none">
			    		 <tr>
			    		 	 <td id="orderNoPrt" colspan="2">订单编号：<span></span></td>
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
		<table id="table_add" class="easyui-datagrid" fit="true">  </table>           
		</div>
	<div id="company_dlg_buttons"
		style="width: 600px; height: 40px; text-align: center">
		<button onclick="company_close()" type="button"
			class="btn btn-default btn-dialog-right">关闭</button>
			<button onclick="print()" type="button" class="btn btn-default btn-dialog-right">打印</button>
	</div>
	<script type="text/javascript">
	function print(){
		var row = $('#table_order').datagrid('getSelected');
		console.info(row);
		$("#order_form").hide();
		$("#table_print").show();
		$("#companyNamePrt>span").append(row.companyName);
		$("#orderNoPrt>span").append(row.supplierOrderNo);
		$("#amountPrt>span").append(row.amount);
		$("#confirmIdPrt>span").append($("#confirmId").find("option:selected").text());
		$("#statusPrt>span").append(getDicValue('status',row.status ,row));
		$("#invoicePrt>span").append(getDicValue('invoice',row.invoice ,row));
		$("#startDatePrt>span").append(row.startDate);
		$("#pillDatePrt>span").append(row.pillDate);
		 $("#order_dlg").jqprint({
			 debug: false,
			 importCSS: true,
			 printContainer: true,
			 operaSupport: false
		 });
			$("#order_form").show();
			$("#table_print").hide();
			$("#table_print  span").text('');
		// company_close();
	 }
	
		$(function() {
			var  searchUrl = '${pageContext.request.contextPath}/supplier!loadAll.action' ;
			var  toolbar = [ {
				text : '订单详情',
				iconCls : 'icon-tip',
				handler : function() {
					order_edit();
				}
			}, '-', {
				text : '确认收货',
				iconCls : 'icon-ok',
				handler : function() {
					order_status('4');
				}
			} ,'-',{
				text:'发票已收',
				iconCls: 'icon-print',
				handler: function(){invoice_status('2');}
			}];
			if("${roleId}" == '2'){
				searchUrl = '${pageContext.request.contextPath}/supplier!loadByCompanyId.action' ;
				toolbar=[ {
					text : '订单详情',
					iconCls : 'icon-tip',
					handler : function() {
						order_edit();
					}
				}, '-', {
					text : '确认收款',
					iconCls : 'icon-ok',
					handler : function() {
						order_status('3');
					}
				},'-',{
					text:'发票已开',
					iconCls: 'icon-print',
					handler: function(){invoice_status('1');}
				} ];
			}
			$('#table_order').datagrid({
								url : searchUrl,
								pagination : true,
								pagePosition:'top',
								pageSize: 30,
								fitColumns : true,
								striped:true,
								singleSelect : true,
								toolbar :toolbar ,
								rowStyler: function(index,row){
									if (row.status  == '4'){
										return 'background-color:#6293BB;color:#fff;'; // return inline style
										// the function can return predefined css class and inline style
										// return {class:'r1', style:{'color:#fff'}};	
									}
								},
								columns : [ [
								{field : 'id',hidden : 'true',editor : 'textbox'}, 
								{field : 'supplierOrderNo',title : '供应商订单',width : 100,align : 'center'}, 
								{field : 'transportDate',title : '发货时间',width : 120,align : 'center',
									formatter : function(value, row, index) {
										if (value) {
											return value.substring(0, 16);
										} else {
											return "";
										}

									}
								}, 
								{field : 'status',title : '订单状态',width : 100,align : 'center',
									formatter : function(value, row, index) {
										if (value == '1') {
											return "新订单";
										} else if (value == '2') {
											return "已审核";
										} else if(value =='3' ){
											 return "已付款";
										} else if(value == "4"){
											return "已收货";
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
								{field : 'remark',title : '备注',width : 100,align : 'center'}
								] ],

							});

			$('#dlg-frame').dialog({
				title : '新增订单',
				width : 909,
				height : 600,
				top : 50,
				left : 100,
				closed : true,
				cache : false,
				modal : true,
				buttons : [ {
					text : '确定',
					iconCls : 'icon-ok',
					handler : function() {
						if (confirm("确定执行下一步操作？")) {
							frameContent.window.doServlet();
						}
					}
				}, {
					text : '关闭',
					iconCls : 'icon-cancel',
					handler : function() {
						$('#dlg-frame').dialog("close");
					}
				} ]
			});

			$('#startDate').datebox(
					{
						formatter : function(date) {
							return date.getFullYear() + '-'
									+ (date.getMonth() + 1) + '-'
									+ date.getDate();
						}

					});
		});
		function getSupOrder() {
			$.messager.confirm(
				'提示',
				'确定要重新生成供应商订单么?',
				function(r) {
					if (r) {
						$.ajax({
							url : '${pageContext.request.contextPath}/supplier!getSupllierOrder.action',
							dataType : 'json',
							success : function(obj) {
								if (obj.success) {
									alert(obj.msg);
									$('#table_order').datagrid('reload');
								} else {
									alert(obj.msg);
									$('#table_order').datagrid('reload');
								}
							}
						});
					}
				});
		}
		var editIndex = undefined;
		$(function() {
			if("${roleId}" == '1'){
				$('#table_add').datagrid({
							url : '${pageContext.request.contextPath}/supplier!searchDetail.action',
							pagination : true,
							fitColumns : true,
							singleSelect : true,
							striped:true,
							onClickRow : onClickRow,
							onLoadSuccess:function(data){
								 var ed = $('#table_add').datagrid('getEditor', {index:0,field:'acount'});
								 console.info(ed);
								 for(var index in data.rows){
									 var thisTarget = $('#table_add').datagrid('getEditor',
												{
													'index' : index,
													'field' : 'acount'
												});
									 console.info(thisTarget);
								 }
							},
							toolbar : [ {
								text : '删除',
								iconCls : 'icon-remove',
								handler : function() {
									removeit();
								}
							}, '-', {
								text : '订单拆分',
								iconCls : 'icon-edit',
								handler : function() {
									order_split();
								}
							}, '-', {
								text : '重置',
								iconCls : 'icon-undo',
								handler : function() {
									reject();
								}
							}, '-', {
								text : '提交',
								iconCls : 'icon-ok',
								handler : function() {
									submitData();
								}
							} ],
							columns : [ [
									{field : 'product',title : '产品大类',width : 100,align : 'center'},
									{field : 'type',title : '产品类型',width : 100,align : 'center'},
									{field : 'sub_product',title : '产品名称',width : 100,align : 'center'},
									{field : 'format',title : '规格',width : 100,align : 'center',formatter: function(value,row,index){
										return row.formatNum + row.format;
									}},
									{field : 'materail',title : '材质/标准',width : 100,align : 'center'},
									{field : 'acount',title : '数量',width : 100,align : 'center',editor : 'textbox'},
									{field : 'unit',title : '单位',width : 100,align : 'center'},
									/* {field : 'price',title : '单价',width : 100,align : 'center',editor : 'textbox'}, */
									{field : 'companyName',title : '供货商',width : 100,align : 'center',
										editor : {
											type : 'combobox',
											options : {
												url : '${pageContext.request.contextPath}/supplier!getCompany.action',
												valueField : 'name',
												textField : 'name',
												onSelect : function(data) {
													var row = $('#table_add').datagrid('getSelected');
													var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
													var thisTarget = $('#table_add').datagrid('getEditor',
																	{
																		'index' : rowIndex,
																		'field' : 'companyName'
																	}).target;
													var value = thisTarget.combobox('getValue');
													var idvalue = $("#table_add").datagrid('getEditor',
																	{
																		index : rowIndex,
																		field : 'companyId'
																	});
													$(idvalue.target).textbox('setValue',data.id);
												}
											}
										}
									}, 
									{field : 'detailId',hidden : 'true',editor : 'textbox'}, 
									{field : 'productId',hidden : 'true',editor : 'textbox'}, 
									{field : 'companyId',hidden : 'true',editor : 'textbox'}, 
									{field : 'initnum',hidden : 'true',editor : 'textbox'}, 
									{field : 'remark',title : '备注',width : 100,align : 'center'}, 
									{field : 'id',hidden : 'true',editor : 'textbox'}
									] ],
										//编辑数据前获取产品detailID，通过产品id获取有该产品的公司列表
									onBeginEdit:function(index, row){
			                          var index=$('#table_add').datagrid('getRowIndex',row)
			                          var ed = $('#table_add').datagrid('getEditor', {index:index,field:'companyName'});
			                          $(ed.target).combobox('reload', {'detailId':row.detailId});//
			                      },

						});
			}else if("${roleId}" == '2'){
				$('#table_add').datagrid({
							url : '${pageContext.request.contextPath}/supplier!searchDetail.action',
							pagination : true,
							fitColumns : true,
							striped:true,
							singleSelect : true,
							onClickRow : onClickRow,
							columns : [ [
									{field : 'product',title : '产品大类',width : 100,align : 'center'},
									{field : 'type',title : '产品类型',width : 100,align : 'center'},
									{field : 'sub_product',title : '产品名称',width : 100,align : 'center'},
									{field : 'format',title : '规格',width : 100,align : 'center',formatter: function(value,row,index){
											return row.formatNum + row.format;
									}},
									{field : 'materail',title : '材质/标准',width : 100,align : 'center' },
									{field : 'acount',title : '数量',width : 100,align : 'center'},
									{field : 'unit',title : '单位',width : 100,align : 'center'},
									/* {field : 'price',title : '单价',width : 100,align : 'center',editor : 'textbox'}, */
									{field : 'detailId',hidden : 'true',editor : 'textbox'}, 
									{field : 'productId',hidden : 'true',editor : 'textbox'},
									{field : 'companyId',hidden : 'true',editor : 'textbox'}, 
									{field : 'initnum',hidden : 'true',editor : 'textbox'}, 
									{field : 'remark',title : '备注',width : 100,align : 'center'}, 
									{field : 'id',hidden : 'true',editor : 'textbox'} 
									] ],

						});
			}
			
			//$("#table_add").datagrid("hideColumn","amount");
		});

		function order_add() {
			$("#order_dlg").dialog({
				onOpen : function() {
					$("#id").val("");
				}
			});
			$('#order_dlg').dialog('open');
			$('#order_dlg').dialog('setTitle', '添加订单');
			$('#table_add').datagrid('loadData', {
				total : 0,
				rows : []
			});
			//$('#table_add').datagrid('reload');
			/* $("#company_save").click(function(){
				$.ajax({
					url : '${pageContext.request.contextPath}/companyAction!add.action',
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
			});  */
		}

		
		function invoice_status(invoice){
    		var row = $('#table_order').datagrid('getSelected');
    		if(invoice == '1' &&  row.status == '1'){
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
        			    			url: '${pageContext.request.contextPath}/supplier!updateInvoiceStatus.action?invoice=' + invoice,
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
    	
	 	function order_status(status){
			var row = $('#table_order').datagrid('getSelected');
			if(status == '3' && row.status != '1'){
				  alert("订单已付款！");
				  return false ;
			}else if(status == '4' && row.status != '3'){
				 alert("订单未付款，不能修改为收货状态");
				 return false ;
			}
	    		if(row){
	    			$.messager.confirm(
	    				'提示',
	    				'确定执行该操作?',
	    				function(r) {
	    					if (r) {
	    						$.ajax({ 
	    			    			url: '${pageContext.request.contextPath}/supplier!updateStatus.action?status=' + status,
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
		function order_split() {
			var row = $('#table_add').datagrid('getSelected');
			if (row) {
				$.messager.confirm(
					'提示',
					'确定进行拆分么?',
					function(r) {
						if (r) {
							$.messager.prompt('','请输入要拆分的行数',function(s){
								if(Math.round(s) == s){
									$.ajax({
										url : '${pageContext.request.contextPath}/supplier!splitOrder.action',
										data : {
											"id" : row.id ,
											"num" :s
										},
										dataType : 'json',
										success : function(obj) {
											if (obj.success) {
												alert(obj.msg);
												$('#table_add').datagrid('reload');
											} else {
												alert(obj.msg);
												$('#table_add').datagrid('reload');
											}
										}
									});
								}else{
									$.messager.alert("error","请输入正确的数字");
								}
							});
						}
					});
			}
		}
		function order_edit() {
			var row = $('#table_order').datagrid('getSelected');
			if (row) {
				$("#order_dlg").dialog({
					onOpen : function() {
						$("#id").val(row.id);
					}
				});
				$('#order_dlg').dialog('open');
				$('#order_dlg').dialog('setTitle', '编辑订单');
				$('#table_add').datagrid('reload', {
					id : $("#id").val()
				});
				editIndex = undefined;
				$("#company_save").click(function() {
					$.ajax({
						url : '${pageContext.request.contextPath}/companyAction!update.action',
						data : $('#order_form')
								.serialize(),
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

		function company_close() {
			document.getElementById('order_form').reset();
			$('#order_dlg').dialog('close');
			$('#table_order').datagrid('reload');
		}
	</script>

	<script type="text/javascript">
		function endEditing() {
			if (editIndex == undefined) {
				return true
			}
			if ($('#table_add').datagrid('validateRow', editIndex)) {
				$('#table_add').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickRow(index) {
			if (editIndex != index) {
				if (endEditing()) {
					$('#table_add').datagrid('selectRow', index).datagrid(
							'beginEdit', index);
					editIndex = index;
				} else {
					$('#table_add').datagrid('selectRow', editIndex);
				}
			}
		}
		function removeit() {
			if (editIndex == undefined) {
				return
			}
			var orderRow = $('#table_order').datagrid('getSelected');
			var row = $('#table_add').datagrid('getSelected');
			if (row) {
				$.messager.confirm(
						'提示',
						'确定要删除么?',
						function(r) {
							if(r) {
								$.ajax({
									url : '${pageContext.request.contextPath}/supplier!deleteSupllierOrderDetail.action',
									data : {
										"orderId" : orderRow.id,
										"detailId" : row.id
									},
									dataType : 'json',
									success : function(obj) {
										if (obj.success) {
											alert(obj.msg);
											$('#table_add').datagrid('reload');
										} else {
											alert(obj.msg);
											$('#table_add').datagrid('reload');
										}
									}
								});
							}
						});
			}
			editIndex = undefined;
		}
		function accept() {
			if (endEditing()) {
				$('#table_add').datagrid('acceptChanges');
			}
		}
		function reject() {
			$('#table_add').datagrid('rejectChanges');
			editIndex = undefined;
		}
		
		function updatePrice(){
			if (endEditing()) {
				//利用easyui控件本身的getChange获取新添加，删除，和修改的内容  
				if ($("#table_add").datagrid('getChanges').length) {
					var deleted = $("#table_add").datagrid('getChanges',
							"deleted");
					var updated = $("#table_add").datagrid('getChanges',
							"updated");
					var data = $('#order_form').serialize();
					var effectRow = new Object();
					effectRow["formData"] = data;
					if (updated.length) {
						effectRow["updated"] = JSON.stringify(updated);
					}
					$.post(
							"${pageContext.request.contextPath}/supplier!getSupllierPrice.action?"
									+ data, effectRow, function(obj) {
								if (obj.success) {
									alert(obj.msg);
									$('#order_dlg').dialog('close');
									$('#table_order').datagrid('reload');
								} else {
									alert(obj.msg);
								}
							}, "JSON");
				}
			}
		}
		
		function submitData() {
			if (endEditing()) {
				//利用easyui控件本身的getChange获取新添加，删除，和修改的内容  
				if ($("#table_add").datagrid('getChanges').length) {
					var inserted = $("#table_add").datagrid('getChanges',
							"inserted");
					var deleted = $("#table_add").datagrid('getChanges',
							"deleted");
					var updated = $("#table_add").datagrid('getChanges',
							"updated");
					var data = $('#order_form').serialize();
					var effectRow = new Object();
					effectRow["formData"] = data;
					if (inserted.length) {
						effectRow["inserted"] = JSON.stringify(inserted);
					}
					;
					if (deleted.length) {
						effectRow["deleted"] = JSON.stringify(deleted);
					}
					if (updated.length) {
						effectRow["updated"] = JSON.stringify(updated);
					}
					$.post(
							"${pageContext.request.contextPath}/supplier!getChanges.action?"
									+ data, effectRow, function(obj) {
								if (obj.success) {
									alert(obj.msg);
									$('#order_dlg').dialog('close');
									$('#table_order').datagrid('reload');
								} else {
									alert(obj.msg);
								}
							}, "JSON");
				}
			}
		}
	</script>
</body>
</html>
