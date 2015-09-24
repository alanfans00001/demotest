package com.psyssp.tool;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class Utils {

	//系统异常页面调整
	public final static String ACTION_ERROR="error";
	
	//用户登录会话信息
	public final static String ACCOUNT_SESSION_KEY="account_session_key";
	
	//用户菜单信息
	public final static String ACCOUNT_MENU_KEY="account_menu_key";
	
	//用户功能按钮信息
	public final static String ACCOUNT_FUN_KEY="account_fun_key";
	
	//系统功能按钮信息
	public final static String SYSTEME_FUN_KEY="system_fun_key";
	
	//系统字典主表信息
	public final static String SYSTEME_WORK_KEY="system_work_key";
	
	//系统用户信息
	public final static String SYSTEME_USER_KEY="system_user_key";
	
//	//新增模式
//	public final static String SYSTEM_DOMODEL_ADD="0";
//	
//	//编辑模式
//	public final static String SYSTEM_DOMODEL_EDIT="1";
	
	public final static String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	/**
	 * 启用状态：启用
	 */
	public final static String WORDBOOK_W00101="W00101";
	/**
	 * 启用状态：禁用
	 */
	public final static String WORDBOOK_W00102="W00102";
	
	
	/**
	 * 在常量表中，新闻分类类型为4
	 */
	public final static Integer ConstData_newsType = 4;
	
//	/***
//	 * 将列表转换为JSON对象返回
//	 * @param list
//	 * @return
//	 */
//	public static<T> Object toJsonFromListWithPage(Pager pResult){
//		return toJsonFromListWithPage(pResult.getResultList(),pResult.getPageNo(),pResult.getTotal());
//	}
	
	/***
	 * 将列表转换为JSON对象返回，没有分页
	 * @param list
	 * @return
	 */
	public static<T> Object toJsonFromListWithPage(List<T> list){
		return toJsonFromListWithPage(list,1,1);
	}
	
	/***
	 * 将列表转换为JSON对象返回,带分页信息
	 * @param list 需要转换的列表
	 * @param page 分页
	 * @param totla 总页数
	 * @return JSON
	 */
	public static<T> Object toJsonFromListWithPage(List<T> list,int page,int total){
		
		HashMap<Object, Object> cellMap = new HashMap<Object, Object>(); 
		ArrayList<Object> mapList = new ArrayList<Object>();
		HashMap<Object, Object> pageInfo = new HashMap<Object, Object>(); 
		  
		if(list == null)
			return null;
		
		for(int i=0; i<list.size();i++){
			if(list.get(i)!=null){
				 cellMap.put("cell", list.get(i));
				 mapList.add(cellMap);  
				 cellMap = new HashMap<Object, Object>(); 
			}
		}
		pageInfo.put("total", total); 
		pageInfo.put("page", page); 
		pageInfo.put("rows", mapList); 
		
		return pageInfo;
	}
	
//	/**
//	 * 将列表(HashMap)转换为JSON对象返回,带分页信息
//	 * @param <T>
//	 * @param pResult
//	 * @return
//	 */
//	public static<T> Object toJsonFromMapWithPage(Pager pResult){
//		return toJsonFromMapWithPage(pResult.getResultList(),pResult.getPageNo(),pResult.getTotal());
//	}
	
	/**
	 * 将列表(HashMap)转换为JSON对象返回
	 * @param <T>
	 * @param list
	 * @return
	 */
	public static<T> Object toJsonFromMapWithPage(List<Object> list){
		return toJsonFromMapWithPage(list,1,1);
	}
	
	/**
	 * 将列表(HashMap)转换为JSON对象返回,带分页信息
	 * @param <T>
	 * @param list
	 * @return
	 */
	public static Object toJsonFromMapWithPage(List<Object> list,int page,int total){
		
		HashMap<Object, Object> cellMap = new HashMap<Object, Object>(); 
		ArrayList<Object> mapList = new ArrayList<Object>();
		HashMap<Object, Object> pageInfo = new HashMap<Object, Object>(); 
		
		if(list == null)
			return null;
		
		for(int i=0; i<list.size();i++){
		
			cellMap.put("cell", list.get(i));
			mapList.add(cellMap);  
			cellMap = new HashMap<Object, Object>(); 
		}
		
		pageInfo.put("total", total); 
		pageInfo.put("page", page); 
		pageInfo.put("rows", mapList); 
		
		return pageInfo;
	}
	
	
	/**
	 * escape zh_cn characters
	 * @param src
	 * @return
	 */
	public static String escape(String src) {
        int i;
        char j;
        StringBuffer tmp = new StringBuffer();
        tmp.ensureCapacity(src.length() * 6);
        for (i = 0; i < src.length(); i++) {
            j = src.charAt(i);
            if (Character.isDigit(j) || Character.isLowerCase(j)
                    || Character.isUpperCase(j))
                tmp.append(j);
            else if (j < 256) {
                tmp.append("%");
                if (j < 16)
                    tmp.append("0");
                tmp.append(Integer.toString(j, 16));
            } else {
                tmp.append("%u");
                tmp.append(Integer.toString(j, 16));
            }
        }
        return tmp.toString();
    }
	
	/**
	 * unescape zh_cn characters
	 * @param src
	 * @return
	 */
	public static String unescape(String src) {
        StringBuffer tmp = new StringBuffer();
        tmp.ensureCapacity(src.length());
        int lastPos = 0, pos = 0;
        char ch;
        while (lastPos < src.length()) {
            pos = src.indexOf("%", lastPos);
            if (pos == lastPos) {
                if (src.charAt(pos + 1) == 'u') {
                    ch = (char) Integer.parseInt(src.substring(pos + 2, pos + 6), 16);
                    tmp.append(ch);
                    lastPos = pos + 6;
                } else {
                    ch = (char) Integer.parseInt(src.substring(pos + 1, pos + 3), 16);
                    tmp.append(ch);
                    lastPos = pos + 3;
                }
            } else {
                if (pos == -1) {
                    tmp.append(src.substring(lastPos));
                    lastPos = src.length();
                } else {
                    tmp.append(src.substring(lastPos, pos));
                    lastPos = pos;
                }
            }
        }
        return tmp.toString();
    }
	
	/***
	 * 时间转换，默认为“yyyy-MM-dd HH24:mm:ss”格式
	 * 
	 * @param date   字符类型日期
	 * @param fmt    转换格式
	 * @return
	 */
	public static Date fmtDate(String date,String fmt) {
		Date result = new Date();
		if(date==null || "".equals(date)){
			return result;
		}
		String fmtStr = DATE_FORMAT;
		if(fmt!=null && !"".equals(fmt)){
			fmtStr = fmt;
		}
		SimpleDateFormat dateformat1=new SimpleDateFormat(fmtStr);
		try {
			result = dateformat1.parse(date);
		} catch (ParseException e) {
			result= null;
			e.printStackTrace();
		}
		return result;
	}
}
