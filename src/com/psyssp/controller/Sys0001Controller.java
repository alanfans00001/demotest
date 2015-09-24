package com.psyssp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.psyssp.beans.SysUser;
import com.psyssp.mapper.DmMapper;
import com.psyssp.service.Sys0001Service;
import com.psyssp.service.Sys0003Service;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.MD5Util;
import com.psyssp.tool.UnAvailableException;
import com.psyssp.tool.Utils;

/**
 * 系统用户
 * @author zj
 *
 */
@Controller
@RequestMapping(value = "/sys0001")
public class Sys0001Controller extends DmController {
	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(Sys0001Controller.class);

	@Autowired
	private Sys0001Service sys0001Service;// 用户
	@Autowired
	private Sys0003Service sys0003Service;// 角色

	private static final String[] ROLES_MENUNOS = { "M0101", "M010101" };

	/**
	 * 初始化
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/init")
	public ModelAndView init(HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			// 权限
			boolean b = super.initFun(ROLES_MENUNOS[0], session);
			if (!b) {
				return new ModelAndView("error");
			}

			// 获取角色集合
			Map<String, Object> map = new HashMap<String, Object>();
			map.put(DmMapper.MAP_KEY_ORDER, "roleno");
			resultMap.put("roleList", sys0003Service.findList(map));
			return new ModelAndView("pages/sys0001", resultMap);
		} catch (Exception e) {
			logger.error("init error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"), e);
		}
	}

	/**
	 * 获取用户集合数据
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	@ResponseBody
	public ComMessage list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			msg.setObj(getListPage(request, sys0001Service, SysUser.class));
			return msg;
		} catch (Exception e) {
			logger.error("list error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("查询失败！");
			return msg;
		}
	}

	/**
	 * 新增或者修改初始化
	 * 
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editInit")
	public ModelAndView editInit(HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			// 权限
			boolean b = super.initFun(ROLES_MENUNOS[1], session);
			if (!b) {
				return new ModelAndView("error");
			}

			if (null != request.getParameter("ids")) {
				String[] ids = request.getParameter("ids").split(",");
				SysUser m = sys0001Service.find(Integer.parseInt(ids[0]));
				resultMap.put("user", m);
			}
			// 获取角色集合
			Map<String, Object> map = new HashMap<String, Object>();
			map.put(DmMapper.MAP_KEY_ORDERBY, "roleno");
			resultMap.put("roleList", sys0003Service.findList(map));

			return new ModelAndView("pages/sys000101", resultMap);
		} catch (Exception e) {
			logger.error("editInit error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"), e);
		}
	}

	/**
	 * 启用
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/startUse")
	@ResponseBody
	public ComMessage startUse(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			String[] ids = request.getParameter("ids").split(",");
			for (String id : ids) {
				SysUser m = new SysUser(Integer.parseInt(id));
				m.setStatus(Utils.WORDBOOK_W00101);
				super.saveOrUpdate(request, m);
				sys0001Service.saveOrUpdate(m);
			}
			return msg;
		} catch (Exception e) {
			logger.error("startUse error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("启用失败！");
			return msg;
		}
	}

	/**
	 * 禁用
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/forbidden")
	@ResponseBody
	public ComMessage forbidden(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			String[] ids = request.getParameter("ids").split(",");
			for (String id : ids) {
				SysUser m = new SysUser(Integer.parseInt(id));
				m.setStatus(Utils.WORDBOOK_W00102);
				super.forbidden(request, m);
				sys0001Service.saveOrUpdate(m);
			}
			return msg;
		} catch (Exception e) {
			logger.error("forbidden error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("禁用失败！");
			return msg;
		}
	}

	/**
	 * 删除
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public ComMessage delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			String[] ids = request.getParameter("ids").split(",");
			for (String id : ids) {
				sys0001Service.delete(Integer.parseInt(id));
			}
			return msg;
		} catch (Exception e) {
			logger.error("delete error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("删除失败！");
			return msg;
		}
	}

	/**
	 * 新增或修改
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public ComMessage saveOrUpdate(@ModelAttribute("user") SysUser user, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ComMessage msg = new ComMessage();
		try {
			if("".equals(user.getPassword())){
				user.setPassword(null);
			}else{
				user.setPassword(MD5Util.MD5(user.getPassword()));
			}
			super.saveOrUpdate(request, user);
			msg.setObj(sys0001Service.saveOrUpdate(user));
			return msg;
		} catch (Exception e) {
			logger.error("saveOrUpdate error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("新增或者修改失败！");
			return msg;
		}
	}
	
	/**
	 * 唯一性验证
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/validateOnly")
	@ResponseBody
	public String validateOnly(@ModelAttribute("user") SysUser user, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			List<SysUser> list = sys0001Service.validateOnly(user);
			if(null!=list && list.size()>0){
				if(list.size()>1){
					return false+"";					
				}
				//新增
				if(null==user.getId() || 0==user.getId()){
					return false+"";
				}	
				//修改
				if(!user.getId().equals(list.get(0).getId())){
					return false+"";
				}
			}
		} catch (Exception e) {
			logger.error("validateOnly error", e);
			return false+"";
		}
		return true+"";
	}
	
	/**
	 * 加减按钮测试
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addAndSub")
	@ResponseBody
	public ComMessage addAndSub(@RequestParam("id") String id,@RequestParam("updateValue") String updateValue,HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ComMessage msg = new ComMessage();
		try {
			return msg;
		} catch (Exception e) {
			logger.error("addAndSub error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("增减失败！");
			return msg;
		}
	}
}
