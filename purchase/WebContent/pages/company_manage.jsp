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
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
     <!-- Morris Chart Styles-->
     <!-- Custom Styles-->
    <link href="assets/css/style.css" rel="stylesheet" />
     <!-- main Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
     <!-- TABLE STYLES-->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
        <script src="assets/js/jquery-1.10.2.js"></script>
      <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
     <!-- DATA TABLE SCRIPTS -->
    <script src="assets/js/public.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
        <script>

        </script>
         <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>
  </head>
  
  <body >
                 <!-- /. ROW  -->
               
            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-black">
                        <div class="panel-heading heading-color font20">
                             企业信息管理
                        </div>
                        <div class="panel-body">
                            <div class="panel-search"><span>公司名称:</span><input class="btn btn-default btn-sm"><span>企业类型：</span><input class="btn btn-default btn-sm"><button class="btn-pri">查询</button></div>
                            <div class="table-responsive">
                                <div class="table-edit">
                                    <a href="#"><i class="fa fa-edit"></i> <span data-toggle="modal" data-target="#myModal-2">编辑</span></a>
                                    <a data-toggle="modal" data-target="#myModal-4" href="#"><i class="fa fa-times"></i> <span>删除</span></a>
                                </div>
                                <table class="table table-striped " id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>公司名称</th>
                                            <th>品牌</th>
                                            <th>联系人</th>
                                            <th>地址</th>
                                            <th>主营业务</th>
                                            <th>企业星级</th>
                                            <th>联系电话</th>
                                            <th>税号</th>
                                            <th>银行账号</th>
                                            <th>备注</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>
                                        <tr class=" gradeX">
                                            <td>大手海恩</td>
                                            <td>汉兴切割</td>
                                            <td>李先生</td>
                                            <td class="center">山东省青岛市市北区</td>
                                            <td class="center">切割电气焊1</td>
                                            <td>5星</td>
                                            <td>13656568989</td>
                                            <td>65464564545455</td>
                                            <td>15654564564564561</td>
                                            <td>暂无</td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    <!--End Advanced Tables -->
                </div>
            </div>
	
    <script type="text/javascript">
    function query(){
	    	$('#company_table').datagrid('load', {
	    	    name: $("#cname").val(),
	    	    brand: $("#brand").val(),
	    	    business:$("#business").val(),
	    	    address:$("#address").val()
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
							url : '${pageContext.request.contextPath}/companyAction!edit.action',
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
							url : '${pageContext.request.contextPath}/companyAction!edit.action',
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
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">企业类型：</label>
                <select name="roleId" id="roleId"  
                    		class="form-control select2 easyui-combobox" style="width: 45%;height: 86%" editable="false">
                	<option value="2">供货商</option>
                	<option value="3">客户</option>
                </select>
            </div>
            <div class="form-group col-md-6 brand">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">品牌：</label>
                <input name="brand" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
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
            <div class="form-group col-md-6  business" style="margin-bottom:0px;">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">主营业务：</label>
                <input name="business" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6 business" style="margin-bottom:0px;">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 30%">企业星级：</label>
                <select name = "level"  class=" form-control" style="display: inline-block;width: 45%" >
                	 <option >一星</option>
                	 <option >二星</option>
                	 <option >三星</option>
                	 <option >四星</option>
                	 <option >五星</option>
                </select>
            </div>
            	<label class="col-md-12 brand" style="color:red;display: inline-block;text-align: left;margin-bottom: 15px;margin-left: 15px;">注意：请填写主要生产产品，便于平台进行推荐</label>
            
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
