$(function(){
    var winH = $(window).height();

    // 窗口大小自适应
    $("#wrapper").css('height', winH);
    $(".bgh").css('minHeight', winH);
    $(window).resize(function(){
        var winH = $(window).height();
        $(".bgh").css('minHeight', winH);
    });

    //左侧导航点击颜色
    $(".main-menu>li>a").click(function(){
        $(this).addClass("bg-2f").siblings("li").removeClass("bg-2f");
    })
    //左侧导航子菜单点击颜色
    $(".main-menu>li ul li").click(function(){
        $(this).addClass("on").siblings("li").removeClass("on");
        $(".main-menu li.menu-one").removeClass("separate");
    })
    $(".navbar-brand-nav li").click(function(){
        $(this).addClass("on").siblings("li").removeClass("on");
    })
    $(".main-menu li.menu-one").click(function(){
        $(".main-menu li.menu-one").removeClass("separate");
        $(".main-menu>li ul li").removeClass("on");
        $(this).addClass("separate");
    })
    $(".table tbody tr").click(function(){
        $(".table tbody td").removeClass("on");
        $(this).find("td").addClass("on");
    });

    //全选,设置chheckbox name='all' tbody id=tb
    $("input[name=all]").click(function () {
        if (this.checked) {
            $("#checkAll :checkbox").prop("checked", true);
        } else {
            $("#checkAll :checkbox").prop("checked", false);
        }
    });

})