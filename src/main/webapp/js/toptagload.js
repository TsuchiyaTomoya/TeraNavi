$(function () {
    $("#showtags").on("click",function(){
        $.ajax({
    		url: '/TeraNavi/front/showTag',
    		type: 'POST',
    		dataType: 'json',
    		data: null;
    	})

    });
});
