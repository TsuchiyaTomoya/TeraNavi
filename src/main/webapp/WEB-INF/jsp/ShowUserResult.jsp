<%@ page
   contentType="text/html ; charset=UTF-8"
   pageEncoding="UTF-8"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <title>検索結果</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="/TeraNavi/css/search.css" rel="stylesheet" type="text/css">

</head>
<body>
    <%-- ヘッダー部分のHTMLを読み込み --%>
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>

	<h2 class="text-center"><b class="page-title">検索結果</b></h2>
    <hr id="hr" class="hr">
    <h3 class="p-level">ユーザの検索結果</h3>

    <br>
    <div class="section">
      <div class="container">
		<c:forEach var="item" items="${result}">
			<div class="row">
			  <div class="col-md-7 col-md-offset-1">
				<img src="${item.iconPath}" class="img-responsive">
                    <div class="prof">
                        <h2>${item.userName}</h2>
                        <h3>${item.nameKana}</h3>
                        <p>${item.profile}</p>
    				    <form action="dmsend" method="post">
                            <div class="form-inline">
                                <label class="control-label">本文</label>
                                <input class="form-control" type="text" name="messageBody">
    				            <input type="hidden" name="receiveUserId" value="${item.id}">
    				            <button type="submit" class="btn btn-default">送信</button>
                            </div>
    				    </form>
			        </div>
                </div>
            </div><br>
	   	</c:forEach><br>
      </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>



</body>
</html>
