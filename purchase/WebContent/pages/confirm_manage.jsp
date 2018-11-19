<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>采购日管理</title>
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
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">采购管理</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 30px">
 		<table id="info_table" class="easyui-datagrid" fit="true" ></table>
 	</div>
	
	
	<div id="toolbar_info" style="padding:2px 5px;">
     	<a onclick="info_add()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-plus fa-fw" style="margin: 2px">新增</a>
        <a onclick="info_edit()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px">编辑</a>    
        <a onclick="info_delete()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-remove fa-fw" style="margin: 2px">删除</a>
    </div>
	
    <script type="text/javascript">
    	$(function(){
			$('#info_table').datagrid({
				url:'${pageContext.request.contextPath}/confirm!loadAll.action',
				pagination: true,
				pagePosition:'top',
				toolbar:'#toolbar_info',				
				fitColumns: true,
				striped:true,
				singleSelect: true,
				columns:[[
					{field:'confirmDate',title:'采购日期',width:100,align:'center'},
					{field:'remark',title:'备注',width:100,align:'center'}
				]],				
			});
		});
		function info_add(){
			$('#info_dlg').dialog('open');	
			$('#info_dlg').dialog('setTitle','添加采购日');
			$("#info_save").unbind('click').click(function(){
  				$.ajax({
					url : '${pageContext.request.contextPath}/confirm!add.action',
					data : $('#info_form').serialize(),
					dataType : 'json',
					success : function(obj) {
						if (obj.success) {
							alert(obj.msg);
							info_close();
						} else {
							alert(obj.msg);
						}
					}
				});
			});
		}
		function info_edit(){
			var row = $('#info_table').datagrid('getSelected');
    		if(row){
    			$('#info_dlg').dialog('open');	
    			$('#info_dlg').dialog('setTitle','编辑企业');
    			$('#info_form').form('load', row);
				$("#info_save").unbind('click').click(function(){
  					$.ajax({
						url : '${pageContext.request.contextPath}/confirm!update.action',
						data : $('#info_form').serialize(),
						dataType : 'json',
						success : function(obj) {
							if (obj.success) {
								alert(obj.msg);
								info_close();
							} else {
								alert(obj.msg);
							}
						}
					});
				});
			}
    	}
		function info_delete(){
			var row = $('#info_table').datagrid('getSelected');
    		if(row){
    			$.messager.confirm(
    				'提示',
    				'确定要删除么?',
    				function(r) {
    					if (r) {
    						$.ajax({ 
    			    			url: '${pageContext.request.contextPath}/confirm!delete.action',
    			    			data : {"id":row.id},
    			    			dataType : 'json',
    			    			success : function(obj){
    			    				if(obj.success){
    			    				 	alert(obj.msg);
    			    				 	$('#info_table').datagrid('reload');
    			    				}else{
    			    					alert(obj.msg);
    			    					$('#info_table').datagrid('reload');
    			    				}
    			    			}
    			    		});
    					}
    				});  		
    			}
		}
		function info_close(){
			$('#info_form').form('reset');
			$('#info_form').form('clear');
			$('#info_dlg').dialog('close');	
			$('#info_table').datagrid('reload');
		}
    </script>
    
    <div id="info_dlg_buttons" style="width:800px;height: 40px;text-align: center">
		<button id="info_save" type="button" class="btn btn-primary btn-dialog-left">保存</button>
		<button onclick="info_close()" type="button" class="btn btn-default btn-dialog-right">取消</button>
	</div>
	
	
	<div  id="info_dlg" closed="true" class="easyui-dialog" style="width:400px;height: 450px"
	data-options="border:'thin',cls:'c1',collapsible:false,modal:true,closable:false,top:10,buttons: '#info_dlg_buttons'">
    	<form id="info_form" role="form" style="padding: 20px">
    		<div class="form-group col-md-12">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">采购时间：</label>
                <input name="confirmDate" class=" form-control" style="display: inline-block;width: 70%"><span style="color:red">*为保证系统正常运行，请填写1-28的整数</span>
            </div>
            <div class="form-group col-md-12">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">备注：</label>
                <textarea name="remark" class=" form-control" rows="4" style="display: inline-block;width: 70%"></textarea>
            </div>
            <input id="id" name="id" style="display:none;"/> 
    	</form>                 
    </div>
</body>
</html>
