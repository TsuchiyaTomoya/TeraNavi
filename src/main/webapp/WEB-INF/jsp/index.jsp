<html>

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
    rel="stylesheet" type="text/css">
    <link href="https://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
    rel="stylesheet" type="text/css">
    <title>TeraNavi</title>
    <link rel="SHORTCUT ICON" href="/TeraNavi/img/favicon.ico">
    <link rel="stylesheet" type="text/css" href="/TeraNavi/css/index.css">
    <jsp:include page="/WEB-INF/jsp/googleanalytics.jsp" />
  </head>
  <body>
      <div class="cover">
        <div class="cover-image" style="background-image : url('/TeraNavi/img/landing.jpg')"></div>
        <div class="vertical_bottom container">
          <div class="row" id="xsLog">
            <a class="btn btn-warning btn-sm col-xs-offset-7 col-xs-4 visible-xs"
            href="/TeraNavi/login">ログイン</a>
          </div>
          <div class="row">
            <a class="btn btn-warning btn-sm col-xs-4 visible-xs" href="/TeraNavi/sign">登録</a>
            <a class="btn btn-warning btn-sm col-xs-offset-2 col-xs-5 visible-xs"
            href="/TeraNavi/front/top">ログインせずに利用</a>
          </div>
        </div>
      </div>
      
      <div style="background-color:rgba(0,0,0,0.8);position:absolute;top:50%;width:100%;height:180px;">
          <h1 class="text-inverse text-center">TeraNaviへようこそ</h1>
          <p class="text-inverse text-center">東京テクニカルカレッジ関係者のコミュニティサイトです。</p>
          <a class="btn btn-lg btn-warning hidden-xs" style="position:relative;left:45%;" href="/TeraNavi/front/top">TeraNaviへ</a>
    </div>

  </body>

</html>
