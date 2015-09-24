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

import com.psyssp.beans.SysFun;
import com.psyssp.service.Sys0006Service;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.UnAvailableException;
import com.psyssp.tool.Utils;

@Controller
@RequestMapping(value="/sys0006")
public class Sys0006Controller extends DmController{
	/**
	 * 日志 
	 */
	private static Logger logger = Logger.getLogger(Sys0001Controller.class);
	//SysFun 按钮服务层对象
	@Autowired
	private Sys0006Service sys0006Service;
	//菜单按钮列表
	private static final String[] ROLES_MENUNOS = { "M0106", "M010601" };
	
	/**
	 * 初始化
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/init")
	public ModelAndView init(HttpServletRequest request,HttpServletResponse response, HttpSession session)throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			//权限
			boolean b = super.initFun(ROLES_MENUNOS[0], session);
			if(!b){
				return new ModelAndView("error");
			}
			return new ModelAndView("pages/sys0006", resultMap);
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
			if(null==getUserSession(request)){
				msg.setResult(ComMessage.RESULT_FAIL);
				msg.setMsg("请登录！");
				return msg;
			}
			msg.setObj(getListPage(request, sys0006Service, SysFun.class));
			return msg;
		} catch (Exception e) {
			logger.error("list error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("查询错误！");
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
				SysFun fun = sys0006Service.find(Integer.parseInt(ids[0]));
				resultMap.put("fun", fun);
			}
			return new ModelAndView("pages/sys000601", resultMap);
		} catch (Exception e) {
			logger.error("editInit error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"), e);
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
				sys0006Service.delete(Integer.parseInt(id));
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
	 * @param fun
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public ComMessage edit(@ModelAttribute("fun") SysFun fun,HttpServletRequest request,HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			if(!request.getParameter("id").isEmpty()){	
				fun.setFunvalue(fun.getFunvalue());
			}
			super.saveOrUpdate(request, fun);
			msg.setObj(sys0006Service.saveOrUpdate(fun));
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
	public String validateOnly(@ModelAttribute("fun") SysFun fun, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			List<SysFun> list = sys0006Service.validateOnly(fun);
			if(null!=list && list.size()>0){
				if(list.size()>1){
					return false+"";					
				}
				//新增
				if(null==fun.getId() || 0==fun.getId()){
					return false+"";
				}	
				//修改
				if(!fun.getId().equals(list.get(0).getId())){
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
				SysFun fun = new SysFun();
				fun.setId(Integer.parseInt(id));
				fun.setStatus(Utils.WORDBOOK_W00101);
				super.saveOrUpdate(request, fun);
				sys0006Service.saveOrUpdate(fun);
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
				SysFun fun = new SysFun();
				fun.setId(Integer.parseInt(id));
				fun.setStatus(Utils.WORDBOOK_W00102);
				super.saveOrUpdate(request, fun);
				sys0006Service.saveOrUpdate(fun);
			}
			return msg;
		} catch (Exception e) {
			logger.error("forbidden error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("禁用失败！");
			return msg;
		}
	}
}
