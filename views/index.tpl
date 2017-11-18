<!DOCTYPE html>

<html>
<head>
<title>Beego</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.css" rel="stylesheet" type="text/css">
<link href="http://cdn.amazeui.org/amazeui/2.7.2/css/amazeui.min.css" rel="stylesheet" type="text/css">
</head>

<body>
	<header class="am-topbar am-topbar-inverse admin-header">
		<div class="am-topbar-brand">
			<strong>美剧搜索</strong>
		</div>
	</header>

	<div class="am-cf admin-main" id="app">
		<!-- content start -->
		<div class="admin-content">
			<div class="admin-content-body">
				<div class="am-cf am-padding am-padding-bottom-0">
					<div class="am-fl am-cf">
						<strong class="am-text-primary am-text-lg">表格</strong>
						<button type="button" @click="getJson"
														class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
														<span class="am-icon-copy"></span> 复制
													</button>
					</div>
				</div>

				<hr>
			
				<div v-for="item in list">
					<div class="am-g">
						<div class="am-u-sm-12 am-u-md-6">
							<div class="am-btn-toolbar">
								<div class="am-btn-group am-btn-group-xs" v-text="item.day"></div>
							</div>
						</div>
					</div>
	
					<div class="am-g">
						<div class="am-u-sm-12">
							<form class="am-form">
								<table
									class="am-table am-table-striped am-table-hover table-main">
									<tbody>
										<tr>
											<td><input type="checkbox" /></td>
											<td>1</td>
											<td><a href="#">Business management</a></td>
											<td>default</td>
											<td class="am-hide-sm-only">测试1号</td>
											<td class="am-hide-sm-only">2014年9月4日 7:28:47</td>
											<td>
												<div class="am-btn-toolbar">
													<div class="am-btn-group am-btn-group-xs">
														<button
															class="am-btn am-btn-default am-btn-xs am-text-secondary">
															<span class="am-icon-pencil-square-o"></span> 编辑
														</button>
														<button
															class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
															<span class="am-icon-copy"></span> 复制
														</button>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td><input type="checkbox" /></td>
											<td>2</td>
											<td><a href="#">Business management</a></td>
											<td>default</td>
											<td class="am-hide-sm-only">测试1号</td>
											<td class="am-hide-sm-only">2014年9月4日 7:28:47</td>
											<td>
												<div class="am-btn-toolbar">
													<div class="am-btn-group am-btn-group-xs">
														<button
															class="am-btn am-btn-default am-btn-xs am-text-secondary">
															<span class="am-icon-pencil-square-o"></span> 编辑
														</button>
														<button
															class="am-btn am-btn-default am-btn-xs am-hide-sm-only">
															<span class="am-icon-copy"></span> 复制
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
<script src="http://cdn.amazeui.org/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="https://cdn.bootcss.com/vue/2.5.3/vue.min.js"></script>
<script src="https://cdn.bootcss.com/vue-resource/1.3.4/vue-resource.min.js"></script>
<script type="application/javascript">
var app = new Vue({
	el: '#app',
	data: {
		list: {},
	},
	methods: {
		getJson: function () {
			var self = this;
				console.log(111111)  
			self.$http.get('list').then(function(res) {
				this.list = res.body
			}).catch(function(err) {
				console.log(err)  
			})
		},
	}
})
</script>