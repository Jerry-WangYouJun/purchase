<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
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
<link href="media/css/jqvmap.css" rel="stylesheet" type="text/css"
	media="screen" />
<link href="media/css/jquery.easy-pie-chart.css" rel="stylesheet"
	type="text/css" media="screen" />
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
<script src="media/js/jquery.easy-pie-chart.js" type="text/javascript"></script>
<script src="media/js/jquery.sparkline.min.js" type="text/javascript"></script>
<script src="media/js/app.js" type="text/javascript"></script>
<script src="media/js/index.js" type="text/javascript"></script>
<script>
	jQuery(document).ready(function() {
		App.init(); //  修改主题
		Index.initDashboardDaterange(); //主页时间
	});
	
	function openTab(url){
        document.getElementById("center-content").src = url;
      };
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
			<div class="brand" style="color:#eee;width:225px">众联焊割集中采购平台</div>
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
							src="media/image/avatar1_small.jpg" /> <span class="username">Bob
								Nilson</span> <i class="icon-angle-down"></i>
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
							<li><a href="login.html"><i class="icon-key"></i> Log
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

				<li class="start "><a href="index.html"> <i
						class="icon-home"></i> <span class="title">主页</span> <span
						class="selected"></span>
				</a></li>

				<li class=""><a href="javascript:;"> <i class="icon-cogs"></i>
						<span class="title">信息管理</span> <span class="arrow "></span>
				</a>
					<ul class="sub-menu">
						<li ><a href="#"  onclick="openTab('<%=path%>/pages/company_list.jsp')">
									客户 & 供应商 管理</a></li>
						<li><a href="#"  onclick="openTab('<%=path%>/pages/user_list.jsp')"> 
									用户管理</a></li>
						<li><a href="#"  onclick="openTab('<%=path%>/pages/confirm_manage.jsp')"> 
									采购日管理</a></li>
					</ul></li>

				<li class=""><a href="javascript:;"> <i class="icon-th"></i>
						<span class="title">订单管理</span> <span class="arrow "></span>
				</a>
					<ul class="sub-menu">
						<li><a href="#" onclick="openTab('<%=path%>/pages/order_manage.jsp')"> 客户订单管理</a></li>
						<li><a href="#" onclick="openTab('<%=path%>/pages/supplier_mange.jsp')"> 供应商管理</a></li>
					</ul></li>
				<li class="last"><a href="#" onclick="openTab('<%=path%>/pages/company_list.jsp')"> <i
						class="icon-bar-chart"></i> <span class="title">产品类别管理</span>
				</a></li>
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
								<label> <span>Layout</span> <select
									class="layout-option m-wrap small">
										<option value="fluid" selected>Fluid</option>
										<option value="boxed">Boxed</option>
								</select>
								</label> <label> <span>Header</span> <select
									class="header-option m-wrap small">
										<option value="fixed" selected>Fixed</option>
										<option value="default">Default</option>
								</select>
								</label> <label> <span>Sidebar</span> <select
									class="sidebar-option m-wrap small">
										<option value="fixed">Fixed</option>
										<option value="default" selected>Default</option>
								</select>
								</label> <label> <span>Footer</span> <select
									class="footer-option m-wrap small">
										<option value="fixed">Fixed</option>
										<option value="default" selected>Default</option>
								</select>
								</label>
							</div>
						</div>
						<!-- END BEGIN STYLE CUSTOMIZER -->

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<ul class="breadcrumb" style="padding:15px 15px">
							<li><i class="icon-home"></i> <a href="index.html">Home</a>
								<i class="icon-angle-right"></i></li>
							<li><a href="#">Dashboard</a></li>
							<li class="pull-right no-text-shadow" style="padding-right: 50px">
								<div id="dashboard-report-range"
									class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive"
									data-tablet="" data-desktop="tooltips" data-placement="top"
									data-original-title="Change dashboard date range">
									<i class="icon-calendar"></i> <span></span> <i
										class="icon-angle-down"></i>
								</div>
							</li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
				<!-- END PAGE HEADER-->

				<!-- BEGIN 主面板 STATS -->
				<div id="dashboard">
	 					<div  id ="home" class="tab-content">
									
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
        function openTab(tabUrl ) {
            //option:
            //tabMainName:tab标签页所在的容器
            //tabName:当前tab的名称
            //tabTitle:当前tab的标题
            //tabUrl:当前tab所指向的URL地址
                var content = '';
                    content = '<iframe id="myframe" src="' + tabUrl + '" width="100%"  height="780px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                    $("#home").empty();
                    $("#home").append(content);
        }
        $(function(){
       	 	$("li a").click(function (e) {
   			   e.preventDefault();
   			   $(".active").removeClass("active");
   			   $(this).parent().addClass("active");
      		});
        });

      
	</script>
</body>
</html>