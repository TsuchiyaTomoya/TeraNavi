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

					loadPolicy();

				});

				function loadPolicy() {

					ajaxSettings.data = {
						ajax: "true",
						target: "policy"
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
							list.append("<li><a onclick='loadPolicyId(\"" + data.list[i].id + "\")'>" + date + "</a></li>");

							if (i == 0) {
								$("#listMobile").append('<button class="btn btn-default btn-block dropdown-toggle" type="button" data-toggle="dropdown">' + date + '<span class="caret"></span></button>');

							}
							
							listMobile.append("<li '><a onclick='loadPolicyId(\"" + data.list[i].id + "\")'>" + date + "</a></li>");


						}

						$("#list ul li:first").css("border-style", "groove");
					};

					ajax = $.ajax(ajaxSettings);

				}

				function loadPolicyId(id) {
					nowId = id;

					ajaxSettings.data = {
						ajax: "true",
						target: "policy",
						id: id,
						where: " WHERE policy_id = ?"
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
							list.append("<li><a onclick='loadPolicyId(\"" + data.list[i].id + "\")'>" + date + "</a></li>");
							if (data.list[i].id == nowId) {
								$("#list ul li:last").css("border-style", "groove");
								$("#listMobile").append('<button class="btn btn-default btn-block dropdown-toggle" type="button" data-toggle="dropdown">' + date + '<span class="caret"></span></button>');
							}
							
							listMobile.append("<li ><a onclick='loadPolicyId(\"" + data.list[i].id + "\")'>" + date + "</a></li>");
							

						}
					};

					ajax = $.ajax(ajaxSettings);
				}
