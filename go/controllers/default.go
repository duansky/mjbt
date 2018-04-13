package controllers

import (
	"encoding/base64"
	"encoding/json"
	"fmt"
	"log"
	"mjbt/models/oabt"

	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

// @router / [get]
func (c *MainController) Get() {
	json := oabt.Index()
	c.Data["json"] = json
	c.TplName = "index.tpl"
}

// @router /list [get]
func (c *MainController) List() {
	c.Data["k"] = c.GetString("k")
	c.TplName = "list.tpl"
}

// @router /listjson [post]
func (c *MainController) Listjson() {
	fmt.Println(c.GetString("keywords"))
	decodeBytes, err := base64.StdEncoding.DecodeString(c.GetString("keywords"))
	if err != nil {
		log.Fatalln(err)
	}

	dayMovies, pageInfos := oabt.DoSnatch(string(decodeBytes))

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

	j, err := json.Marshal(m)
	if err != nil {
		log.Fatal(err)
	}
	//	fmt.Println(string(j))

	c.Data["json"] = base64.StdEncoding.EncodeToString(j) // m
	c.ServeJSON()
}
