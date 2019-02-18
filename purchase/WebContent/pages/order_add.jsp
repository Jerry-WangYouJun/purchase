<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/common.jsp"></jsp:include>
<style type="text/css">
button, input, optgroup, select, textarea {
   
    color:black;
}
.div_position{
      margin-left:  20px;
        padding: 0px;
}
</style>
</head>
<body>
	 <div>
		<form class="form-inline"  role="form" style="" id = "form1">
		  <div class="form-group">
		    <label class="div_position" for="exampleInputName2">订单编号</label>
		    <input type="text" class="form-control div_position" id="orderNo" name="orderNo" placeholder="请输入订单编号">
		  </div>
		</form>
	 </div>
	 		<table id="table_order" class="easyui-datagrid" fit="true" >
	 			
	 		</table>
	 
	 <script type="text/javascript">
	 var editIndex = undefined;
		$(function(){
			
			$('#table_order').datagrid({
				url:'${pageContext.request.contextPath}/orderAction!searchDetail.action',
				pagination: true,
				fitColumns: true,
				singleSelect: true,
				onClickRow: onClickRow,
				toolbar: [{
					text:'添加',
					iconCls: 'icon-add',
					handler: function(){append();}
				},'-',{
					text:'删除',
					iconCls: 'icon-remove',
					handler: function(){removeit();}
				}/* ,'-',{
					text:'保存',
					iconCls: 'icon-save',
					handler: function(){accept();}
				} ,'-',{
					text:'取消',
					iconCls: 'icon-undo',
					handler: function(){reject();}
				}*/,'-',{
					text:'提交',
					iconCls: 'icon-ok',
					handler: function(){submitData();}
				}],
				columns:[[
					{field:'product',title:'产品大类',width:100,align:'center',
						editor : {    
	                        type : 'combobox',    
	                        options : {    
	                            url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
	                            valueField:'product' ,   
	                            textField:'product',  
	                            onSelect:function(data){  
	                                var row = $('#table_order').datagrid('getSelected');  
	                                var rowIndex = $('#table_order').datagrid('getRowIndex',row);//获取行号  
	                                 var ed = $("#table_order").datagrid('getEditor', {  
	                                        index : rowIndex,  
	                                        field : 'unit'  
	                                    });  
	                                $(ed.target).textbox('setValue',  data.unit);   
	                                var thisTarget = $('#table_order').datagrid('getEditor', {'index':rowIndex,'field':'product'}).target;  
	                                var value = thisTarget.combobox('getValue');  
	                                var target = $('#table_order').datagrid('getEditor', {'index':rowIndex,'field':'type'}).target;  
	                                target.combobox('clear'); //清除原来的数据  
	                                var subtarget = $('#table_order').datagrid('getEditor', {'index':rowIndex,'field':'sub_product'}).target;  
	                                subtarget.combobox('clear');
	                                var url = '${pageContext.request.contextPath}/orderAction!getProductType.action?product='+data.product;  
	                                target.combobox('reload', url);//联动下拉列表重载   */
	                            }  
	                        }    
	                    	}/* ,
						formatter : function (value, row, index) {
			                   
			                    return row.materail;
			                } */
					},
					{field:'type',title:'产品类型',width:100,align:'center',
						editor : {    
	                        type : 'combobox',    
	                        options : {    
	                           // url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
	                            valueField:'type' ,   
	                            textField:'type',  
	                            onSelect:function(data){  
	                                var row = $('#table_order').datagrid('getSelected');  
	                                var rowIndex = $('#table_order').datagrid('getRowIndex',row);//获取行号  
	                                var thisTarget = $('#table_order').datagrid('getEditor', {'index':rowIndex,'field':'type'}).target;  
	                                var value = thisTarget.combobox('getValue');  
	                                var idvalue = $("#table_order").datagrid('getEditor', {  
                                        index : rowIndex,  
                                        field : 'productId'  
                                    });  
                                $(idvalue.target).textbox('setValue',  data.id ); 
	                                var target = $('#table_order').datagrid('getEditor', {'index':rowIndex,'field':'sub_product'}).target;  
	                                target.combobox('clear'); //清除原来的数据  
	                                var url = '${pageContext.request.contextPath}/orderAction!getProductDetail.action?productId='+data.id;  
	                                target.combobox('reload', url);//联动下拉列表重载   
	                            }  
	                        }    
	                    	}
					},
					{field:'sub_product',title:'产品规格',width:100,align:'center',
						editor : {    
	                        type : 'combobox',    
	                        options : {    
	                           // url:'${pageContext.request.contextPath}/orderAction!getProduct.action',  
	                            valueField:'subProduct' ,   
	                            textField:'subProduct',  
	                            onSelect:function(data){  
	                                var row = $('#table_order').datagrid('getSelected');  
	                                var rowIndex = $('#table_order').datagrid('getRowIndex',row);//获取行号  
	                                 var ed = $("#table_order").datagrid('getEditor', {  
	                                        index : rowIndex,  
	                                        field : 'materail'  
	                                    });  
	                                $(ed.target).textbox('setValue',  data.material);   
	                                var idvalue = $("#table_order").datagrid('getEditor', {  
                                        index : rowIndex,  
                                        field : 'detailId'  
                                    });  
                                $(idvalue.target).textbox('setValue',  data.id );   
	                            }  
	                        }    
	                    	}},
					{field:'materail',title:'材质',width:100,align:'center',editor:'textbox'},
					{field:'acount',title:'数量',width:100,align:'center',editor:'textbox'},
					{field:'unit',title:'单位',width:100,align:'center',editor:'textbox'},
					{field:'price',title:'单价',width:100,align:'center',editor:'textbox'},
					{field:'detailId', hidden:'true',editor:'textbox' },
					{field:'productId', hidden:'true',editor:'textbox' },
					{field:'remark',title:'备注',width:100,align:'center',editor:'textbox'}
				]],
				
			});
			//$("#table_order").datagrid("hideColumn","amount");
		});
		function endEditing(){
			if (editIndex == undefined){return true}
			if ($('#table_order').datagrid('validateRow', editIndex)){
				$('#table_order').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickRow(index){
			if (editIndex != index){
				if (endEditing()){
					$('#table_order').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					editIndex = index;
				} else {
					$('#table_order').datagrid('selectRow', editIndex);
				}
			}
		}
		function append(){
			if (endEditing()){
				$('#table_order').datagrid('appendRow',{status:'P'});
				editIndex = $('#table_order').datagrid('getRows').length-1;
				$('#table_order').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeit(){
			if (editIndex == undefined){return}
			$('#table_order').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function accept(){
			if (endEditing()){
				$('#table_order').datagrid('acceptChanges');
			}
		}
		function reject(){
			$('#table_order').datagrid('rejectChanges');
			editIndex = undefined;
		}
		function submitData() {
			if (endEditing()) { 
		                //利用easyui控件本身的getChange获取新添加，删除，和修改的内容  
		            if ($("#table_order").datagrid('getChanges').length) {  
		                    var inserted = $("#table_order").datagrid('getChanges', "inserted");  
		                    var deleted = $("#table_order").datagrid('getChanges', "deleted");  
		                    var updated = $("#table_order").datagrid('getChanges', "updated");
		                
		                    var effectRow = new Object();  
		                    if (inserted.length) { 
		                        effectRow["inserted"] = JSON.stringify(inserted);  
		                    }  
		                    if (deleted.length) {  
		                        effectRow["deleted"] = JSON.stringify(deleted);  
		                    }  
		                    if (updated.length) {  
		                        effectRow["updated"] = JSON.stringify(updated);  
		                    } 
		                    $.post("${pageContext.request.contextPath}/orderAction!getChanges.action?companyId="+1, effectRow, function(rsp) {
		                            $.messager.alert("提示", "提交成功！");
		                            $table_order.datagrid('acceptChanges');
		                        
		                    }, "JSON");
		              }
				} 
			}
	 </script>
</body>
</html>