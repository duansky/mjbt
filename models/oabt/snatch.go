package oabt

import (
	"log"
	"net/url"

	"github.com/astaxie/beego"
	"github.com/duansky/goquery"
)

func DoSnatch(key string) []*DayMovies {
	urlIndex := beego.AppConfig.String("cili001.com")

	if key != "" {
		urlIndex = urlIndex + "/index?topic_title3=" + url.QueryEscape("权力的游戏")
	}

	doc, err := goquery.NewDocument(urlIndex)
	if err != nil {
		log.Fatal(err)
	}

	listItem := doc.Find(".list-item")
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
				m.Name = n.Find(".b").Text()
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
