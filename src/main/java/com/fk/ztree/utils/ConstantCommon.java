package com.fk.ztree.utils;

/**
 * 
* <p>Title:ConstantCommon </p>
* <p>Description: 常量操作 </p>
* <p>Company: </p> 
* @author fangkun
* @date 2018年8月28日
 */
public class ConstantCommon {
	private static PropertiesLoader properties = new PropertiesLoader("conf/weixin.properties");
	
	//微信appId
	public static final String appId = properties.getProperty("appID");
	
	//微信secret
   public static final String secret = properties.getProperty("secret");

}
