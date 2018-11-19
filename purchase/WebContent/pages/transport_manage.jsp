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
    
    <title>物流信息管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">
 		    物流信息管理
 		</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 30px">
		  <c:if test="${roleId eq 1 }">
 			 <div >
            	物流名称：
                <input name="transname" id = "transname"class=" form-control" style="display: inline-block;width: 10%">
            物流单号：
                 <input name="transno" id = "transno"class=" form-control" style="display: inline-block;width: 10%">
                <button onclick="query()">查询</button>
            </div> 
		  </c:if>
 		<table id="company_table" class="easyui-datagrid" fit="true" ></table>
 	</div>
	<div id="toolbar_company" style="padding:2px 5px;">
	<c:if test="${roleId eq 1 }">
     	<a onclick="company_add()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-plus fa-fw" style="margin: 2px">新增</a>
        <a onclick="company_delete()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-remove fa-fw" style="margin: 2px">删除</a>
        <a onclick="company_edit()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px">编辑</a>    
    </c:if>
    </div>
	
    <script type="text/javascript">
    function query(){
	    	$('#company_table').datagrid('load', {
	    		transname: $("#transname").val(),
	    		transno: $("#transno").val()
	    	});
    }
    	$(function(){
			$('#company_table').datagrid({
				url:'${pageContext.request.contextPath}/transAction!loadAll.action',
				pagination: true,
				toolbar:'#toolbar_company',		
				pagePosition:'top',
				pageSize: 30,
				fitColumns: true,
				striped:true,
				singleSelect: true,
				columns:[[
					{field:'id', hidden:true},
					{field:'orderid',hidden:true},
					{field:'orderName',title:'订单号',width:100,align:'center'},
					{field:'transname',title:'物流名称',width:100,align:'center'},
					{field:'transno',title:'物流单号',width:100,align:'center'},
					{field:'telphone',title:'物流电话',width:100,align:'center'},
					{field:'money',title:'运费',width:150,align:'center'},
					{field:'payflag',title:'是否付款',width:150,align:'center',
						formatter: function(value,row,index){
							if(value='1'){
								 return "是";
							}else{
								return "否";
							}
						}
					},
					{field:'driver',title:'司机',width:150,align:'center'},
					{field:'driverphone',title:'司机电话',width:150,align:'center'},
					{field:'remark',title:'备注',width:100,align:'center'}
				]],	
				onDblClickCell: function(index,field,value){
					company_edit();
					/* $(this).datagrid('beginEdit', index);
					var ed = $(this).datagrid('getEditor', {index:index,field:field});
					//$(ed.target).focus();
					alert(123); */
				}
			});
		});
		function company_add(){
			$('#userName').attr("readOnly",false);
			$('#company_dlg').dialog('open');	
			$('#company_dlg').dialog('setTitle','添加物流信息');
			$("#company_save").unbind('click').click(function(){
				if($("#company_form").validate().form()){
		  				$.ajax({
							url : '${pageContext.request.contextPath}/transAction!edit.action',
							data : $('#company_form').serialize(),
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
				}
				
			});
		}
		function company_edit(){
			var row = $('#company_table').datagrid('getSelected');
    		if(row){
    			$('#userName').attr("readOnly",true);
    			$('#company_dlg').dialog('open');	
    			$('#company_dlg').dialog('setTitle','编辑企业');
    			$('#company_form').form('load', row);
				$("#company_save").unbind('click').click(function(){
					if($("#company_form").validate().form()){
	  					$.ajax({
							url : '${pageContext.request.contextPath}/transAction!edit.action',
							data : $('#company_form').serialize(),
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
					}
				});
			}
    	}
		function company_delete(){
			var row = $('#company_table').datagrid('getSelected');
    		if(row){
    			$.messager.confirm(
    				'提示',
    				'确定要删除么?',
    				function(r) {
    					if (r) {
    						$.ajax({ 
    			    			url: '${pageContext.request.contextPath}/transAction!delete.action',
    			    			data : {"id":row.id},
    			    			dataType : 'json',
    			    			success : function(obj){
    			    				if(obj.success){
    			    				 	alert(obj.msg);
    			    				 	$('#company_table').datagrid('reload');
    			    				}else{
    			    					alert(obj.msg);
    			    					$('#company_table').datagrid('reload');
    			    				}
    			    			}
    			    		});
    					}
    				});  		
    			}
		}
		function company_close(){
			$('#company_form').form('reset');
			$('#company_form').form('clear');
			$('#company_dlg').dialog('close');	
			$('#company_table').datagrid('reload');
			$('label.error').remove();
			$('.error').removeClass("error");
		}
		
		
		$(function(){
			$("#company_form").validate();
			$('#roleId').combobox({
				onChange:function(n,o){
					 if(n == '2'){
						  $(".brand").show();
						  $(".business").css("margin-bottom" , "0px");
					 }else {
						 $(".brand").hide(); 
						 $(".business").css("margin-bottom" , "15px");
					 }
			    }
			});
			if('${roleId}' != '1'){
				$("#company_table").datagrid("hideColumn","brand");
			}
		})
		
		function checkOnly(val){
			if(val == ''){
				return false ;
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/transAction!checkOrderNo.action',
				data : {orderNo:$("#orderNo").val()},
				dataType : 'json',
				success : function(obj) {
					if (!obj.success) {
						alert(obj.msg);
						$("#orderNo").val("");
					} else{
						console.info(obj);
						$("#orderid").val(obj.obj);
					}
				}
			});
	}
    </script>
    
    <div id="company_dlg_buttons" style="width:800px;height: 40px;text-align: center">
		<button id="company_save" type="button" class="btn btn-primary btn-dialog-left">保存</button>
		<button onclick="company_close()" type="button" class="btn btn-default btn-dialog-right">取消</button>
	</div>
	
	
	<div  id="company_dlg" closed="true" class="easyui-dialog" style="width:750px;height: 450px"
	data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
    	<form id="company_form" role="form" style="padding: 20px">
    			<div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">物流名称：</label>
                <input name="transname" class="form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6 brand">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">物流单号：</label>
                <input name="transno" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6 brand">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">物流电话：</label>
                <input name="telphone" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">客户订单：</label>
                <input name="orderName" id="orderNo" onchange="checkOnly(this.value)"  class="form-control" style="display: inline-block;width: 45%"
                 placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">运费：</label>
                <input name="money" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">是否支付：</label>
                 <select name = "payflag"  class=" form-control" style="display: inline-block;width: 45%" >
                	 <option  value="0">否</option>
                	 <option  value="1">是</option>
                </select>
            </div>
            <div class="form-group col-md-6 " >
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">司机：</label>
                <input name="driver" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6 " >
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">司机电话：</label>
                <input name="driverphone" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">备注：</label>
                <textarea name="remark" class=" form-control" rows="2" style="display: inline-block;width: 45%"></textarea>
            </div>
            <input id="id" name="id" style="display:none;"/> 
            <input id="orderid" name="orderid" style="display:none;"/>
    	</form>                 
    </div>
</body>
</html>
