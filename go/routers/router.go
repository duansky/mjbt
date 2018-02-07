package routers

import (
	"mjbt/go/controllers"

	"github.com/astaxie/beego"
)

func init() {
	beego.Include(&controllers.MainController{})
	//	beego.Router("/", &controllers.MainController{})
}
