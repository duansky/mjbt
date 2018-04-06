package oabt

import (
	"fmt"
	"log"
	"net/http"
	"net/url"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/astaxie/beego"
)

func Index() []string {
	url := "http://" + beego.AppConfig.String("cili001.com") + "/home.html"

	fmt.Println(url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	req.Header.Add("Accept", "text/html, application/xhtml+xml, */*")
	req.Header.Add("Accept-Language", "zh-CN")
	req.Header.Add("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36")
	req.Header.Add("Connection", "Keep-Alive")
	req.Header.Add("Host", beego.AppConfig.String("cili001.com"))
	res, err := client.Do(req)
	defer res.Body.Close()
	//最后直接把res传给goquery就可以来解析网页了
	root, err := goquery.NewDocumentFromResponse(res)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(root.Find(".search-hot").First().Html())

	return nil
}

func DoSnatch(key string) ([]*MovieInfo, []*PageInfo) {
	urlIndex := beego.AppConfig.String("cili001.com")

	if key != "" {
		urlIndex = urlIndex + "/index/index?k=" + url.QueryEscape(key)
	}

	return snatch(urlIndex)
}

func Page(href string) ([]*MovieInfo, []*PageInfo) {
	urlIndex := beego.AppConfig.String("cili001.com")

	if href != "" {
		urlIndex = urlIndex + href
	}

	return snatch(urlIndex)
}

func snatch(url string) ([]*MovieInfo, []*PageInfo) {
	fmt.Println("========url:" + url)

	client := &http.Client{}
	req, err := http.NewRequest("GET", "http://"+url, nil)
	req.Header.Add("Accept", "text/html, application/xhtml+xml, */*")
	req.Header.Add("Accept-Language", "zh-CN")
	req.Header.Add("User-Agent", "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36")
	req.Header.Add("Connection", "Keep-Alive")
	req.Header.Add("Host", beego.AppConfig.String("cili001.com"))
	res, err := client.Do(req)
	defer res.Body.Close()
	//最后直接把res传给goquery就可以来解析网页了
	root, err := goquery.NewDocumentFromResponse(res)
	if err != nil {
		log.Fatal(err)
	}

	listItem := root.Find(".link-list-wrapper")

	/**********写文件***********/
	//	s, _ := doc.Html()
	//	ioutil.WriteFile("c:/oabt.html", []byte(s), 0644)
	/*********************/

	// 不带时间的日期
	var date string
	movieInfos := make([]*MovieInfo, 0, 10)
	listItem.Children().Each(func(i int, n *goquery.Selection) {

		if goquery.NodeName(n) == "p" && n.HasClass("link-list-title") {
			date = n.Text()
		}

		if goquery.NodeName(n) == "ul" && n.HasClass("link-list") {
			n.Children().Each(func(i2 int, n2 *goquery.Selection) {
				if goquery.NodeName(n2) == "li" {

					m := new(MovieInfo)

					m.UpdateTime = date + " " + n2.Find(".time").Text()
					name := strings.Replace(n2.Find(".name").Text(), "[CiLi001.com]", "", -1)
					name = strings.Replace(name, "【ciLi001.com】", "", -1)
					m.Name = strings.Replace(name, "【L】", "", -1)
					m.Size = n2.Find(".size").Text()
					m.Ed2k, _ = n2.Attr("data-ed2k")
					m.Magnet, _ = n2.Attr("data-magnet")
					movieInfos = append(movieInfos, m)
				}

			})

		}

	})

	pageInfos := make([]*PageInfo, 0, 10)
	paginationUl := root.Find(".pagination")
	if paginationUl.Children().Size() > 0 {

		pageHrefList := paginationUl.Find("a")
		if pageHrefList.Size() > 0 {
			pageHrefList.Each(func(i int, n *goquery.Selection) {
				p := new(PageInfo)
				if v, ok := n.Attr("aria-label"); ok {
					p.Text = v
				} else {
					p.Text = n.Text()
				}

				if href, ok := n.Attr("href"); ok {
					p.ReqUrl = href
				}

				pageInfos = append(pageInfos, p)
			})
		}
	}

	return movieInfos, pageInfos
}
