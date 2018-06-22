<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>客户/供应商管理</title>
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
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">客户/供应商管理</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 3px">
 			 <div >
            	公司名称：
                <input name="name" id = "cname"class=" form-control" style="display: inline-block;width: 10%">
            	企业类型：
                <select name="roleId" id="roleId" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;" editable="false">
                    <option value="">-选择-</option>
                	<option value="2">供货商</option>
                	<option value="3">客户</option>
                </select>
                <button onclick="query()">查询</button>
            </div> 
 		<table id="company_table" class="easyui-datagrid" fit="true" ></table>
 	</div>
	<div id="toolbar_company" style="padding:2px 5px;">
     	<a onclick="company_add()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-plus fa-fw" style="margin: 2px">新增</a>
        <a onclick="company_edit()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px">编辑</a>    
        <a onclick="company_delete()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-remove fa-fw" style="margin: 2px">删除</a>
    </div>
	
    <script type="text/javascript">
    function query(){
    	$('#company_table').datagrid('load', {
    	    name: $("#cname").val(),
    	    roleId: $("#roleId").val()
    	});
    }
    	$(function(){
			$('#company_table').datagrid({
				url:'${pageContext.request.contextPath}/companyAction!loadAll.action',
				pagination: true,
				toolbar:'#toolbar_company',				
				fitColumns: true,
				striped:true,
				singleSelect: true,
				columns:[[
					{field:'name',title:'公司名称',width:100,align:'center'},
					{field:'contacts',title:'联系人',width:100,align:'center'},
					{field:'address',title:'地址',width:150,align:'center'},
					{field:'business',title:'主营业务',width:150,align:'center'},
					{field:'level',title:'企业星级',width:150,align:'center'},
					{field:'telphone',title:'联系电话',width:150,align:'center'},
					{field:'tax',title:'税号',width:150,align:'center'},
					{field:'card',title:'银行账号',width:150,align:'center'},
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
			$('#company_dlg').dialog('open');	
			$('#company_dlg').dialog('setTitle','添加企业');
			$("#company_save").unbind('click').click(function(){
				if($("#company_form").validate().form()){
		  				$.ajax({
							url : '${pageContext.request.contextPath}/companyAction!add.action',
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
    			$('#company_dlg').dialog('open');	
    			$('#company_dlg').dialog('setTitle','编辑企业');
    			$('#company_form').form('load', row);
				$("#company_save").unbind('click').click(function(){
					if($("#company_form").validate().form()){
	  					$.ajax({
							url : '${pageContext.request.contextPath}/companyAction!update.action',
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
    			    			url: '${pageContext.request.contextPath}/companyAction!delete.action',
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
		})
		
    </script>
    
    <div id="company_dlg_buttons" style="width:800px;height: 40px;text-align: center">
		<button id="company_save" type="button" class="btn btn-primary btn-dialog-left">保存</button>
		<button onclick="company_close()" type="button" class="btn btn-default btn-dialog-right">取消</button>
	</div>
	
	
	<div  id="company_dlg" closed="true" class="easyui-dialog" style="width:750px;height: 450px"
	data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#company_dlg_buttons'">
    	<form id="company_form" role="form" style="padding: 20px">
    		<div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">公司名称：</label>
                <input name="name" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">企业类型：</label>
                <select name="roleId" id="roleId" 
                    		class="form-control select2 easyui-combobox" style="width: 45%;height: 86%" editable="false">
                	<option value="2">供货商</option>
                	<option value="3">客户</option>
                </select>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">登录账号：</label>
                <input name="userName" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">联系人：</label>
                <input name="contacts" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">主营业务：</label>
                <input name="business" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">企业星级：</label>
                <input name="level" class=" form-control" style="display: inline-block;width: 45%" >
            </div>
            
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">联系电话：</label>
                <input name="telphone" class=" form-control"  style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">税号：</label>
                <input name="tax" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">银行账号：</label>
                <input name="card" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">地址：</label>
                <textarea name="address" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required></textarea>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">备注：</label>
                <textarea name="remark" class=" form-control" rows="2" style="display: inline-block;width: 45%"></textarea>
            </div>
            <input id="id" name="id" style="display:none;"/> 
    	</form>                 
    </div>
</body>
</html>
