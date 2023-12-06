$(document).ready(function(){
    var oldPswflag=0;
    var newPswflag=0;
    $("#name").val($("#nameVal").text());
    $("#email").val($("#emailVal").text());
    $("#telephone").val($("#telephoneVal").text());
    $("#changeInfo").click(function(){
        $("#update-info").modal({
            backdrop:'static    '
        });
    });


    $("#saveInfo").click(function (){
        var isCheck =$('#update-form0').valid();
        if(!isCheck){
            return;
        }
        var saveInfo={};
        saveInfo.name=$("#name").val();
        saveInfo.email=$("#email").val();
        saveInfo.telephone=$("#telephone").val();
        $.ajax({
            type: "POST",
            url: "saveInfo",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:saveInfo,
            dateType:"json",
            success: function(result){
                if (result.msg=="更新失败")
                {
                    swal(result.msg);
                }
                else {
                    $("#update-info").modal('hide');
                    swal("修改成功", "", "success");
                    $("button").click(function (){
                        location.reload();
                    });
                }
            },
            error:function (){
                alert("更新失败");
            }
        });
    });

    $("#changePsw").click(function (){
        $("#update-Psw").modal({
            backdrop:'static'
        });
    });

    $("#oldPsw").blur(function (){
        if ($("#oldPsw").val()!=$("#Psw").attr("Psw"))
        {
            $("#oldPswError").show();
        }
        else
        {
            $("#oldPswError").hide();
            oldPswflag=1;
        }
    })

   /* $("#newPsw").focus(function (){
        if ($("#oldPsw").val()==$("#Psw").attr("Psw"))
        {
            $("#oldPswError").hide();
            oldPswflag=1;
        }
    });*/

    $("#newPsw").blur(function (){
        if($("#newPsw").val().length<8)
        {
            $("#newPswError").show();
        }
        else {
            $("#newPswError").hide();
            newPswflag=1;
        }
    });

    $("#savePsw").click(function (){
        if (oldPswflag==1&&newPswflag==1)
        {
            var Psw={};
            Psw.Psw=$("#newPsw").val();
            $.ajax({
                type: "POST",
                url: "savePsw",
                contentType:"application/x-www-form-urlencoded; charset=utf-8",
                data:Psw,
                dateType:"json",
                success: function(result){
                    if (result.msg=="更新失败")
                    {
                        swal(result.msg);
                    }
                    else {
                        $("#update-info").modal('hide');
                        swal(result.msg);
                        $("button").click(function (){
                            location.reload();
                        });
                    }
                },
                error:function (){
                    alert("更新失败");
                }
            });
        }
    });

    $('#addressManage').click(function () {
        location.replace('/minority/info/address');
    });


});
$(function() {
    var tel = $("#telephone");
    var span1 = $("#span1");
    tel.blur(function() {

        if(tel.val() == "") {
            span1.html("*必填项");
        } else {
            var reg_tel = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;    //11位手机号码 正则，正则验证用户输入的数据是否合法
            if(reg_tel.test(tel.val()))
                span1.html("");
            else {
                span1.html("")
            }
        }
    });
});