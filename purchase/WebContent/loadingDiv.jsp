<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div id='loadingDiv' style="position: absolute; z-index: 1000; top: 0px; left: 0px;
width: 100%; height: 100%; background: black;  text-align: center;">
	  <img alt="" src="${basePath}/img/load.gif" width="150px" height="150px" style="margin: 0 auto;margin-top: 200px;border-radius: 150px" >
</div>
 <script src="${basePath}/vendor/layer/layer.js"></script> 
<script type="text/JavaScript">
    function closeLoading() {
        $("#loadingDiv").fadeOut("normal", function () {
            $(this).remove();
        });
    }
    var no;
    $.parser.onComplete = function () {
        if (no) clearTimeout(no);
        no = setTimeout(closeLoading, 3000);
    }
</script>
