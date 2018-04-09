<!DOCTYPE html>

<html>
<head>
<title>美剧搜索</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" Content="zh-CN">
<meta name="Keywords" Content="美剧,美剧搜索,美剧下载,下载美剧">
<link href="https://cdn.bootcss.com/amazeui/2.7.2/css/amazeui.min.css" rel="stylesheet" type="text/css">
<style>
	.floatno{
		float:none!important;
	}
	
	.search-hot {
	  width: 720px;
	  margin: 30px auto 0 auto;
	}
	.search-hot li {
	  display: inline-block;
	  padding: 5px 10px;
	  color: #336699;
	}
	.search-hot li a {
	  color: #336699;
	}
	.search-hot li a.hot:before {
	  content: "\f111";
	  display: inline-block;
	  font-family: 'Font Awesome 5 Pro';
	  font-size: inherit;
	  text-rendering: auto;
	  -webkit-font-smoothing: antialiased;
	  -moz-osx-font-smoothing: grayscale;
	  font-weight: 900;
	  transform: scale(0.5);
	  color: #19e619;
	}
	.search-hot li.title {
	  display: block;
	  font-size: 1.1rem;
	  color: #4d4d4d;
	}
	
</style>
</head>

<body>
	<header class="am-topbar am-topbar-inverse admin-header">
		<div class="am-topbar-brand">
			<strong><a href="/">美剧搜索</a></strong>
		</div>
	</header>

	<div class="am-cf admin-main" id="app">
		<!-- content start -->
		<div class="admin-content am-u-sm-10 am-center floatno">
			<div class="admin-content-body">
				<div class="am-g am-center am-u-md-4 floatno">
			        <div class="am-u-sm-12">
			          <div class="am-input-group am-input-group-sm">
			            <input type="text" class="am-form-field" v-model="param.keywords" @keyup.enter="toList">
				          <span class="am-input-group-btn">
				            <button class="am-btn am-btn-default" type="button" @click="toList">搜索</button>
				          </span>
			          </div>
			        </div>
			    </div>
				<p></p>
				<ul class="search-hot">
					<li class="title">热门搜索：</li>
					<li v-for="(key, index) in keys">
						<a v-bind:href="'list?k=' + encodeURI(key)" v-text="key"></a>
					</li>
				</ul>
			</div>
			<footer class="admin-content-footer">
				<hr>
				<p class="am-padding-left">© 2018</p>
			</footer>
		</div>
		<!-- content end -->
	</div>
</body>
</html>
<script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="https://cdn.bootcss.com/vue/2.5.15/vue.min.js"></script>
<script src="https://cdn.bootcss.com/vue-resource/1.5.0/vue-resource.min.js"></script>
<script type="application/javascript">
var json = "${.json}";
var obj = $.parseJSON(json);
var app = new Vue({
	el: '#app',
	data: {
		keys: obj.data.hotkey,
		param: {
			keywords: "",
		},
	},

	methods: {
		toList: function () {
			window.location = "list?k=" + encodeURI(this.param.keywords);
		},
	}
})

</script>
