<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <!-- import CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/element-ui/2.2.1/theme-chalk/index.css">
<style>
.el-header, .el-footer {
    background-color: #B3C0D1;
    color: #333;
    text-align: left;
    line-height: 60px;
  }
  
  .el-main {
    background-color: #E9EEF3;
    color: #333;
    text-align: center;
    line-height: 100%;
  }
  
  body > .el-container {
    margin-bottom: 40px;
  }

  .el-row {
    margin-bottom: 20px;
    &:last-child {
      margin-bottom: 0;
    }
  }
  .el-col {
    border-radius: 4px;
  }
  .bg-purple-dark {
    background: #99a9bf;
  }
  .bg-purple {
    background: #d3dce6;
  }
  .bg-purple-light {
    background: #e5e9f2;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 36px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }

</style>
</head>
<body>
<div id="app">
<el-container>
  <el-header>美剧搜索</el-header>
	<el-main>
		<!-- 搜索区 start -->
		<el-row>
			<el-col :span="8"><div class="grid-content"></div></el-col>
			<el-col :span="8">
				<div class="grid-content bg-purple-light">
					<el-input placeholder="请输入片名" v-model="param.keywords" prefix-icon="el-icon-search" clearable @keyup.enter="getJson">
					</el-input>
				</div>
			</el-col>
			<el-col :span="8">
				<div class="grid-content" align="left">
					&nbsp;
					<el-button type="primary" plain @click="getJson">搜索</el-button>
				</div>
			</el-col>
		</el-row>
		<!-- 搜索区 end -->
		
		<!-- 列表区 start -->
		<template>
		    <el-table :data="tableData" style="width: 100%">
				<el-table-column label="" width="180" align="left">
				</el-table-column>
				<el-table-column label="日期" width="180" align="left">
				    <template slot-scope="scope">
				        <i class="el-icon-time"></i>
				        <span>{{scope.row.updateTime}}</span>
				    </template>
				</el-table-column>
		      	<el-table-column prop="name" label="片名" align="left">
		      	</el-table-column>
		      	<el-table-column prop="size" label="大小" align="left" width="100">
		      	</el-table-column>
		      	<el-table-column label="操作" header-align="center" align="center">
			      <template slot-scope="scope">
			        <el-button size="mini" >复制电驴链接</el-button>
			        <el-button size="mini" >复制磁力链接</el-button>
			      </template>
			    </el-table-column>
		    </el-table>
		</template>
		<!-- 列表区 end -->
<el-pagination background layout="prev, pager, next" :total="50">
</el-pagination>
	</el-main>
  <el-footer>© 2017</el-footer>
</el-container>
</div>
</body>
  <!-- import Vue before Element -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.13/vue.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue-resource/1.5.0/vue-resource.min.js"></script>
  <!-- import JavaScript -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/element-ui/2.2.1/index.js"></script>
<script>
var Main = {
      	data() {
        	return {
				param: {
					keywords: "",
				},
			
	        	tableData: [],
        	}
      	},
		
		created() {
	    	this.getJson();
	    },
		
		methods: {
            getJson: function () {
				var self = this;
				self.$http.post('list', self.param, {emulateJSON:true}).then(function(res) {
					this.tableData = res.body
				}).catch(function(err) {
					console.log(err)  
				})
			},
       	},
    }
var Ctor = Vue.extend(Main)
new Ctor().$mount('#app')
</script>
</html>