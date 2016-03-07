<%@ page
	contentType="text/html ; charset=UTF-8"
	pageEncoding="UTF-8"
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- saved from url=(0069)file:///C:/GitHub/TeraNavi/src/main/webapp/WEB-INF/design/signUp.html -->
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="utf-8">
	<title>新規登録</title>

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
	<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="/TeraNavi/css/style.css" type="text/css">

</head>
<body>
	<%-- ヘッダー部分のHTMLを読み込み --%>
	<jsp:include page="/WEB-INF/jsp/header.jsp"/>

	<div class="section">
		<div class="container">
			<div class="row">
				<h1 class="text-center">新規登録</h1><br />
				<form id="signForm" action="front/signup" method="post" class="text-center">
				<!-- ここから -->
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label class="pull-left control-label"  for="name">お名前</label>
						<input type="text" form="signForm" id="fName" name="userName" placeholder="田中太郎" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
				<!-- ここまででひとつのインプットを構成する -->
				</form>
			</div><!--end of row-->

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="furi">ふりがな</label>
						<input type="text" form="signForm" id="fNameKana" name="nameKana" placeholder="たなかたろう" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="sex" id="fSex">性別</label>
						男性<input form="signForm" type="radio" name="sex" value="m">
						女性<input form="signForm" type="radio" name="sex" value="f">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="sexVisibleFlag" id="fSexVisible">性別の表示/非表示</label>
						表示<input form="signForm" type="radio" name="sexVisibleFlag" value="0" checked="true">
						非表示<input form="signForm" type="radio" name="sexVisibleFlag" value="1">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>
<!--
			現時点で利用しない情報なのでオミット
			生年月日を利用した機能は追加実装予定
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="birthday">生年月日</label>
						<input type="date" form="signForm" id="fBirthday" name="birthDate" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>
-->

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="mail">メールアドレス</label>
						<input type="mail" form="signForm" id="fMail" name="mailAddress" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="mail">メールアドレス確認</label>
						<input type="mail" name="mailAddress" id="fMail2" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="login">ログインID</label>
						<input type="text" id="fLoginId" form="signForm" name="loginId" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="pass">パスワード</label>
						<input type="password" id="fPassword" form="signForm" name="password" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="pass">パスワード確認</label>
						<input type="password" id="fPassword2" name="password" form="signForm" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="question">秘密の質問</label>
						<select name="questionId" form="signForm" id="fQuestionId" class="form-control">
							<option value="1" selected="true">質問1</option>
							<option value="2">質問2</option>
						</select>
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="answer">回答</label>
						<input type="text" id="fAnswer" form="signForm" name="questionAnswer" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>
			</div>

			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="key">登録キーを入力してください</label>
						<input type="text" name="signKey" id="fKey" form="signForm" class="form-control">
					</div>
				</div>
				<div class="col-md-3"></div>

			</div>
			<div class="row">
				<input type="hidden" name="adminFlag" form="signForm" value="0">
				<div class="hidden-xs">
				<button type="submit" class="btn btn-primary" id="signsubmit" data-toggle="modal" style="margin-left:790px;">確認</button>
				</div>
				<div class="visible-xs col-xs-12">
					<button type="submit" class="btn btn-primary btn-block" id="signsubmitMobile" data-toggle="modal">確認</button>
				</div>

			</div>
			</div>
		</form>

		<!-- モーダルウィンドウの中身 -->
        <div class="fade modal text-justify hidden-xs" id="signup-modal">
        	<div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
            	  <button type="button" class="close pull-right[]" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                  </button>
                  <h4 class="modal-title">新規登録</h4>
                </div>

				<div class="modal-body">
					<div class="row">

						<div class="col-xs-1"></div>
						<div class="col-xs-10">

							<h2>名前</h2>
							<h4 id="sName"></h4>
							<hr size="1" color="#fffff">

							<h2>ふりがな</h2>
							<h4 id="sKana"></h4>
							<hr size="1" color="#fffff">

							<h2>性別</h2>
							<h4 id="sSex"></h4>
							<hr size="1" color="#fffff">

<!--							<label>生年月日</label>
							<h3 id="sBirth"></h3>
							<hr size="1" color="#fffff">-->

							<h2>メールアドレス</h2>
							<h4 id="sMail"></h4>
							<hr size="1" color="#fffff">

							<h2>ログインID</h2>
							<h4 id="sId"></h4>
							<hr size="1" color="#fffff">

							<h2>パスワード</h2>
							<h4 id="sPass"></h4>
							<hr size="1" color="#fffff">

							<h2>秘密の質問</h2>
							<h4 id="sQuestion"></h4>
							<hr size="1" color="#fffff">

							<h2>秘密の回答</h2>
							<h4 id="sAnswer"></h4>
							<hr size="1" color="#fffff">
							<!--<h2 id="sKey"></label>-->
							<p></p>
						</div>
					</div>
                </div>

				<div class="modal-footer">
                	<button type="submit" class="btn btn-block btn-primary" form="signForm">登録</button>
                    <button type="button" class="btn btn-block btn-primary" data-dismiss="modal">キャンセル</button>
                </div>
              </div>
            </div>
         </div>
          <!-- モーダル閉じるやつだよ -->
	  </div>

	<!--モバイル用のmodal-->
	<div class="fade modal text-justify modal-xs" id="signup-modal-mobile">
        	<div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
            	  <button type="button" class="close pull-right[]" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                  </button>
                  <h4 class="modal-title">新規登録</h4>
                </div>

				<div class="modal-body">
					<div class="row">

						<div class="col-xs-1"></div>
						<div class="col-xs-10">

							<label>名前</label>
							<h3 id="sNameMobile"></h3>
							<hr size="1" color="#fffff">

							<label>ふりがな</label>
							<h3 id="sKanaMobile"></h3>
							<hr size="1" color="#fffff">

							<label>性別</label>
							<h3 id="sSexMobile"></h3>
							<hr size="1" color="#fffff">

<!--							<label>生年月日</label>
							<h3 id="sBirthMobile"></h3>
							<hr size="1" color="#fffff">-->

							<label>メールアドレス</label>
							<h3 id="sMailMobile"></h3>
							<hr size="1" color="#fffff">

							<label>ログインID</label>
							<h3 id="sIdMobile"></h3>
							<hr size="1" color="#fffff">

							<label>パスワード</label>
							<h3 id="sPassMobile"></h3>
							<hr size="1" color="#fffff">

							<label>秘密の質問</label>
							<h3 id="sQuestionMobile"></h3>
							<hr size="1" color="#fffff">

							<label>秘密の回答</label>
							<h3 id="sAnswerMobile"></h3>
							<hr size="1" color="#fffff">
							<!--<h2 id="sKey"></label>-->
							<p></p>
						</div>
					</div>
                </div>

				<div class="modal-footer">
                	<button type="submit" class="btn btn-block btn-primary" form="signForm">登録</button>
                    <button type="button" class="btn btn-block btn-primary" data-dismiss="modal">キャンセル</button>
                </div>
              </div>
            </div>
         </div>


	  <jsp:include page="/WEB-INF/jsp/footer.jsp"/>
	  <script>
	  	$("#signsubmit").on("click", function() {
			if($("#fMail").val()==$("#fMail2").val()){
				if($("#fPassword").val()==$("#fPassword2").val()){

					$("#sName").empty();
					$("#sKana").empty();
					$("#sSex").empty();
//					$("#sBirth").empty();
					$("#sMail").empty();
					$("#sId").empty();
					$("#sPass").empty();
					$("#sQuestion").empty();
					$("#sAnswer").empty();
					$("#sKey").empty();

					$("#sName").append($("#fName").val());
					$("#sKana").append($("#fNameKana").val());
					var cSex = $("input[name='sex']:checked").val();
					if(cSex == 'f'){
						cSex = '女';
					}else if (cSex=='m') {
						cSex='男';
					}
					$("#sSex").append(cSex);
//					$("#sBirth").append($("#fBirthday").val());
					$("#sMail").append($("#fMail").val());
					$("#sId").append($("#fLoginId").val());
					$("#sPass").append($("#fPassword").val());
					$("#sQuestion").append($("#fQuestionId option:selected").text());
					$("#sAnswer").append($("#fAnswer").val());
					$("#sKey").append($("#fKey").val());

					$("#signup-modal").modal("show");
				}else{
					alert("パスワードとパスワードの確認が一致しません");
				}
			}else{
				alert("メールアドレスとメールアドレスの確認が一致しません");
			}

	  	});

		$("#signsubmitMobile").on("click", function() {
			if($("#fMail").val()==$("#fMail2").val()){
				if($("#fPassword").val()==$("#fPassword2").val()){

					$("#sNameMobile").empty();
					$("#sKanaMobile").empty();
					$("#sSexMobile").empty();
//					$("#sBirthMobile").empty();
					$("#sMailMobile").empty();
					$("#sIdMobile").empty();
					$("#sPassMobile").empty();
					$("#sQuestionMobile").empty();
					$("#sAnswerMobile").empty();
					$("#sKeyMobile").empty();

					$("#sNameMobile").append($("#fName").val());
					$("#sKanaMobile").append($("#fNameKana").val());
					var cSex = $("input[name='sex']:checked").val();
					if(cSex == 'f'){
						cSex = '女';
					}else if (cSex=='m') {
						cSex='男';
					}
					$("#sSexMobile").append(cSex);
//					$("#sBirthMobile").append($("#fBirthday").val());
					$("#sMailMobile").append($("#fMail").val());
					$("#sIdMobile").append($("#fLoginId").val());
					$("#sPassMobile").append($("#fPassword").val());
					$("#sQuestionMobile").append($("#fQuestionId option:selected").text());
					$("#sAnswerMobile").append($("#fAnswer").val());
					$("#sKeyMobile").append($("#fKey").val());

					$("#signup-modal-mobile").modal("show");
				}else{
					alert("パスワードとパスワードの確認が一致しません");
				}
			}else{
				alert("メールアドレスとメールアドレスの確認が一致しません");
			}

	  	});
	  </script>
</body>
</html>
