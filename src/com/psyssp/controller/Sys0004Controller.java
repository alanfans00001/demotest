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
import com.psyssp.beans.SysRole;
import com.psyssp.beans.SysRolesToPurview;
import com.psyssp.mapper.DmMapper;
import com.psyssp.service.Sys0002Service;
import com.psyssp.service.Sys0003Service;
import com.psyssp.service.Sys0004Service;
import com.psyssp.tool.AvoidDuplicateSubmission;
import com.psyssp.tool.ComMessage;
import com.psyssp.tool.UnAvailableException;
@Controller
@RequestMapping(value = "/sys0004")
public class Sys0004Controller extends DmController{
	/**
	 * 日志
	 */
	private static Logger logger = Logger.getLogger(Sys0004Controller.class);
	@Autowired
	private Sys0002Service sys0002Service;
	@Autowired
	private Sys0003Service sys0003Service;
	@Autowired
	private Sys0004Service sys0004Service;

	private static final String[] ROLES_MENUNOS = { "M010401"};
	
	/**
	 * 初始化
	 */
	@RequestMapping(value = "/init")
	public ModelAndView init(HttpServletRequest request,HttpSession session){
		try {
			return new ModelAndView("pages/sys0004");
		} catch (Exception e) {
			logger.error("init error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"), e);
		}
	}
	
	
	/**
	 * 获取用户集合
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value  = "/list")
	@ResponseBody
	public ComMessage list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ComMessage msg=new ComMessage();
		try {
			//未登录，给出提示，跳转至登录页面
			if(null==getUserSession(request)){
				msg.setResult(ComMessage.RESULT_FAIL);
				msg.setMsg("请登录！");
				return msg;
			}
			//分页查询
			msg.setObj(getListPage(request, sys0004Service, SysRolesToPurview.class));
			return msg;
		} catch (Exception e) {
			logger.error("list error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("查询错误！");
			return msg;
		}
	}
	
	/**
	 * 角色权限设定初始化
	 * @param request
	 * @return
	 * @throws Exception
	 */
	SysRole roleNo = null;
	@RequestMapping(value = "/assignPermission")
	@AvoidDuplicateSubmission(needSaveToken = true)
	public ModelAndView assignPermission(HttpServletRequest request,HttpSession session){
		Map<String, Object> resultmMap = new HashMap<String, Object>();
		try {
			// 权限
			boolean b = super.initFun(ROLES_MENUNOS[0], session);
			if (!b) {
				return new ModelAndView("error");
			}
			
			String[] ids=null;
			if (null != request.getParameter("ids")) {
				ids= request.getParameter("ids").split(",");
				roleNo = sys0003Service.find(Integer.parseInt(ids[0]));
				resultmMap.put("roleno", roleNo.getRoleno());
			}
			
			Map<String, Object> map=new HashMap<String, Object>();
			map.put(DmMapper.MAP_KEY_M, roleNo);
			// 获取角色集合
			List<SysMenu> menuList = sys0002Service.findList(null);
			// 获取权限设置集合
			List<SysRolesToPurview> rolesList = sys0004Service.findList(map);
			resultmMap.put("menuList", menuList);
			resultmMap.put("rolesList", rolesList);
			resultmMap.put("ids", ids[0]);
			return new ModelAndView("pages/sys000401",resultmMap);
		} catch (Exception e) {
			logger.error("assignPermission error", e);
			throw new UnAvailableException(getMessage("COM.ERROR.E0001"), e);
		}
	}
	
	/**
	 * 设定角色权限
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOrUpdate")
	@ResponseBody
	@AvoidDuplicateSubmission(needRemoveToken = true)
	public ComMessage saveOrUpdate(@ModelAttribute("roles") SysRolesToPurview roles,HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		ComMessage msg = new ComMessage();
		try {
			super.saveOrUpdate(request, roles);
			
			String roleno = request.getParameter("roleno");
			String[] chkFun = request.getParameter("chkFun").split(",");
			String[] chkSubFun = request.getParameter("chkSubFun").split(","); 
			if((chkFun.length>0 && chkFun!=null) && (chkSubFun.length>0 && chkSubFun!=null)){
				Map<String, Object> map=new HashMap<String, Object>();
				map.put(DmMapper.MAP_KEY_M, roleNo);
				List<SysRolesToPurview> rolesList = sys0004Service.findList(map);
				//删除
				for (SysRolesToPurview sysRolesToPurview : rolesList) {
					sys0004Service.delete(sysRolesToPurview.getId());
				}
				//添加
				for (String string : chkFun) {
					SysRolesToPurview rp = new SysRolesToPurview();
					rp.setRoleno(roleno);
					rp.setMenuno(string);
					rp.setFunno("");
					super.saveOrUpdate(request, rp);
					sys0004Service.saveOrUpdate(rp);
				}
				for (String string : chkSubFun) {
					String funno = request.getParameter("funs_"+string);
					
					SysRolesToPurview rp = new SysRolesToPurview();
					rp.setRoleno(roleno);
					rp.setMenuno(string);
					rp.setFunno(funno);
					super.saveOrUpdate(request, rp);
					sys0004Service.saveOrUpdate(rp);
				}
			}
			
			return msg;
		} catch (Exception e) {
			logger.error("saveOrUpdate error", e);
			msg.setResult(ComMessage.RESULT_FAIL);
			msg.setMsg("新增或者修改失败！");
			return msg;
		}
	}

}
