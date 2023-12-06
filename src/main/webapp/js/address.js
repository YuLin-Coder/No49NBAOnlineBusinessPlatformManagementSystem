$(document).ready(function (){
    var addresId;
    $("[name='changeAddr']").click(function (){
        $("#update-addr").modal({
            backdrop:'static'
        });

        $("#name").val($(this).parents("#parent").find("#conname").text());
        $("#telephone").val($(this).parents("#parent").find("#contel").text());
        $("#detailaddress").val($(this).parents("#parent").find("#detailaddr").text());
         addresId=$(this).parents("#parent").find("#table").attr("address-id");

    });


    $("#saveAddr").click(function (){

        var isCheck =$('#addrForm').valid();
        if(!isCheck){
            return;
        }

         var saveAddr={};
         saveAddr.addressid=addresId;
         saveAddr.province=$("#provinceUpdate").val();
         saveAddr.city=$("#cityUpdate").val();
         saveAddr.county=$("#countyUpdate").val();
         saveAddr.detailaddr=$("#detailaddress").val();
         saveAddr.conname=$("#name").val();
         saveAddr.contel=$("#telephone").val();
        /*if($("#telephone").val() == null || $("#telephone").val() == ''){

            return false;
        }*/
    /*    if(!validate_add_form()){
            return false;
        }*/
        $.ajax({
            type: "POST",
            url: "../saveAddr",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:saveAddr,
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

    $("[name='deleteAddr']").click(function (){
        addresId=$(this).parents("#parent").find("#table").attr("address-id");
        var address={};
        address.addressid=addresId;
        $.ajax({
            type: "POST",
            url: "../deleteAddr",
            contentType:"application/x-www-form-urlencoded; charset=utf-8",
            data:address,
            dateType:"json",
            success:function (result){
                swal(result.msg);
                $("button").click(function (){
                    location.reload();
                });
            },
            error:function (){
                alert("删除失败");
            }
            });
    });

    $("#addAddr").click(function () {
        $("#insert-addr").modal({
            backdrop:'static'
        });
    });

    $("#insertAddr").click(function (){
        var isCheck= $('#insert-form').valid();
        if(!isCheck){
            return;
        }

        var insertAddr={};
        insertAddr.addressid={};
        insertAddr.userid={};
       insertAddr.province=$("#provinceInsert").val();
       insertAddr.city=$("#cityInsert").val();
        insertAddr.county=$("#countyInsert").val();
        insertAddr.detailaddr=$("#detailaddressInsert").val();
        insertAddr.conname=$("#nameInsert").val();
    /*    if($("#nameInsert").val() == null || $("#nameInsert").val() == ''){

            return false;
        }*/
       insertAddr.contel=$("#telephoneInsert").val();
/*        if($("#telephoneInsert").val() == null || $("#telephoneInsert").val() == ''){

            return false;
        }*/
       $.ajax({
           type:"POST",
           url:"../insertAddr",
           contentType:"application/x-www-form-urlencoded; charset=utf-8",
           data:insertAddr,
           dataType:"json",
           success:function (result){
               swal(result.msg);
               $("button").click(function (){
                   var query = {};
                   var qitems = location.search.substr(1).split('&')||[];
                   for(var i =0;i<qitems.length;i++){
                       var i = qitems[i].split('=');
                       query[i[0]]=i[1];
                   }
                   if(query['from']&&query['from']==='pay'){
                       location.replace('/minority/order');
                       return;
                   }

                   location.reload();
               });
           },
           error:function (){
               alert("添加失败");
           }
       });

    });
});