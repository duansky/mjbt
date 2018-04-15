package controllers

import (
	"encoding/base64"
	"encoding/json"
	"log"
	"mjbt/models/oabt"
	"strings"
	"time"

	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

var lastGetTime time.Time

func init() {
	lastGetTime = time.Now()
}

// @router / [get]
func (c *MainController) Get() {

	if oabt.Hotkeys == "" {
		if s := oabt.Index(); strings.Contains(s, "is_login") {
			oabt.Hotkeys = s
		}
	}

	c.Data["json"] = oabt.Hotkeys
	c.TplName = "index.tpl"
}

// @router /list [get]
func (c *MainController) List() {
	c.Data["k"] = c.GetString("k")
	c.TplName = "list.tpl"
}

// @router /listjson [post]
func (c *MainController) Listjson() {
	//	decodeBytes, err := base64.StdEncoding.DecodeString(c.GetString("keywords"))
	//	if err != nil {
	//		log.Fatalln(err)
	//	}

	//	dayMovies, pageInfos := oabt.DoSnatch(string(decodeBytes))
	dayMovies, pageInfos := oabt.DoSnatch(c.GetString("key"))

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
