<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Insert title here</title>
   	 <link href="<%=path%>/vendor/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
   	 <link href="<%=path%>/vendor/bootstrap-select/css/bootstrap-select.min.css">
   	 
 	 <script src="<%=path %>/vendor/bootstrap-select/js/jquery-3.2.1.min.js" ></script>
   	 <script type="text/javascript" src="<%=path%>/vendor/bootstrap/js/bootstrap.js"></script>
   	 <script type="text/javascript" src="<%=path%>/vendor/bootstrap-select/js/bootstrap-select.js"></script>
   	 <script type="text/javascript" src="<%=path%>/vendor/jquery/jquery.js"></script>
   	 <script src="<%=path%>/vendor/layer/layer.js"></script>
   	 <script src="<%=path%>/js/jquery.validate.min.js"></script>
	<script src="<%=path%>/js/jquery.metadata.js"></script>
	<script src="<%=path%>/js/messages_zh.js"></script>
</head>
<style type="text/css">
	.errorColor{
	 color:red;
	}

</style>
<body>
	<div class='container'>
		<div class="row">
			<div class="col-md-6"  id="productType">
	 		<form class="bs-example bs-example-form" data-example-id="simple-input-groups" id="form1">	 
	 			
	 			
			     <div class="input-group" style="margin-top:10px">
			    	<label>选择一级类型：</label>
				        <select id="firstType" class=" show-tick form-control">
				          	<option value=""></option>
				        </select>
			      </div>
			      
			 	 <div class="input-group" style="margin-top:10px;display:none" id="divSecType">
			    	<label>选择二级类型：</label>
			        <select id="secType" class=" show-tick form-control" required>
			         	<option value=""></option>
			        </select>
			      </div>
			      
	 			<div id="productInput">		
	 				<h5 id="productTitle">创建一级类型</h5>
			   		<div class="input-group" style="margin-top:10px">
					  <span class="input-group-addon" id="basic-addon1">名称</span>
					  <input type="text" class="form-control" placeholder="名称" aria-describedby="basic-addon1" id="productName" name="productName" required>
					</div>
					<span class="errorColor"></span>
					<div class="input-group" id="divUnit" style="margin-top:10px">
					  <span class="input-group-addon" id="basic-addon2">单位</span>
					  <input type="text" class="form-control" placeholder="单位" aria-describedby="basic-addon2" id="productUnit" name="productUnit" required>
					</div>
					<span class="errorColor"></span>
					<div class="input-group divBase" style="margin-top:10px;display:none">
					  <span class="input-group-addon" id="basic-addon3">基础采购量</span>
					  <input type="text" class="form-control" placeholder="基础采购量" aria-describedby="basic-addon3" id="productBase" name="productBase" >
					</div>
					<span class="errorColor"></span>
					<div class="divBase" style="display:none;color:red;"><span >*基础采购量只填写相应数量即可</span></div>
					<div class="input-group" style="margin-top:10px">
					  <span class="input-group-addon" id="basic-addon4">备注</span>
					  <input type="text" class="form-control" placeholder="备注" aria-describedby="basic-addon4" id="productRemark" name="productRemark">
					</div>
				</div>
				
				<div id="deteailInput" style="display:none">	
					<h5 id="detailTitle">创建三级类型</h5>	
			   		<div class="input-group">
					  <span class="input-group-addon" id="basic-addon1">名称</span>
					  <input type="text" class="form-control" placeholder="名称" aria-describedby="basic-addon1" id="detailName" name="detailName" required>
					</div>
					<span class="errorColor"></span>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon2">规格</span>
					  <input type="text" class="form-control" placeholder="规格" aria-describedby="basic-addon2" id="detailFormat" name="detailFormat" >
					</div>
					<span class="errorColor"></span>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon3">材质/标准</span>
					  <input type="text" class="form-control" placeholder="材质/标准" aria-describedby="basic-addon3" id="detailMaterial" name="detailMaterial" >
					</div>
					<span class="errorColor"></span>
					<br>
					<div class="input-group">
					  <span class="input-group-addon" id="basic-addon4">备注</span>
					  <input type="text" class="form-control" placeholder="备注" aria-describedby="basic-addon4" id="detailRemark">
					</div>
					<span class="errorColor"></span>
				</div>
				
				
				
				<div class="input-group" style="margin-top:10px">
					<button type="button" class="btn btn-success" style="margin-left:100px" id="save">保存</button>
				<button type="button" class="btn btn-warning" style="margin-left:100px" id="cancel">取消</button> 
				</div>
	  		</form>


			<script type="text/javascript">
				$(function(){
					//加载一级类型
					$.post("<%=path%>/productAction!searchFirstProductType.action",function(data){				
						var productList = JSON.parse(data);
						for (var i = 0; i < productList.length; i++) {
							var product = productList[i];
							$("#firstType").append("<option value="+product.id+">"+product.product+"</option>");
						}
					})
					
					//一级类型监听
					$("#firstType").change(function(){
						var id  = $("#firstType").val();
						if(id != null && id != '' )
							{
								$("#secType").html("");	
								$("#secType").append("<option value=''></option>")	
								//加载二级
								$.post("<%=path%>/productAction!searchChildProductType.action?parentId="+id,function(data){
									var productList = JSON.parse(data);
									for (var i = 0; i < productList.length; i++) {
										var product = productList[i];
										$("#secType").append("<option value="+product.id+">"+product.product+"</option>")
									}
								})
								$("#productTitle").html("创建二级类型")
								$("#productInput").find("input").html("");
								$(".divBase").show();
								$("#divUnit").hide();
								$("#divSecType").show();
							}
						else
							{
								$("#productTitle").html("创建一级类型")
								$("#productInput").find("input").html("");
								$(".divBase").hide();
								$("#divUnit").show();
								$("#divSecType").hide();
							}
						$(".errorColor").text('');
					})
					
					//二级类型监听
					$("#secType").change(function(){
						var id = $("#secType").val();
						if(id!= null && id!= '')
							{
								$("#deteailInput").show();
								$("#productInput").hide();
							}
						else
							{
								$("#deteailInput").hide();
								$("#productInput").show();
							}
						$(".errorColor").text('');
					})
					
					//保存
					$("#save").click(function(){
						var firstTypeId = $("#firstType").val();
						var secTypeId = $("#secType").val();
							
							if(secTypeId != null && secTypeId != ''){
									//保存detail 
									var detailName = $("#detailName").val();
									var detailFormat = $("#detailFormat").val();
									var detailMaterial = $("#detailMaterial").val();
									var detailRemark = $("#detailRemark").val();
									if($("#form1").validate().element($("#detailName"))&&
											$("#form1").validate().element($("#detailFormat"))&&
											$("#form1").validate().element($("#detailMaterial"))){
										$.post("<%=path%>/productAction!saveProductDetail.action",
												{
													productId:secTypeId,
													subProduct:detailName,
													format:detailFormat,
													material:detailMaterial,
													remark: detailRemark
												},
												function(data){
													layer.alert("保存成功");
													window.parent.location.reload();
										})
									}
							}else{
									var productName = $("#productName").val();
									var productUnit = $("#productUnit").val();
									var productBase = $("#productBase").val();
									var productRemark = $("#productRemark").val();
									var reg=/^[-\+]?\d+(\.\d+)?$/;
									if($("#form1").validate().element($("#productName"))){
										//firstTypeId 为空说明大类，验证单位，不为空说明为小类，验证基础采购
											if(firstTypeId == '' ){
												if(!$("#form1").validate().element($("#productUnit"))){
													return false;
												} 
											}else{
												if(!$("#form1").validate().element($("#productBase"))){
											    		return false;
												}else{
													if( productBase  == 0){
														 alert("基础采购量不能为0 ,请重新填写");
														 return false;
													}
													if(!reg.test(productBase)){
														alert("基础采购量数字格式，请重新输入~");
														$("#productBase").val('');
														$("#productBase").focus();
														return false ;
													}
												}
											}
											$.post("<%=path%>/productAction!saveProduct.action",
													{   parentId:firstTypeId,
														product:productName,
														unit:productUnit,
														base:productBase,
														remark:productRemark
													},
													function(data){
														layer.alert("保存成功");
														window.parent.location.reload();
											})
									}
							}
					})
					//取消
					$("#cancel").click(function(){
						var index = parent.layer.getFrameIndex(window.name)
						parent.layer.close(index);
						
					}) 
				})	
				
				$(function(){
					$("#form1").validate({
						errorPlacement: function(error, element) {
							$( element )
								.parent().next('span').append( error );
						}
					});
				})
			</script>
			</div> 
		</div>
	</div>
</body>
</html>