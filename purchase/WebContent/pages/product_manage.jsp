<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML >
<html lang="zh-CN">
  <head>
    <base href="<%=basePath%>">
    
    <title>产品类别管理</title>   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

     <link href="<%=path%>/vendor/select-tree/base.css" rel="stylesheet" type="text/css" />
     <link href="<%=path%>/vendor/select-tree/style.css" rel="stylesheet" type="text/css" />
	 <link href="<%=path%>/vendor/easyui/themes/material/easyui.css" rel="stylesheet" type="text/css"> 
     <link href="<%=path%>/vendor/easyui/themes/icon.css" rel="stylesheet" type="text/css">
   	 <link href="<%=path%>/vendor/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
	
	
	 <link href="<%=path%>/vendor/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css" rel="stylesheet">
	 <script type="text/javascript" src="<%=path%>/vendor/jquery/jquery.js"></script>
	 <script type="text/javascript" src="<%=path%>/vendor/zTree/js/jquery.ztree.core.js"></script>
	 <script type="text/javascript" src="<%=path%>/vendor/zTree/js/jquery.ztree.excheck.js"></script>	
	 <script type="text/javascript" src="<%=path%>/vendor/zTree/js/jquery.ztree.exedit.js"></script>	
	 <script type="text/javascript" src="<%=path%>/vendor/zTree/js/jquery.ztree.exhide.js"></script>	
	 
	 <script src="<%=path%>/vendor/layer/layer.js"></script>
	 <script src="<%=path%>/js/jquery.validate.min.js"></script>
	<script src="<%=path%>/js/jquery.metadata.js"></script>
	<script src="<%=path%>/js/messages_zh.js"></script>
<style type="text/css">
	.errorColor > label{
	 color:red;
	}

</style>
     <script type="text/javascript">
				
		var setting = {
				
				key:{
					isHidden:"hide"
				},
				data: {
					  simpleData : {  
			                enable : true,  
			                idKey : "id",  
			                pIdKey : "pid",  
			                rootPId : 0,
			                isHidden:"hide"
			            } 
				},
				callback: {
					onClick: zTreeOnClick,
					
					
				}
			};
		var treeNodes; 
		var code;
		
		
		
		//监听 点击事件
		function zTreeOnClick(event, treeId, treeNode) {		    
		    var id =treeNode.id;
		    if(id.indexOf('detail')!= -1)
		    	{
		    		id = id.substr(7);
			    	$("#detailId").val(id);
		    		$.post("<%=path%>/productAction!searchProductDetail.action?id="+id,function(data){		    		
		    			var detail = JSON.parse(data);
		    			$("#detailProductId").val(detail.productId);
		    			$("#detailName").val(detail.subProduct);
		    			$("#detailFormat").val(detail.format);
		    			$("#detailMaterial").val(detail.material);
		    			$("#detailRemark").val(detail.remark);		    			
		    		})
		    		$("#detailType").show();
		    		$("#productType").hide();
		    		$(".errorColor").text('');
		    	}else	{
		    		$("#productId").val(id);
		    		$.post("<%=path%>/productAction!searchProduct.action?id="+id,function(data){
		    			var product = JSON.parse(data);
		    			$("#productName").val(product.product);
		    			$("#productUnit").val(product.unit);
		    			$("#productBase").val(product.base);		    			
		    			$("#productRemark").val(product.remark);
		    			$("#parentId").val(product.parentId);
		    			if(product.parentId > 0){
			    			$(".divBase").show();
		    			}else{
		    				$(".divBase").hide();
		    			}
		    			$("#divUnit").show();
		    			if(product.unit==null || product.unit=="")
	    				{    					
	    					$("#divUnit").hide();	    				
	    				}
/* 		    			if(product.base==null || product.base=="")
	    				{	    					
	    					$(".divBase").show();
	    					
	    				}
 */		    		})
			    	$("#detailType").hide();
		    		$("#productType").show();
		    		$(".errorColor").text('');
		    	}
		};
		
		
		function showCode(str) {
			if (!code) code = $("#code");
			code.empty();
			code.append("<li>"+str+"</li>");
		}		

		$(document).ready(function(){
			$("#productType").hide();
		  $.ajax({  
	            async : false,//是否异步  
	            cache : false,//是否使用缓存  
	            type : 'POST',//请求方式：post  
	            dataType : 'json',//数据传输格式：json  
	            url : "<%=path%>/productAction!loadTree.action",  
	            error : function() {  
	                //请求失败处理函数  
	                alert('网页有错误，请联系管理员！');  
	            },  
	            success : function(data) {  
	                treeNodes = data;//把后台封装好的简单Json格式赋给treeNodes                  
	            }  
	        });  			 
			$.fn.zTree.init($("#tree"), setting,treeNodes);	
			
			//保存（类型）
			
			//保存 （详情）
			$("#detailSave").click(function(){
				//保存detail 
				var id =$("#detailId").val();
				var detailName = $("#detailName").val();
				var detailFormat = $("#detailFormat").val();
				var detailMaterial = $("#detailMaterial").val();
				var detailRemark = $("#detailRemark").val();
				var productId = $("#detailProductId").val();
				if($("#form_child").validate().form()){
					$.post("<%=path%>/productAction!saveProductDetail.action",
							{
								id:id,
								subProduct:detailName,
								format:detailFormat,
								material:detailMaterial,
								remark: detailRemark,
								productId:productId
							},
							function(data){
								layer.alert("保存成功");
								window.location.reload();
					})
				}
			})
			//删除详情
			$("#detailDelete").click(function(index){				
				var id = $("#detailId").val();
				layer.confirm('是否确定删除？', {
					  btn: ['确定','取消'] //按钮
					}, function(){											
					  $.post("<%=path%>/productAction!deleteProductDetailById.action?id="+id,function(){
						  var treeObj = $.fn.zTree.getZTreeObj("tree");
						  var nodes = treeObj.getSelectedNodes();
						  for (var i=0, l=nodes.length; i < l; i++) {
						  	treeObj.removeNode(nodes[i]);
						  }						  
						  layer.closeAll();
					  })
					  
					}, function(){
						layer.closeAll();
					});
			})
			//删除类型
			$("#productDelete").click(function(){
				var id = $("#productId").val();
				var parentId = $("#parentId").val();
				layer.confirm('是否确定删除选项及子项？', {
					  btn: ['确定','取消'] //按钮
					}, function(){											
					  $.post("<%=path%>/productAction!deleteProductById.action?id="+id+"&parentId="+parentId,function(){
						  var treeObj = $.fn.zTree.getZTreeObj("tree");
						  var nodes = treeObj.getSelectedNodes();
						  for (var i=0, l=nodes.length; i < l; i++) {
						  	treeObj.removeNode(nodes[i]);
						  }						  
						  layer.closeAll();
					  })
					  
					}, function(){
						layer.closeAll();
					});
			})
			//新增
			$("#addProduct").click(function(){
				layer.open({
					  type: 2,
					  title: '新增',
					  shadeClose: true,
					  shade: 0.8,
					  area: ['380px', '90%'],
					  content: '<%=path%>/pages/product_add.jsp' //iframe的url
					}); 
			})
			
			$("#importProduct").click(function(){
				layer.open({
					  type: 2,
					  title: '导入',
					  shadeClose: true,
					  shade: 0.8,
					  area: ['450px', '40%'],
					  content: '<%=path%>/pages/product_import.jsp' //iframe的url
				});
			});
		});
		
		function productSave(){
			var id =$("#productId").val();
			var productName = $("#productName").val();
			var productUnit = $("#productUnit").val();
			var productBase = $("#productBase").val();
			var productRemark = $("#productRemark").val();
			var parentId = $("#parentId").val();
			if($("#form1").validate().form()){
				var reg=/^[-\+]?\d+(\.\d+)?$/;
					/* if(productBase  == '' || productBase  == 0){
						 alert("基础采购量不能为空或0 ,请重新填写");
						 return false;
					} */
				if(!reg.test(productBase)){
					alert("基础采购量数字格式，请重新输入~");
					$("#productBase").val('');
					$("#productBase").focus();
					return false ;
				}
				$.post("<%=path%>/productAction!saveProduct.action",{
							id:id,
							parentId:parentId,
							product:productName,
							unit:productUnit,
							base:productBase,
							remark:productRemark
					},
						function(data){
							var obj = eval('(' + data + ')');
							if(obj.success){
								layer.alert("保存成功");
								window.location.reload();
							}else{
								layer.alert(obj.msg);
							}
						})
			}
		};
	$(function(){
		$("#form1").validate({
			errorPlacement: function(error, element) {
				$( element )
					.parent().next('span').append( error );
			}
		});
		$("#form_child").validate({
			errorPlacement: function(error, element) {
				$( element )
					.parent().next('span').append( error );
			}
		});
	})
    </script>
  
  </head>
  
 <body class="">


 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<span style="font-size: 22px;height:40px;line-height: 40px;margin: 0px">订单类别选择</span>
 	</div>
 
 	<div data-options="region:'north',border:false,showHeader:false"  style="height:40px" >
 		<a  id="addProduct" style="background-color:#e05447;color:#fff;float: left;width:60px;height: 30px;line-height: 30px;text-align: center;margin-top: 5px">新增</a>
 		<a  id="importProduct" style="background-color:#e05447;color:#fff;float: left;width:60px;height: 30px;line-height: 30px;text-align: center;margin-top: 5px">导入</a>
<!--  		<a onclick="reset()" id="reset" style="background-color:#007FFF;color:#fff;float: right;width:60px;height: 30px;line-height: 30px;text-align: center;margin-top: 5px;margin-right:10px">新增</a> 		
 --></div>
 	
	<div class='container'>
	<div class="row">
	 <div class='col-md-6' >
	   <ul id="tree" class="ztree"></ul>
	</div> 
 	<div class="col-md-6"  id="productType">
 		<h4>编辑</h4>
 		
 		<form id="form1" class="bs-example bs-example-form" data-example-id="simple-input-groups">
 			<input type="hidden" id="productId">
 			<input type="hidden" id="parentId">
 			
	   		<div class="input-group" style="margin-top:10px">
			  <span class="input-group-addon" id="basic-addon1">名称</span>
			  <input type="text" class="form-control" placeholder="名称" aria-describedby="basic-addon1" name="productName" id="productName" required>
			</div>
			<span class="errorColor"></span>
		
			<div class="input-group" id="divUnit" style="margin-top:10px">
			  <span class="input-group-addon" id="basic-addon2">单位</span>
			  <input type="text" class="form-control" placeholder="单位" aria-describedby="basic-addon2" name="productUnit" id="productUnit" required>
			</div>
			<span class="errorColor"></span>
			
			<div class="input-group divBase" style="margin-top:10px">
			  <span class="input-group-addon" id="basic-addon3">基础采购量</span>
			  <input type="text" class="form-control" placeholder="基础采购量" aria-describedby="basic-addon3" name="productBase" id="productBase" >
			</div>
			 <span class="errorColor"></span>
			 <div  class="divBase"><span style="color:red">基础采购量只填写相应数量即可</span></div>
			
			<div class="input-group" style="margin-top:10px">
			  <span class="input-group-addon" id="basic-addon4">备注</span>
			  <input type="text" class="form-control" placeholder="备注" aria-describedby="basic-addon4" id="productRemark">
			</div>
			
			<div class="input-group" style="margin-top:10px">
				<button type="button" class="btn btn-success" style="margin-left:100px" id="productSave()" onclick="productSave()">保存</button>
			
				<button type="button" class="btn btn-danger" style="margin-left:100px" id="productDelete">删除</button>
			</div>
  		</form>		
	</div> 
	
	 <div class="col-md-6" style="display:none" id="detailType">
	 	<h4>编辑</h4>
 		<form class="bs-example bs-example-form" data-example-id="simple-input-groups"  id="form_child">
 			<input type="hidden" id="detailId">
 			<input type="hidden" id="detailProductId">
	   		<div class="input-group">
			  <span class="input-group-addon" id="basic-addon1">名称</span>
			  <input type="text" class="form-control" placeholder="名称" aria-describedby="basic-addon1" name="detailName" id="detailName" required>
			</div>
			<span class="errorColor"></span>
			<br>
			<div class="input-group">
			  <span class="input-group-addon" id="basic-addon2">规格</span>
			  <input type="text" class="form-control" placeholder="规格" aria-describedby="basic-addon2" name="detailFormat" id="detailFormat" >
			</div>
			<span class="errorColor"></span>
			<br>
			<div class="input-group">
			  <span class="input-group-addon" id="basic-addon3">材质/标准</span>
			  <input type="text" class="form-control" placeholder="材质/标准" aria-describedby="basic-addon3"name="detailMaterial" id="detailMaterial" >
			</div>
			<span class="errorColor"></span>
			<br>
			<div class="input-group">
			  <span class="input-group-addon" id="basic-addon4">备注</span>
			  <input type="text" class="form-control" placeholder="备注" aria-describedby="basic-addon4" name="detailRemark" id="detailRemark">
			</div>
			<br>
			<div class="input-group">
				<button type="button" class="btn btn-success" style="margin-left:100px" id="detailSave" >保存</button>
				
				<button type="button" class="btn btn-danger" style="margin-left:100px" id="detailDelete">删除</button>
				
			</div>
  		</form>		
	</div> 
	</div>
	</div>
	
	<!-- <div id="dialog-confirm" class="easyui-dialog" title="确认删除所选项及其子项？" closed="true">
	  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>删除后将无法恢复，请谨慎操作</p>
	</div> --> 

</body>
</html>
