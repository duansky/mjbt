/**
 * 
 */
package com.duansky.mjbt;

import java.io.Serializable;

/**
 * 影片信息实体
 * 
 * @author duansky
 */
public class MovieInfoEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 影片更新时间
	 */
	private int updateTime;
	
	/**
	 * 片名
	 */
	private String name;
	
	/**
	 * 影片文件大小
	 */
	private String size;
	
	/**
	 * 影片磁力链接
	 */
	private String magnet;
	
	/**
	 * 影片电驴链接
	 */
	private String ed2k;

	public int getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(int updateTime) {
		this.updateTime = updateTime;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getMagnet() {
		return magnet;
	}

	public void setMagnet(String magnet) {
		this.magnet = magnet;
	}

	public String getEd2k() {
		return ed2k;
	}

	public void setEd2k(String ed2k) {
		this.ed2k = ed2k;
	}
}
