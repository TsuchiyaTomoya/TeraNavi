<%--
    Document   : TestExceptionPage
    Created on : 2016/02/18, 11:37:17
    Author     : Masaki
--%>

<%@page pageEncoding="UTF-8" isErrorPage="true"  %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>ロジックエラー</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
		<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">

    </head>
    <body>
       <jsp:include page="/WEB-INF/jsp/header.jsp"/>

			<div class="container">
			   <div class="row">
				   <h1>申し訳ありません、問題が発生しました</h1>

				   <p>処理の最中に何らかの問題が発生しました。もう一度前のページに戻ってやり直して見てください</p>

				   <br>

				   <p>*このページが何度も表示されてしまう場合は、下記の「エラー内容」を添付のうえお問い合わせフォームから連絡をお願いします</p>

				   エラー内容:<br>
				   <textarea readonly="true" cols="100" rows="7">
                       <%
                        exception.getMessage();
                        exception.printStackTrace(new java.io.PrintWriter(out)); 
                       %>

                   </textarea><br>



					<a href="/TeraNavi/front/top">Topへ</a>

			   </div><!--end row-->
			</div><!--end container-->
		<jsp:include page="/WEB-INF/jsp/footer.jsp"/>


    </body>
</html>
