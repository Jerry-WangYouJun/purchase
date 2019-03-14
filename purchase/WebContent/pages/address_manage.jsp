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
    
    <title>地址管理</title>
    
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
<link href="${basePath}/assets/css/style.css" rel="stylesheet" />
  </head>
  
  <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">地址管理</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 30px">
 		<table id="user_table" class="easyui-datagrid" fit="true" ></table>
 	</div>
	
	
	<div id="toolbar_user" style="padding:2px 5px;">
		<a onclick="user_add()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-plus fa-fw" style="margin: 2px">新增</a>  
        <a onclick="user_edit()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px">修改</a>    
        <a onclick="user_delete()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-remove fa-fw" style="margin: 2px">删除</a>
    </div>
	
    <script type="text/javascript">
    	$(function(){
			$('#user_table').datagrid({
				url:'${pageContext.request.contextPath}/addressAction!loadAll.action?cid=${cid}',
				pagination: true,
				pagePosition:'top',
				pageSize: 30,
				toolbar:'#toolbar_user',				
				fitColumns: true,
				striped:true,
				singleSelect: true,
				columns:[[
					{field:'companyName',title:'公司',width:50,align:'center',formatter:function(value,row,index){
                        return row.company.name;
                    }},
					{field:'name',title:'地址标签',width:30,align:'center'},
					{field:'province',title:'省',width:20,align:'center'},
					{field:'city',title:'市',width:20,align:'center'},
					{field:'address',title:'详细地址',width:100,align:'center'},
					{field:'isDefault',title:'默认地址',width:20,align:'center',
						formatter: function(value,row,index){
							switch(value){
								case '1':
									return '是';
								break;
								case '0':
									return '否';
								break;
							}							
						}}
				]],				
			});
			$("#loadingDiv").remove();
			if('${roleId}' != '1'){
				
			}
		});
		function user_add(){
			$('#user_dlg').dialog('open');	
			$('#user_dlg').dialog('setTitle','添加地址');
			$("#user_save").unbind('click').click(function(){
  				$.ajax({
					url : '${pageContext.request.contextPath}/addressAction!edit.action?cid=${cid}',
					data : $('#user_form').serialize(),
					dataType : 'json',
					success : function(obj) {
						if (obj.success) {
							alert(obj.msg);
							user_close();
						} else {
							alert(obj.msg);
						}
					}
				});
			});
		}
		function user_edit(){
			var row = $('#user_table').datagrid('getSelected');
    		if(row){
    			$('#user_dlg').dialog('open');	
    			$('#user_dlg').dialog('setTitle','编辑地址');
    			$('#user_form').form('load', row);
    			//updateCombox(roleId,row.roleId);
    			//updateCombox(companyId,row.companyId);
				$("#user_save").unbind('click').click(function(){
  					$.ajax({
						url : '${pageContext.request.contextPath}/addressAction!edit.action',
						data : $('#user_form').serialize(),
						dataType : 'json',
						success : function(obj) {
							if (obj.success) {
								alert(obj.msg);
								user_close();
							} else {
								alert(obj.msg);
							}
						}
					});
				});
			}
    	}
		function user_delete(){
			var row = $('#user_table').datagrid('getSelected');
    		if(row){
    			$.messager.confirm(
    				'提示',
    				'确定要删除么?',
    				function(r) {
    					if (r) {
    						$.ajax({ 
    			    			url: '${pageContext.request.contextPath}/addressAction!delete.action?cid=${cid}',
    			    			data : {"id":row.id},
    			    			dataType : 'json',
    			    			success : function(obj){
    			    				if(obj.success){
    			    				 	alert(obj.msg);
    			    				 	$('#user_table').datagrid('reload');
    			    				}else{
    			    					alert(obj.msg);
    			    					$('#user_table').datagrid('reload');
    			    				}
    			    			}
    			    		});
    					}
    				});  		
    			}
		}
		function user_close(){
			$('#user_form').form('reset');
			$('#user_form').form('clear');
			$('#user_dlg').dialog('close');	
			$('#user_table').datagrid('reload');
		}
    </script>
    
    <div id="user_dlg_buttons" style="width:800px;height: 40px;text-align: center">
		<button id="user_save" type="button" class="btn btn-primary btn-dialog-left">保存</button>
		<button onclick="user_close()" type="button" class="btn btn-default btn-dialog-right">取消</button>
	</div>
	
	
	<div  id="user_dlg" closed="true" class="easyui-dialog" style="width:600px;height: 300px"
	data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:50,buttons: '#user_dlg_buttons'">
    		<form class="form-horizontal" role="form"  style="padding: 20px" id="user_form">
						<input type="hidden"  name="id" >
						<input type="hidden"  name="cid" >
					  <div class="form-group">
					    <label for="firstname" class="col-sm-2 control-label">地址标签：</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="name" name="name" placeholder="必填" required>
					    </div>
					    <label for="lastname" class="col-sm-2 control-label">是否默认：</label>
					    <div class="col-sm-4">
					      <select name="isDefault" id="isDefault" 
                    		class="form-control " editable="false" required>
                    			<option value="">请选择</option>
			                	<option value="1">是</option>
			                	<option value="0">否</option>
			                </select>
					    </div>
					  </div>
					  <div class="form-group">
					   		 <label class="col-sm-2 control-label" >所在省：</label>
					   		 <div class="col-sm-4">
                				<input name="province" class=" form-control"  placeholder="必填" required>
                			 </div>
                			 <label class="col-sm-2 control-label" >所在市：</label>
					   		 <div class="col-sm-4">
                				<input name="city" class="form-control"  placeholder="必填" required>
                			 </div>
					  </div>
					  <div class="form-group">
					    <label for="lastname" class="col-sm-2 control-label">地址：</label>
					    <div class="col-sm-10">
					      <input type="text" class="form-control"  name="address" placeholder="必填" required>
					    </div>
					  </div>
				</form>                
    </div>
</body>
</html>
