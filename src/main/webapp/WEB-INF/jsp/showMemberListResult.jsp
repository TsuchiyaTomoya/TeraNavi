<%@ page
	contentType="text/html ; charset=UTF-8"
	pageEncoding="UTF-8"
	%>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE html>
	<html lang="ja">
		<head>
			<meta charset="UTF-8">
			<title>コミュニティメンバー</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
            <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
            <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
            <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
        	<script type="text/javascript" src="/TeraNavi/js/fileup.js"></script>

			<link rel="stylesheet" type="text/css" href="/TeraNavi/css/comm.css">

		</head>
		<body>
			<%-- ヘッダー部分のHTMLを読み込み --%>
			<jsp:include page="/WEB-INF/jsp/header.jsp"/>
			<
				<div class="hidden-xs">
					<img src="${result.community.headerPath}" id="headimg">
					<label for="headerFile" id="headerPath">
						<input type="file" id="headerFile" style="display:none">
					</label>

				</div>
				<div class="visible-xs">
					<img src="${result.community.headerPath}" id="mobileHead">
				</div>

				<div class="container-fluid">
					<div class="row">
						<div class="col-md-3"></div>
						<div class="col-md-5 hidden-xs">
							<p> <span id="name" class="col-md-12 text-center" style="position:relative;margin-top:-200px;margin-left:20px;background-color:rgba(255,255,255,0.7);font-size: 60px;">${result.community.name}</span>
							</p>
						</div>
						<div class="col-xs-11 visible-xs">
							<p> <span id="mobileCommName" class="col-xs-12 text-center">${result.community.name}</span>
							</p>
						</div>
						<div class="col-md-4"></div>
					</div>
					<div class="row hidden-xs">
						<div class="col-md-12">
							<img id="icon" src="${result.community.iconPath}" style="width:130px; height:130px; position:relative; bottom:110px; margin-left:50px;"></img>
						</div>
					</div>
					<div class="row visible-xs">
						<div class="col-md-12">
							<img id="mobileCommIcon" src="${result.community.iconPath}"></img>
						</div>
					</div>
					<div class="container">
						<div class="row">
							<form id="grant" action="commGra" method="post">
								<div class="container">
									<div class="row text-center">
										<div class="col-xs-12">
											<h1>コミュニティメンバー</h1>
											<div class="row hidden-xs">
												<c:forEach var="member" items="${result.members}">
													<div class="col-md-3">
														<img src="${member.iconPath}" class="img-responsive">
														<h4>${member.userName}</h4>
														<input type="hidden" name="targetUser" value="${member.id}">
														<input type="hidden" name="communityId" value="${result.value}">
														<c:choose>
															<c:when test="${result.community.adminFlag eq 1}">
																<div class="check"></div>
															</c:when>
														</c:choose>
													</div>
												</c:forEach>
											</div>


											<div class="row visible-xs">
												<table class="table table-striped">
													<tbody>
														<c:forEach var="member" items="${result.members}">
															<tr>
																<td>
																	<img id="mobileMemberIcon" src="${member.iconPath}" class="img-responsive">

																</td>
																<td>
																	<h3>${member.userName}</h4>

																</td>
															</tr>

														</c:forEach>


													</tbody>

												</table>

											</div>
										</div>
									</div>
								</div>
								<c:choose>
									<c:when test="${result.community.adminFlag eq 1}">
										<p id="sub"></p>
									</c:when>
								</c:choose>
							</form>
						</div><!--end row-->
					</div><!--end container-->
				</div>
				<jsp:include page="/WEB-INF/jsp/footer.jsp"/>


				<script>
					$(function () {
						$('.check').append('<input type="checkbox">');
						$('#sub').append('<button type="submit" class="btn btn-warning" form="grant">権限付与する</button>');
					});
				</script>




		</body>
	</html>
