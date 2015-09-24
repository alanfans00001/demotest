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

import com.psyssp.service.PaaService;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.UnAvailableException;
@Controller
@RequestMapping(value="Paa")
public class PaaController extends TblController {
	

	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(PaaController.class);
	
	@Autowired
	private PaaService paaService;


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

			return new ModelAndView("pages/tblVariable", resultMap);
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
			msg.setObj(paaService.getAA());
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("list error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("查询失败！");
			return msg;
		}
	}
}
