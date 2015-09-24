package com.psyssp.tool;

public class SysUtils {

	
	/**
	 * 图片存储服务器路径
	 */
	public static String images_path = BaseUtil.readValue("images_path");
	
	/**
	 * 图片url拼接前缀
	 */
	public static String images_urlPath = BaseUtil.readValue("images_urlPath");
	
	/**
	 * 用户注册时默认图片
	 */
	public static String defaultphotos = BaseUtil.readValue("defaultphotos");
	
	/**
	 * 咨询师注册时默认图片
	 */
	public static String defaultconsultor = BaseUtil.readValue("defaultconsultor");
	
	/**
	 * 新闻附件上传地址/路径
	 */
	public static String attachments_path = BaseUtil.readValue("attachments_path");
	
    /**
     * 新闻附件下载拼接url前缀	
     */
	public static String attachments_urlpath = BaseUtil.readValue("attachments_urlpath");
	
	
}
