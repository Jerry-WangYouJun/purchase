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
    <title>订单打印</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
   <jsp:include page="/common.jsp"></jsp:include>
   <script src="${basePath}/js/edit.js"></script>
   <script language="javascript" src="${basePath}/js/jquery.jqprint-0.3.js"></script>
    <style >
    .haokan ul{
    			height: 250px;
            margin-left: 350px;
        }
        
    </style>
  </head>
 <body class="easyui-layout" style="height: 120%">
		   <div class="easyui-layout"data-options="fit:true" id="order_dlg">
	            <div data-options="region:'center'">
			    		<div>
			    			<div style="position:relative;">
							<div style="position:absolute; z-index:2;  top:10px;">
			                		
						    </div>
							<div style="position:absolute; z-index:2; left:150px; top:5px;">
			                		<h4>青岛众联焊割五金制品有限公司</h4>
								税号:91370203MA3FF5FN5A &nbsp;采购网址：www.cglm2017.com<br/>
								账号:农行市北区郑州路支行38080401040016852<br/>
								地址：青岛市市北区镇平路1号-9 &nbsp;电话:18561852354<br/>
								<br/>
						    </div>
						    
						    　<img alt="" src="${basePath}/img/print_logo.jpg" style="width:100px;height:100px;margin-left: 10px "> 
						</div>
			    			 <div style="position:relative;">
								<div class="table_print" style="position:absolute; z-index:2; left:350px; top:10px;">
												
								</div>
			    			
			    			</div>
						<table  id="table_print"  class="table" style="width: 60%">
					    		 <tr>
					    		 	 <td id="">公司：<span>${companyName }</span></td>
					    		 	 <td id="">订单编号：<span>${orderNo }</span></td>
					    		 	 <td id="">订单总价：<span>${amount }</span></td>
					    		 	 <td id="">发票状态：<span id="invoice"></span></td>
					    		 </tr>
					    		 <tr>
					    		 	 <td id="">采购批次：<span>${confirm }</span></td>
					    		 	 <td id="">下单时间：<span>${startDate }</span></td>
					    		 	 <td id="" colspan="2">收货地址：<span>${address }</span></td>
					    		 </tr>
					    	</table>
				    	</div>
	                <table id="table_add" class="easyui-datagrid" fit="false" ></table>  
	               <div class="table_print" >
		                <div style="margin: 20px">
		                		
			                双方责权:<br/>
							1.双方在平等互利的情况下，依据《中国人民合同法》达成协议。<br/>
							2.供货方必须保证产品品牌、型号符合甲方要求。<br/>
							3.供货方在采购方付完货款后的一个采购周期内，送货至收货地点。<br/>
							4.采购方尽全力帮助供货方快速完成货物的装卸及清点。<br/>
							5.采购方验收货物合格后，收货人在送货单签字，供货方留底。<br/>
							6.此合同采购方付款时生效。<br/>
							7.供货方提供的产品按照厂家的质保细则进行包换包退。<br/>
							8.由于天灾、国家政策变更等不可抗拒因素所造成的违约，双方均不承担违约责任。<br/>
							9.未尽事宜双方协商解决。<br/>
		                
		                </div>
		                <div style="position:relative;">
							<div style="position:absolute; z-index:2;  top:10px;">
			                		<ul style="list-style:none; ">
						        			<li style=" padding-top: 10px">	  <h4 style="margin: 2px">供货方：青岛众联焊割五金制品有限公司</h4></li>
										<li style="margin: 0px">		<h4 style="margin: 2px">联系人：王涛</h4></li>
										<li style="margin: 0px">		<h4 style="margin: 2px">	联系电话：18561852354</h4></li>
										<li style="margin: 0px">		<h4 style="margin: 2px">签章：</h4></li>
								</ul>
						    </div>
							<div style="position:absolute; z-index:2; left:350px; top:10px;">
			                		<ul style="list-style:none; ">
						        			<li style=" padding-top: 10px">	  <h4 style="margin: 2px">	采购方：</h4></li>
										<li style="margin: 0px">		<h4 style="margin: 2px">联系人：</h4></li>
										<li style="margin: 0px">		<h4 style="margin: 2px">	联系电话：</h4></li>
										<li style="margin: 0px">		<h4 style="margin: 2px">签章：</h4></li>
								</ul>
						    </div>
						    
						    　<img alt="" src="${basePath}/img/sign.jpg" style="width:300px;height:250px;margin-left: 40px "> 
						</div>
	               </div>
	            </div>
	        </div>
	<div id="company_dlg_buttons" style="width:600px;height: 40px;text-align: center">
			<button onclick="company_close()" type="button" class="btn btn-default btn-dialog-right">关闭</button>
			 <!-- <button onclick="print()" type="button" class="btn btn-default btn-dialog-right">打印</button>  -->
	</div>
    <script type="text/javascript">
    	$(function(){
    		    		 $('#table_add').datagrid({
    		    		     url:'${pageContext.request.contextPath}/orderAction!searchDetail.action?id=${id}' ,
					fitColumns: true,
					singleSelect: true,
					collapsible:true,
					striped:true,
				    columns:[[
						{field:'defaultFlag',title:'托管采购',width:100 ,align:'center', formatter: function(value,row,index){
							if(value == '1'){
								return "托管";
							}else{
								return "不托管";
							}
						}
	                },
						{field:'product',title:'产品大类',width:100,align:'center'},
						{field:'type',title:'产品类型',width:100,align:'center'},
						{field:'sub_product',title:'产品信息',width:'25%',align:'center'},
						/* {field:'format',title:'产品规格',width:100,align:'center'},
						{field:'materail',title:'材质/标准',width:100,align:'center'}, */
						{field:'brand',title:'品牌',width:100,align:'center'},
						{field:'acount',title:'数量',width:100,align:'center'},
						{field:'unit',title:'单位',width:100,align:'center'},
						{field:'boxnum',title:'包装件数',width:100, hidden:'true',align:'center'},
						{field:'price',title:'单价',width:100,align:'center'},
						{field:'amount',title:'总价',width:100,align:'center'},
						/* {field:'sprice',title:'供应商报价',width:100,align:'center',editor:'textbox'}, */
						{field:'detailId', hidden:'true',editor:'textbox' },
						{field:'productId', hidden:'true',editor:'textbox' },
						{field:'address',hidden:'true'},
						{field:'base', hidden:'true',editor:'textbox' },
						{field:'remark',title:'备注',width:100,align:'center'},
						{field:'id', hidden:'true',editor:'textbox' }
					]]
			 })
			$("#invoice").text(getDicValue("invoice",'${invoice}' , null));
			 setTimeout( function(){
			 $("#order_dlg").jqprint({
				 debug: false,
				 importCSS: true,
				 printContainer: true,
				 operaSupport: false
			 });
			 },3000)
    	})
    </script>
</body>
</html>
