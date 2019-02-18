<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>企业信息注册</title>
<title>注册</title>

 <jsp:include page="/common.jsp"></jsp:include>
<link rel="shortcut icon" href="img/logo.jpg" />
<style type="text/css">
body {
	background: #191c2c !important;
}
</style>
<script type="text/javascript">
	 function toggleRole(role){
		 if(role == '2'){
			  $(".brand").show();
			  $(".business").css("margin-bottom" , "0px");
		 }else {
			 $(".brand").hide(); 
			 $(".business").css("margin-bottom" , "15px");
		 }
	 }
	$(function(){
		var role = $("#roleId").val();
		toggleRole(role);
		$("#company_form").validate();
		$('#roleId').combobox({
			onChange:function(n,o){
				toggleRole(n)
		    }
		});
		
		$("#company_save").click(function(){
			if($("#company_form").validate().form()){
	  				$.ajax({
						url : '${pageContext.request.contextPath}/companyAction!edit.action',
						data : $('#company_form').serialize(),
						dataType : 'json',
						success : function(obj) {
							if (obj.success) {
								alert(obj.msg);
								window.location.href="${basePath}/login.jsp";
							} else {
								alert(obj.msg);
							}
						}
					});
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
	
	function backToLogin(){
		var flag  ;
		flag=confirm("确认放弃？");
		if(flag){
			window.history.back();
		}
	}
	
	function user_add(){
		$('#user_dlg').dialog('open');	
		$('#user_dlg').dialog('setTitle','添加地址');
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
	
</script>
</head>

<body>
	<form class="form-horizontal" style="width: 800px; margin: 50px auto; padding:20px;background: #ffecec "
		  id ="company_form">
			 <input type="hidden" name="roleId" value="3">
		<fieldset>
			<legend>企业信息注册  <a href="##" class="btn btn-primary pull-right" onclick="backToLogin()">返回</a>
			</legend>
		</fieldset>

            <!-- <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">企业类型：</label>
                <select name="roleId" id="roleId"  
                    		class="form-control select2 easyui-combobox" style="width: 45%;height: 86%" editable="false">
                	<option value="2">供货商</option> 
                	<option value="3">客户</option>
                </select>
            </div> -->
			<div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">公司名称：</label>
                <input name="name" class="form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
             <div class="form-group col-md-6 brand">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">品牌：</label>
                <input name="brand" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">登录账号：</label>
                <input name="userName" id="userName" onchange="checkOnly(this.value)" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
			<div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">登录密码：</label>
                <input name="userPwd" type="password" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
			<div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">联系人：</label>
                <input name="contacts" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6 business"  style="margin-bottom:0px;">
            		<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">主营业务：</label>
                <input name="business" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            
            	<label class="col-md-12 brand" style="color:red;display: inline-block;text-align: left;margin-bottom: 15px;">注意：请填写主要生产产品，便于平台进行推荐</label>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">联系电话：</label>
                <input name="telphone" class=" form-control"  style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">税号：</label>
                <input name="tax" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">银行账号：</label>
                <input name="card" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">地址：</label>
                <textarea name="address" class=" form-control" style="display: inline-block;width: 45%" placeholder="必填" required></textarea>
            </div>
            <div class="form-group col-md-6">
            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: right;width: 30%">备注：</label>
                <textarea name="remark" class=" form-control" rows="2" style="display: inline-block;width: 45%"></textarea>
            </div>
            <input id="id" name="id" style="display:none;"/> 
			<div class="form-group">
				<div class="col-sm-8 col-sm-offset-2">
						<button id="company_save" type="button" class="btn btn-primary btn-block btn-lg" >保存</button>
				</div>
			</div>
	</form>
</body>


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
					    <label for="firstname" class="col-sm-2 control-label">地址描述：</label>
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
</html>