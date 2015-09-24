package com.psyssp.controller;

import java.util.HashMap;
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

import com.psyssp.beans.TblUserInfo;
import com.psyssp.service.TblUserInfoService;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.UnAvailableException;

@Controller
@RequestMapping(value="tblUserInfo")
public class TblUserInfoController extends TblController {

	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(TblUserInfoController.class);
	
	@Autowired
	private TblUserInfoService tblUserInfoService;


	private static final String[] ROLES_MENUNOS = { "M0301", "M030101" };
	
	

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

			return new ModelAndView("pages/tblUserInfo", resultMap);
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
			msg.setObj(dynamicgetListPage(request, tblUserInfoService, TblUserInfo.class));
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
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
				Object tui = tblUserInfoService.findByCard(Integer.parseInt(ids[0]));
				resultMap.put("DynamicBean", tui);
			}
			return new ModelAndView("pages/tblUserInfo01", resultMap);
		} catch (Exception e) {
			e.printStackTrace();
			
			logger.error("editInit error", e);	
				throw new UnAvailableException(getMessage("COM.ERROR.E0001"), e);
		}
	}
	
	
	/**
	 * 新增或修改
	 * @param fun
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public ComMessage edit(@ModelAttribute("tblUserInfo") TblUserInfo tblUserInfo,HttpServletRequest request,HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			super.saveOrUpdate(request, tblUserInfo);
			msg.setObj(tblUserInfoService.saveOrUpdate(tblUserInfo));
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveOrUpdate error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("新增或者修改失败！");
			return msg;
		}
	}
	
	
	/**
	 * 删除
	 * 2015年9月16日 上午10:26:01
	 * 
	 * @auther liuc
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
				tblUserInfoService.delete(Integer.parseInt(id));
			}
			return msg;
		} catch (Exception e) {
			logger.error("delete error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("删除失败！");
			return msg;
		}
	}

	
}
