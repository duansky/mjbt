/**
 * 
 */
package com.duansky.mjbt.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Administrator
 *
 */
@RestController
public class DataController {
	
	/**
	 * 首页
	 * 
	 * @return
	 */
	@ResponseBody
	@GetMapping("/")
    public Object index() {
		
        return "index";
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
