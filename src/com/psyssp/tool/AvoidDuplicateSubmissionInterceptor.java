package com.psyssp.tool;

import java.lang.reflect.Method;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.psyssp.beans.SysUser;



public class AvoidDuplicateSubmissionInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger LOG = Logger.getLogger(AvoidDuplicateSubmissionInterceptor.class);

	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,Object handler) throws Exception{
		
		SysUser user = (SysUser) request.getSession().getAttribute(Utils.ACCOUNT_SESSION_KEY);
		if(user != null){
			HandlerMethod  handlerMethod = (HandlerMethod) handler;
			Method method = handlerMethod.getMethod();
			 
			AvoidDuplicateSubmission annotation = method.getAnnotation(AvoidDuplicateSubmission.class);
			if(annotation != null){
				
				boolean needSaveSession = annotation.needSaveToken();
				if(needSaveSession){
					request.getSession(false).setAttribute("token", UUID.randomUUID().toString());;
				}
				
				boolean needRemoveSession = annotation.needRemoveToken();
				if(needRemoveSession){
					if(isRepeatSubmit(request)){
						LOG.warn("please don't repeat submit,[user:" + user.getUsername() + ",url:"+ request.getServletPath() + "]");
						return false;
					}
					request.getSession(false).removeAttribute("token");
				}
			}
		}
		return true;
	}
	
	
	private boolean isRepeatSubmit(HttpServletRequest request){
		String serverToken = (String) request.getSession(false).getAttribute("token");
		if(serverToken == null){
			return true;
		}
		
		String clinetToken = request.getParameter("token");
		if(clinetToken == null){
			return true;
		}
		if(!serverToken.equals(clinetToken)){
			return true;
		}
		return false;
	}
}
