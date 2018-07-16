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
			var order = $("#table_order").datagrid('getSelected');
			if('${roleId}' == '1'){
				return false;
			}
			if(order != null &&  order.status != '1'  ){
				return false;
			} 
			if (editIndex == undefined){return true}
			var index = $('#table_add').datagrid('getEditingRowIndexs');
			if(index > 0){
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
			 		    alert('数据不全，请核对！');
						return false;		 		
			 	 } 
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