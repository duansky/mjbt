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
	c.TplName = "index.tpl"
}

// @router /list [post]
func (c *MainController) List() {
	dayMovies := oabt.DoSnatch(c.GetString("keywords"))
	//	j, err := json.Marshal(dayMovies)
	//	if err != nil {
	//		log.Fatal(err)
	//	}
	//	fmt.Println(string(j))
	c.Data["json"] = dayMovies
	c.ServeJSON()
}
