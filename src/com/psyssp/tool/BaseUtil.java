package com.psyssp.tool;

import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;

import sun.misc.BASE64Decoder;

 

/**
 * ͨ�ù�����
 * 
 * @author Administrator
 * 
 */
public class BaseUtil {


	/**
	 * 获得计算机名称
	 * @return
	 * @throws UnknownHostException
	 */
	public static String getHostName() throws UnknownHostException{
		 InetAddress s = InetAddress.getLocalHost();
         return s.getHostName();
	}
	
	/**
	 * 将时间转换为字符串 
	 * @param date
	 * @param formatter
	 * @return
	 */
	public static String getDateToString(Date date,String formatter){
		SimpleDateFormat format = new SimpleDateFormat(formatter);
		return format.format(date);
	}
	
	/**
	 * 下载图片到指定位置
	 * @param picurl
	 * @param saveurl
	 * @throws IOException
	 */
	public static boolean downloadPic(String picurl,String saveurl) throws IOException{
		boolean flag = true;
		URL url = new URL(picurl);
		try{
			url.openConnection().getInputStream();
			InputStream is = url.openStream();
			File outFile = new File(saveurl);
			OutputStream os = new FileOutputStream(outFile);
			byte[] buff = new byte[1024];
			while(true) {
				int readed = is.read(buff);
				if(readed == -1) {
					break;
				}
				byte[] temp = new byte[readed];
				System.arraycopy(buff, 0, temp, 0, readed);
				os.write(temp);
			}
			is.close(); 
	    	os.close();
		}catch (Exception e) {
			e.printStackTrace();
			flag = false;
		}
    	return flag;
	}
	
	/**
	 * base64字符串转化成图片  
	 * @param imgStr
	 * @param filepath
	 * @return
	 */
    public static boolean GenerateImage(String imgStr,String filepath) {   //对字节数组字符串进行Base64解码并生成图片  
        if (imgStr == null || filepath == null){
            return false;  
        }
        BASE64Decoder decoder = new BASE64Decoder();  
        try{  
            //Base64解码  
            byte[] b = decoder.decodeBuffer(imgStr);  
            for(int i=0;i<b.length;++i) {  
                if(b[i]<0){//调整异常数据  
                    b[i]+=256;  
                }  
            }  
            //生成jpeg图片  
            OutputStream out = new FileOutputStream(filepath);      
            out.write(b);  
            out.flush();  
            out.close();  
            return true;  
        }catch (Exception e){  
            return false;  
        }  
    }  
    
	
	/**
	 * 将集合类型转换数据为字符串
	 * 
	 **/
	@SuppressWarnings("unchecked")
	public static String getStringByObject(Object o){
		List<String> olist = (List<String>)o;
		String _s = "";
		for(String s : olist){
			_s = _s+","+s;
		}
		if(olist.size()>0){
			_s = _s.substring(1);
		}
		return _s;
	}
	
	/**
	 * 获得几小时前的时间
	 * @param beforeHours
	 * @return
	 */
	public static String getTimeBefore(int beforeHours){
		Calendar calendar = Calendar.getInstance();  
        /* HOUR_OF_DAY 指示一天中的小时 */  
        calendar.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY) - beforeHours);  
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        return df.format(calendar.getTime());
	}
	
	/**
	 * 获得几天前的时间
	 * @param beforeDays
	 * @param format
	 * @return
	 */
	public static String getDateBefore(int beforeDays,String format){
		Calendar calendar = Calendar.getInstance();  
        /* DAY_OF_MONTH 指示一月中的某天 */  
        calendar.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH) - beforeDays);  
        SimpleDateFormat df = new SimpleDateFormat(format);  
        return df.format(calendar.getTime());
	}
	
	/**
	* 字符串转换成日期
	* @param str
	* @param fmt
	* @return date
	*/
	public static Date strToDate(String str,String fmt) {
	   SimpleDateFormat format = new SimpleDateFormat(fmt);
	   Date date = null;
	   try {
	    date = format.parse(str);
	   } catch (ParseException e) {
	    e.printStackTrace();
	   }
	   return date;
	}
	/**
	 *将不是日期格式的字符串改成日期格式的字符串
	 *
	 *
	 **/
	public static String strToDateStr(String str){
		return str.substring(0,19);
	}
	/**
	 * 读取target_resource.properties文件信息
	 * @param key
	 * @return
	 */	
	public static String readValue(String key) {
		if(StringUtils.isNotBlank(key)){
			String file = BaseUtil.class.getResource("/").getPath().replaceAll("%20", " ").toString().replaceAll("file:/", "") +"config.properties";
			Properties props = new Properties();
			try {
				InputStream in = new BufferedInputStream(new FileInputStream(file));
				props.load(in);
			 	//String value = new String(props.getProperty(key).getBytes(),"utf-8");
				String value = props.getProperty(key);
			 	return value;
			} catch (Exception e) {
		         e.printStackTrace();
		         return null;
			}
		}else{
			return null;
		}
	}
	
	/**
	 * 将汉字转换unicode
	 * @param text
	 * @return
	 */
	public static String code(String text){
		String result = "";
        for (int i = 0; i < text.length(); i++){
            int chr1 = (char) text.charAt(i);
            result  += "\\u" + Integer.toHexString(chr1);            
        }
        return result;
	}
	
	/** 
     * 修改或添加键值对 如果key存在，修改, 反之，添加。 
     * @param filePath 文件路径，即文件所在包的路径，例如：java/util/config.properties 
     * @param key 键 
     * @param value 键对应的值 
     */  
    public static void writeData(String filePath, String key, String value) {  
        //获取绝对路径  
        filePath = BaseUtil.class.getResource("/" + filePath).toString();  
        //截掉路径的”file:/“前缀  
        filePath = filePath.substring(6);  
        Properties prop = new Properties();  
        try {  
            File file = new File(filePath);  
            if (!file.exists())  
                file.createNewFile();  
            InputStream fis = new FileInputStream(file);  
            prop.load(fis);  
            //一定要在修改值之前关闭fis  
            fis.close();  
            OutputStream fos = new FileOutputStream(filePath);  
            prop.setProperty(key, value);  
            //保存，并加入注释  
            prop.store(fos, "Update '" + key + "' value");  
            fos.close();  
        } catch (IOException e) {  
            System.err.println("Visit " + filePath + " for updating " + value + " value error");  
        }  
    }
    
    /**
     * 将double转换为string,并保留2为小数
     * @param x
     * @return
     */
    public static String getDataByDouble(double x){
    	java.text.DecimalFormat   df   =new   java.text.DecimalFormat("#.00"); 
    	return (new Double(df.format(x).toString())).toString();
    }
    
    /**
     * 字符串数组做比较
     * @param text
     * @return
     */
    public static String[] strCompare(String [] text){
    	String temp = "";
	    for (int i = 0; i < text.length; i++) {
	        for (int j = i+1; j < text.length; j++) {
	            if (text[i].compareTo(text[j]) > 0) {
	                temp = text[i];
	                text[i] = text[j];
	                text[j] = temp;
	            }
	        }
	    }
    	return text;
    }
    
    
    /**
     * list去除重复数据
     * @param list
     * @return
     */
    @SuppressWarnings("unchecked")
	public static List removeDuplicate(List list){
    	HashSet h = new HashSet(list);
    	list.clear();
    	list.addAll(h);
    	return list;
	}
    
    /**
     * 去除list里面的重复数据
     * @param list
     * @return
     */
    public static List<String> removeRepeat(List<String> list){
    	Set<String> set = new HashSet<String>();
		set.addAll(list);
		list = new ArrayList<String>();
		for(String s : set){
			list.add(s);
		}
    	return list;
    }
    
    /**
     * 往文件里面追加内容
     * @param filePath
     * @param content
     * @throws IOException
     */
    public static void printMsg(String filePath,String content) throws IOException{
    	FileOutputStream fos = new FileOutputStream(filePath, true);
    	OutputStreamWriter osw = new OutputStreamWriter(fos);
    	BufferedWriter out = new BufferedWriter(osw);     
    	out.write(content); 
    	out.close();
    	osw.close();
    	fos.close();
    }
    
    public static byte[] getBytes(String filePath){  
        byte[] buffer = null;  
        try {  
            File file = new File(filePath);  
            FileInputStream fis = new FileInputStream(file);  
            ByteArrayOutputStream bos = new ByteArrayOutputStream(1000);  
            byte[] b = new byte[1000];  
            int n;  
            while ((n = fis.read(b)) != -1) {  
                bos.write(b, 0, n);  
            }  
            fis.close();  
            bos.close();  
            buffer = bos.toByteArray();  
        } catch (FileNotFoundException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return buffer;  
    }
    
	/**
	 * 获取properties文件属性值
	 * @param property 要获取的属性名称
	 * @return
	 */
	public static String getPropertie(String property,String propertyName){
		String configFile = BaseUtil.class.getResource("/").getPath().toString().replaceAll("file:/", "") + propertyName;
		Properties p = new Properties();
		String returnValue = "";
		try {
			InputStreamReader inputStream = new InputStreamReader(new FileInputStream(configFile), "utf-8");
			p.load(inputStream);
			returnValue = p.getProperty(property); 
		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnValue;
	}
    
    /**
	 * 读取properties文件信息
	 * @param key
	 * @return
	 */	
	public static String readValueByKeyAndFile(String key,String filename) {
		if(StringUtils.isNotBlank(key)){
			String file = BaseUtil.class.getResource("/").getPath().replaceAll("%20", " ").toString().replaceAll("file:/", "") +filename;
			Properties props = new Properties();
			try {
				InputStream in = new BufferedInputStream(new FileInputStream(file));
				props.load(in);
			 	//String value = new String(props.getProperty(key).getBytes(),"utf-8");
				String value = props.getProperty(key);
			 	return value;
			} catch (Exception e) {
		         e.printStackTrace();
		         return null;
			}
		}else{
			return null;
		}
	}
	
	
	public static String load(String property) {
		String configFile = BaseUtil.class.getResource("/").getPath().toString().replaceAll("file:/", "") + "config.properties";
		Properties p = new Properties();
		try {
			InputStreamReader inputStream = new InputStreamReader(new FileInputStream(configFile), "utf-8");
			p.load(inputStream);
		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return p.getProperty(property);
	}
}
