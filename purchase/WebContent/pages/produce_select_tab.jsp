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
   <script src="<%=path%>/vendor/jquery/jquery.min.js"></script>
   <script src="<%=path%>/vendor/bootstrap/js/bootstrap.js"></script>   
    <script src="<%=path%>/vendor/layer/layer.js"></script>  
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
<script type="text/javascript">
var index = layer.load(2, { shade:[0.3,'#fff'] , time:10000 });  //0代表加载的风格，支持0-2
</script>
	<div data-options="region:'north',border:false,showHeader:false"  style="height:80px" >
		<c:if test="${roleId eq  '3' }">
	 		<span style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">请在下面选择您要采购的商品明细<br/>点击产品名称，可查看下一级</span>
		</c:if>
		<c:if test="${roleId eq  '2' }">
	 		<span style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">产品类别选择</span>
	 		<button  id="imageFile" type="button" class="btn btn-primary" style="float: right;text-align: center;margin-top: 10px;margin-right:10px">上传产品图片</button>
		</c:if>
 		<button onclick="select_save()" id="select_save" type="button" class="btn btn-primary" style="float: right;text-align: center;margin-top: 10px;margin-right:10px">保存</button> 		
 		<button onclick="reset()" id="reset" type="button" class="btn btn-primary" style="float: right;text-align: center;margin-top: 10px;margin-right:10px">全不选</button>
 		<button onclick="selectAll()" id="reset" type="button" class="btn btn-primary" style="float: right;text-align: center;margin-top: 10px;margin-right:10px">全选</button>
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
			              	<a href="#sec_<s:property value="id"/>" data-toggle="tab" >
			              		<input type="checkbox" id="first_check_<s:property value="#product.id"/>" class="aaa" data='<s:property value="#product.id"/>'> 
									<s:property value="#product.product"/>
			              	</a>
			              </li>       			
         		 </s:iterator>
            </ul>
          </div>       
  			<!-- 第二级 -->
          <div class="col-xs-2">
            <!-- Tab panes -->
            <div class="tab-content" id="sec">			            
            	   <s:iterator id="product" status='st' value='#request.productList'>           	 	
	            	 	 <div class="tab-pane clearfix" id="sec_<s:property value="id"/>">             
			                  <ul class="nav nav-tabs tabs-left ">
			                  	<s:iterator id="child" value="#product.children" status='in' >		                  		
					                  	<li class="secTab">
							              	<a href="#third_<s:property value="#child.id"/>" data-toggle="tab" onclick="getImg(this)"> 
							              		<input type="checkbox" id='sec_check_<s:property value="#child.id"/>' data='<s:property value="#child.id"/>' class="aaa" data-parent='<s:property value='#child.parentId'/>'> 							              			
			                      						<s:property value="#child.product"/>							              											              
							              		
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
            <div class="tab-content" id="third">
            <%-- <s:iterator id="secProduct" value="#request.secProduct" status="st">       	              
		              <div class="tab-pane  clearfix" id="third_<s:property value="#secProduct.id"/>">            
		                 <p class="clearfix">
		                 	<s:iterator value="#secProduct.children" id='child'>
			                    <span class="ccc">
			                        <input type="checkbox" value="<s:property value="#child.productId"/>" id="third_check_<s:property value="#child.id"/>"data='<s:property value="#child.id"/>' data-parent='<s:property value="#child.productId"/>'>
			                        <label for="third_check_<s:property value="#child.id"/>" style="font-size:15">
			                        <a style="text-decoration:none">
			                        	<s:property value="#child.subProduct"/>-
			                        	<s:property value="#child.formatNum"/>
			                        	<s:property value="#child.format"/>-
			                        	<s:property value="#child.material"/>
			                        </a></label>
			                    </span>	                   
		                    </s:iterator>
		                  </p>
			              <div><img alt="" src="" id="img_<s:property value="#secProduct.id"/>" class="col-md-8"></div>                     
		              </div>
              </s:iterator> --%>
            </div>
          </div>
          <div class="clearfix"></div>
  
        </div>
        </div>
 <%--  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script> --%>
  <script>
  function getImg(obj){
	   var id = $(obj).children(":checkbox").attr("data") ;
	   var checked =  $(obj).children(":checkbox").is(":checked") ;
	  if(checked){
		   var imgUrl = $("#img_" + id ).attr("src");
		   if(imgUrl == ''){
			   var first = $("#first_check_" + $(obj).children(":checkbox").attr("data-parent") ).parent().text().replace(/<p>/g,"");
			   $.ajax({
				   url:"${pageContext.request.contextPath}/productAction!getImgInfoByproductId.action?proId=" + id,
				   type:"get",
				   dataType:"json",
				   success:function(data){
					   $("#img_"+ id).attr('src', "/ring/upload/"+data[0][0]+"/"+data[0][1]+"/"+ data[0][2] +".jpg");
				   }
			   })
		   }
	  }
	  
	 // getThird(id);
  }
  $("#imageFile").click(function(){
	    var proId = $("li.active :input")[1].getAttribute("data");
		layer.open({
			  type: 2,
			  title: '导入',
			  shadeClose: true,
			  shade: 0.8,
			  area: ['450px', '40%'],
			  content: '<%=path%>/report!importInit.action?proId=' + proId //iframe的url
		});
	});
  	
  
    $('.aaa').click(function(event){
      event.stopPropagation()
    })
    
    <%-- function getSecond(id){
     	$.ajax({
            type: 'POST',
            url: '<%=path%>/productAction!searchChildProductType.action?parentId=' + id,//发送请求
            dataType : "json",
            success: function(data) {
            		layer.close(index);
            		var htmlStr= "";
            		for(var index = 0 ; index < data.length ; index ++ ){
            			  console.info(data[index]);
            			  htmlStr += '<div class="tab-pane clearfix active" id="sec_' + id + '">' +           
 		                 '<ul class="nav nav-tabs tabs-left ">' + 
              			'<li class="secTab">' + 
				              	'<a href="#third_' + data[index].id + '" data-toggle="tab" onclick="getImg(this)"> '+
				              	   '<input type="checkbox" id="sec_check_' + data[index].id + '" data='+ data[index].id+
				              	    'class="aaa" data-parent="data[index].id.parentId">' + data[index].product	 + 
				              	    '</a> </li>	</ul> </div>	';
            		}
            		$("#sec").html(htmlStr);
		    }
		});
    } --%>
    
    //加载选择的商品
    $(function(){
    	
     	$.ajax({
            type: 'POST',
            url: '<%=path%>/productAction!toProduceSelectThirdTab.action',//发送请求
            dataType : "json",
            success: function(data) {
            	layer.close(index);
            	var htmlStr  = "";
	            	for(var index = 0 ; index < data.length ; index ++ ){
	            		htmlStr+= '<div class="tab-pane  clearfix" id="third_'+data[index].id +'">' + 
	            		    ' <p class="clearfix">'  ; 
	            		for(var i = 0 ; i < data[index].children.length ; i ++ ){
	            			htmlStr+= ' <span class="ccc">' + 
	            			  '<input type="checkbox" value="'+data[index].children[i].productId + '"' + 
	            			  ' id="third_check_'+data[index].children[i].id +'"  data='+data[index].children[i].id+ 
	            			  ' data-parent='+data[index].children[i].productId + '>' + 
	            			  '<label for="third_check_'+data[index].children[i].id + '" style="font-size:15">' + 
	            			  ' <a style="text-decoration:none">' +  data[index].children[i].subProduct +
	            			  '-' + data[index].children[i].formatNum+'-' + data[index].children[i].format +'-' + 
	            			   data[index].children[i].material + ' </a></label> </span>';
	            		}
	            		htmlStr += '</p> <div><img alt="" src="" id="img_'+data[index].id+'" class="col-md-8"></div> </div>';
			    }
	            	$("#third").html(htmlStr)
	             	$.ajax({
	                    type: 'POST',
	                    url: '<%=path%>/productAction!getUserSelectProductDetail.action',//发送请求
	                    dataType : "json",
	                    success: function(data) {
	                    	layer.close(index);
	        	            	for (var i = 0; i < data.length; i++) {
	        	    				var obj = data[i];
	        	    				$("#third_check_"+obj.productDetailId).prop('checked',true);
	        	    				if(obj.imgUrl){
	        	    					$("#img_"+obj.productId).attr('src', "/ring/upload/"+obj.imgUrl);
	        	    				}
	        	    			} 
	        		      }
	        		});
            }
		});
     	
    	
    	$.ajax({
            type: 'POST',
            url: '<%=path%>/productAction!getUserSelectProductDetail.action',//发送请求
            dataType : "json",
            success: function(data) {
            	layer.close(index);
      //      	if(data){
	            	for (var i = 0; i < data.length; i++) {
	    				var obj = data[i];
	    				var parentId = obj.productId;
	    				 $("#sec_check_"+parentId).prop('checked',true);
	    				 var firstIndex  = $("#sec_check_"+parentId).attr("data-parent");
	    				 $("#first_check_"+firstIndex).prop('checked',true);
	    			} 
  //          	}else{
  //          		$('input[type="checkbox"]').prop('checked',true);
  //          	}
		      }
		});

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
    
   function selectAll(){
	   $('input[type="checkbox"]').prop('checked',true);
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
			type: 'POST',
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