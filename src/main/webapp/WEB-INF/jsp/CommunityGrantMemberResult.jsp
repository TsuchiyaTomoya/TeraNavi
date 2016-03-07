<%@ page
   contentType="text/html ; charset=UTF-8"
   pageEncoding="UTF-8"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>権限付与完了</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/TeraNavi/js/fileup.js"></script>



</head>
<body>
    <%-- ヘッダー部分のHTMLを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>

    <div class="section">
        <div class="container">
           <div class="row">

               <div calss="col-md-8">


                            <h1>権限を付与しました！</h1>
                            <p>３秒後にコミュニティに戻ります<br>
                                戻らないに場合は<a href="/TeraNavi/front/showcomm?commId=${result.commId}">こちら</a></p>
                </div>
            </div>

        </div><!--end row-->
    </div><!--end container-->
    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>
    <script>
    $(document).ready( function(){

        setTimeout(function(){
            window.location.href = './showcomm?commId=${result.commId}';
        }, 3000);

    });


    </script>

</body>
</html>
