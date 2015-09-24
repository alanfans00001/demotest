package com.psyssp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.psyssp.beans.SysRolesToPurview;
import com.psyssp.beans.SysUser;
import com.psyssp.mapper.DmMapper;
import com.psyssp.service.Sys0001Service;
import com.psyssp.service.Sys0004Service;
import com.psyssp.service.Sys0005Service;
import com.psyssp.service.Sys0006Service;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.MD5Util;
import com.psyssp.tool.UnAvailableException;
import com.psyssp.tool.Utils;

/**
 * 首页
 * @author zj
 *
 */
@Controller
@RequestMapping(value = "")
public class Sys0000Controller extends DmController {
	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(Sys0000Controller.class);

	@Autowired
	private Sys0001Service sys0001Service;//用户
	@Autowired
	private Sys0004Service sys0004Service;//权限浏览
	@Autowired
	private Sys0005Service sys0005Service;//字典
	@Autowired
	private Sys0006Service sys0006Service;//功能按钮

	/**
	 * 初始化
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/init")
	public ModelAndView init(HttpServletRequest request, HttpSession session) throws Exception {
		try {
			//未登录，跳转至登录页面
			if(null==getUserSession(request)){
				return new ModelAndView("pages/login");		
			}
			//获取系统用户集合
			if(null==session.getAttribute(Utils.SYSTEME_USER_KEY)){
				Map<String, Object> map=new HashMap<String, Object>();
				map.put(DmMapper.MAP_KEY_ORDERBY, "userno");
				session.setAttribute(Utils.SYSTEME_USER_KEY, sys0001Service.findList(map));
			}
			//获取系统字典集合
			if(null==session.getAttribute(Utils.SYSTEME_WORK_KEY)){
				Map<String, Object> map=new HashMap<String, Object>();
				map.put(DmMapper.MAP_KEY_ORDERBY, "wordbookno");
				session.setAttribute(Utils.SYSTEME_WORK_KEY, sys0005Service.findList(map));
			}
			//获取系统功能按钮集合
			if(null==session.getAttribute(Utils.SYSTEME_FUN_KEY)){
				Map<String, Object> map=new HashMap<String, Object>();
				map.put(DmMapper.MAP_KEY_ORDERBY, "funno");
				session.setAttribute(Utils.SYSTEME_FUN_KEY, sys0006Service.findList(map));
			}

			//获取登录用户可用的菜单集合
			if(null==session.getAttribute(Utils.ACCOUNT_MENU_KEY)){
				SysRolesToPurview rp = new SysRolesToPurview();
				rp.setRoleno(((SysUser)getUserSession(request)).getRoleno());
				Map<String, Object> map=new HashMap<String, Object>();
				map.put(DmMapper.MAP_KEY_M, rp);
				map.put(DmMapper.MAP_KEY_ORDERBY, "menuno");
				session.setAttribute(Utils.ACCOUNT_MENU_KEY, sys0004Service.findObjectList(map));
			}
			//清理登录用户可用的功能按钮集合
			session.removeAttribute(Utils.ACCOUNT_FUN_KEY);

			return new ModelAndView("pages/home");	
		} catch (Exception e) {
			logger.error("init error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"),e);
		}
	}

	/**
	 * 登录
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loginIn")
	@ResponseBody
	public ComMessage loginIn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			String userno = request.getParameter("userno");
			String password = request.getParameter("password");
			SysUser m = new SysUser();
			m.setUserno(userno);
			m.setPassword(MD5Util.MD5(password));
			m = sys0001Service.findByUser(m);
			if (null == m || null == m.getId() || 0 == m.getId()) {
				msg.setResult(ComMessage.RESULT_FAIL);
				msg.setMsg("用户名或者密码错误！");
			}
			request.getSession().setAttribute(Utils.ACCOUNT_SESSION_KEY, m);
		} catch (Exception e) {
			logger.error("loginIn error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"),e);
		}
		return msg;
	}

	 /**
	 * 退出登录
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping(value="/loginOut")
	 public void loginOut(HttpServletRequest request,HttpServletResponse response) throws
	 Exception {
		 try {
			request.getSession().invalidate();
			response.sendRedirect("init");
		} catch (Exception e) {
			logger.error("loginOut error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"),e);
		}
	 }	
}
