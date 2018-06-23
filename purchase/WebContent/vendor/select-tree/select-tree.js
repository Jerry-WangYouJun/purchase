
function initMenu(id, obj){
//  var datalist = $("#" + id);
 // var data = eval("(" + obj + ")");
	var data = obj;
//  datalist.append("<div id='result' style='display:blank'></div>");
  // var resultArea = datalist.find("#result");
  // datalist.append("<div class='menu' id='firstMenu' >" + "" + "</div>");
  var firstMenu = $("#firstMenu");
  firstMenu.html("");
  firstMenu.append("<div id='result' style='display:none' ></div>");
  var resultArea = firstMenu.find("#result");
  //获取用户选择的产品
  $.post("/order_bak/productAction!getUserSelectProductDetail.action",function(data){
	  var temp = eval(data);
	  if(temp==null)
		  {
		  	return;
		  }
	  for (var i = 0; i < temp.length; i++) {
		var id = temp[i];
		resultArea.find("a[id='c_" + id + "']").remove();
        resultArea.append("<a href='#' id='c_" +id + "'>" +id + "</a>");   
	}
  })
  

  var secondMenu = $("#secondMenu"); 
  firstMenu.append("<ul></ul>");

  $.each(data, function (i, obj) {   // 循环第一级
	  
      $(firstMenu).find("ul").append("<li  name='" + i + "'><a id='first_" + obj.id + "' >" + obj.product + "</a></li>");
        // if (datalist.find("div[class='sub-menu']").length <= 0) {
        //     datalist.append("<div class='sub-menu' id='secondMenu'></div>");
        // }
        //var secondMenu = datalist.find("#secondMenu");
          
       //$(firstMenu).find("ul li:first").addClass("sele").trigger("click");
  });
  $("#firstMenu ul li").click(function () {
      //判断是否是点击自己
      if($(this).hasClass("sele"))
    	  {
    	  //判断a标签状态
    	  	var temp = $(this).find("a").hasClass("sele");
    	  	if($(this).find("a").hasClass("sele"))
    	  		{
    	  			$(this).find("a").removeClass("sele");
    	  			$("#secondMenu dt a").removeClass("sele");
    	  			$("#secondMenu  dd a").removeClass("sele");
    	  			var alist = $("#secondMenu  dd a");   	  			
    	  			 for (var i = 0; i < alist.length; i++) {
    	 				var a = alist[i];
    	 				$(a).removeClass("sele")
    	 				var tempId = a.id;
    	 				$("#c_" + tempId + "").remove();
    	 			}
    	  		}
    	  	else{ 
    	  			$(this).find("a").addClass("sele");   
    	  			$("#secondMenu dt a").addClass("sele");
    	  			$("#secondMenu dd a").addClass("sele");
    	  			$("#secondMenu dd").show();
    	  			var alist = $("#secondMenu  dd a");
    	  			for (var i = 0; i < alist.length; i++) {
    					var a = alist[i];
    					var tempId = a.id;					
    					$("#c_" + tempId + "").remove();
    					resultArea.append("<a href='#' id='c_" +tempId + "'>" +tempId + "</a>");  
    				}   
    	  		}
    	  }
      else
    	  {
    	  	  secondMenu.html("");  
              $("#firstMenu ul li").removeClass("sele");
              $("#firstMenu ul li a").removeClass("sele");	              
              $(this).addClass("sele");
              
              var index = $(this).attr("name");    
              //console.log(index);
              //第二级
              $.each(data[index].children, function (j, item) {
                secondMenu.append("<dl id='dl_" + j + "'></dl>");               
                var dtItem = "<dt id='dt_" + j + "'><a data='"+item.parentId+"' onClick='secondTypeSelect("+j+",this)'>" + item.product + "</a></dt>";
                	
                secondMenu.find("dl[id='dl_" + j + "']").append(dtItem);
                secondMenu.find("dl[id='dl_" + j + "']").append("<dd id='dd_" + j + "'></dd>");
                $("#dd_"+j).hide();
                //第三级
                $.each(data[index].children[j].children, function (m, dist) {              	          	
            	  var threeMenu = "<a onClick='thirdTypeSelect("+dist.id+",this)' href='javascript:void(0)'  id='" +  dist.id  + "'>"
             	  + dist.subProduct + ' - ' + dist.format + ' - ' + dist.material + "</a>";  
                  secondMenu.find("dl[id='dl_" + j + "'] dd[id='dd_" + j + "']").append(threeMenu);              
                });            
              });             
    	  }
      
      
    //循环结束后  取出 resultArea 中所有的 id  循环 选中 相应的产品  	
		var selectedItems = resultArea.find("a");
		    $.each(selectedItems, function (i, item) {
			var id = $(item).html();
			$("#"+id).addClass("sele");
			$("#"+id).parent().parent().find("dt a").addClass("sele");
			$("#"+id).parent().parent().find("dd").show();
			var parentId = $("#"+id).parent().parent().find("dd a").attr("data");
			$("#first_"+parentId).addClass("sele");  
			});		
    
    }); 
  
}
 
 
 
  /*//监听 dd 下的产品 a 标签 (1级)
  $("dd").find("a").bind("click", function () { 
 	  var id = $(this).parent().attr("id").substr(3);
 	  //如果 a 标签  被选中  就 去掉选中 
 	  //判断 是否还有其它 a 标签 被选中 如果 没有  就把 dt 下的 选中状态去掉 
      if ($(this).hasClass("sele")){
        $(this).removeClass("sele");    
        var temp = $(this).parent().find(".sele");
        if(temp.length!= 0)
     	   {
     	   	return;
     	   }
        else if(temp.length==0)
     	   {         
     	   		$("#dt_"+id).find("a").removeClass("sele");
     	   		
     	   }
      }else{
        $(this).addClass("sele");
        $("#dt_"+id).find("a").addClass("sele");                   
      }
   });*/
  
  


/*$("#firstMenu").find("li a").bind("click", function () {
	debugger;
    if ($(this).hasClass("sele")){
      $(this).removeClass("sele");
      //resultArea.find("a[id='c_" + $(this).attr("id") + "']").remove();
    }else{
      $(this).addClass("sele");
      //resultArea.append("<a href='#' id='c_" + $(this).attr("id") + "'>" + $.trim($(this).attr("id")) + "</a>");
    }            
 });*/
	// 列表项点击事件，选中则在结果容器中显示添加选中样式

	//监听 二级科目  显示三级科目
	function secondTypeSelect(id,obj)
	{
		var resultArea = $("#result");	
		 $("#dd_"+id).show(); 	 
		 if ($(obj).hasClass("sele")){		 	 
		      $(obj).removeClass("sele");
		      var alist = $("#dd_"+id).find("a");
		     // $("#dd_"+id).find("a").removeClass("sele");
		      for (var i = 0; i < alist.length; i++) {
				var a = alist[i];
				$(a).removeClass("sele")
				var tempId = a.id;
				$("#c_" + tempId + "").remove();
			}
		     //判断 二级类型是否还有选中项 如果没有 就把一级类型 去掉选中
		     var secType = $("#secondMenu").find("dl .sele");
			 if(secType.length==0)
			 {
			 	$(obj).parent().parent().find("dt a").removeClass("sele");
			 	var parentId= $(obj).parent().parent().find("dt a").attr("data");			 	
			 	$("#first_"+parentId).removeClass("sele");
			 }  
		      
		      
		     // $("#c_" + id + "").remove(); 		      
		    }else{		 	   
		      $(obj).addClass("sele");
		      $("#dd_"+id).find("a").addClass("sele");
		      var alist = $("#dd_"+id).find("a");
		      for (var i = 0; i < alist.length; i++) {
					var a = alist[i];
					var tempId = a.id;					
					$("#c_" + tempId + "").remove();
					resultArea.append("<a href='#' id='c_" +tempId + "'>" +tempId + "</a>");  
				}     
		      //将一级类型选中
		      var parentId = $(obj).attr("data");
		      $("#first_"+parentId).addClass("sele");		      
		    }
	}
	//监听 三级类型
	function thirdTypeSelect(id,obj)
	{		
		var resultArea = $("#result");
	 if ($(obj).hasClass("sele")){		 	 
	      $(obj).removeClass("sele");	           
	      $("#c_" + id + "").remove(); 
	    }else{		 	   
	      $(obj).addClass("sele");
	      $("#c_" + id + "").remove(); 
	      resultArea.append("<a href='#' id='c_" +id + "'>" +id + "</a>");
	      $(obj).parent().parent().find("dt a").addClass("sele");
	    }
	 	//判断三级类型是否还有选中  没有 就取消二级选中 
		 var alist = $(obj).parent().find(".sele");
		 if(alist.length==0)
			 {
			 	$(obj).parent().parent().find("dt a").removeClass("sele");
			 }
		 //判断二级类型中是否还有选中 没有就取消
		 var secType = $("#secondMenu").find("dl .sele");
		 if(secType.length==0)
		 {
		 	$(obj).parent().parent().find("dt a").removeClass("sele");
		 	var parentId= $(obj).parent().parent().find("dt a").attr("data");		 	
		 	$("#first_"+parentId).removeClass("sele");
		 }
	}
	
	

	function setSelected(){
	  var resultArea = datalist.find("#result");
	
	}
	function getSelected(){
		var firstMenu = $("#firstMenu");
		var resultArea = firstMenu.find("#result");
	    var selectedItems = resultArea.find("a");
	    var results = "";
	    $.each(selectedItems, function (i, item) {
	        results += $.trim($(item).html()) + ",";
	    });
	    if (results.length > 0) {
	      results = results.substr(0, results.length - 1);
	    }
	    return results;
	}
