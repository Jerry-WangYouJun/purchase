<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/common.jsp"></jsp:include>
<title>Insert title here</title>
<script type="text/javascript">
        	 function checkPwd(){
        		   $.ajax({
        				url: '${pageContext.request.contextPath}/userAction!login.action',
	        		    	data : $('#user_form').serialize(),
	        		    	dataType : 'json',
	        		    	success : function(obj){
	        		    		if(obj.success){
	        		    			updatePwd();
	        		    		}else{	
	        		    			alert("密码错误,请确认！");
	        				}
	        		    	}
        		   });
        	 }
        	 
        	 function updatePwd(){
        		  $.ajax({
        			  url: '${pageContext.request.contextPath}/userAction!updatePwd.action',
      		    	data : $('#user_form').serialize(),
      		    	dataType : 'json',
      		    	success : function(obj){
      		    		if(obj.success){
      						alert(obj.msg);
      					}else{
      						alert(obj.msg);
      					}
      		    	}
        		  });
        	 }
</script>
</head>
<body>
     <div  id="user_dlg"  style="width:400px;height: 200px">
	    	<form id="user_form" role="form" style="padding: 20px">
	   	 	<div class="form-group col-md-12">
	            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 35%">旧密码：</label>
	               <input name="userName" type="hidden" value = "${userName}">
	                <input name="userPwd" id="oldpwd"  type="password" class="form-control"  style="display: inline-block;width: 70%">
	        </div>
	    		<div class="form-group col-md-12">
	            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 35%">新密码：</label>
	                <input name="newPwd" id="newpwd" type="password" class="form-control"  style="display: inline-block;width: 70%">
	        </div>
	        <div class="form-group col-md-12">
	            	<label class="col-md-4" style="display: inline-block;height: 34px;line-height: 34px;text-align: left;width: 35%">确认密码：</label>
	                <input name="confirmpwd" type="password" id="confirmpwd" class="form-control" style="display: inline-block;width: 70%">
	        </div>
	        <div class="form-group col-md-12">
		        <button id="user_save"  onclick="checkPwd()" type="button" class="btn btn-primary btn-dialog-left">修改密码</button>
			</div>
	    	</form>                 
    </div>
</body>
</html>