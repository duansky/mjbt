package oabt

// 分页信息
type PageInfo struct {
	Text   string `json:"text"`   // 分页按钮显示字符
	ReqUrl string `json:"reqUrl"` // 向抓取服务器请求的url
}

// 影片信息
type MovieInfo struct {
	UpdateTime string `json:"updateTime"` // 影片更新时间
	Name       string `json:"name"`       // 片名
	Size       string `json:"size"`       // 影片文件大小
	Magnet     string `json:"magnet"`     // 影片磁力链接
	Ed2k       string `json:"ed2k"`       // 影片电驴链接
}

var Hotkeys string
