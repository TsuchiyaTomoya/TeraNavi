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

	<h5 class="page-title">検索結果</h5>
    <hr id="hr" class="hr">
    <p class="p-level">ブログの検索結果です</p>

    <br>
    <div class="section">
      <div class="container">
		<c:forEach var="item" items="${result}">
			<div class="row">
			  <div class="col-md-3">
				<img src="${item.headerPath}" class="img-responsive">
			  </div>
			  <div class="col-md-9">
                  <a href="/TeraNavi/front/showBlog?bloguserId=${item.userId}">
                      <h1 class="text-muted">${item.title}</h1>
                  </a>
				<h3></h3>
				<p>${item.explanation}<br>
				</p>
			  </div>
			</div>


	   	</c:forEach>
      </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/footer.jsp"/>



</body>
</html>
