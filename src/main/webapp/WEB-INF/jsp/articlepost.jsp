<%@ page
   contentType="text/html ; charset=UTF-8"
   pageEncoding="UTF-8"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>

    <meta charset="UTF-8">

    <title>記事を書く</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="/TeraNavi/js/wysiwyger.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="/TeraNavi/js/fileup.js"></script>
    <script src="/TeraNavi/js/ckeditor/ckeditor.js"></script>
</head>
<body>
    <%-- ヘッダー部分のHTMLを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>

    <%-- トップのナビゲーションを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/topnav.jsp"/>

    <div class="section">
        <div class="container">
           <div class="row">

                <!-- 2列をサイドメニューに割り当て -->
                <div class="col-md-2">
                    <jsp:include page="/WEB-INF/jsp/mypagenav.jsp"/>
                    <script>
                      $("#articlePostTab").attr("class","active");
                    </script>
                </div>


                <!-- 残り8列はコンテンツ表示部分として使う -->
                <div calss="col-md-8">

                    <div class="row">
                        <form action="/TeraNavi/front/articlepost" method="post" id="articleForm" role="form">
                            <div class="form-group">
                                <div class="input-group col-md-8">
                                    <label class="control-label">タイトル</label>
                                    <input type="text" name="title" class="form-control" id="inputTitle">
                                </div>
                                <br>

                                <div class="input-group col-md-8">
                                    <label class="control-label">内容</label>
                                    <textarea class="ckeditor" id="inputBody" name="body"></textarea>
                                </div>
                                <div class="col-md-2" style="padding-left:0px;">
                                    <a class="btn btn-default btn-block" id="btn_addTag">タグ追加</a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="row">

                    </div>

                    <div class="row">
                        <div class="col-md-4 col-md-offset-2">
                            <button type="button" class="btn btn-default pull-right" id="btn_preview">プレビュー</button>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-default pull-right" id="btn_draft">下書き保存</button>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-lg btn-warning pull-right" id="btn_post">投稿</button>
                        </div>
                    </div>

                    <form action="/TeraNavi/front/draftArticle" method="post" id="draftForm">
                        <input type="hidden" name="title" value="" id="draftTitle">
                        <input type="hidden" name="body" value="" id="draftBody">
                    <form>

                    <br>
                    <h1>記事投稿ページ</h1>
                    <form action="/TeraNavi/front/articlepost" method="post">
                        タイトル <input type="text" name="title"><br>
                        内容 <textarea id="tbody" name="body" rows="4" cols="40" ondrop="onDrop(event)" ondragover="onDragOver(event)"></textarea><br>
                        <input type="submit" value="投稿">
                    </form>

                    <h1>下書き</h1>
                    <form action="/TeraNavi/front/draftArticle" method="post">
                        タイトル <input type="text" name="title"><br>
                        内容 <textarea id="tbody" name="body" rows="4" cols="40" ondrop="onDrop(event)" ondragover="onDragOver(event)"></textarea><br>
                        <input type="submit" value="投稿">
                    </form>

                </div><!-- end col-8コンテンツ -->

           </div><!--end row-->
        </div><!--end container-->
    </div><!--end section-->
    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>

    <!-- タグ選択モーダル -->
    <div class="fade modal text-justify" id="addTagModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close pull-right[]" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">×</span>
              </button>
            　<h4 class="modal-title text-center">タグ追加</h4>
             </div>
            <div class="modal-body" id="addTagModalBody">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-block btn-default" data-dismiss="modal">確定</button>
            </div>
          </div>
        </div>
     </div>

    <!-- 確認モーダル -->
    <div class="fade modal text-justify" id="articlePostModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close pull-right[]" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">×</span>
              </button>
            　<h4 class="modal-title text-center">確認</h4>
             </div>
            <div class="modal-body" id="articlePostModalBody">
                <p>この内容でよろしいですか？</p><br>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-block btn-warning" id="btn_modalArticlePost" data-dismiss="modal">投稿</button>
                <button type="button" class="btn btn-block btn-default" data-dismiss="modal">キャンセル</button>
            </div>
          </div>
        </div>
     </div>

    <!-- 結果モーダル -->
     <div class="modal fade" id="articlePostResultModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">閉じる</span></button>
             <h4 class="modal-title text-center" id="articlePostResultModalLabel">記事の投稿結果</h4>
           </div>
           <div class="modal-body">
             <p id="articlePostResultMessage" class="text-center">記事の投稿が完了しました</p>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">閉じる</button>
           </div>
         </div><!-- /.modal-content -->
       </div><!-- /.modal-dialog -->
     </div><!-- /.modal -->

	<script>
		var ajaxSettings;
		var ajax;
		$(function(){

            //タグ一覧を取得する処理-----------------------------------------------------------
            $.ajax({
                // urlで飛ばしたいコマンドを指定してあげる
              url: '/TeraNavi/front/getTagList',
              type:'POST',
              dataType: 'json',
            //   dataでパラメータ名を指定する。コマンド側でgetParameterのときに使います。
              data:{
                //   キー:バリューで書く。バリューには変数も使えます。
                ajax:'true'
              }
            })
            //    成功時の処理
               .done(function(data) {
                  //タグ選択モーダルにタグ一覧を入れ込む
                  var atmBody = $("#addTagModalBody")
                  for(var i in data){
                      var tagId = data[i].id;
                      var tagName = data[i].name;
                      atmBody.append(
                        '<label class="checkbox-inline">\n\
                            <input type="checkbox" name="chTag" value="'+tagId+'">\n\
                                '+tagName+'\n\
                        </label>'
                      );
                  }
               })
            //    失敗時の処理
               .fail(function() {

               });

            //タグ選択モーダルを出す処理---------------------------------------------
            $("#btn_addTag").on("click",function(){
               $("#addTagModal").modal();
            });

            //記事投稿の際の確認モーダルを出す処理---------------------------------------------
            $("#btn_post").on("click",function(){
                var apmBody = $("#articlePostModalBody");
                var title = $("#inputTitle").val();
                var body = CKEDITOR.instances.inputBody.getData();
                $("#articlePostModalBody").empty();
                apmBody.append('<h1 class="text-center">'+title+'</h1><br>'+body);
                $("#articlePostModal").modal();
            });

            //記事を投稿する処理--------------------------------------------------------------
            $("#btn_modalArticlePost").on("click",function(){

                var checks=[];
                $("[name='chTag']:checked").each(function(){
                    checks.push(this.value);
                });

                $.ajax({
                    // urlで飛ばしたいコマンドを指定してあげる
                  url: '/TeraNavi/front/articlepost',
                  type:'POST',
                  dataType: 'json',
                //   dataでパラメータ名を指定する。コマンド側でgetParameterのときに使います。
                  data:{
                    //   キー:バリューで書く。バリューには変数も使えます。
                    title:$("#inputTitle").val(),
                    body:CKEDITOR.instances.inputBody.getData(),
                    tag:checks,
                    ajax:'true'
                  }
                })
                //    成功時の処理
                   .done(function(data) {
                      $("#articlePostResultModal").modal();
                   })
                //    失敗時の処理
                   .fail(function() {
                       $("#articlePostResultMessage").text("記事を投稿できませんでした");
                       $("#articlePostResultModal").modal();
                   });
            });

            //下書き保存する処理--------------------------------------------------------------
            $("#btn_draft").on("click",function(){

                var checks=[];
                $("[name='chTag']:checked").each(function(){
                    checks.push(this.value);
                });

                $.ajax({
                    // urlで飛ばしたいコマンドを指定してあげる
                  url: '/TeraNavi/front/draftArticle',
                  type:'POST',
                //   Ajaxは基本的にJSONというデータ形式を使うのが一般的。JSONについては後述。
                  dataType: 'json',
                //   dataでパラメータ名を指定する。コマンド側でgetParameterのときに使います。
                  data:{
                    //   キー:バリューで書く。バリューには変数も使えます。
                    title:$("#inputTitle").val(),
                    body:CKEDITOR.instances.inputBody.getData(),
                    tag:checks,
                    ajax:'true'
                  }
               })
                //    成功時の処理
                   .done(function(data) {
                      $("#articlePostResultModalLabel").text("記事の下書き保存結果");
                      $("#articlePostResultMessage").text("記事の下書き保存が完了しました");
                      $("#articlePostResultModal").modal();
                   })
                //    失敗時の処理
                   .fail(function() {
                       $("#articlePostResultMessage").text("記事を下書き保存できませんでした");
                       $("#articlePostResultModal").modal();
                   });
            });


			ajaxSettings = {
				type:'post',
				url:'upload',
				processData:false,
				contentType:false,
				cache:false,
				dataType:'json',
				success:function(data){
					console.log("success");
					var text = $("#tbody").val();
					$("#tbody").val(text+"<br>"+data.result);
				}
			}


            $("#btn_preview").on("click",function(){
                alert($(':text[name="inputTitle"]').val());
            });

		});

		function onDrop(event){
			var files = event.dataTransfer.files;


			for(var i = 0;i < files.length;i++){

				var f = files[i];
				var formData = new FormData();
				formData.append("file",f);
				ajaxSettings.data = formData;
				ajax = $.ajax(ajaxSettings);
			}

			event.preventDefault();
		}

		function onDragOver(event){
			event.preventDefault();
		}

	</script>
</body>
</html>
