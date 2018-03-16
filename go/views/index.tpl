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
				<section data-am-widget="accordion" class="am-accordion am-accordion-gapped" data-am-accordion='{  }' id="sectionList">
			      <dl class="am-accordion-item" v-for="(movieInfo, index) in list" v-bind:id="'dl_' + index">
			        <dt class="am-accordion-title" v-bind:id="'dt_' + index" v-bind:index="index" onclick="toggle(this);">
				          <div class="am-g">
						  <div class="am-u-sm-6 am-u-lg-2">
						    <span class="am-show-md-down" ></span>
						    <span class="am-hide-md-down" v-text="movieInfo.updateTime"></span>
						  </div>
						  <div class="am-u-sm-6 am-u-lg-8">
						    <span class="am-show-md-down" ></span>
						    <span class="am-hide-md-down" v-text="movieInfo.name"></span>
						  </div>
						  <div class="am-u-sm-12 am-u-lg-2">
						    <span class="am-show-md-down" ></span>
						    <span class="am-hide-md-down" v-text="movieInfo.size"></span>
						  </div>
						</div>
			        </dt>
			        <dd class="am-accordion-bd am-collapse" v-bind:id="'dd_' + index">
			          <!-- 规避 Collapase 处理有 padding 的折叠内容计算计算有误问题， 加一个容器 -->
			          <div class="am-accordion-content" >
						<p style="word-wrap:break-word;" v-text="movieInfo.ed2k"></p>
						<hr data-am-widget="divider" style="" class="am-divider am-divider-dotted" />
						<p style="width:100%; word-wrap:break-word;" v-text="movieInfo.magnet"></p>
			          </div>
			        </dd>
			      </dl>
			  	</section>
				<!-- 分页 start -->
				<ul data-am-widget="pagination"
				      class="am-pagination am-pagination-default">
				
				      <li class="am-pagination-prev ">
				        <a href="#" class="">上一页</a>
				      </li>
				
		            <li class="">
		              <a href="#" class="">1</a>
		            </li>
		            <li class="am-active">
		              <a href="#" class="am-active">2</a>
		            </li>
		            <li class="">
		              <a href="#" class="">3</a>
		            </li>
		            <li class="">
		              <a href="#" class="">4</a>
		            </li>
		            <li class="">
		              <a href="#" class="">5</a>
		            </li>
				
				      <li class="am-pagination-next ">
				        <a href="#" class="">下一页</a>
				      </li>
				  </ul>
				  <!-- 分页 end -->
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
				this.list = res.body
			}).catch(function(err) {
				console.log(err)  
			})
		},
	}
})

var lastDt;
function toggle(e) {
	$(".am-active, .am-in").removeClass("am-active am-in");
	var index = $(e).attr("index");

	if (lastDt != e) {
		$("#dl_" + index).addClass("am-active");
		$("#dd_" + index).addClass("am-in");
		lastDt = e;
	} else {
		lastDt = null;
	}
}

</script>
