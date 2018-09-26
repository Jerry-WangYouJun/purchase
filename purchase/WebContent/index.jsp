<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}" scope="request"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>众联焊割集中采购平台</title>
<link href="media/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
	<link href="media/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/bootstrap-responsive.min.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="media/css/style.css" rel="stylesheet" type="text/css" />
<link href="media/css/style-responsive.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/default.css" rel="stylesheet" type="text/css"
	id="style_color" />
<link href="media/css/uniform.default.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/jquery.gritter.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/daterangepicker.css" rel="stylesheet"
	type="text/css" />
<link href="media/css/fullcalendar.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="media/image/favicon.ico" />
<script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
<script src="media/js/jquery-migrate-1.2.1.min.js"
	type="text/javascript"></script>
<script src="media/js/jquery-ui-1.10.1.custom.min.js"
	type="text/javascript"></script>
<script src="media/js/bootstrap.min.js" type="text/javascript"></script>
<script src="media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>
<script src="media/js/jquery.cookie.min.js" type="text/javascript"></script>
<script src="media/js/jquery.uniform.min.js" type="text/javascript"></script>
<script src="media/js/jquery.flot.js" type="text/javascript"></script>
<script src="media/js/jquery.flot.resize.js" type="text/javascript"></script>
<script src="media/js/jquery.pulsate.min.js" type="text/javascript"></script>
<script src="media/js/date.js" type="text/javascript"></script>
<script src="media/js/daterangepicker.js" type="text/javascript"></script>
<script src="media/js/jquery.gritter.js" type="text/javascript"></script>
<script src="media/js/fullcalendar.min.js" type="text/javascript"></script>
<script src="media/js/jquery.sparkline.min.js" type="text/javascript"></script>
<script src="media/js/app.js" type="text/javascript"></script>
<script src="media/js/index.js" type="text/javascript"></script>


<link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />  
<script src="${pageContext.request.contextPath}/js/moment-with-locales.js"></script>  
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script> 
<script src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script> 
<script>
	
	$(function(){
		 if("${roleId}"  == ""){
			   alert("登录超时");
			   location.href="${pageContext.request.contextPath}/login.jsp";
		 }
		App.init(); //  修改主题
		//Index.initDashboardDaterange(); //主页时间
		
		$.ajax({ 
   			url: '${pageContext.request.contextPath}/userAction!checkConfirm.action',
   			dataType : 'json',
   			success : function(obj){
   					var myDate = new Date();
   					var curDay= myDate.getDate();
   					var now = new Date();
   			        var year = now.getFullYear();       //年
   			        var month = now.getMonth() + 1;     //月
   				if(obj.success && "${roleId}"  == "3"){
   					var nowDate = "下一个采购日" + CurentTime();
   							if(curDay > obj.obj.confirmDate){
   								month += 1 ;
   							}
   							if(month < 10 ){
   								 month = "0" + month ;
   							}
   							$('#dashboard-report-range span').html("当前日期："+ CurentTime() +formatDay(curDay) 
   									+"<br/>下一个采购日：" + year+"-" + month + "-"  + formatDay(obj.obj.confirmDate) ); 
   							//alert(nowDate + formatDay(obj.obj[i].confirmDate) + "请在采购日之前结清待支付订单,否则订单将进入下一个采购周期！" );
   						$('#dashboard-report-range').css("backgroundColor" ,"#e02222");
   					}else{
   						$('#dashboard-report-range span').html("当前日期:"+ CurentTime() + formatDay(curDay));
   						$('#dashboard-report-range').css("backgroundColor" ,"#aaa");
   					}
   			}
   		});
		
		$.ajax({ 
   			url: '${pageContext.request.contextPath}/userAction!findConfirm.action',
   			dataType : 'json',
   			success : function(obj){
   					 $("#confirm").text(obj.msg);
   			}
   		});
		
		$('#dashboard-report-range').show();
		
		
		$.ajax({ 
   			url: '${pageContext.request.contextPath}/productAction!countSituation.action',
   			dataType : 'json',
   			success : function(obj){
   				for(var o in obj){
   					if(obj[o].msg == 0 ){
   						$("#"+obj[o].key).removeClass("badge");
   						continue;
   					}else{
   					 $("#"+obj[o].key).text(obj[o].msg);
   					}
   					for(var index in obj[o].obj){
						  if( obj[o].obj[index])
						  $("#" + obj[o].key +"Msg").append('<li class="external" ><a href="#" > '
							+ obj[o].obj[index]
						    + '<i class="m-icon-swapright"></i></a></li>'); 
					 }
   				}
   			}
   		});
	});
	function formatDay(day){
		if(day < 10 ) {
			return day = "0" + day;
		}else{
			return day ;
		}
	}
	
	function CurentTime()
    { 
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var clock = year + "-";
        if(month < 10)
            clock += "0";
        clock += month + "-";
        return(clock); 
    }  
</script>
<style type="text/css">
	.container-fluid {
    padding-right: 0px;
     padding-left: 0px;
}
</style>
</head>
<body class="page-header-fixed">
	<div class="header navbar navbar-inverse navbar-fixed-top">
		<!-- BEGIN TOP NAVIGATION BAR -->
		<div class="navbar-inner">
			<div class="brand" style="color:#eee;width:225px;margin-left:5px">众联焊割集中采购平台</div>
			<div class="container-fluid" style="background-color:#fff;margin-left: 225px;">

				<!-- BEGIN RESPONSIVE MENU TOGGLER -->
				<a href="javascript:;" class="btn-navbar collapsed" 
					data-toggle="collapse" data-target=".nav-collapse"> <img
					src="media/image/menu-toggler.png" alt="" />
				</a>
				<!-- END RESPONSIVE MENU TOGGLER -->

				<!-- BEGIN 顶部提醒 MENU -->
				<ul class="nav pull-right">
					
					<!-- BEGIN NOTIFICATION DROPDOWN -->
					<li class="dropdown" id="header_notification_bar"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <i
							class="icon-warning-sign"></i> <span class="badge" id="first"> </span>
					</a>
						<ul class="dropdown-menu extended notification" id="firstMsg">
							
						</ul></li>
					<!-- END NOTIFICATION DROPDOWN -->

					<!-- BEGIN INBOX DROPDOWN -->
					<li class="dropdown" id="header_inbox_bar">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							 <i class="icon-envelope"></i> <span class="badge" id="second"></span>
						</a>
						<ul class="dropdown-menu extended inbox" id="secondMsg">
							
						 </ul>
					 </li>
					<!-- END INBOX DROPDOWN -->

					<!-- BEGIN TODO DROPDOWN -->
					<li class="dropdown" id="header_task_bar"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <i
							class="icon-tasks"></i> <span class="badge" id="third"></span>
					</a>
						<ul class="dropdown-menu extended tasks" id="thirdMsg">
						</ul></li>
					<!-- END TODO DROPDOWN -->
					<!-- BEGIN 修改订单金额 -->
					<c:if test="${roleId eq '1' }"></c:if>
					<li class="dropdown" ><a href="#" onclick="uploadModal()" class="dropdown-toggle"
						data-toggle="dropdown" style="padding-right:10px"> <i class="icon-yen"></i> <span class="username"  style="font-size: 20px">
							订单最低金额设置</span> 
						</a>
					</li>
					<!-- END 修改订单金额 -->
					<!-- BEGIN 用户登陆 DROPDOWN -->
					<li class="dropdown" ><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" style="padding-right:10px">  <span class="username"  style="font-size: 20px">
							${userName }</span> 
						</a>
					</li>
					<li class="dropdown" >
						<a href="#" style="padding-right:10px;font-size: 20px"  class="dropdown-toggle" onclick="logout()">退出</a>
					</li>
					<!-- END 用户登陆 DROPDOWN -->
				</ul>
				<!-- END 顶部提醒  MENU -->
			</div>
		</div>
		<!-- END TOP NAVIGATION BAR -->
	</div>
	<!-- END HEADER -->


	<!-- BEGIN CONTAINER -->
	<div class="page-container">
	
		<!-- BEGIN 左侧目录树 -->
		<div class="page-sidebar nav-collapse collapse">
			<!-- BEGIN SIDEBAR MENU -->
			<ul class="page-sidebar-menu">

					<li class="">
						<a href="javascript:;"> <i class="icon-cogs"></i>
							<span class="title">信息管理</span> <span class="arrow "></span>
						</a>
						<ul class="sub-menu">
							 <c:choose >
									<c:when test="${roleId eq '1' }">
										<li class="active-menu"><a href="#"  onclick="openTab('客户 &供应商管理','${basePath}/pages/company_manage.jsp')">
													客户&供应商管理</a>
										</li>
									</c:when>
									<c:when test="${roleId eq '2' }">
										<li class="active-menu"><a href="#"  onclick="openTab('供应商管理','${basePath}/pages/company_manage.jsp')">
													供应商管理</a>
										</li>
									</c:when>
									<c:when test="${roleId eq '3' }">
										<li class="active-menu"><a href="#"  onclick="openTab('客户管理','${basePath}/pages/company_manage.jsp')">
													客户管理</a>
										</li>
									</c:when>
							 </c:choose>
							<li class="active-menu"><a href="#"  onclick="openTab('密码管理','${basePath}/pages/user_manage.jsp')"> 
										密码管理</a>
							</li>
							<c:if test="${roleId eq '1' }">
								<li class="active-menu">
					                <a href="#"  class="active" onclick="openTab('产品类别管理','${basePath}/pages/product_manage.jsp')">
					                      产品类别管理</a>
					            </li>
								<li class="active-menu"><a href="#"  onclick="openTab('采购日管理','${basePath}/pages/confirm_manage.jsp')"> 
											采购日管理</a>
								</li>
								<li class="active-menu"><a href="#" onclick="openTab('价格设置','${basePath}/pages/price_manage.jsp')"> 
										<span class="title">价格设置</span></a>
								</li>
							</c:if>
						</ul>
					</li>
					<c:if test="${roleId ne 1 }">
						<li class="active-menu"><a href="#" onclick="openTab('产品类别管理','${basePath}/productAction!toProduceSelectTab.action')"> <i
								class="icon-bar-chart"></i> <span class="title">产品类别管理</span>
						</a></li>																 
					</c:if>
					<c:if test="${roleId eq 2 }">
						 <li class="last active-menu"><a href="#" onclick="openTab('价格设置','${basePath}/pages/price_manage.jsp')"> <i
								class="icon-bar-chart"></i> <span class="title">价格设置</span>
						</a></li>
					</c:if>
					<li class="">
							<a href="javascript:;"> <i class="icon-th"></i>
								<span class="title">订单管理</span> <span class="arrow "></span></a>
							<ul class="sub-menu">
								<c:if test="${roleId eq 1 }">
									<li class="active-menu"><a href="#" onclick="openTab('客户订单管理','${basePath}/pages/admin_order_manage.jsp')"> 快速下单</a></li>
									<li class="active-menu"><a href="#" onclick="openTab('加急订单管理','${basePath}/pages/urgent_manage.jsp')"> 加急订单管理</a></li>
									<li class="active-menu"><a href="#" onclick="openTab('物流信息管理','${basePath}/pages/transport_manage.jsp')"> 物流信息管理</a></li>
								</c:if>
								<c:if test="${roleId eq 3 }">
									<li class="active-menu"><a href="#" onclick="openTab('客户订单管理','${basePath}/pages/order_manage.jsp')">  快速下单</a></li>
									<li class="active-menu"><a href="#" onclick="openTab('加急订单管理','${basePath}/pages/urgent_manage.jsp')"> 加急订单管理</a></li>
								</c:if>
								<c:if test="${roleId ne 3 }">
									<li class="active-menu"><a href="#" onclick="openTab('供应商管理','${basePath}/pages/supplier_mange.jsp')"> 采购订单管理</a></li>
								</c:if>
							</ul>
					</li>
			</ul>
			<!-- END SIDEBAR MENU -->
		</div>
		<!-- END 左侧目录树 -->

		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<div id="portlet-config" class="modal hide">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button"></button>
					<h3>Widget Settings</h3>
				</div>
				<div class="modal-body">Widget settings form goes here</div>
			</div>
			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->
				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN STYLE CUSTOMIZER -->
						<div class="color-panel hidden-phone">
							<div class="color-mode-icons icon-color"></div>
							<div class="color-mode-icons icon-color-close"></div>
							<div class="color-mode">
								<p>THEME COLOR</p>
								<ul class="inline">
									<li class="color-black current color-default"
										data-style="default"></li>
									<li class="color-blue" data-style="blue"></li>
									<li class="color-brown" data-style="brown"></li>
									<li class="color-purple" data-style="purple"></li>
									<li class="color-grey" data-style="grey"></li>
									<li class="color-white color-light" data-style="light"></li>
								</ul>
							</div>
						</div>
						<!-- END BEGIN STYLE CUSTOMIZER -->
						<c:if test="${roleId eq 3}">
							<h3 class="page-title">
								&nbsp;&nbsp;每月采购日为<span id ="confirm"></span>请在采购日前全额支付，否则订单将延期到下一采购日进行采购 <br/>
								<span style="color:red">&nbsp;&nbsp; 对订单状态进行任何修改时，请确认无误再行操作。如有疑问，请拨打热线电话</span>
							</h3>
						</c:if>
						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<ul class="breadcrumb" style="padding:15px 15px">
							<li><i class="icon-home"></i> <a href="index.jsp">首页</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="#" id="panelName"></a></li>
							<li class="pull-right no-text-shadow" style="padding-right: 50px">
								<div id="dashboard-report-range"
									class="dashboard-date-range no-tooltip-on-touch-device responsive"
									data-tablet="" data-desktop="tooltips" data-placement="top"
									data-original-title="Change dashboard date range">
									<i class="icon-calendar"></i> <span></span> 
								</div>
							</li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
				<!-- END PAGE HEADER-->

				<!-- BEGIN 主面板 STATS -->
				<div id="dashboard">
	 					<div  id ="home" class="tab-content" style="margin-left: 20px">
									
						</div>
				</div>
				<!-- END 主面板 STATS -->
				
			</div>
			<!-- END PAGE CONTAINER-->

		</div>
		<!-- END PAGE -->
		<!-- END CONTAINER -->
			
		<!-- BEGIN FOOTER -->
		<div class="footer">
			<div class="footer-inner">
				2013 &copy; Metronic by keenthemes.Collect from 
			</div>
			<div class="footer-tools">
				<span class="go-top"> <i class="icon-angle-up"></i>
				</span>
			</div>
		</div>
		<!-- END FOOTER -->
	</div>
	 <script>
		/**
         * 增加标签页
         */
        function openTab(panelName ,tabUrl ) {
            //option:
            //tabMainName:tab标签页所在的容器
            //tabName:当前tab的名称
            //tabTitle:当前tab的标题
            //tabUrl:当前tab所指向的URL地址
                var content = '';
                    content = '<iframe id="myframe" src="' + tabUrl + '" width="100%"  height="780px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                   $("#panelName").text(panelName);
                    $("#home").empty();
                    $("#home").append(content);
        }
        $(function(){
       	 	$(".active-menu a").click(function (e) {
   			   e.preventDefault();
   			   $(".active").removeClass("active");
   			   $(this).parent().addClass("active");
      		});
        });

        function logout(){
        	$.ajax({ 
    			url: '${pageContext.request.contextPath}/userAction!logout.action',
    			dataType : 'json',
    			success : function(obj){
    				if(obj.success){
    					alert(obj.msg);
						location.replace('${basePath}/login.jsp');
					}else{
						alert(obj.msg);
					}
    			}
    		});
        }
        
        function uploadModal() {
     		$('#uploadModal').modal({backdrop: 'static'});
    			$("#uploadModal").modal("show");
    			
    		}
        
        function uploadPwd(){
     		var path = "${pageContext.request.contextPath}/orderAction!updateBase.action";
     		var base = $("#new").val();
     		if(base=='' ){
     			 alert("金额不能为空");
     			 return  false;
     		}
     		$.ajax({
				url : path,
				type : 'post',
				data: {'base': base} ,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						alert( data.msg);
						$("#uploadModal").modal("hide");
					} else {
						alert( data.msg);
					}
	
				},
				error : function(transport) {
					alert( "系统产生错误,请联系管理员!");
				}
			});
     	}
	</script>
	<div class="modal fade" id="uploadModal" tabindex="-2" role="dialog"
		aria-labelledby="uploadModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:400px; ">
			<div class="modal-content">
				<div class="modal-body">
					   	<form class="form-signin" role="form" method="POST"
						 id="mlbForm"
						action="${pageContext.request.contextPath}/uploadExcel/upload.do">
						<div class="form-group">
						    <label style="width: 70px" for="message-text" class="control-label">最低金额:</label>
						    <input    id="new" name="new"  value="${base}"/>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button"  class="btn btn-primary"  onclick="uploadPwd()">提交</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
</html>