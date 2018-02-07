package oabt

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"
)

func DoSnatch(key string) []*DayMovies {
	urlIndex := beego.AppConfig.String("cili001.com")

	if key != "" {
		urlIndex = urlIndex + "/index?topic_title3=" + url.QueryEscape(key)
	}
	fmt.Println("========url:" + urlIndex)

	client := &http.Client{}
	req, err := http.NewRequest("GET", urlIndex, nil)
	req.Header.Add("Accept", "text/html, application/xhtml+xml, */*")
	req.Header.Add("Accept-Language", "zh-CN")
	req.Header.Add("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36")
	req.Header.Add("Connection", "Keep-Alive")
	req.Header.Add("Host", "oabt001.com")
	res, err := client.Do(req)
	defer res.Body.Close()
	//最后直接把res传给goquery就可以来解析网页了
	doc, err := goquery.NewDocumentFromResponse(res)

	//	doc, err := goquery.NewDocument(urlIndex)
	if err != nil {
		log.Fatal(err)
	}

	listItem := doc.Find(".list-item")

	/**********写文件***********/
	s, _ := doc.Html()
	ioutil.WriteFile("c:/oabt.html", []byte(s), 0644)
	/*********************/

	listDt := listItem.Find("dt")
	dayMoviesArr := make([]*DayMovies, 0, 10)
	forCount := 0 // 防止死循环
	listDt.Each(func(i int, dt *goquery.Selection) {

		dayMovies := new(DayMovies)
		dayMovies.Day = dt.Text()
		n := dt.Next()
		movieInfos := make([]*MovieInfo, 0, 10)

		for {
			if goquery.NodeName(n) == "dt" || goquery.NodeName(n) == "" {
				break
			}
			forCount++
			if forCount > 1000 {
				break
			}

			if goquery.NodeName(n) == "dd" {
				m := new(MovieInfo)
				m.UpdateTime = n.Find(".a").Text()
				name := strings.Replace(n.Find(".b").Text(), "[CiLi001.com]", "", -1)
				m.Name = strings.Replace(name, "【ciLi001.com】", "", -1)
				m.Size = n.Find(".d").Children().First().Text()
				m.Ed2k, _ = n.Attr("ed2k")
				m.Magnet, _ = n.Attr("magnet")
				movieInfos = append(movieInfos, m)
			}

			n = n.Next()
		}

		dayMovies.MovieInfos = movieInfos
		dayMoviesArr = append(dayMoviesArr, dayMovies)
	})

	return dayMoviesArr
}
