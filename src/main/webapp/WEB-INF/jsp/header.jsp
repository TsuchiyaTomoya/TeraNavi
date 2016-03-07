<link href="/TeraNavi/css/header.css" rel="stylesheet" type="text/css">
<script src="/TeraNavi/js/search.js"></script>

<div class="hidden-xs">
	<nav class="navbar navbar-default navbar-fixed-top" id="header_bar">
		<div class="container-fluid">
			<div class="navbar-header" >
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbarEexample3">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a href="/TeraNavi/front/top" class="navbar-brand" id="TeraNavi"><img src="/TeraNavi/img/TeraNavi_logo.png" style="width:100px; margin-top:-25px;"></a>
			</div>
			<form method="post" action="/TeraNavi/front/usearch" class="md_sform" id="sform" role="search">
				<select id="target" class="md_target">
					<option value="usearch" selected>ユーザ</option>
					<option value="commList">コミュニティ</option>
					<option value="keywordsearch">ブログ</option>
				</select>
				<input type="text"  name="keyword" class="md_keyword">
				<input type="hidden" name="intention" value="search">
				<span>
					<button type="submit" class="btn btn-default md_searchbutton" id="searchbutton"><i class='fa fa-search' id="searchicon"></i></button>
				</span>
			</form>
			<i class="fa fa-bell-o hidden-xs" id="bell_logo"></i>
			<ul class="nav pull-right">
				<c:choose>
					<c:when test="${not empty sessionScope.loginUser}">
						<li class="dropdown">
							<a href="#" id="username" class="dropdown-toggle" data-toggle="dropdown">
								<img id="account_img" class="hidden-xs" src="${sessionScope.loginUser.iconPath}">
								<span>${sessionScope.loginUser.userName}さん<b class="caret"></b></span>
							</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="/TeraNavi/front/mypage?paramUserId=${sessionScope.loginUser.id}">マイページ</a></li>
								<li><a href="/TeraNavi/front/logout">ログアウト</a></li>
							</ul>
						</li>
					</c:when>
					<c:otherwise>
						<ul class="nav navbar-nav navbar-right list-inline">
							<li><a class="headermenu" href="/TeraNavi/sign">新規登録</a><li>
							<li><a class="headermenu" data-toggle="modal" href="#loginmodal">ログイン</a><li>
						</ul>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</nav>
	
</div>

<div class="visible-xs">
	<div class="navbar navbar-default navbar-fixed-top xs-header-nav">
		<div class="container-fluid">
			<div class="navbar-header">
				<a href="/TeraNavi/front/top" class="navbar-brand" id="TeraNavi"><img src="/TeraNavi/img/TeraNavi_logo.png" style="width:60px; margin-top:-10px;"></a>
				<button type="button" class="navbar-toggle navbar-left" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					
					<li><a href="TeraNavi/front/top">Top</a></li>
					<c:choose>
						<c:when test="${not empty sessionScope.loginUser}">
							<li><a href="/TeraNavi/front/mypage?paramUserId=${sessionScope.loginUser.id}">マイページ</a></li>
							<li><a href="/TeraNavi/front/logout">Logout</a></li>
						</c:when>
						<c:otherwise>
							<li><a data-toggle="modal" href="#loginmodal">Login</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div>

<!-- 横スクロールナビゲーション -->


<%-- 検索モーダル本体 --%>
	<div class="modal fade" id="searchForm" tabindex="-1" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
                <form action="/TeraNavi/front/usearch" method="POST">
                  <div class="form-group">
						<select id="target">
							<option value="usearch" selected>ユーザ</option>
							<option value="commList">コミュニティ</option>
							<option value="keywordsearch">ブログ</option>
						</select>
					  <input type="text" class="form-group" name="keyword" placeholder="検索キーワード">
                  </div>
                  <button type="submit" class="btn btn-default btn-block">検索</button>
                </form>
            </div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">閉じる</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
</div>
	
<div id="loginmodal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content col-xs-12 col-md-12">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h1 class="text-center">ログイン</h1>
				</div>
				<div class="modal-body">
					<form action="/TeraNavi/front/login" method="post">
						<div class="form-group">
							<label class="control-label" for="exampleInputId">ログインID</label>
							<input class="form-control" name="loginId" type="text">
						</div>
						<div class="form-group">
							<label class="control-label" for="exampleInputPass">パスワード</label>
							<input class="form-control" name="password" type="password">
						</div>
						<button type="submit" class="btn btn-default pull-right">送信する</button>
					</form>
					<a href="/TeraNavi/reset">パスワードを忘れた方はこちら</a>
				</div>
				<div class="modal-footer"></div>
			</div><!--end moal-content-->
		</div><!--end modal-dialog-->
	</div><!--end modal-->