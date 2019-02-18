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
			 	 if( acount == 0 || eval(acount) < eval(base) ){
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
	   						$('#table_add').datagrid('reload', {
	   							id: 0
	   						});
	   					}
	   				});
    		}else{
    			$('#order_dlg').dialog('close');
    			$('#table_add').datagrid('reload', {
						id: 0
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
			 setTimeout( function(){
				 $('#table_add').datagrid('reload', {
					 id: row.id
				});
			 },200)
			 
			
			}
    	}
   
     	
    function query(){
    	var col = $("#queryCol").val();
    	var val = $("#queryValue").val();
    	var dataParams = {};
        dataParams[col] = val;
 	    	$('#table_order').datagrid('load', {
 	    		  colName:col ,
 	    		  colValue:val,
 	    		 ostatue :$("#ostatue").val(),
 	    		oinvoice:$("#oinvoice").val()
 	    	});
  	}
    
    function changeAmount(){
    		var row = $('#table_add').datagrid('getSelected');  
    		if(row == null){
    			return false ;
    		}
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
         var taxrate = $("#table_add").datagrid('getEditor', {  
             index : rowIndex,  
             field : 'taxrate'  
         });
         var taxflag = $("#taxrate").val();
         var amount = price.target.textbox('getValue') * acount.target.textbox('getValue');
//         if(taxflag != '0'){
//        	    amount -= (amount*taxrate.target.textbox('getValue')*0.01);
//         }
        $(bra.target).textbox('setValue', amount);
    }
    
    function changeBoxnum(){
		var row = $('#table_add').datagrid('getSelected');  
		if(row == null){
			return false ;
		}
	    var rowIndex = $('#table_add').datagrid('getRowIndex',row);//获取行号  
	     var boxnum = $("#table_add").datagrid('getEditor', {  
	            index : rowIndex,  
	            field : 'boxnum'  
	        }); 
	     
	     var acount = $("#table_add").datagrid('getEditor', {  
	         index : rowIndex,  
	         field : 'acount'  
	     });
	     var formatNum = $("#table_add").datagrid('getEditor', {  
	         index : rowIndex,  
	         field : 'formatNum'  
	     });
	     
	     if(formatNum.target.textbox('getValue') == ''){
	    	
	    	 return true;
	     }
	     var num = acount.target.textbox('getValue') / formatNum.target.textbox('getValue');
	     var rest = acount.target.textbox('getValue') % formatNum.target.textbox('getValue');
//	     if(parseInt(acount.target.textbox('getValue')) < parseInt(formatNum.target.textbox('getValue'))){
//	    	 alert("为了方便发货，数量不得少于" +formatNum.target.textbox('getValue') ); 
//	    	acount.target.textbox('setValue' , '');
//	    	 return false ;
//	     }
//	     if(rest != 0 ){
//	    	   alert("为了方便发货，数量必须是" + formatNum.target.textbox('getValue') + "的整数倍");
//	    	  acount.target.textbox('setValue' , '');
//	    	   return false ;
//	     }
	//     if(taxflag != '0'){
	//    	    amount -= (amount*taxrate.target.textbox('getValue')*0.01);
	//     }
	    $(boxnum.target).textbox('setValue', Math.ceil(num));
	}
    
    //获取页面URL
    function getProjectUrl(){
	    	var hostUrl = "";
	    	var url = window.document.location.href;
	    	var pathname = window.document.location.pathname;
	    	pathname = pathname.substring(0,pathname.indexOf("/",1)+1);
	    	hostUrl = url.substring(0,url.indexOf(pathname)) + pathname;
	    	return hostUrl;
    }