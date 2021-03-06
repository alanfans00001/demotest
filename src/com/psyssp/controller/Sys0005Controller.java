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

import com.psyssp.beans.SysWordbook;
import com.psyssp.mapper.DmMapper;
import com.psyssp.service.Sys0003Service;
import com.psyssp.service.Sys0005Service;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.UnAvailableException;
import com.psyssp.tool.Utils;

/**
 * 数据字典Control
 * @author zhuqiang
 * */
@Controller
@RequestMapping(value = "/sys0005")
public class Sys0005Controller extends DmController {
	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(Sys0005Controller.class);
	/**
	 * 权限
	 * */
	private static final String[] ROLES_MENUNOS = { "M0105", "M010501" };
	@Autowired
	private Sys0005Service sys0005Service;// 字典
	@Autowired
	private Sys0003Service sys0003Service;// 角色

	@RequestMapping("/init")
	public ModelAndView init(HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			// 权限
			boolean b = super.initFun(ROLES_MENUNOS[0], session);
			if (!b) {
				return new ModelAndView("error");
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put(DmMapper.MAP_KEY_ORDER, "roleno");
			resultMap.put("roleList", sys0003Service.findList(map));
			return new ModelAndView("pages/sys0005", resultMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
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
				SysWordbook m = sys0005Service.find(Integer.parseInt(ids[0]));
				resultMap.put("wordbook", m);
			}

			return new ModelAndView("pages/sys000501", resultMap);
		} catch (Exception e) {
			logger.error("editInit error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0005"), e);
		}
	}


	/**
	 * 新增或者修改
	 * 
	 * @param request
	 * @param SysWordbook
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public ComMessage saveOrUpdate(@ModelAttribute("wordbook") SysWordbook wordbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			super.saveOrUpdate(request, wordbook);
			msg.setObj(sys0005Service.saveOrUpdate(wordbook));
			return msg;
		} catch (Exception e) {
			logger.error("saveOrUpdate error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("新增或者修改失败！");
			return msg;
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
				SysWordbook detail=sys0005Service.find(Integer.parseInt(id));
				detail.setStatus(Utils.WORDBOOK_W00101);
				sys0005Service.saveOrUpdate(detail);
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
				SysWordbook m=sys0005Service.find(Integer.parseInt(id));
				m.setStatus(Utils.WORDBOOK_W00102);
				sys0005Service.saveOrUpdate(m);
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
				sys0005Service.delete(Integer.parseInt(id));
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
	 * @author zhuqiang
	 * @deprecated 数据字典Ajax显示
	 * */
	@RequestMapping(value = "/list")
	@ResponseBody
	public ComMessage list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			msg.setObj(getListPage(request, sys0005Service, SysWordbook.class));
			return msg;
		} catch (Exception e) {
			logger.error("list error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("查询失败！");
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
	public String validateOnly(@ModelAttribute("wordbook") SysWordbook wordbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			List<SysWordbook> list = sys0005Service.validateOnly(wordbook);
			if (null != list && list.size() > 0) {
				if (list.size() > 1) {
					return false + "";
				}
				// 新增
				if (null == wordbook.getId() || 0 == wordbook.getId()) {
					return false + "";
				}
				// 修改
				if (!wordbook.getId().equals(list.get(0).getId())) {
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
