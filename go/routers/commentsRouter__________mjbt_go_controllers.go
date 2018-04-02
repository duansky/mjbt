package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context/param"
)

func init() {

	beego.GlobalControllerRouter["mjbt/controllers:MainController"] = append(beego.GlobalControllerRouter["mjbt/controllers:MainController"],
		beego.ControllerComments{
			Method: "Get",
			Router: `/`,
			AllowHTTPMethods: []string{"get"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["mjbt/controllers:MainController"] = append(beego.GlobalControllerRouter["mjbt/controllers:MainController"],
		beego.ControllerComments{
			Method: "List",
			Router: `/list`,
			AllowHTTPMethods: []string{"post"},
			MethodParams: param.Make(),
			Params: nil})

	beego.GlobalControllerRouter["mjbt/controllers:MainController"] = append(beego.GlobalControllerRouter["mjbt/controllers:MainController"],
		beego.ControllerComments{
			Method: "Page",
			Router: `/page`,
			AllowHTTPMethods: []string{"post"},
			MethodParams: param.Make(),
			Params: nil})

}
