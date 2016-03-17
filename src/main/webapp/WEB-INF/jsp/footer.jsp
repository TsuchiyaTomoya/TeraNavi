<link href="/TeraNavi/css/footer.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/TeraNavi/js/footerFixed.js"></script>

<nav class="navbar navbar-default footer" role="navigation" id="footer">
	<footer class="container-fluid">
		<div class="row">
			<div class="col-md-3">
				<h3>TeraNaviについて</h3>
				<a href="/TeraNavi/showRule"><p>利用規約</p></a>
					<a data-toggle="modal" href="#contact-modal"><p>お問い合わせ</p></a>
				<a href="/TeraNavi/help"><p>よくある質問</p></a>
			</div>
			<div class="col-md-4">
				<h3>運営元について</h3>
				<a href="http://www.tera-house.ac.jp/"><p>学校法人 小山学園</p></a>
				<a href="/TeraNavi/showPolicy"><p>プライバシーポリシー</p></a>
			</div>
			<div class="col-md-4">
				<h3>ソーシャル公式アカウント</h3>
				<div id="facebook_icon">
					<a href="#"><img src="/TeraNavi/img/facebook_alt.png"><p>Facebook</p></a>
				</div>
				<div id="twitter_icon">
					<a href="https://twitter.com/TeraNaviInfo"><img src="/TeraNavi/img/twitter_alt.png" width="35px" height="32px"><p>Twitter</p></a>
				</div>
			</div>

			<div id="contact-modal" class="modal fade">
				<div class="modal-dialog">
				<c:choose>
						<c:when test="${not empty sessionScope.loginUser.id}">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h1 class="text-center hidden-xs">お問い合わせ</h1>
									<h3 class="text-center visible-xs" id="mobileContactTitle">お問い合わせ</h3>
								</div>
								<div id="contactM" class="modal-body">
									<form action="/TeraNavi/front/sendContact" method="post">
										<div class="form-group">
											<label class="control-label" for="exampleInputName">お名前</label>
											<input class="form-control" id="contactName" name="name" type="text" value="${sessionScope.loginUser.userName}">
										</div>
										<div class="form-group">
											<label class="control-label" for="exampleInputTitle">件名</label>
											<input class="form-control" id="contactTitle" name="title" type="text">
										</div>
										<div class="form-group">
											<label class="control-label">メールアドレス</label>
											<input class="form-control" id="contactAddress" type="email" name="address" value="${sessionScope.loginUser.mailAddress}">
										</div>
										<div class="form-group">
											<label class="control-label">カテゴリ</label>
											<select class="form-control" id="contactCategory" name="category">
												<option>サイトについて</option>
												<option>その他</option>
											</select>
										</div>
										<div class="form-group">
											<label class="control-label">本文</label>
											<textarea class="form-control" id="contactBody" name="body"></textarea>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<div>
										<button type="button" id="contactBtn" class="btn btn-default pull-right hidden-xs">送信する</button>
										<button type="button" id="contactBtn" class="btn btn-default btn-block pull-right visible-xs">送信する</button>
									</div>
								</div>
							</div><!--end moal-content-->

					</c:when>
					<c:otherwise>
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h1 class="text-center hidden-xs">お問い合わせ</h1>
									<h3 class="text-center visible-xs" id="mobileContactTitle">お問い合わせ</h3>
								</div>
								<div id="contactM" class="modal-body">
									<form action="/TeraNavi/front/sendContact" method="post">
										<div class="form-group">
											<label class="control-label" for="exampleInputName">お名前</label>
											<input class="form-control" id="contactName" name="name" type="text">
										</div>
										<div class="form-group">
											<label class="control-label" for="exampleInputTitle">件名</label>
											<input class="form-control" id="contactTitle" name="title" type="text">
										</div>
										<div class="form-group">
											<label class="control-label">メールアドレス</label>
											<input class="form-control" id="contactAddress" type="email" name="address">
										</div>
										<div class="form-group">
											<label class="control-label">カテゴリ</label>
											<select class="form-control" id="contactCategory" name="category">
												<option>サイトについて</option>
												<option>その他</option>
											</select>
										</div>
										<div class="form-group">
											<label class="control-label">本文</label>
											<textarea class="form-control" id="contactBody" name="body"></textarea>
										</div>
									</form>

								</div>
								<div class="modal-footer">
									<div>
										<button type="button" id="contactBtn" class="btn btn-default pull-right hidden-xs">送信する</button>
										<button type="button" id="contactBtn" class="btn btn-default btn-block pull-right visible-xs">送信する</button>
									</div>

								</div>
							</div><!--end moal-content-->
						</div><!--end modal-dialog-->
					</c:otherwise>
				</c:choose>
				</div><!--end modal-dialog-->
			</div><!--end modal-->
		</div>
	</footer>
</nav>
	<script>
		var ajaxSettings;
		var ajax;
		$(function(){

			ajaxSettings = {
				type:'post',
				url:'/TeraNavi/front/sendContact',
				dataType:'json',
				data:null

			};

			$("#contactBtn").on("click",function(){
				sendContact();
			});
		});

		function sendContact(){

			ajaxSettings.data = {
				ajax:"true",
				name:$("#contactName").val(),
				title:$("#contactTitle").val(),
				address:$("#contactAddress").val(),
				category:$("#contactCategory option:selected").text(),
				body:$("#contactBody").val()
			};

			ajaxSettings.success = function(data){

				var target = $("#contactM");
				target.empty();
				target.append("<h2 style='text-align:center;'>お問い合わせを送信しました</h2>");
			}

			ajax = $.ajax(ajaxSettings);

		}
		</script>
