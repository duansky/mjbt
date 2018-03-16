/**
 * 
 */
package com.duansky.mjbt.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.nutz.lang.Lang;
import org.nutz.lang.Times;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.duansky.mjbt.MovieInfoEntity;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * @author Administrator
 *
 */
@RestController
public class DataController {
	
	@Value("${sites.site1}")
	private String site;
	
	private static final Log log = Logs.get();
	
	private String getPageHtml(String url) {
		OkHttpClient client = new OkHttpClient();//创建OkHttpClient对象
        Request request = new Request.Builder()
                .url(url)//请求接口。如果需要传参拼接到接口后面。
                .build();//创建Request 对象
        String indexHtml = null;
        Response response = null;
        try {
        	response = client.newCall(request).execute();//得到Response 对象
			if (response.isSuccessful()) {
				indexHtml = response.body().string();
			}
		} catch (IOException e) {
			log.error(e);
			return "";
		} finally {
			if (response != null) {
				response.close();
			}
		}
        
        return indexHtml;
	}
	
	/**
	 * 首页
	 * 
	 * @return
	 */
	@ResponseBody
	@GetMapping("/")
    public Object index() {
        String indexHtml = getPageHtml(site);
        Document body = Jsoup.parse(indexHtml);
        Elements list = body.getElementsByClass("list-item");
        List<MovieInfoEntity> l = new ArrayList<MovieInfoEntity>();
        if (!Lang.isEmpty(list)) {
        	Elements children = list.first().children();
        	
        	String day = null;
        	for (Element e : children) {
        		if ("dt".equals(e.tagName())) { // 日期
        			day = e.html();
        		}

        		if ("dd".equals(e.tagName())) { // 影片信息
        			MovieInfoEntity m = new MovieInfoEntity();
        			m.setUpdateTime((int)Times.ams(String.format("%s %s", day, e.getElementsByClass("a").html())) / 1000);
        			m.setName(e.getElementsByClass("b").text());
        			m.setSize(e.getElementsByClass("d").first().children().first().text());
        			m.setEd2k(e.attr("ed2k"));
        			m.setMagnet(e.attr("magnet"));
        			
        			l.add(m);
        		}
        		
			}
        }
		
        return l;
    }
	
	/**
	 * 搜索
	 * @param keyword
	 * @param p
	 * @return
	 */
	@ResponseBody
	@GetMapping("/search/{keyword}/{p}")
	public Object search(@PathVariable("keyword") String keyword, @PathVariable("p") Integer p) {
		
		return keyword + p;
	}
	

	/**
	 * 热门搜索
	 * 
	 * @return
	 */
	@ResponseBody
	@GetMapping("/hotKeyword")
    public Object hotKeyword() {
		
        return "hotKeyword";
    }
}
