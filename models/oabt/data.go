package oabt

// 单天下的所有影片
type DayMovies struct {
	Day string `json:"day"` // 2006-01-02
	// 单个日期下所有的影片
	MovieInfos []*MovieInfo `json:"movieInfos"` // 影片
}

// 影片信息
type MovieInfo struct {
	UpdateTime string `json:"updateTime"` // 影片更新时间
	Name       string `json:"name"`       // 片名
	Size       string `json:"size"`       // 影片文件大小
	Magnet     string `json:"magnet"`     // 影片磁力链接
	Ed2k       string `json:"ed2k"`       // 影片电驴链接
}
