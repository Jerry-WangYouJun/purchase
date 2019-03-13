<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div id='loadingDiv' style="position: absolute; z-index: 1000; top: 0px; left: 0px;
width: 100%; height: 100%; background: url('${basePath}/img/index.jpeg'); background-size: 100% 100%; text-align: center;">
</div>
 <script src="${basePath}/vendor/layer/layer.js"></script> 
<script type="text/JavaScript">
var index = layer.load(1); 
    function closeLoading() {
        $("#loadingDiv").fadeOut("normal", function () {
        		layer.close(index); 
            $(this).remove();
        });
    }
    var no;
    $.parser.onComplete = function () {
        if (no) clearTimeout(no);
        no = setTimeout(closeLoading, 1000);
    }
</script>
