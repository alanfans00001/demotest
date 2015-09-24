package com.psyssp.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;





import com.psyssp.beans.*;
import com.psyssp.service.*;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.UnAvailableException;
@Controller
@RequestMapping(value = "/sys0003") 
public class Sys0003Controller extends DmController{
	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(Sys0003Controller.class);
	//SysRole 角色服务层对象
	@Autowired
	private Sys0003Service sys0003Service;
	
	@Autowired
	private Sys0004Service sys0004Service;
	//菜单按钮列表
	private static final String[] ROLES_MENUNOS={"M0103","M010301"};
	
	/**
	 * 初始化
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/init")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		try {
			//权限
			boolean b = super.initFun(ROLES_MENUNOS[0], session);
			if(!b){
				return new ModelAndView("error");
			}
			return new ModelAndView("pages/sys0003");
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
		ComMessage msg=new ComMessage();
		try {
			if(null==getUserSession(request)){
				msg.setResult(ComMessage.RESULT_FAIL);
				msg.setMsg("请登录！");
				return msg;
			}
			msg.setObj(getListPage(request, sys0003Service, SysRole.class));
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
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editInit")
	public ModelAndView editInit(HttpServletRequest request, HttpSession session) throws Exception {
		Map<String, Object> resultMap=new HashMap<String, Object>();
		try {
			//权限
			boolean b = super.initFun(ROLES_MENUNOS[1], session);
			if(!b){
				return new ModelAndView("error");
			}
			if (null != request.getParameter("ids")) {
				String[] ids = request.getParameter("ids").split(",");
				SysRole role = sys0003Service.find(Integer.parseInt(ids[0]));
				resultMap.put("role",role);
			}
			return new ModelAndView("pages/sys000301",resultMap);
		} catch (Exception e) {
			logger.error("editInit error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"), e);
		}
	}
	
	/**
	 * 新增或修改
	 * @param role
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	public ComMessage edit(@ModelAttribute("role") SysRole role,HttpServletRequest request,HttpServletResponse response) throws Exception {
		ComMessage msg = new ComMessage();
		try {
			if(!request.getParameter("id").isEmpty()){	//修改
				role.setRolename(role.getRolename());
			}
			super.saveOrUpdate(request, role);
			msg.setObj(sys0003Service.saveOrUpdate(role));
			return msg;
		} catch (Exception e) {
			logger.error("saveOrUpdate error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("新增或者修改失败！");
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
			//角色集合
			List<Integer> roleToIds = new ArrayList<Integer>();
			for (String id : ids) {
				Map<String,Object> map = new HashMap<String, Object>();
				//当前id角色
				SysRole role = sys0003Service.find(Integer.parseInt(id));
				map.put("roleNO", role.getRoleno());
				//当前角色下面权限集合
				List<SysRolesToPurview> rolesToPurviews = sys0004Service.findList(map);
				
				sys0003Service.delete(Integer.parseInt(id));
				for(SysRolesToPurview roleTo :rolesToPurviews){
					roleToIds.add(roleTo.getId());
				}
			}
			
			for(Integer id:roleToIds){
				sys0004Service.delete(id);
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
	 * @param user
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/validateOnly")
	@ResponseBody
	public String validateOnly(@ModelAttribute("role") SysRole role, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			List<SysRole> list = sys0003Service.validateOnly(role);
			if(null!=list && list.size()>0){
				if(list.size()>1){
					return false+"";					
				}
				//新增
				if(null==role.getId() || 0==role.getId()){
					return false+"";
				}	
				//修改
				if(!role.getId().equals(list.get(0).getId())){
					return false+"";
				}
			}
		} catch (Exception e) {
			logger.error("validateOnly error", e);
			return false+"";
		}
		return true+"";
	}
	
	
}
