<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="css/style2.0.css">
	<link rel="shortcut icon" href="media/image/favicon.ico" />
	<style type="text/css">
	ul li{font-size: 30px;color:#2ec0f6;}
	.tyg-div{z-index:-1000;float:left;position:absolute;left:5%;top:20%;}
	.tyg-p{
		font-size: 14px;
	    font-family: 'microsoft yahei';
	    position: absolute;
	    top: 135px;
	    left: 60px;
	}
	.tyg-div-denglv{
		z-index:1000;float:right;position:absolute;right:3%;top:10%;
	}
	.tyg-div-form{
		background-color: #23305a;
		width:300px;
		height:auto;
		margin:120px auto 0 auto;
		color:#2ec0f6;
	}
	.tyg-div-form form {padding:10px;}
	.tyg-div-form form input[type="text"]{
		width: 270px;
	    height: 30px;
	    margin: 25px 10px 0px 0px;
	}
	.tyg-div-form form input[type="password"]{
		width: 270px;
	    height: 30px;
	    margin: 25px 10px 0px 0px;
	}
	.tyg-div-form form button {
	    cursor: pointer;
	    width: 270px;
	    height: 44px;
	    margin-top: 25px;
	    padding: 0;
	    background: #2ec0f6;
	    -moz-border-radius: 6px;
	    -webkit-border-radius: 6px;
	    border-radius: 6px;
	    border: 1px solid #2ec0f6;
	    -moz-box-shadow:
	        0 15px 30px 0 rgba(255,255,255,.25) inset,
	        0 2px 7px 0 rgba(0,0,0,.2);
	    -webkit-box-shadow:
	        0 15px 30px 0 rgba(255,255,255,.25) inset,
	        0 2px 7px 0 rgba(0,0,0,.2);
	    box-shadow:
	        0 15px 30px 0 rgba(255,255,255,.25) inset,
	        0 2px 7px 0 rgba(0,0,0,.2);
	    font-family: 'PT Sans', Helvetica, Arial, sans-serif;
	    font-size: 14px;
	    font-weight: 700;
	    color: #fff;
	    text-shadow: 0 1px 2px rgba(0,0,0,.1);
	    -o-transition: all .2s;
	    -moz-transition: all .2s;
	    -webkit-transition: all .2s;
	    -ms-transition: all .2s;
}
</style>
  </head>
  
  <body>
    <div class="tyg-div">
	<ul>
    	<li>让</li>
    	<li><div style="margin-left:20px;">采</div></li>
    	<li><div style="margin-left:40px;">购</div></li>
    	<li><div style="margin-left:60px;">更</div></li>
    	<li><div style="margin-left:80px;">轻</div></li>
    	<li><div style="margin-left:100px;">松</div></li>
    	<li><div style="margin-left:120px;">更</div></li>
    	<li><div style="margin-left:140px;">放</div></li>
    	<li><div style="margin-left:160px;">心</div></li>
    </ul>
</div> 
<div id="contPar" class="contPar">
	<div id="page1"  style="z-index:1;">
		<div class="title0">众联集中采购平台</div>
		<div class="title1"><!-- 旅游、交通、气象、公共安全、大数据 --></div>
		<div class="imgGroug">
			<ul>
				<img alt="" class="img0 png" src="<%=basePath%>/img/page1_0.png">
				<img alt="" class="img1 png" src="<%=basePath%>/img/page1_1.png">
				<img alt="" class="img2 png" src="<%=basePath%>/img/page1_2.png">
			</ul>
		</div>
		<img alt="" class="img3 png" src="img/page1_3.jpg">
	</div>
</div>
<div class="tyg-div-denglv">
	<div class="tyg-div-form">
		<form action="" id="log_form">
			<h2>登录</h2><p class="tyg-p">欢迎访问  </p>
			<div style="margin:5px 0px;">
				<input type="text" name="userName" placeholder="请输入账号..."/>
			</div>
			<div style="margin:5px 0px;">
				<input type="password" name="userPwd" placeholder="请输入密码..."/>
			</div>
			<button type="button" onclick="submitForm()"  class="log_btn">登<span style="width:20px;"></span>录</button>
			<div style="margin:15px 0px;">
				 <a href="register.jsp" style="color: white;padding: 5px">企业注册</a>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/com.js"></script>
<script>
	function submitForm(){
		$.ajax({ 
	    	url: '${pageContext.request.contextPath}/userAction!login.action',
	    	data : $('#log_form').serialize(),
	    	dataType : 'json',
	    	success : function  test(obj){
	    		if(obj.success){
					location.replace('<%=path%>' + '/index.jsp');
				}else{
					alert(obj.msg);
				}
	    	}
	    });
	}
	
	$(function(){
	$("#log_form").keydown(function(e){
		 var e = e || event,
		 keycode = e.which || e.keyCode;
		 if (keycode==13) {
		 $(".log_btn").trigger("click");
		 }
	});
	});
</script>
  </body>
</html>
