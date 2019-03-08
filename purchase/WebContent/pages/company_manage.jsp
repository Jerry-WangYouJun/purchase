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
    <script src="${basePath}/vendor/layer/layer.js"></script>
     <link href="${basePath}/assets/css/style.css" rel="stylesheet" />
<style type="text/css">
    .form-control {
        background-color: rgb(85, 85, 85);
   	 	color: rgb(255, 255, 255);    border-width: 0px;
   	 	
    }
    
    #_easyui_textbox_input1,#_easyui_textbox_input2{
    	    background-color: black;
    }
</style>
     
  </head>
  
  <body class="easyui-layout">
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<p style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">
 				<c:choose >
									<c:when test="${roleId eq '1' }">
										企业信息管理
									</c:when>
									<c:when test="${roleId eq '2' }">
										供应商 管理
									</c:when>
									<c:when test="${roleId eq '3' }">
										客户 管理
									</c:when>
							 </c:choose>
 		</p>
 	</div>
 	<div data-options="region:'center',border:false,showHeader:false" style="padding-bottom: 30px">
		  <c:if test="${roleId eq 1 }">
 			 <div >
            	查询条件
                <select name="queryCol" id="queryCol" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;background-color:black;" editable="false">
                    <option value="">-选择-</option>
	                	<option value="name">企业名称</option>
	                 <option value="brand">品牌</option>
	                	<!-- <option value="2">已报价</option> -->
	                	<option value="address">地址</option>
	                	<option value="business">主营业务</option>
	                	<option value="level">企业星级</option>
                </select>
              		  查询内容
                <input name="queryValue" id = "queryValue"class=" form-control" style="display: inline-block;width: 10%">
                
              	  查询条件
                <select name="queryCol" id="queryCol2" 
                    		class="form-control select2 easyui-combobox" style="width: 10%;" editable="false">
                    <option value="">-选择-</option>
	                	<option value="name">企业名称</option>
	                 <option value="brand">品牌</option>
	                	<!-- <option value="2">已报价</option> -->
	                	<option value="address">地址</option>
	                	<option value="business">主营业务</option>
	                	<option value="level">企业星级</option>
                </select>
              		  查询内容
                <input name="queryValue2" id = "queryValue2"class=" form-control" style="display: inline-block;width: 10%">
                <button onclick="query()" class="btn btn-default queryBtn" >查询</button>
            </div> 
		  </c:if>
 		<table id="company_table" class="easyui-datagrid" fit="true"  height="100%"></table>
 	</div>
	<div id="toolbar_company" style="padding:2px 5px;">
	<c:if test="${roleId eq 1 }">
     	<a onclick="company_add()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-plus fa-fw" style="margin: 2px">新增</a>
	</c:if>
        <a onclick="company_edit()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-edit fa-fw" style="margin: 2px">编辑</a>    
    <c:if test="${roleId eq 1 }">
        <a onclick="company_delete()" class="easyui-linkbutton"  plain="true" iconCls="fa fa-remove fa-fw" style="margin: 2px">删除</a>
    </c:if>
    <c:if test="${roleId ne 2 }">
        <a onclick="address_manager()" class="easyui-linkbutton"  plain="true"  style="margin: 2px">地址管理</a>
    </c:if>
    </div>
	
    <script type="text/javascript">
    function  address_manager(){
		var row = $('#company_table').datagrid('getSelected');
		var id = 0;
		
		if(row ){
			id = row.id
		}else {
			if("${roleId}" == '1'){
				layer.alert("请选择要修改的企业");
				return false ;
			}
		}
		layer.open({
				  type: 2,
				  title: '管理地址',
				  shadeClose: false,
				  shade: 0.8,
				  area: ['90%', '90%'],
				  content: '<%=path%>/companyAction!loadAddress.action?companyId='+ id 
			});
	}
    
    function query(){
	    	$('#company_table').datagrid('load', {
	    		colName: $("#queryCol").val(),
	    		colName2: $("#queryCol2").val(),
	    		colValue:$("#queryValue").val(),
	    		colValue2:$("#queryValue2").val()
	    	});
    }
    	$(function(){
    		var role = '${role}';
    		var flag = true;
    		if(role != '1'){
    			 flag = false;
    		}
			$('#company_table').datagrid({
				url:'${pageContext.request.contextPath}/companyAction!loadAll.action?roleId=' + role ,
				pagination: true,
				toolbar:'#toolbar_company',		
				pagePosition:'top',
				pageSize: 30,
				fitColumns: true,
				striped:true,
				singleSelect: true,
				columns:[[
					{field:'id',hidden:'true'},
					{field:'name',title:'公司名称',width:100,align:'center'},
					{field:'brand',title:'品牌',width:100,align:'center'},
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
			if(role == '3'){
				$('#company_table').datagrid('hideColumn', 'brand');
   			}
			if("${roleId}" != '1'){
				$('#company_table').datagrid({
					pagination: false,
				});
			}
		
		});
		function company_add(){
			$('#userName').attr("readOnly",false);
			$('#company_dlg').dialog('open');	
			$('#company_dlg').dialog('setTitle','添加企业');
			$("#company_save").unbind('click').click(function(){
				if($("#company_form").validate().form()){
		  				$.ajax({
							url : '${pageContext.request.contextPath}/companyAction!edit.action?roleId=${role}',
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
							url : '${pageContext.request.contextPath}/companyAction!edit.action?roleId=${role}',
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
		})
		
		function checkOnly(val){
		$.ajax({
			url : '${pageContext.request.contextPath}/userAction!checkUserOnly.action',
			data : $('#company_form').serialize(),
			dataType : 'json',
			success : function(obj) {
				if (!obj.success) {
					alert(obj.msg);
					$("#userName").val("");
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
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">公司名称：</label>
                <input name="name" class="form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <c:if test="${role == 1 }">
	            <div class="form-group col-md-6">
	            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">企业类型：</label>
	                <select name="roleId" id="roleId"  
	                    		class="form-control select2 easyui-combobox" style="width: 45%;height: 86%" editable="false">
	                	<option value="2">供货商</option>
	                	<option value="3">客户</option>
	                </select>
	            </div>
            </c:if>
	            <div class="form-group col-md-6">
	            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">企业类型：</label>
	                <select name="roleId" id="roleId"  
	                    		class="form-control select2 easyui-combobox" style="width: 45%;height: 86%" editable="false">
	            <c:if test="${role == 3 }">
	                	<option value="3">客户</option>
	            </c:if>
	             <c:if test="${role == 2 }">
	                	<option value="2">供应商</option>
	            </c:if>
	                </select>
	            </div>
            <c:if test="${role == 2 }">
            <div class="form-group col-md-6  business" style="margin-bottom:0px;">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">主营业务：</label>
                <input name="business" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6 brand">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">品牌：</label>
                <input name="brand" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            	<label class="col-md-12 brand" style="color:red;display: inline-block;text-align: left;margin-bottom: 15px;margin-left: 15px;">注意：请填写主要生产产品，便于平台进行推荐</label>
            </c:if>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">登录账号：</label>
                <input name="userName" id="userName" onchange="checkOnly(this.value)"  class="form-control" style="display: inline-block;width: 45%"
                 placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">联系人：</label>
                <input name="contacts" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">联系电话：</label>
                <input name="telphone" class=" form-control"  style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            
            <div class="form-group col-md-6 ">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">企业星级：</label>
                <select name = "level"  class=" form-control" style="display: inline-block;width: 45%" >
                	 <option >一星</option>
                	 <option >二星</option>
                	 <option >三星</option>
                	 <option >四星</option>
                	 <option >五星</option>
                </select>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">开户银行：</label>
                <input name="bank" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">银行账号：</label>
                <input name="card" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">税号：</label>
                <input name="tax" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
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
