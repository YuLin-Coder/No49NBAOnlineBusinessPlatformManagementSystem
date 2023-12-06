var newPswflag=0;
var currentUserID = 0;

$(document).ready(function () {

    var path = $("#path").text();

    var currentPage = 1;

    to_page(path, 1);

    $("#newPswAdmin").blur(function (){
        if($("#newPswAdmin").val().length<8)
        {
            $("#newPswAdminError").show();
        }
        else {
            $("#newPswAdminError").hide();
            newPswflag=1;
        }
    });

    $("#savePswAdmin").click(function (){
        if (newPswflag==1)
        {
            var Psw={};
            Psw.Psw=$("#newPswAdmin").val();
            $.ajax({
                type: "POST",
                url: "/minority/admin/user/savepsw/"+currentUserID,
                contentType:"application/x-www-form-urlencoded; charset=utf-8",
                data:Psw,
                dateType:"json",
                success: function(result){
                    if (result.msg=="更新失败")
                    {
                        swal(result.msg);
                    }
                    else {
                        $("#update-Psw-admin").modal('hide');
                        swal(result.msg);
                    }
                },
                error:function (){
                    alert("更新失败");
                }
            });
        }
    });


});

$(document).on("click",".templatemo-delete-btn",function () {
    var goodsname = $(this).parents("tr").find("td:eq(1)").text();
    var goodsid = $(this).parents("tr").find("td:eq(0)").text();
    swal({
            title: "确定删除" + goodsname + "吗？",
            type: "warning",
            showCancelButton: true,
            cancelButtonText:"取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确定删除！",
            closeOnConfirm: false,
        },
        function () {
            /*swal("删除！", "你的虚拟文件已经被删除。", "success");*/
            $.ajax({
                url: "/minority/admin/user/delete/" + goodsid,
                type: "DELETE",
                success:function (result) {
                    swal(result.msg, "","success");
                    to_page('/minority',currentPage);
                },
                error:function () {
                    /*to_page('/shop',currentPage);*/
                }
            });
        });
});

$(document).on("click",".templatemo-reset-btn",function () {
    currentUserID = $(this).parents("tr").find("td:eq(0)").text();
    $("#update-Psw-admin").modal({
        backdrop:'static'
    });
});

function to_page(path, page) {
    $.ajax({
        url: path + "/admin/user/showjson",
        data: "page=" + page,
        type: "get",
        success: function (result) {

            //解析显示
            build_user_table(path, result);

            //页面信息
            build_page_info(path, result);

            //分页
            build_page_nav(path, result);

            currentPage = page;
        }
    });
}

function build_user_table(path,result) {
    $("#goodsinfo tbody").empty();
    var goods = result.info.pageInfo.list;
    $.each(goods, function (index,item) {
        var userid = $("<td></td>").append(item.userid);
        var username = $("<td></td>").append(item.username);
        var email = $("<td></td>").append(item.email);
        var telephone = $("<td></td>").append(item.telephone);

        var deleteBtn = $("<button></button>").addClass("templatemo-delete-btn").append("删除");
        var resetBtn = $("<button></button>").addClass("templatemo-reset-btn").append("reset");

        var deleteTd = $("<td></td>").append(deleteBtn);
        var resetTd = $("<td></td>").append(resetBtn);


        $("<tr></tr>").append(userid)
            .append(username)
            .append(email)
            .append(telephone)
            .append(deleteTd).append(resetTd).appendTo("#goodsinfo tbody");
    })
}

function build_page_info(path,result) {
    $("#page-info-area").empty();
    $("#page-info-area").append("当前第"+ result.info.pageInfo.pageNum +"页，总共"+ result.info.pageInfo.pages +"页，总共"+ result.info.pageInfo.total +"记录")
}

function build_page_nav(path,result) {
    $("#page-div-nav ul").empty();
    var pageUl = $("<ul></ul>").addClass("pagination")

    var firstPage = $("<li></li>").append($("<a aria-label=\"Next\"></a>")
        .append($("<span aria-hidden=\"true\"></span>")
            .append("首页")));

    var prePage = $("<li></li>").append($("<a aria-label=\"Next\"></a>")
        .append($("<span aria-hidden=\"true\"><i class=\"fa fa-backward\"></i></span>")));

    if(!result.info.pageInfo.hasPreviousPage) {
        prePage.addClass("li-none");
    } else {
        prePage.click(function () {
            to_page('/shop',result.info.pageInfo.prePage);
        });
    }

    //跳转
    firstPage.click(function () {
        to_page('/shop',1);
    });

    var nextPage = $("<li></li>").append($("<a aria-label=\"Next\"></a>")
        .append($("<span aria-hidden=\"true\"><i class=\"fa fa-forward\"></i></span>")));

    var lastPage = $("<li></li>").append($("<a aria-label=\"Next\"></a>")
        .append($("<span aria-hidden=\"true\"></span>")
            .append("末页")));

    if(!result.info.pageInfo.hasNextPage) {
        nextPage.addClass("li-none");
    } else {
        nextPage.click(function () {
            to_page('/shop',result.info.pageInfo.nextPage);
        });
    }

    lastPage.click(function () {
        to_page('/shop',result.info.pageInfo.lastPage);
    });

    pageUl.append(firstPage).append(prePage);

    $.each(result.info.pageInfo.navigatepageNums,function (index,item) {
        var numLi = $("<li></li>").append($("<a></a>")
            .append($("<span aria-hidden=\"true\"></span>").append(item)));
        if(result.info.pageInfo.pageNum === item) {
            numLi.addClass("active");
        }
        numLi.click(function () {
            to_page('/shop',item);
        });
        pageUl.append(numLi);
    });

    pageUl.append(nextPage).append(lastPage).appendTo("#page-div-nav");
}