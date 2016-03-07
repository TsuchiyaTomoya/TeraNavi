$(function(){
    $("#chatwrite").on("click",function(){
        $.ajax({
            url : "/TeraNavi/front/writechat",
            type : "POST",
            dataType : "JSON",
            data : {
                ajax : 'true',
                topicId : $("input[name=topicId]").val(),
                chatBody : $("textarea[name=chatBody]").val(),
                userId : $("input[name=userId]").val()
            }
        })
        .done(function(data){
            $("textarea").val("");
            $(".wrapper").empty();
            // JSON形式で返ってきたものから中身を取り出して表示するサンプル
            for(var i in data){
                var userId = data[i].userId;
                var userName = data[i].userName;
                var iconPath = data[i].iconPath;
                var body = data[i].body;
                var date = data[i].date;

                 var user_id = $("input[name=userId]").val();
                if(userId ==user_id){
                    console.log(i + " " + userId + " "+ body+user_id);

                    $(".wrapper").append("<div class=\"row\"><div class=\"col-md-6\"></div><div class=\"col-md-6\"><div class=\"box\"><p class=\"content\">" + body + "</p></div><p class=\"Mydate\">" + date + "<img class=\"account img-thumbnail\" src=\"" + iconPath + "\"/><p class=\"Myusername\">" + userName + "</p></div></div>");
                }else{
                    console.log(i + " " + userId + " " + body+user_id);
                    $(".wrapper").append("<div class=\"row\"><div class=\"col-md-6\"><div class=\"other_box\"><p class=\"other_content\">" + body + "</p></div><p class=\"date\">" + date + "<p><img class=\"other_account img-thumbnail\" src=\"" + iconPath + "\"/><p class=\"username\">" + userName + "</p></div><div class=\"col-md-6\"></div></div>"
                    );
                }
            }
        })
        .fail(function(data){
            console.log(data);
        });
    });
});
