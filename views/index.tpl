<!DOCTYPE html>

<html>
<head>
<title>美剧搜索</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="https://cdn.bootcss.com/amazeui/2.7.2/css/amazeui.min.css" rel="stylesheet" type="text/css">
<style>
	.floatno{
		float:none!important;
	}
</style>
</head>

<body>
	<header class="am-topbar am-topbar-inverse admin-header">
		<div class="am-topbar-brand">
			<strong>美剧搜索</strong>
		</div>
	</header>

	<div class="am-cf admin-main" id="app">
		<!-- content start -->
		<div class="admin-content am-u-sm-10 am-center floatno">
			<div class="admin-content-body">
				<div class="am-g am-center am-u-md-4 floatno">
			        <div class="am-u-sm-12">
			          <div class="am-input-group am-input-group-sm">
			            <input type="text" class="am-form-field" v-model="param.keywords" @keyup.enter="getJson">
				          <span class="am-input-group-btn">
				            <button class="am-btn am-btn-default" type="button" @click="getJson">搜索</button>
				          </span>
			          </div>
			        </div>
			    </div>
				<p></p>
				<div class="am-g" >
					<div class="am-u-sm-12" style="float:auto;">
						<form class="am-form">
							<table class="am-table am-table-striped am-table-hover table-main">
								<tbody>
									<tr v-for="movieInfo in list">
										<td v-text="movieInfo.updateTime"></td>
										<td v-text="movieInfo.name"></td>
										<td v-text="movieInfo.size"></td>
										<td>
											<div class="am-btn-toolbar">
												<div class="am-btn-group am-btn-group-xs">
													<button
														class="am-btn am-btn-default am-btn-xs am-text-secondary">
														<span class="am-icon-pencil-square-o"></span> 复制ed2k
													</button>
													<button
														class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
														<span class="am-icon-copy"></span> 复制magnet
													</button>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<hr />
						</form>
					</div>
				</div>
			</div>
			<footer class="admin-content-footer">
				<hr>
				<p class="am-padding-left">© 2017</p>
			</footer>
		</div>
		<!-- content end -->
	</div>
</body>
</html>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="https://cdn.bootcss.com/vue/2.5.3/vue.min.js"></script>
<script src="https://cdn.bootcss.com/vue-resource/1.3.4/vue-resource.min.js"></script>
<script type="application/javascript">
var app = new Vue({
	el: '#app',
	data: {
		list: {},
		param: {
			keywords: "",
		},
	},
	created: function () {
    	this.getJson();
    },
	methods: {
		getJson: function () {
			var self = this;
			self.$http.post('list', self.param, {emulateJSON:true}).then(function(res) {
				this.list = []
				var list = res.body
				for (var i in list) {
					var day = list[i].day
					var movieInfos = list[i].movieInfos
					for (var m in movieInfos) {
						movieInfos[m].updateTime = day + " " + movieInfos[m].updateTime
						this.list.push(movieInfos[m])
					}
				}
			}).catch(function(err) {
				console.log(err)  
			})
		},
	}
})
</script>