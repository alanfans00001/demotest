package com.psyssp.tool;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

public class HttpClient {
	
	public static final int SUCCESS=0;//正常
	public static final int ERROR=500;//
	public static final int BASE=2000;
	
	public static final int PARAMETERS=2001;//参数错误
	//接口服务器地址
	public static final String INTERFACE_SERVER="http://client.xrong.cn/";
	public static final String CHARSET = "UTF-8";
	//设置连接超时时间
	public static final int DEFAULT_CONNECTION_TIMEOUT = (5 * 1000); // milliseconds
	//设置读取超时时间
	public static final int DEFAULT_SOCKET_TIMEOUT = (10 * 1000); // milliseconds
	
	public static HttpClient instance(){
		return new HttpClient();
	}
	
	public  String send(Map<String, Object> params,String serverUrl,String action) throws Exception{
		HttpURLConnection conn = null;
		DataOutputStream outStream = null;
		StringBuffer sb = new StringBuffer();
		try {
			URL url=new URL(serverUrl+action);
			conn=(HttpURLConnection) url.openConnection();
			conn.setConnectTimeout(DEFAULT_CONNECTION_TIMEOUT);
			conn.setReadTimeout(DEFAULT_SOCKET_TIMEOUT);
			conn.setRequestProperty("Charset", CHARSET);
			conn.setUseCaches(false);
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");

			byte[] data=initParams(params).getBytes(CHARSET);
			conn.setRequestProperty("Content-Length", String.valueOf(data.length));
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			outStream=new DataOutputStream(conn.getOutputStream());
			outStream.write(data);
			outStream.flush();
			if(conn.getResponseCode()==200){
				InputStream in = conn.getInputStream();
				InputStreamReader reader = new InputStreamReader(in, CHARSET);
				char[] buff = new char[1024];
				int len;
				while ((len = reader.read(buff)) > 0) {
					sb.append(buff, 0, len);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new CustomException(HttpClient.BASE, "远程服务器没有响应");
		}
		finally{
			if(outStream!=null){
				try {
					outStream.close();
					outStream=null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(conn!=null){
				conn.disconnect();
				conn=null;
			}
		}
		return sb.toString();
	}
	
	/**
	 * 初始化参数
	 * **/
	private String initParams(Map<String, Object> params){
		String requestParams="";
		if(params==null || params.size()==0){
			return requestParams;
		}
		Iterator<Entry<String, Object>> iter=params.entrySet().iterator();
		while(iter.hasNext()){
			Entry<String, Object> entry=iter.next();
			requestParams=requestParams+entry.getKey()+"="+entry.getValue()+"&";
		}
		requestParams=requestParams.substring(0, requestParams.length()-1);
		return requestParams;
	}

	public static String sendRequest(String params,String action) throws Exception{
		return sendRequest(params, HttpClient.INTERFACE_SERVER, action);
	}
	/**
	 * 以后不用
	 * @throws CustomException 
	 * */
	public 	static String sendRequest(String params,String serverUrl,String action) throws CustomException{
		HttpURLConnection conn = null;
		DataOutputStream outStream = null;
		StringBuffer sb = new StringBuffer();
		try {
			URL url=new URL(serverUrl+action);
			conn=(HttpURLConnection) url.openConnection();
			conn.setConnectTimeout(DEFAULT_CONNECTION_TIMEOUT);
			conn.setReadTimeout(DEFAULT_SOCKET_TIMEOUT);
			conn.setRequestProperty("Charset", CHARSET);
			conn.setUseCaches(false);
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			byte[] data=params.getBytes(CHARSET);
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("Content-Length", String.valueOf(data.length));
			outStream=new DataOutputStream(conn.getOutputStream());
			outStream.write(data);
			outStream.flush();
			if(conn.getResponseCode()==200){
				InputStream in = conn.getInputStream();
				InputStreamReader reader = new InputStreamReader(in, CHARSET);
				char[] buff = new char[1024];
				int len;
				while ((len = reader.read(buff)) > 0) {
					sb.append(buff, 0, len);
				}

			}
		} catch (Exception e) {
			throw new CustomException(HttpClient.BASE,  "远程服务器没有响应");
		}
		finally{
			if(outStream!=null){
				try {
					outStream.close();
					outStream=null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(conn!=null){
				conn.disconnect();
				conn=null;
			}
		}
		return sb.toString();
	}

	
}
