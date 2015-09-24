package com.psyssp.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.psyssp.beans.TblModel;
import com.psyssp.beans.SysFun;
import com.psyssp.beans.SysUser;
import com.psyssp.mapper.TblMapper;
import com.psyssp.service.TblService;
import com.psyssp.tool.Message;
import com.psyssp.tool.PageInfo;
import com.psyssp.tool.Pager;
import com.psyssp.tool.Utils;

public class TblController implements ApplicationContextAware, DisposableBean {

	// 日志
		private static Logger logger = Logger.getLogger(TblController.class);

		// 上下文
		private static ApplicationContext applicationContext = null;

		public static ApplicationContext getApplicationContext() {
			return applicationContext;
		}

		public void setApplicationContext(ApplicationContext applicationContext) {
			TblController.applicationContext = applicationContext;
		}

		public void destroy() throws Exception {
			TblController.clearHolder();
		}

		public static void clearHolder() {
			logger.debug("clear applicationContext");
			applicationContext = null;
		}

		/**
		 * 获取提示信息
		 * 
		 * @param id
		 * @return
		 */
		protected Message getMessage(String id) {
			return getMessage(id, null);
		}

		/**
		 * 获取提示信息
		 * 
		 * @param id
		 *            消息编号
		 * @param par
		 *            消息参数
		 * @return 消息实体
		 */
		protected Message getMessage(String id, String par[]) {

			if (id == null || id.length() <= 0) {
				logger.warn("id is null");
				return null;
			}
			if (applicationContext == null) {
				logger.warn("ApplicationContext is null");
				return null;
			}
			Message msg = new Message();
			msg.setId(id);
			msg.setMsg(applicationContext.getMessage(id, par, Locale.getDefault()));

			return msg;
		}

		/**
		 * 获取用户会话信息
		 * 
		 * @param request
		 * @return
		 */
		protected SysUser getUserSession(HttpServletRequest request) {
			return (SysUser) request.getSession().getAttribute(Utils.ACCOUNT_SESSION_KEY);
		}

		/**
		 * 新增或者修改实体时，对新增人、新增时间、修改人、修改时间四个公共字段的处理
		 * 
		 * @param request
		 * @param m
		 * @throws Exception
		 */
		protected void saveOrUpdate(HttpServletRequest request, TblModel m) throws Exception {
			SimpleDateFormat sdf = new SimpleDateFormat(Utils.DATE_FORMAT);
			String date = sdf.format(new Date());
			if (null == m.getCreate_date() || "".equals(m.getCreate_date())) {
				m.setCreate_date(date);
				m.setCreater_userid(getUserSession(request).getId());
			}
			m.setModifie_date(date);
			m.setModifier_userid(getUserSession(request).getId());
		}
		
		

		/**
		 * 获取分页数据
		 * 
		 * @param request
		 *            请求
		 * @param service
		 *            查询用的逻辑服务层实体
		 * @param clazz
		 *            查询用的表对象实体
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings("unchecked")
		public Object getListPage(HttpServletRequest request, TblService service, Class<?> clazz) throws Exception {
			// 获取前台的分页信息
			String str = request.getParameter("page");
			if (null == str || "".equals(str)) {
				return null;
			}
			// 创建查询条件
			Map<String, Object> map = new HashMap<String, Object>();
			JSONObject page = new JSONObject(str);
			ObjectMapper om = new ObjectMapper();
			// 设置查询条件的查询实体
			JSONObject pageFilter = page.optJSONObject("pageFilter");
			if (null != pageFilter) {
				map.put(TblMapper.MAP_KEY_M, om.readValue(pageFilter.toString(), clazz));
			}
			// 设置查询条件的当前页码和每页显示数量
			JSONObject pageConfig = page.optJSONObject("pageConfig");
			if (null == pageConfig) {
				pageConfig = new JSONObject();
			}
			PageInfo pageInfo = new PageInfo();
			pageInfo.setCurrentPage(pageConfig.optInt("currentPage", 1));
			pageInfo.setShowCount(pageConfig.optInt("showCount", 20));
			// 设置查询条件的排序字段和排序方式
			if (null != pageConfig.optString("orderby", "") && !"".equals(pageConfig.optString("orderby", ""))) {
				map.put(TblMapper.MAP_KEY_ORDERBY, pageConfig.optString("orderby"));
			}
			if (null != pageConfig.optString("order", "") && !"".equals(pageConfig.optString("order", ""))) {
				map.put(TblMapper.MAP_KEY_ORDER, pageConfig.optString("order"));
			}
			// 获取分页的查询数据
			List<TblModel> list = service.findListPage(map, pageInfo);
			int temp = pageInfo.getTotalResult() / pageInfo.getShowCount();
			if (pageInfo.getTotalResult() % pageInfo.getShowCount() != 0) {
				temp++;
			}
			// 将数据载入即将返回前台的实体
			Pager pager = new Pager();
			pager.setCurrentPage(pageInfo.getCurrentPage());
			pager.setAllRow(pageInfo.getTotalResult());
			pager.setPageSize(pageInfo.getShowCount());
			pager.setField(null == map.get(TblMapper.MAP_KEY_ORDERBY) ? "" : map.get(TblMapper.MAP_KEY_ORDERBY).toString());
			pager.setSort(null == map.get(TblMapper.MAP_KEY_ORDER) ? "" : map.get(TblMapper.MAP_KEY_ORDER).toString());
			pager.setTotalPage(temp);
			pager.setList(list);

			return pager;
		}

		/**
		 * 获取多表分页数据
		 * 
		 * @param request
		 *            请求
		 * @param service
		 *            查询用的逻辑服务层实体
		 * @param clazz
		 *            查询用的表对象实体
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings("unchecked")
		public Object getObjectListPage(HttpServletRequest request, TblService service, Class clazz) throws Exception {
			// 获取前台的分页信息
			String str = request.getParameter("page");
			if (null == str || "".equals(str)) {
				return null;
			}
			// 创建查询条件
			Map<String, Object> map = new HashMap<String, Object>();
			JSONObject page = new JSONObject(str);
			ObjectMapper om = new ObjectMapper();
			// 设置查询条件的查询实体
			JSONObject pageFilter = page.optJSONObject("pageFilter");
			if (null != pageFilter) {
				map.put(TblMapper.MAP_KEY_M, om.readValue(pageFilter.toString(), clazz));
			}
			// 设置查询条件的当前页码和每页显示数量
			JSONObject pageConfig = page.optJSONObject("pageConfig");
			if (null == pageConfig) {
				pageConfig = new JSONObject();
			}
			PageInfo pageInfo = new PageInfo();
			pageInfo.setCurrentPage(pageConfig.optInt("currentPage", 1));
			pageInfo.setShowCount(pageConfig.optInt("showCount", 20));
			// 设置查询条件的排序字段和排序方式
			if (null != pageConfig.optString("orderby", "") && !"".equals(pageConfig.optString("orderby", ""))) {
				map.put(TblMapper.MAP_KEY_ORDERBY, pageConfig.optString("orderby"));
			}
			if (null != pageConfig.optString("order", "") && !"".equals(pageConfig.optString("order", ""))) {
				map.put(TblMapper.MAP_KEY_ORDER, pageConfig.optString("order"));
			}
			// 获取分页的查询数据
			List<Object> list = service.findObjectListPage(map, pageInfo);
			int temp = pageInfo.getTotalResult() / pageInfo.getShowCount();
			if (pageInfo.getTotalResult() % pageInfo.getShowCount() != 0) {
				temp++;
			}
			// 将数据载入即将返回前台的实体
			Pager pager = new Pager();
			pager.setCurrentPage(pageInfo.getCurrentPage());
			pager.setAllRow(pageInfo.getTotalResult());
			pager.setPageSize(pageInfo.getShowCount());
			pager.setField(null == map.get(TblMapper.MAP_KEY_ORDERBY) ? "" : map.get(TblMapper.MAP_KEY_ORDERBY).toString());
			pager.setSort(null == map.get(TblMapper.MAP_KEY_ORDER) ? "" : map.get(TblMapper.MAP_KEY_ORDER).toString());
			pager.setTotalPage(temp);
			pager.setList(list);

			return pager;
		}
		
		
		
		
		/**
		 * 获取分页数据
		 * 
		 * @param request
		 *            请求
		 * @param service
		 *            查询用的逻辑服务层实体
		 * @param clazz
		 *            查询用的表对象实体
		 * @return
		 * @throws Exception
		 */
		@SuppressWarnings("unchecked")
		public Object dynamicgetListPage(HttpServletRequest request, TblService service, Class<?> clazz) throws Exception {
			// 获取前台的分页信息
			String str = request.getParameter("page");
			if (null == str || "".equals(str)) {
				return null;
			}
			// 创建查询条件
			Map<String, Object> map = new HashMap<String, Object>();
			JSONObject page = new JSONObject(str);
			ObjectMapper om = new ObjectMapper();
			// 设置查询条件的查询实体
			JSONObject pageFilter = page.optJSONObject("pageFilter");
			if (null != pageFilter) {
				map.put(TblMapper.MAP_KEY_M, om.readValue(pageFilter.toString(), clazz));
			}
			// 设置查询条件的当前页码和每页显示数量
			JSONObject pageConfig = page.optJSONObject("pageConfig");
			if (null == pageConfig) {
				pageConfig = new JSONObject();
			}
			PageInfo pageInfo = new PageInfo();
			pageInfo.setCurrentPage(pageConfig.optInt("currentPage", 1));
			pageInfo.setShowCount(pageConfig.optInt("showCount", 20));
			// 设置查询条件的排序字段和排序方式
			if (null != pageConfig.optString("orderby", "") && !"".equals(pageConfig.optString("orderby", ""))) {
				map.put(TblMapper.MAP_KEY_ORDERBY, pageConfig.optString("orderby"));
			}
			if (null != pageConfig.optString("order", "") && !"".equals(pageConfig.optString("order", ""))) {
				map.put(TblMapper.MAP_KEY_ORDER, pageConfig.optString("order"));
			}
			// 获取分页的查询数据
			List<Object> list = service.deyfindListPage(map, pageInfo);
			int temp = pageInfo.getTotalResult() / pageInfo.getShowCount();
			if (pageInfo.getTotalResult() % pageInfo.getShowCount() != 0) {
				temp++;
			}
			// 将数据载入即将返回前台的实体
			Pager pager = new Pager();
			pager.setCurrentPage(pageInfo.getCurrentPage());
			pager.setAllRow(pageInfo.getTotalResult());
			pager.setPageSize(pageInfo.getShowCount());
			pager.setField(null == map.get(TblMapper.MAP_KEY_ORDERBY) ? "" : map.get(TblMapper.MAP_KEY_ORDERBY).toString());
			pager.setSort(null == map.get(TblMapper.MAP_KEY_ORDER) ? "" : map.get(TblMapper.MAP_KEY_ORDER).toString());
			pager.setTotalPage(temp);
			pager.setList(list);

			return pager;
		}

		@SuppressWarnings("unchecked")
		protected boolean initFun(String mid, HttpSession session) {
			boolean b = false;
			List<SysFun> list = new ArrayList<SysFun>();
			// 当前登录用户可用的菜单集合
			if (null == session.getAttribute(Utils.ACCOUNT_MENU_KEY)) {
				return false;
			}
			List<Map<String, Object>> menuList = (List<Map<String, Object>>) session.getAttribute(Utils.ACCOUNT_MENU_KEY);
			for (Map<String, Object> menu : menuList) {
				if (mid.equals(menu.get("menuno")) && null != menu.get("allfunno")) {
					
					if(menu.get("funno")==null){
						continue;	
					}
					String[] funnos = menu.get("funno").toString().split(",");
					List<SysFun> funList = (List<SysFun>) session.getAttribute(Utils.SYSTEME_FUN_KEY);
					for (String funno : funnos) {
						for (SysFun fun : funList) {
							if (funno.equals(fun.getFunno())) {
								list.add(fun);
								break;
							}
						}
					}
					b = true;
					break;
				}
			}
			// 登录用户是否有权限访问页面
			if (b) {
				session.setAttribute(Utils.ACCOUNT_FUN_KEY, list);
				return true;
			} else {
				return false;
			}
		}

		/**
		 * 获取查询条件
		 * 
		 * @param request
		 * @param cls
		 * @return
		 */
		protected Object getCondition(HttpServletRequest request, Class<?> cls) {
			String json = "";
			try {
				if (request.getParameter("condition") != null) {
					json = request.getParameter("condition");
				}
			} catch (Exception ex) {
				json = null;
			}
			if (json == null)
				return null;
			ObjectMapper obj = new ObjectMapper();

			Object vo = null;
			try {
				vo = obj.readValue(json, cls);
			} catch (Exception e) {
				return null;
			}
			return vo;
		}

		/**
		 * 执行更新/删除返回默认提示信息
		 * 
		 * @param id
		 * @param arrMsg
		 * @return
		 */
		protected @ResponseBody
		Message finishExecute(String id, String[] arrMsg) {
			return getMessage(id, arrMsg);
		}

		/**
		 * 执行更新/删除返回默认提示信息
		 * 
		 * @param b
		 * @return
		 */
		protected @ResponseBody
		Message finishExecute(boolean b) {
			if (b) {
				return getMessage("COM.INFO.I0001", null);
			} else {
				return getMessage("COM.INFO.I0002", null);
			}
		}

		/**
		 * 
		 * @return
		 */
		protected ModelAndView exception() {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("msg", getMessage("COM.ERROR.E0001"));
			return new ModelAndView(Utils.ACTION_ERROR, resultMap);
		}

}
