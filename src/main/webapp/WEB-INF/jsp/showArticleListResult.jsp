<%@ page
   contentType="text/html ; charset=UTF-8"
   pageEncoding="UTF-8"
   import="ttc.bean.ArticleBean"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <title>記事一覧表示</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="/TeraNavi/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
    <%-- ヘッダー部分のHTMLを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>

    <div class="container">
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <h1 class="text-warning" style="margin-bottom:5%">${result[0].userName} さんの投稿記事一覧</h1>
                <table class="table table-striped">
                   <thead>
                       <tr>
                           <c:if test="${sessionScope.loginUser.id eq result[0].userId}" >
                               <th></th>
                           </c:if>
                           <th>タイトル</th>
                           <th>内容</th>
                           <th>投稿日時</th>
                           <c:if test="${sessionScope.loginUser.id eq result[0].userId}" >
                               <th>選択</th>
                           </c:if>
                       </tr>
                   </thead>
                   <tbody>
                       <c:forEach var="article" items="${result}">
                       <tr id="tableRow${article.articleId}">
                           <c:if test="${sessionScope.loginUser.id eq article.userId}" >
                               <td> <a class="btn btn-default btn-sm" href="/TeraNavi/front/showArticle?articleId=${article.articleId}&edit=true">編集</a> </td>
                           </c:if>
                           <td>
                               <a href="/TeraNavi/front/showArticle?articleId=${article.articleId}">
                                   <c:out value="${article.title}"/>
                               </a>
                           </td>
                           <td> ${ fn:substring(article.articleBody, 0, 20) } </td>
                           <td> <c:out value="${article.createdDate}"/> </td>
                           <c:if test="${sessionScope.loginUser.id eq article.userId}" >
                               <td> <input class="chDelete" type="checkbox" name="articleId" value="${article.articleId}"> </td>
                           </c:if>
                       </tr>
                       </c:forEach>
                   </tbody>
               </table>
               <c:if test="${sessionScope.loginUser.id eq result[0].userId}" >
                   <a id="btn_articleDelete" class="btn btn-danger pull-right">削除</a>
               </c:if>
           </div><!--end col-->
       </div><!--end row-->
    </div><!--end container-->
    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>

    <!-- 確認モーダル -->
    <div class="fade modal text-justify" id="articleDeleteModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close pull-right[]" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">×</span>
              </button>
            　<h4 class="modal-title text-center">確認</h4>
             </div>
            <div class="modal-body">
                <p class="text-center">本当に削除しますか？</p>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-block btn-danger" id="btn_modalDelete" data-dismiss="modal">削除</button>
                <button type="button" class="btn btn-block btn-default" data-dismiss="modal">キャンセル</button>
            </div>
          </div>
        </div>
     </div>

     <!-- 結果モーダル -->
      <div class="modal fade" id="deleteArticleResultModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">閉じる</span></button>
              <h4 class="modal-title text-center" id="deleteArticleResultModalLabel">記事削除結果</h4>
            </div>
            <div class="modal-body">
              <p id="deleteArticleResultMessage" class="text-center">記事の削除が完了しました</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">閉じる</button>
            </div>
          </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
      </div><!-- /.modal -->

    <script>

        $(function(){

            $("#btn_articleDelete").on("click",function(){
                $("#articleDeleteModal").modal();
            });

            $("#btn_modalDelete").on("click",function(){

                var checks=[];
                $("[name='articleId']:checked").each(function(){
                    checks.push(this.value);
                });

                $.ajax({
                    // urlで飛ばしたいコマンドを指定してあげる
                  url: '/TeraNavi/front/deleteArticle',
                  type:'POST',
                //   Ajaxは基本的にJSONというデータ形式を使うのが一般的。JSONについては後述。
                  dataType: 'json',
                //   dataでパラメータ名を指定する。コマンド側でgetParameterのときに使います。
                  data:{
                    //   キー:バリューで書く。バリューには変数も使えます。
                    "articleId":checks,
                    ajax:'true'
                  }
               })
                //    成功時の処理
                   .done(function(data) {
                       $("#deleteArticleResultModal").modal();

                       jQuery.each(checks, function() {
                           $("#tableRow" + this).hide();
                        });

                   })
                //    失敗時の処理
                   .fail(function() {
                       $("#deleteArticleResultMessage").text("記事の削除に失敗しました");
                       $("#deleteArticleResultModal").modal();
                   });
            });


        });

    </script>

</body>
</html>
