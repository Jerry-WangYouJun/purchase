<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户/供应商管理</title>
</head>
<body id="a2">
	<div >
			<div >
				  <div class="panel-body" id="a3" style="display:block">
				  	    <table id="infoTable"> </table>
					<div id="toolbar" class="btn-group">  
			            <button id="btn_edit" type="button" class="btn btn-default" onclick="updateData('company')">  
			                <span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span>修改  
			            </button>  
			            <button id="btn_delete" type="button" class="btn btn-default" onclick="deleteDataAll('company')">  
			                <span class="glyphicon glyphicon-remove" aria-hidden="true" ></span>删除  
			            </button>  
			            <button id="btn_delete" type="button" class="btn btn-default" onclick="addInfo('company')">  
			            	<span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>新增
			            </button>
			        </div>  
				  </div>
			</div>
		</div>
		
	<div class="modal fade" id="myModal" tabindex="-2" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" >
			<div class="modal-content" style="width: 800px">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">代理商管理</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form"  style="padding: 20px" id="dataForm">
						<input type="hidden"  name="id" >
					  <div class="form-group">
					    <label for="firstname" class="col-sm-2 control-label">公司名称：</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="name" name="name" placeholder="必填" required>
					    </div>
					    <label for="lastname" class="col-sm-2 control-label">企业类型：</label>
					    <div class="col-sm-4">
					      <select name="roleId" id="roleId" 
                    		class="form-control select2 easyui-combobox" editable="false" required>
                    			<option value="">请选择</option>
			                	<option value="2">供货商</option>
			                	<option value="3">客户</option>
			                </select>
					    </div>
					  </div>
					  <div class="form-group">
					   		 <label class="col-sm-2 control-label" >登录账号：</label>
					   		 <div class="col-sm-4">
                				<input name="userName" class=" form-control"  placeholder="必填" required>
                			 </div>
                			 <label class="col-sm-2 control-label" >联系人：</label>
					   		 <div class="col-sm-4">
                				<input name="contacts" class="form-control"  placeholder="必填" required>
                			 </div>
					  </div>
					  <div class="form-group">
					    <label for="firstname" class="col-sm-2 control-label">主营业务：</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control"  name="business" placeholder="必填" required>
					    </div>
					    <label for="lastname" class="col-sm-2 control-label">企业星级：</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control"  name="level" >
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="firstname" class="col-sm-2 control-label">联系电话：</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" name="telphone" placeholder="必填" required>
					    </div>
					    <label for="lastname" class="col-sm-2 control-label">税号：</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control"  name="tax" placeholder="必填" required>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="firstname" class="col-sm-2 control-label">银行账号：</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="name" name="card" placeholder="必填" required>
					    </div>
					    <label for="lastname" class="col-sm-2 control-label">地址：</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control"  name="address" placeholder="必填" required>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="lastname" class="col-sm-2 control-label">备注：</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control"  name="remark">
					    </div>
					  </div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="subInfoAll('company')">提交更改</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
<script type="text/javascript">
			
		$(function(){
			    $('#infoTable').bootstrapTable({  
			        url : '${basePath}/companyAction!loadAll.action', // 请求后台的URL（*）            
			        method : 'get', // 请求方式（*）  
			        toolbar : '#toolbar', // 工具按钮用哪个容器  
			        cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）  
			        sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）  
			        pagination : true, // 是否显示分页（*）  
			        pagePosition:'top',
			        pageNumber: 1,    //如果设置了分页，首页页码  
			        pageSize: 50,                       //每页的记录行数（*）  
			        pageList: [100,300,600],        //可供选择的每页的行数（*）  
			        queryParamsType:'',
			        singleSelect    : true,   
			        showRefresh : true, // 是否显示刷新按钮  
			        clickToSelect : true, // 是否启用点击选中行  
			        showToggle : false, // 是否显示详细视图和列表视图的切换按钮  
			        search:false,   //是否启用搜索框 
			        
			        columns : [ {  
			            checkbox : true 
			        },{  
			            field : 'id', visible: false 
			        },
			        {field:'name',title:'公司名称',width:100,align:'center', valign: 'middle'  },
					{field:'contacts',title:'联系人',width:100,align:'center'},
					{field:'address',title:'地址',width:150,align:'center'},
					{field:'business',title:'主营业务',width:150,align:'center'},
					{field:'level',title:'企业星级',width:150,align:'center'},
					{field:'telphone',title:'联系电话',width:150,align:'center'},
					{field:'tax',title:'税号',width:150,align:'center'},
					{field:'card',title:'银行账号',width:150,align:'center'},
					{field:'remark',title:'备注',width:100,align:'center'}
			        ],  
			        silent : true, // 刷新事件必须设置  
			    });  
		});
		
		
	</script>
</html>