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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.psyssp.beans.SysMenu;
import com.psyssp.mapper.DmMapper;
import com.psyssp.service.Sys0002Service;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.UnAvailableException;

/**
 * 系统菜单
 * @author cyb
 * 
 */
@Controller
@RequestMapping(value = "/sys0002")
public class Sys0002Controller extends DmController {
	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(Sys0002Controller.class);

	@Autowired
	private Sys0002Service sys0002Service;// 菜单

	private static final String[] ROLES_MENUNOS = { "M0102", "M010201" };

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

			// 权限
			boolean b = super.initFun(ROLES_MENUNOS[0], session);
			if (!b) {
				return new ModelAndView("error");
			}

			return new ModelAndView("pages/sys0002");
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
			msg.setObj(getListPage(request, sys0002Service, SysMenu.class));
			return msg;
		} catch (Exception e) {
			logger.error("list error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("查询错误！");
			return msg;
		}
	}

	/**
	 * 新增初始化
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
				SysMenu m = sys0002Service.find(Integer.parseInt(ids[0]));
				resultMap.put("menu", m);
			}
			Map<String, Object> map=new HashMap<String, Object>();
			map.put(DmMapper.MAP_KEY_ORDERBY, "menuno");
			resultMap.put("menuList", sys0002Service.findList(map));
			
			return new ModelAndView("pages/sys000201", resultMap);
		} catch (Exception e) {
			logger.error("editInit error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"), e);
		}
	}

	/**
	 * 新增或修改
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public ComMessage saveOrUpdate(@ModelAttribute("menu") SysMenu menu, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ComMessage msg = new ComMessage();
		try {
			super.saveOrUpdate(request, menu);
			msg.setObj(sys0002Service.saveOrUpdate(menu));
			return msg;
		} catch (Exception e) {
			logger.error("saveOrUpdate error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("新增或者修改失败！");
			return msg;
		}
	}

	/*
	 * 删除菜单
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public ComMessage delete(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			String[] ids = request.getParameter("ids").split(",");
			for (String id : ids) {
				sys0002Service.delete(Integer.parseInt(id));
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
	 * 唯一性验证
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/validateOnly")
	@ResponseBody
	public String validateOnly(@ModelAttribute("menu") SysMenu menu, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			List<SysMenu> list = sys0002Service.validateOnly(menu);
			if (null != list && list.size() > 0) {
				if (list.size() > 1) {
					return false + "";
				}
				// 新增
				if (null == menu.getId() || 0 == menu.getId()) {
					return false + "";
				}
				// 修改
				if (!menu.getId().equals(list.get(0).getId())) {
					return false + "";
				}
			}
		} catch (Exception e) {
			logger.error("validateOnly error", e);
			return false + "";
		}
		return true + "";
	}
}
