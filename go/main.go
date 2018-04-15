package main

import (
	"mjbt/job"
	_ "mjbt/routers"

	"github.com/astaxie/beego"
)

func main() {
	job.StartJob()
	beego.Run()
}
