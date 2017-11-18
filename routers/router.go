package routers

import (
	"mjbt/controllers"

	"github.com/astaxie/beego"
)

func init() {
	beego.Include(&controllers.MainController{})
	//	beego.Router("/", &controllers.MainController{})
}
