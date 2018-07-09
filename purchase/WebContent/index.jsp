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
	jQuery(document).ready(function() {
		
		//
	});
	
	$(function(){
		 if("${roleId}"  == ""){
			   alert("登录超时");
			   location.href="${pageContext.request.contextPath}";
		 }
		App.init(); //  修改主题
		//Index.initDashboardDaterange(); //主页时间
		$.ajax({ 
   			url: '${pageContext.request.contextPath}/userAction!checkConfirm.action',
   			dataType : 'json',
   			success : function(obj){
   					var myDate = new Date();
   					var curDay= myDate.getDate();
					
   				if(obj.obj.length > 0 ){
   					var nowDate = "下一个采购日" + CurentTime();
   						for(var i  in obj.obj){ 
   							$('#dashboard-report-range span').html("当前日期："+ CurentTime() +formatDay(curDay) 
   									+"<br/>下一个采购日：" + CurentTime()  + formatDay(obj.obj[i].confirmDate) ); 
   							//alert(nowDate + formatDay(obj.obj[i].confirmDate) + "请在采购日之前结清待支付订单,否则订单将进入下一个采购周期！" );
   							break;
   						}
   						$('#dashboard-report-range').css("backgroundColor" ,"#e02222");
   					}else{
   						$('#dashboard-report-range span').html("当前日期:"+ CurentTime() + formatDay(curDay));
   						$('#dashboard-report-range').css("backgroundColor" ,"#aaa");
   					}
   			}
   		});
		
		$('#dashboard-report-range').show();
		
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
				<!-- BEGIN LOGO -->
				<a class="brand" href="index.html" style="color:#eee;"> </a>
				<!-- END LOGO -->

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
							class="icon-warning-sign"></i> <span class="badge">6</span>
					</a>
						<ul class="dropdown-menu extended notification">
							<li>
								<p>You have 14 new notifications</p>
							</li>
							<li><a href="#"> <span class="label label-success"><i
										class="icon-plus"></i></span> New user registered. <span class="time">Just
										now</span>
							</a></li>
						</ul></li>
					<!-- END NOTIFICATION DROPDOWN -->

					<!-- BEGIN INBOX DROPDOWN -->
					<li class="dropdown" id="header_inbox_bar">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							 <i class="icon-envelope"></i> <span class="badge">5</span>
						</a>
						<ul class="dropdown-menu extended inbox">
							<li>
								<p>You have 12 new messages</p>
							</li>
							<li><a href="inbox.html?a=view"> <span class="photo"><img
										src="media/image/avatar2.jpg" alt="" /></span> <span class="subject">
										<span class="from">Lisa Wong</span> <span class="time">Just
											Now</span>
								</span> <span class="message"> Vivamus sed auctor nibh congue
										nibh. auctor nibh auctor nibh... </span>

							</a></li>
						 </ul>
					 </li>
					<!-- END INBOX DROPDOWN -->

					<!-- BEGIN TODO DROPDOWN -->
					<li class="dropdown" id="header_task_bar"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <i
							class="icon-tasks"></i> <span class="badge">5</span>
					</a>
						<ul class="dropdown-menu extended tasks">
							<li>
								<p>You have 12 pending tasks</p>
							</li>
							<li><a href="#"> <span class="task"> <span
										class="desc">New release v1.2</span> <span class="percent">30%</span>
								</span> <span class="progress progress-success "> <span
										style="width: 30%;" class="bar"></span>
								</span>
							</a></li>
							<li class="external"><a href="#">See all tasks <i
									class="m-icon-swapright"></i></a></li>
						</ul></li>
					<!-- END TODO DROPDOWN -->

					<!-- BEGIN 用户登陆 DROPDOWN -->
					<li class="dropdown user"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> <img alt=""
							src="media/image/avatar1_small.jpg" /> <span class="username">
							${userName }</span> <i class="icon-angle-down"></i>
						</a>
						<ul class="dropdown-menu">
							<li><a href="extra_profile.html"><i class="icon-user"></i>
									My Profile</a></li>
							<li><a href="page_calendar.html"><i
									class="icon-calendar"></i> My Calendar</a></li>
							<li><a href="inbox.html"><i class="icon-envelope"></i>
									My Inbox(3)</a></li>
							<li><a href="#"><i class="icon-tasks"></i> My Tasks</a></li>
							<li class="divider"></li>
							<li><a href="#" onclick="logout()"><i class="icon-key"></i> Log
									Out</a></li>
						</ul></li>
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
							<li class="active-menu"><a href="#"  onclick="openTab('客户 &供应商管理','${basePath}/pages/company_manage.jsp')">
										客户 &供应商 管理</a>
							</li>
							<li class="active-menu"><a href="#"  onclick="openTab('用户管理','${basePath}/pages/user_manage.jsp')"> 
										用户管理</a>
							</li>
							<c:if test="${roleId eq '1' }">
								<li>
					                <a href="#"  class="active" onclick="openTab('产品类别管理','${basePath}/pages/product_manage.jsp')">
					                  <i class="fa fa-dashboard fa-fw"></i>产品类别管理</a>
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
						<li class=""><a href="javascript:;"> <i class="icon-th"></i>
								<span class="title">订单管理</span> <span class="arrow "></span>
						</a>
							<ul class="sub-menu">
								<c:if test="${roleId ne 2 }">
									<li class="active-menu"><a href="#" onclick="openTab('客户订单管理','${basePath}/pages/order_manage.jsp')"> 客户订单管理</a></li>
								</c:if>
								<c:if test="${roleId ne 3 }">
									<li class="active-menu"><a href="#" onclick="openTab('供应商管理','${basePath}/pages/supplier_mange.jsp')"> 供应商管理</a></li>
								</c:if>
							</ul></li>
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
								</label>
							</div>
						</div>
						<!-- END BEGIN STYLE CUSTOMIZER -->

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<ul class="breadcrumb" style="padding:15px 15px">
							<li><i class="icon-home"></i> <a href="index.html">Home</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="#" id="panelName">Dashboard</a></li>
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
	</script>
</body>
</html>