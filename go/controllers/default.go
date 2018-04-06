package controllers

import (
	"mjbt/models/oabt"

	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

// @router / [get]
func (c *MainController) Get() {
	oabt.Index()
	c.TplName = "index.tpl"
}

// @router /list [get]
func (c *MainController) List() {
	c.TplName = "list.tpl"
}

// @router /listjson [post]
func (c *MainController) Listjson() {
	dayMovies, pageInfos := oabt.DoSnatch(c.GetString("keywords"))

	c.Send2page(dayMovies, pageInfos)
}

// @router /page [post]
func (c *MainController) Page() {
	dayMovies, pageInfos := oabt.Page(c.GetString("requrl"))

	c.Send2page(dayMovies, pageInfos)
}

func (c *MainController) Send2page(dayMovies []*oabt.MovieInfo, pageInfos []*oabt.PageInfo) {
	m := make(map[string]interface{})
	m["dayMovies"] = dayMovies
	m["pageInfos"] = pageInfos

	//	j, err := json.Marshal(pageInfos)
	//	if err != nil {
	//		log.Fatal(err)
	//	}
	//	fmt.Println(string(j))

	c.Data["json"] = m
	c.ServeJSON()
}
