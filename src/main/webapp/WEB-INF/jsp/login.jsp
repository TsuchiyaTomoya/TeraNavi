<html lang="ja">
<head>
    <title>ログイン</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>-->
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="/TeraNavi/css/style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/TeraNavi/js/footerFixed.js"></script>
    <script type="text/javascript" src="/TeraNavi/js/footerFixed.js"></script>
</head>
<body>
    <%-- ヘッダー部分のHTMLを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>


    <div class="container">
       <div class="row">
           <div class="col-md-4 col-md-offset-4" style="margin-top:50px;">
               <h1 class="text-center">ログインページ</h1>
               <form action="/TeraNavi/front/login" method="post">
                   <div class="form-group">
                       <label class="control-label">ログインID</label>
                       <input class="form-control" type="text" name="loginId">
                   </div>
                   <div class="form-group">
                       <label class="control-label">パスワード</label>
                       <input class="form-control" type="password" name="password">
                   </div>
                   <button type="submit" class="btn btn-default pull-right">ログイン</button>
               </form>
           </div>
       </div><!--end row-->
    </div><!--end container-->
    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>
</body>
</html>
