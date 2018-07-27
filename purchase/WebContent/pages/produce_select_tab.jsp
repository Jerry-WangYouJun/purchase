<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <title>Bootstrap Vertical Tabs</title>
  <link rel="stylesheet" href="<%=path%>/vendor/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%=path %>/vendor/bootstrap/css/bootstrap.vertical-tabs.css">
  <link href="<%=path%>/vendor/easyui/themes/material/easyui.css" rel="stylesheet" type="text/css"> 
  <link href="<%=path%>/vendor/easyui/themes/icon.css" rel="stylesheet" type="text/css">
  <style>
    .ccc{
      width: 25%;
      float: left;
      line-height: 32px;
      font-size: 14px;
      text-indent: 1em;
    }
    .nav-tabs li a{
      line-height: 32px;
      font-size: 14px;
      text-indent: 1em;
    }
   
  </style>
</head>
<body>
	<div data-options="region:'north',border:false,showHeader:false"  style="height:80px" >
		<c:if test="${roleId eq  '3' }">
	 		<span style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">请在下面选择您要采购的商品明细<br/>点击产品名称，可查看下一级</span>
		</c:if>
		<c:if test="${roleId eq  '2' }">
	 		<span style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">产品类别选择</span>
		</c:if>
 		<button onclick="select_save()" id="select_save" type="button" class="btn btn-primary" style="float: right;text-align: center;margin-top: 10px;margin-right:10px">保存</button> 		
 		<button onclick="reset()" id="reset" type="button" class="btn btn-primary" style="float: right;text-align: center;margin-top: 10px;margin-right:10px">重置</button>
 	</div>
    <div class="row" style="min-height:600px;">
        <div>
          <hr/>
           <div class="col-xs-2"> 
          	<!-- required for floating -->
            <!-- Nav tabs -->
            <!-- 第一级 -->
            <ul class="nav nav-tabs tabs-left">
            	<s:iterator  id="product" status="st" value="#request.productList">            							
          				 <li class="" onclick="activeThird(this)">
			              	<a href="#sec_<s:property value="id"/>" data-toggle="tab">
			              		<input type="checkbox" id="first_check_<s:property value="#product.id"/>" class="aaa" data='<s:property value="#product.id"/>'> 
									<s:property value="#product.product"/>
								</input>
			              	</a>
			              </li>       			
         		 </s:iterator>
            </ul>
          </div>       
  			<!-- 第二级 -->
          <div class="col-xs-2">
            <!-- Tab panes -->
            <div class="tab-content">			            
            	 <s:iterator id="product" status='st' value='#request.productList'>           	 	
	            	 	 <div class="tab-pane clearfix" id="sec_<s:property value="id"/>">             
			                  <ul class="nav nav-tabs tabs-left ">
			                  	<s:iterator id="child" value="#product.children" status='in' >		                  		
					                  	<li class="secTab">
							              	<a href="#third_<s:property value="#child.id"/>" data-toggle="tab"> 
							              		<input type="checkbox" id='sec_check_<s:property value="#child.id"/>' data='<s:property value="#child.id"/>' class="aaa" data-parent='<s:property value='#child.parentId'/>'> 							              			
			                      						<s:property value="#child.product"/>							              											              
							              		</input>
							              	</a>
							             </li>				             	
			                  	</s:iterator>					              					             
			          		  </ul>
		             	 </div>	            	 	            	       	
            	</s:iterator>             	         
            </div>
          </div> 
  			<!-- 第三级 -->
  			<div class="col-xs-8">
            <!-- Tab panes -->
            <div class="tab-content">
            <s:iterator id="secProduct" value="#request.secProduct" status="st">       	              
		              <div class="tab-pane  clearfix" id="third_<s:property value="#secProduct.id"/>">            
		                 <p class="clearfix">
		                 	<s:iterator value="#secProduct.children" id='child'>
			                    <span class="ccc">
			                        <input type="checkbox" value="<s:property value="#child.productId"/>" id="third_check_<s:property value="#child.id"/>"data='<s:property value="#child.id"/>' data-parent='<s:property value="#child.productId"/>'>
			                        <label for="third_check_<s:property value="#child.id"/>" style="font-size:15">
			                        <a style="text-decoration:none">
			                        	<s:property value="#child.subProduct"/>/
			                        	<s:property value="#child.format"/>/
			                        	<s:property value="#child.material"/>
			                        </a></label>
			                    </span>	                   
		                    </s:iterator>
		                  </p>
		              </div>	                     
              </s:iterator>
            </div>
          </div>
          <div class="clearfix"></div>
  
        </div>
        </div>
   <script src="<%=path%>/vendor/jquery/jquery.min.js"></script>
   <script src="<%=path%>/vendor/bootstrap/js/bootstrap.js"></script>     
 <%--  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script> --%>
  <script>
    $('.aaa').click(function(event){
      event.stopPropagation()
    })
    
    //加载选择的商品
    $(function(){
    	$.post("<%=path%>/productAction!getUserSelectProductDetail.action",function(data){
    		var json = JSON.parse(data);   	
    		for (var i = 0; i < json.length; i++) {
				var obj = json[i];
				$("#third_check_"+obj).prop('checked',true);
				var parentId = $("#third_check_"+obj).attr("data-parent");
				 $("#sec_check_"+parentId).prop('checked',true);
				 var firstIndex  = $("#sec_check_"+parentId).attr("data-parent");
				 $("#first_check_"+firstIndex).prop('checked',true);
				
			} 
    	})
    	//一级类型选择 
    	$("[id^='first_check_']").change(function(){
    		var obj = $(this).attr("data");
    		var checkList ;
    		if($(this).prop("checked"))
    			{
    			 checkList = $("#sec_"+obj).find("input:checkbox").prop("checked",true);
    			}
    		else
    			{
    			 checkList = $("#sec_"+obj).find("input:checkbox").prop("checked",false);
    			
    			}
    		//全选第三级
			for (var i = 0; i < checkList.length; i++) {
				var check = checkList[i];
				var id = $(check).attr("data");
				if($(check).prop("checked"))
					{
						$("#third_"+id).find("input:checkbox").prop("checked",true);
					}
				else
					{
						$("#third_"+id).find("input:checkbox").prop("checked",false);
					}			
			}
    		
    	})
    	//二级类型 选择
    	$("[id^='sec_check_']").change(function(){
    		var obj = $(this).attr("data");
    		if($(this).prop("checked"))
			{
			 $("#third_"+obj).find("input:checkbox").prop("checked",true);
			 var parentId = $(this).attr("data-parent");
			 $("#first_check_"+parentId).prop('checked',true);
			}
			else
			{
			 $("#third_"+obj).find("input:checkbox").prop("checked",false);
			}
    		//判断当前的二级是否全部取消
    		var parentId = $(this).attr("data-parent");
    		if($("#sec_"+parentId).find("input:checked").length==0)
    			{
    				$("#first_check_"+parentId).prop('checked',false);
    			}
    		else if($("#sec_"+parentId).find("input:checked").length ==$("#sec_"+parentId).find("input:checkbox").length)
    			{
    				$("#first_check_"+parentId).prop('checked',true);
    			}
    	})	
    	
    	//三级类型 选择
    	$("[id^='third_check_']").change(function(){
    		if($(this).prop("checked"))
			{
			 var parentId = $(this).attr("data-parent");
			 $("#sec_check_"+parentId).prop('checked',true);
			 var firstIndex  = $("#sec_check_"+parentId).attr("data-parent");
			 $("#first_check_"+firstIndex).prop('checked',true);
			}
    		//判断是否应该取消二级选择
    		var parentId = $(this).attr("data-parent");
    		if($("#third_"+parentId).find("input:checked").length==0){
    				$("#sec_check_"+parentId).prop('checked',false);
    		}else if($("#third_"+parentId).find("input:checked").length ==$("#third_"+parentId).find("input:checkbox").length){
					$("#sec_check_"+parentId).prop('checked',true);
    		}
    		
    		 var firstIndex  = $("#sec_check_"+parentId).attr("data-parent");
			 $("#first_check_"+firstIndex).prop('checked',true);
			 if($("#sec_"+firstIndex).find("input:checked").length==0){
 				 $("#first_check_"+firstIndex).prop('checked',false);
 			 }else if($("#sec_"+firstIndex).find("input:checked").length ==$("#sec_"+firstIndex).find("input:checkbox").length){
				 $("#first_check_"+firstIndex).prop('checked',true);
 			 }
    	})
    	
    	
    	$("[id^='third_check_']").each(function(){
    		var parentId = $(this).attr("data-parent");
    		if($(this).prop("checked"))
			{
			 var parentId = $(this).attr("data-parent");
			 $("#sec_check_"+parentId).prop('checked',true);
			 var firstIndex  = $("#sec_check_"+parentId).attr("data-parent");
			 $("#first_check_"+firstIndex).prop('checked',true);
			}
    		//判断是否应该取消二级选择
    		var parentId = $(this).attr("data-parent");
    		if($("#third_"+parentId).find("input:checked").length==0){
    				$("#sec_check_"+parentId).prop('checked',false);
    		}else if($("#third_"+parentId).find("input:checked").length ==$("#third_"+parentId).find("input:checkbox").length){
					$("#sec_check_"+parentId).prop('checked',true);
    		}
    		
    		 var firstIndex  = $("#sec_check_"+parentId).attr("data-parent");
			 $("#first_check_"+firstIndex).prop('checked',true);
			 if($("#sec_"+firstIndex).find("input:checked").length==0){
 				 $("#first_check_"+firstIndex).prop('checked',false);
 			 }else if($("#sec_"+firstIndex).find("input:checked").length ==$("#sec_"+firstIndex).find("input:checkbox").length){
				 $("#first_check_"+firstIndex).prop('checked',true);
 			 }
    	})
    	
    	
    })
    
    
    //重置
    function reset()
    {
    	$('input[type="checkbox"]').prop('checked',false);
    }
    
    //保存
    function select_save(){
		var productlist="";	
		var list = $("[id^='third_check_']:checked");
		if(list.length==0)
			{
				alert("请选择一个产品");
				return ;
			}
		for (var i = 0; i < list.length; i++) {
			var obj = list[i];		
			productlist +=$(obj).attr("data")+',';
		}
		productlist = productlist.substr(0,productlist.length-1);
		//console.log(productlist);			
		$.ajax({ 
			url: '${pageContext.request.contextPath}/productAction!saveUserProduct.action',	
			data : {'productlist':productlist},		
			dataType : 'json',
			success : function(obj){
				if (obj.success) {
					alert(obj.msg);
					//refresh();
				} else {
					alert(obj.msg);
				}
			}
		});			
	}
    
     function activeThird(obj){
    	 if(!$(obj).hasClass("active")){
	    	 $(".col-xs-8  .tab-pane" ).removeClass("active");
	    	 $(".secTab").removeClass("active");
    	 }
     }
  </script>
</body>
</html>