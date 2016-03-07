<%@ page
	contentType="text/html ; charset=UTF-8"
	pageEncoding="UTF-8"
	%>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!DOCTYPE html>
	<html lang="ja">
		<head>
			<meta charset="UTF-8">
			<title>利用規約</title>
			<!-- Latest compiled and minified CSS -->
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
			<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
			<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
			<link href="/TeraNavi/css/policy.css" rel="stylesheet" type="text/css">


		</head>
		<body>
			<%-- ヘッダー部分のHTMLを読み込み --%>
			<jsp:include page="/WEB-INF/jsp/header.jsp"/>

			<div class="section hidden-xs">
				<div class="container">
					<div class="row">
						<div class="col-md-10 col-md-offset-1">
							<h1>利用規約最新版</h1>
						</div>
					</div>
				</div>
			</div>

			<div class="visible-xs col-xs-10 col-xs-offset-1">
				<h2>利用規約最新版</h2>
			</div>

			<div class="section">
				<div class="container">
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<div id="listMobile" class=" dropdown visible-xs">
								
							</div>
							<div id="main">
								<h1>少々お待ちください</h1>
							</div>
						</div>
						<div class="col-md-2 hidden-xs">
							<div id="list">
								<ul>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>


			<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

			<script>
				var ajaxSettings;
				var ajax;
				var nowId;
				$(function () {

					ajaxSettings = {
						type: 'post',
						url: '/TeraNavi/front/TermsDisplay',
						dataType: 'json',
						data: null

					};

					loadRule();

				});

				function loadRule() {

					ajaxSettings.data = {
						ajax: "true",
						target: "rule"
					};

					ajaxSettings.success = function (data) {

						var main = $("#main");
						var list = $("#list ul");

						$("#listMobile").empty();
						$("#listMobile").append('<ul class="dropdown-menu" style="width:100%;"></ul>');

						var listMobile = $("#listMobile ul");




						main.empty();
						list.empty();
						
						main.append("<p>" + data.main.date + "</p>");
						main.append("<p>" + data.main.body + "</p>");
						list.append("<h1>リスト</h1>");
						for (var i = 0; i < data.list.length; i++) {
							var date = data.list[i].date.slice(0, 10);
							list.append("<li><a onclick='loadRuleId(\"" + data.list[i].id + "\")'>" + date + "</a></li>");

							if (i == 0) {
								$("#listMobile").append('<button class="btn btn-default btn-block dropdown-toggle" type="button" data-toggle="dropdown">' + date + '<span class="caret"></span></button>');

							}
							
							listMobile.append("<li '><a onclick='loadRuleId(\"" + data.list[i].id + "\")'>" + date + "</a></li>");


						}

						$("#list ul li:first").css("border-style", "groove");
					};

					ajax = $.ajax(ajaxSettings);

				}

				function loadRuleId(id) {
					nowId = id;

					ajaxSettings.data = {
						ajax: "true",
						target: "rule",
						id: id,
						where: " WHERE rule_id = ?"
					};

					ajaxSettings.success = function (data) {

						var main = $("#main");
						var list = $("#list ul");

						$("#listMobile").empty();
						$("#listMobile").append('<ul class="dropdown-menu" style="width:100%;"></ul>');
						
						var listMobile = $("#listMobile ul");
						
						main.empty();
						list.empty();
						

						main.append("<p>" + data.main.date + "</p>");
						main.append(data.main.body);

						list.append("<h1>リスト</h1>");
						for (var i = 0; i < data.list.length; i++) {

							var date = data.list[i].date.slice(0, 10);
							list.append("<li><a onclick='loadRuleId(\"" + data.list[i].id + "\")'>" + date + "</a></li>");
							if (data.list[i].id == nowId) {
								$("#list ul li:last").css("border-style", "groove");
								$("#listMobile").append('<button class="btn btn-default btn-block dropdown-toggle" type="button" data-toggle="dropdown">' + date + '<span class="caret"></span></button>');
							}
							
							listMobile.append("<li ><a onclick='loadRuleId(\"" + data.list[i].id + "\")'>" + date + "</a></li>");
							

						}
					};

					ajax = $.ajax(ajaxSettings);
				}

			</script>

		</body>
	</html>
