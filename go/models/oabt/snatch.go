package oabt

import (
	"io/ioutil"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"
)

func DoSnatch(key string) []*MovieInfo {
	urlIndex := beego.AppConfig.String("cili001.com")

	if key != "" {
		urlIndex = urlIndex + "/index?topic_title3=" + url.QueryEscape(key)
	}
	fmt.Println("========url:" + urlIndex)

	client := &http.Client{}
	req, err := http.NewRequest("GET", "http://" + urlIndex, nil)
	req.Header.Add("Accept", "text/html, application/xhtml+xml, */*")
	req.Header.Add("Accept-Language", "zh-CN")
	req.Header.Add("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36")
	req.Header.Add("Connection", "Keep-Alive")
	req.Header.Add("Host", urlIndex)
	res, err := client.Do(req)
	defer res.Body.Close()
	//最后直接把res传给goquery就可以来解析网页了
	doc, err := goquery.NewDocumentFromResponse(res)

//fmt.Println(doc.Find("#pages_btns").Html())

	//	doc, err := goquery.NewDocument(urlIndex)
	if err != nil {
		log.Fatal(err)
	}

	listItem := doc.Find(".list-item")

	/**********写文件***********/
	s, _ := doc.Html()
	ioutil.WriteFile("c:/oabt.html", []byte(s), 0644)
	/*********************/
	
	// 不带时间的日期
	var date string
	movieInfos := make([]*MovieInfo, 0, 10)
	listItem.Children().Each(func(i int, n *goquery.Selection) {

		if goquery.NodeName(n) == "dt" {
			date = n.Text()
		}
		
		if goquery.NodeName(n) == "dd" {
			m := new(MovieInfo)
			m.UpdateTime = date + " " + n.Find(".a").Text()
			name := strings.Replace(n.Find(".b").Text(), "[CiLi001.com]", "", -1)
			m.Name = strings.Replace(name, "【ciLi001.com】", "", -1)
			m.Size = n.Find(".d").Children().First().Text()
			m.Ed2k, _ = n.Attr("ed2k")
			m.Magnet, _ = n.Attr("magnet")
			movieInfos = append(movieInfos, m)
		}
		
	})
	
	

	return movieInfos
}
