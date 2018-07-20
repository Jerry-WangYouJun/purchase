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
			if('${roleId}' == '1'){
				return false;
			}
			if($("#orderNo").val() != ''){
				var order = $("#table_order").datagrid('getSelected');
				if(order != null &&  order.status != '1'  ){
					return false;
				} 
			}
			if (editIndex == undefined){return true}
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
				  var base = $("#table_add").datagrid('getEditor', {  
	                  index : index ,
	                  field : 'base'      
	              }).target.textbox('getValue');
			 	 if( acount == 0 || acount < base ){
		 		    alert('采购数量不应小于最小采购数量');
					return false;		 		
		 	 	 }
			}
			if ($('#table_add').datagrid('validateRow', editIndex)){
				$('#table_add').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
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
			                    $.post(getProjectUrl() + "orderAction!getChanges.action?"  + data  , effectRow, function(obj) {
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
    	 * 修改发票状态
    	 * @param invoice
    	 * @returns
    	 */
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
							percent = "&percent="   + s;
				    			$.messager.confirm(
				    				'提示',
				    				'确定执行该操作?',
				    				function(r) {
				    					if (r) {
				    						$.ajax({ 
				    			    			url: getProjectUrl() + 'orderAction!updateStatus.action?status=' + status + percent,
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
		    			    			url: getProjectUrl() + 'orderAction!updateStatus.action?status=' + status ,
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
    			    			url: getProjectUrl() + 'orderAction!deleteOrder.action',
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
					 $('#confirmId').combobox('setValue', "");
               }
			});
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
						url : getProjectUrl() + 'companyAction!update.action',
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
                        $('#confirmId').combobox('setValue', row.confirmId);
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
    
    function getProjectUrl(){
    	var hostUrl = "";
    	var url = window.document.location.href;
    	var pathname = window.document.location.pathname;
    	pathname = pathname.substring(0,pathname.indexOf("/",1)+1);
    	hostUrl = url.substring(0,url.indexOf(pathname)) + pathname;
    	return hostUrl;
    }