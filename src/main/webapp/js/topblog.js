/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function topBlogLoad(){
	$.ajax({
		url : "/TeraNavi/front/topBlog",
		type : "POST",
		dataType : "JSON",
		data : {
			ajax : 'true'
		}
	})

	.done(function(data){
		var space = $("#departmentSpace");
		space.empty();

		// 各科ブログのデータの表示
		for(var i in data.department){
			var userId = data.department[i].userId;
			var userName = data.department[i].userName;
			var articleId = data.department[i].articleId;
			var title = data.department[i].title;
			var iconPath = data.department[i].iconPath;
			var body = data.department[i].articleBody;
			var date = data.department[i].createdDate;
			var commentCount = data.department[i].commentCount;

			body = body.replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'');
			body = body.substr(0,30);
			
			var tags = '';
			
			tags+='<div class="row col-md-10 col-xs-10 col-xs-offset-1 col-md-offset-1 well mobile-content-space">';
			
			tags+='<div class="col-md-2 col-xs-12"><br>';
//			PCのアイコン欄生成
			tags+='<div class="hidden-xs">';
			tags+='<a href="/TeraNavi/front/mypage?paramUserId='+userId+'">';
			tags+='<img src="'+iconPath+'" class="img-thumbnail" style="width:100px;height:100px;">';
			tags+='<h3 class="text-muted" style="margin-top:0px;">'+userName+'</h3>';
			tags+='</a>';
			tags+='</div>';
			
//			モバイルのアイコン欄生成
			tags+='<div class="visible-xs">';
			tags+='<a href="/TeraNavi/front/mypage?paramUserId='+userId+'">';
			tags+='<img src="'+iconPath+'" class="img-thumbnail" style="width:100px;height:100px;">';
			tags+='<h5 class="text-muted mobile-user-name" style="margin-top:0px;">'+userName+'</h5>';
			tags+='</a>';
			tags+='</div>';
			
			tags+='</div>';
			
			
			tags+='<div class="col-md-7 col-xs-12">';
//			PCのブログ名・本文の生成
			tags+='<div class="hidden-xs">';
			tags+='<a href="/TeraNavi/front/showArticle?articleId='+articleId+'"><h2 class="text-muted">'+title+'</h2></a>';
			tags+='<p >'+body+'</p>';
			tags+='<div class="text-right">';
			tags+='<a class="btn btn-warning" href="/TeraNavi/front/showArticle?articleId='+articleId+'">続きを読む</a>';
			tags+='</div>';
			tags+='</div>';

//			モバイルのブログ名・本文の生成
			tags+='<div class="visible-xs">';
			tags+='<a href="/TeraNavi/front/showArticle?articleId='+articleId+'"><h5 class="text-muted text-center">'+title+'</h5></a>';
			tags+='<a class="btn btn-warning btn-block" href="/TeraNavi/front/showArticle?articleId='+articleId+'">記事を読む</a>';
			tags+='</div>';

			tags+='</div>';
			
//			PCの日付・コメント数の生成
			tags+='<div class="col-md-3 hidden-xs">';
			tags+='<br><br>';
			tags+='<p>'+date+'</p>';
			tags+='<br>';
			tags+='<p>コメント数 '+commentCount+'</p>';
			tags+='</div>';
			
			tags+='</div>';
			
			space.append(tags);
			
		}
		
		var space2 = $("#blogSpace");
		space2.empty();
		
		//人気ブログの表示
		for(var i in data.blog){
			var headerPath = data.blog[i].headerPath;
			var userId = data.blog[i].userId;
			var title = data.blog[i].title;
			var explanation = data.blog[i].explanation;
			
			explanation = explanation.replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'');
			
			var tags = '';
			tags += '<div class="row col-md-10 col-xs-10 col-xs-offset-1 col-md-offset-1 well mobile-content-space">';//コンテンツの開始div
			
			tags += '<div class="col-md-2 col-xs-12">';//画像表示領域
			
			tags += '<br>';
			tags += '<div class="hidden-xs">';
			tags += '<img src="'+headerPath+'" class="img-thumbnail" style="width:150px;height:50px;">';
			tags += '</div>';
			tags += '<div class="visible-xs">';
			tags += '<img src="'+headerPath+'" class="img-thumbnail" style="width:150px;height:50px;">';
			tags += '</div>';
			
			tags += '</div>';//画像表示領域の終了
			
			
			tags += '<div class="col-md-7 col-xs-12">';//ブログタイトルなど
			
			tags += '<div class="hidden-xs">';
			tags += '<a href="/TeraNavi/front/showBlog?bloguserId='+userId+'"><h2 class="text-muted">'+title+'</h2></a>';
			tags += '<p id="articleBody">'+explanation+'</p>';
			tags += '<div class="text-right">';
			tags += '<a class="btn btn-warning" href="/TeraNavi/front/showBlog?bloguserId='+userId+'">ブログページへ</a>';
			tags += '</div>';
			tags += '</div>';
			
			tags += '<div class="visible-xs">';
			tags += '<a href="/TeraNavi/front/showBlog?bloguserId='+userId+'"><h4 class="text-muted text-center">'+title+'</h4></a>';
			tags += '<p class="mobile-article-body" id="articleBody">'+explanation+'!!</p>';
			tags += '<a class="btn btn-warning btn-block" href="/TeraNavi/front/showBlog?bloguserId='+userId+'">ブログページへ</a>';
			tags += '</div>';
			
			
			tags += '</div>';//ブログタイトルなどの終了
			
			
			tags += '</div>';//コンテンツの終了div
			
			space2.append(tags);
		}
	})
	.fail(function(data){
		console.log(data);
	});
}

