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
			            <input type="text" class="am-form-field" v-model="param.key" @keyup.enter="getJson">
				          <span class="am-input-group-btn">
				            <button class="am-btn am-btn-default" type="button" @click="getJson">搜索</button>
				          </span>
			          </div>
			        </div>
			    </div>
				<p></p>
				<section data-am-widget="accordion" class="am-accordion am-accordion-gapped" data-am-accordion='{  }' id="sectionList">
			      <dl class="am-accordion-item" v-for="(movieInfo, index) in dayMovies" v-bind:id="'dl_' + index">
			        <dt class="am-accordion-title" style="cursor: default;" v-bind:id="'dt_' + index" v-bind:index="index" >
						<div class="am-g">
							<div class="am-u-sm-2" v-text="movieInfo.updateTime"></div>
							<div class="am-u-sm-7" v-text="movieInfo.name" style="cursor:pointer;" onclick="toggle(this)" v-bind:index="index"></div>
							<div class="am-u-sm-1" v-text="movieInfo.size"></div>
							<div class="am-u-sm-2">
								<button type="button" class="js-copy am-btn am-btn-primary am-round" v-bind:data-clipboard-text="movieInfo.ed2k" onclick="alert('已复制链接,请粘贴到迅雷等下载工具中')" ><i class="am-icon-copy"></i>ED2K</button>
								<button type="button" class="js-copy am-btn am-btn-secondary am-round" v-bind:data-clipboard-text="movieInfo.magnet" onclick="alert('已复制链接,请粘贴到迅雷等下载工具中')"><i class="am-icon-copy"></i>MAG</button>
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
				<ul data-am-widget="pagination" class="am-pagination am-pagination-default">
			        <li v-for="(p, index) in pageInfos"  v-bind:lirequrl="p.reqUrl">
			          <a v-bind:reqUrl="p.reqUrl" v-text="p.text" @click="doPage" href="javascript:void(0);"></a>
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
<script src="https://cdn.bootcss.com/clipboard.js/2.0.0/clipboard.min.js"></script>
<script src="https://cdn.bootcss.com/amazeui/2.7.2/js/amazeui.min.js"></script>
<script src="https://cdn.bootcss.com/vue/2.5.15/vue.min.js"></script>
<script src="https://cdn.bootcss.com/vue-resource/1.5.0/vue-resource.min.js"></script>
<script type="application/javascript">


var app = new Vue({
	el: '#app',
	data: {
		dayMovies: {},
		pageInfos: {},
		param: {
			keywords: "",
			key: b64_to_utf8("${.k}"),
			requrl: "",
		},
	},
	created: function () {
    	this.getJson();
    },

	updated: function () {
		$(".am-pagination li").each(function( index ) { // 解决分页按钮样式bug
			if ($(this).attr("lirequrl") == "") {
				$(".am-active").removeClass("am-active");
				$(this).addClass("am-active");
			}
		});
    },
	
	methods: {
		getJson: function () {
			var self = this;
			if (self.param.key && self.param.key != "") {
				self.param.keywords = utf8_to_b64(self.param.key);
			}
			self.$http.post('listjson', self.param, {emulateJSON:true}).then(function(res) {
				shrink();
				dataHanlder(self, res)
			}).catch(function(err) {
				console.log(err)  
			})
		},

		doPage: function (e) {
			var self = this;
			var requrl = e.target.getAttribute("requrl");
			if (requrl == "") return;
			
			self.param["requrl"] = requrl;
			self.$http.post('page', self.param, {emulateJSON:true}).then(function(res) {
				shrink();
				dataHanlder(self, res)
			}).catch(function(err) {
				console.log(err)  
			})
		},
	}
})

var lastDt;
function toggle(e) {
	shrink();
	var index = $(e).attr("index");

	if (lastDt != e) {
		$("#dl_" + index).addClass("am-active");
		$("#dd_" + index).addClass("am-in");
		lastDt = e;
	} else {
		lastDt = null;
	}
}

function dataHanlder(self, res) {
	var jsonData = jQuery.parseJSON(b64_to_utf8(res.body));
	self.dayMovies = jsonData.dayMovies;
	var pageInfos = jsonData.pageInfos;
	
	for (var i in pageInfos) {
		
		switch(pageInfos[i].text) {
		case "Frist":
			pageInfos[i].text = "第一页";
		  	break;
		case "Previous":
			pageInfos[i].text = "上一页";
		  	break;
		case "Next":
			pageInfos[i].text = "下一页";
		  	break;
		case "Last":
			pageInfos[i].text = "最末页";
			break;
		}	
	}
	
	self.pageInfos = pageInfos;
}

function shrink() {
	$("#sectionList .am-active, #sectionList .am-in").removeClass("am-active am-in");
}

var clipboard = new ClipboardJS('.js-copy');

function utf8_to_b64(str) {
    return window.btoa(unescape(encodeURIComponent(str)));
}

function b64_to_utf8(str) {
    return decodeURIComponent(escape(window.atob(str)));
}

</script>
