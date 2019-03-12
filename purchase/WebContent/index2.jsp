<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}" scope="request"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>众联集中采购平台</title>
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
     <!-- FontAwesome Styles-->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
     <!-- Morris Chart Styles-->
     <!-- Custom Styles-->
    <link href="assets/css/style.css" rel="stylesheet" />
     <!-- main Styles-->
    <link href="assets/css/custom-styles.css" rel="stylesheet" />
     <!-- TABLE STYLES-->
        <script src="assets/js/jquery-1.10.2.js"></script>
      <!-- Bootstrap Js -->
    <script src="assets/js/bootstrap.min.js"></script>
    <!-- Metis Menu Js -->
    <script src="assets/js/jquery.metisMenu.js"></script>
     <!-- DATA TABLE SCRIPTS -->
    <script src="assets/js/public.js"></script>
        <script>

        </script>
         <!-- Custom Js -->
    <script src="assets/js/custom-scripts.js"></script>


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
		//App.init(); //  修改主题
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
   						$('#dashboard-report-range').css("backgroundColor" ,"red");
   					}else{
   						$('#dashboard-report-range span').html("当前日期:"+ CurentTime() + formatDay(curDay));
   						$('#dashboard-report-range').css("backgroundColor" ,"#4a19c8");
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
        .outBox{width:1400px;height:40px;overflow: hidden;margin:0 auto;position:relative;border-radius:4px;margin-left:10px;padding-bottom: 10px}
        .ulPmd{width:600px;height:40px;position:absolute;left:0;top:0;margin-left:250px}
        .ulPmd li{width:auto;height:40px;float:left;list-style: none;margin-left:20px;line-height:8px;margin-left:250px}

#fontf{
	 font-family:'微软雅黑' !important

}
</style>
</head>
<body >
<div id="wrapper">
        <nav class="navbar navbar-default top-navbar top-navbar-fix" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">众联集中采购平台</a>
                <div class="navbar-brand-nav">
                    <ul>
                        <li class="on">首页菜单</li>
                        <li>内页菜单</li>
                        <li>用户菜单</li>
                    </ul>
                </div>
            </div>

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">

                        <i class="fa fa-exclamation-triangle fa-lg"><span class="badge" id="first"> </span></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts" id="firstMsg">

                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>

                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-envelope fa-lg"><span class="badge" id="second"></span></i><i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-messages" id="secondMsg">
                    </ul>
                    <!-- /.dropdown-messages -->
                </li>
					
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">

                        <i class="fa fa-list fa-lg"><span class="badge" id="third"></span></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-alerts" id="thirdMsg">
                    </ul>
                    <!-- /.dropdown-alerts -->
                </li>
                   <!-- /.dropdown -->
                   
                   <c:if test="${roleId eq '1' }">
		                <li class="dropdown">
		                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" onclick="uploadModal()" aria-expanded="false">
		
		                        <div data-toggle="modal" data-target="#myModal">
		                            <i class="fa fa-yen fa-lg"></i><span> 订金最低金额设置 </span><i class="fa fa-caret-down"></i>
		                        </div>
		
		                    </a>
		                    <!-- /.dropdown-alerts -->
		                </li>
		                <li class="dropdown">
		                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" onclick="transModal()" aria-expanded="false">
		
		                        <div data-toggle="modal" data-target="#myModal2">
		                            <i class="fa fa-yen fa-lg"></i><span>  运费设置 </span><i class="fa fa-caret-down"></i>
		                        </div>
		
		                    </a>
		                    <!-- /.dropdown-alerts -->
		                </li>
						
						<li class="dropdown" ><a href="#" onclick="transModal()" class="dropdown-toggle"
							data-toggle="dropdown" style="padding-right:10px"> <i class="icon-yen"></i> <span class="username"  style="font-size: 20px">
								运费</span> 
							</a>
						</li>
					</c:if>
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> ${userName }</a>
                        </li>
                        <!-- <li><a href="#"><i class="fa fa-gear fa-fw"></i> 设置</a>
                        </li> -->
                        <li class="divider"></li>
                        <li><a href="#" onclick="logout()"><i class="fa fa-sign-out fa-fw"></i> 登出</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
        </nav>
        <!--/. NAV TOP  -->

        <nav class="navbar-default navbar-side left-menu-bg" role="navigation">
                <div class="sidebar-collapse">
                    <ul class="nav main-menu" id="main-menu">
                        <li>
                            <a href="#"><i class="fa fa-list font18"></i><span>信息管理</span><span class="fa arrow font18"></span></a>
                            <ul class="nav nav-second-level">
                            		<c:choose >
									<c:when test="${roleId eq '1' }">
										<li class=""><a href="#"  onclick="openTab('客户管理','${basePath}/companyAction!loadCustomer.action?role=3')">
													客户</a>
													
										</li>
										<li class=""><a href="#"  onclick="openTab('供应商管理','${basePath}/companyAction!loadCustomer.action?role=2')">
													供应商管理</a>
													
										</li>
										<li class=""><a href="#" onclick="openTab('公告管理','${basePath}/pages/notice_manage.jsp')"> 公告管理</a></li>
									</c:when>
									<c:when test="${roleId eq '2' }">
										<li class=""><a href="#"  onclick="openTab('供应商管理','${basePath}/companyAction!loadCustomer.action?role=2')">
													供应商管理</a>
										</li>
									</c:when>
									<c:when test="${roleId eq '3' }">
										<li class=""><a href="#"  onclick="openTab('客户管理','${basePath}/companyAction!loadCustomer.action?role=3')">
													客户管理</a>
										</li>
									</c:when>
							 </c:choose>
							 <li class=""><a href="#"  onclick="openTab('密码管理','${basePath}/pages/user_manage.jsp')"> 
										密码管理</a>
							</li>
							<c:if test="${roleId eq '1' }">
								<li class="">
					                <a href="#"  class="active" onclick="openTab('产品类别管理','${basePath}/pages/product_manage.jsp')">
					                      产品类别管理</a>
					            </li>
								<li class=""><a href="#"  onclick="openTab('采购日管理','${basePath}/pages/confirm_manage.jsp')"> 
											采购日管理</a>
								</li>
								<li class=""><a href="#" onclick="openTab('价格设置','${basePath}/pages/price_manage.jsp')"> 
										<span class="title">价格设置</span></a>
								</li>
							</c:if>
                            </ul>
                        </li>
                        <c:if test="${roleId ne 1 }">
						<li class=""><a href="#" onclick="openTab('产品类别管理','${basePath}/productAction!toProduceSelectTab.action')"> <i
								class="icon-bar-chart"></i> <span class="title">产品类别管理</span>
						</a></li>	
					</c:if>
					<c:if test="${roleId eq 2 }">
						 <li class="last "><a href="#" onclick="openTab('价格设置','${basePath}/pages/price_manage.jsp')"> <i
								class="icon-bar-chart"></i> <span class="title">价格设置</span>
						</a></li>
					</c:if>
					<c:if test="${roleId ne 2 }">
							<li class="last "><a href="#" onclick="openTab('色卡设置','${basePath}/pages/color_select.jsp')"> <i
								class="icon-bar-chart"></i> <span class="title">色卡管理</span>
						</a></li>
					</c:if>
					<li>
                            <a href="#"><i class="fa fa-paste font18"></i><span>订单管理</span><span class="fa arrow font18"></span></a>
                            <ul class="nav nav-second-level">
								<c:if test="${roleId eq 1 }">
									<li class=""><a href="#" onclick="openTab('客户订单管理','${basePath}/pages/admin_order_manage.jsp')"> 快速下单</a></li>
									<li class=""><a href="#" onclick="openTab('加急订单管理','${basePath}/pages/urgent_manage.jsp')"> 加急订单管理</a></li>
									<li class=""><a href="#" onclick="openTab('物流信息管理','${basePath}/pages/transport_manage.jsp')"> 物流信息管理</a></li>
								</c:if>
								<c:if test="${roleId eq 3 }">
									<li class=""><a href="#" onclick="openTab('客户订单管理','${basePath}/pages/order_manage.jsp')">  快速下单</a></li>
									<li class=""><a href="#" onclick="openTab('加急订单管理','${basePath}/pages/urgent_manage.jsp')"> 加急订单管理</a></li>
								</c:if>
								<c:if test="${roleId ne 3 }">
									<li class=""><a href="#" onclick="openTab('供应商管理','${basePath}/pages/supplier_mange.jsp')"> 采购订单管理</a></li>
								</c:if>
                            </ul>
                        </li>
					<c:if test="${roleId ne 1 }">
						<li class="last "><a href="#" onclick="contactUs()"> <i
								class="icon-bar-chart"></i> <span class="title">联系我们</span>
						</a></li>
						</c:if>
                    </ul>

            </div>
            <!--<div class="navbar-side-bg-b"></div>-->

        </nav>
        <!-- /. NAV SIDE  -->
        <div id="page-wrapper" class="page-wrapper bgh">
            <div id="page-inner">
			 <div class="row">
                    <div class="col-md-12">
                        
                            <script language="javascript" type="text/javascript">
						function contactUs(){
							 $("#home").empty();
							 $("#contact").show();
						}
					        $(function () {
					        	 $("#contact").hide();
					            var i=0;
					            var timer;
					            timer=setInterval(function(){
					                    //根据ul的位移来判断一秒钟向左移动的距离；
					                if(i>$('li').length){
					                    i=1;
					                    //如果所有li元素向左移动一遍完成，那滚动重新开始
					                }else{
					                    i+=1;
					                }
					                    //通过i的值来改变整体li元素的位置
					                var ulLeft=-($('li').width())*i;
					                $('.ulPmd').css('left',ulLeft)
					            },1000);
					                    //鼠标滑过li的时候，清除定时器
					            $('li').on('mouseover',function () {
					                clearInterval(timer)
					            });
					                    //鼠标滑出li的时候，继续定时器
					            $('li').on('mouseout',function () {
					            	 clearInterval(timer)
					                timer=setInterval(function() {
					                    //根据ul的位移来判断一秒钟向左移动的距离；
					                    if(i>$('li').length){
					                        i=1;
					                    }else{
					                        i+=1;
					                    }
					                    var ulLeft=-($('li').width())*i;
					                    $('.ulPmd').css('left',ulLeft)
					                },1000);
					            })
					        })
					    </script>
						<!-- END BEGIN STYLE CUSTOMIZER -->
						<c:if test="${roleId eq 3}">
						<div class="outBox">
						    <ul class="ulPmd" style="width:5000px">
						        <li> <h3><span id ="confirm" style="color:red;"></span></h3></li>
						    </ul>
						</div>
						</c:if>
                            <h1 class="page-header page-header-font">
                            首页<small><i class="fa fa-angle-right"></i><span id="manageName">客户管理</span></small>
                             <div class="page-header-right" id="dashboard-report-range">  <i class="fa fa-calendar"></i> <span></span></div>
                           
                        </h1>
                    </div>
                </div> 
                
                <div id = "contact" style= "margin:0px 20px;color: white;">
									  <h3 style="margin:2px">
									   对公账户：</h3>
									   <h3 style="margin:2px">
									    公司名称:青岛众联焊割五金制品有限公司</h3>
										<h3 style="margin:2px">开户银行:农行市北区郑州路支</h3>
									<h3 style="margin:2px">	账号:38080401040016852
										</h3>
										
										<h3 style="margin:2px">售后服务请扫下方二维码添加微信联系人：</h3>
										<img alt="" src="img/code.jpeg">
								</div>
                 <!-- /. ROW  -->
               <div id="dashboard">
	 					<div  id ="home" class="tab-content" style="margin-left: 20px">
									
						</div>
				</div>

        </div>
    </div>
             <!-- /. PAGE INNER  -->
    </div>

	

	<!-- BEGIN CONTAINER -->
	 <script>
		/**
         * 增加标签页
         */
        function openTab(panelName ,tabUrl ) {
        	$("#contact").hide();
            //option:
            //tabMainName:tab标签页所在的容器
            //tabName:当前tab的名称
            //tabTitle:当前tab的标题
            //tabUrl:当前tab所指向的URL地址
            
                var content = '';
                    content = '<iframe id="myframe" src="' + tabUrl + '" width="100%"  height="1450px"  frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes"></iframe>';
                   $("#panelName").text(panelName);
                    $("#home").empty();
                    $("#home").append(content);
                    $("#manageName").text(panelName);
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
        
        function transModal() {
     		$('#transModal').modal({backdrop: 'static'});
    			$("#transModal").modal("show");
    			
    		}
        
        function uploadtrans(){
        	var path = "${pageContext.request.contextPath}/orderAction!updateTrans.action";
     		var trans = $("#trans").val();
     		if(trans=='' ){
     			 alert("金额不能为空");
     			 return  false;
     		}
     		$.ajax({
				url : path,
				type : 'post',
				data: {'trans': trans} ,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						alert( data.msg);
						$("#transModal").modal("hide");
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
	
	<div class="modal fade" id="transModal" tabindex="-2" role="dialog"
		aria-labelledby="uploadModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:400px; ">
			<div class="modal-content">
				<div class="modal-body">
					   	<form class="form-signin" role="form" method="POST"
						 id="mlbForm"
						action="${pageContext.request.contextPath}/uploadExcel/upload.do">
						<div class="form-group">
						    <label style="width: 70px" for="message-text" class="control-label">运费金额:</label>
						    <input    id="trans" name="trans"  value="${trans}"/>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button"  class="btn btn-primary"  onclick="uploadtrans()">提交</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
</html>