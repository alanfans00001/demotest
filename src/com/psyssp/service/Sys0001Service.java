package com.psyssp.service;


import org.springframework.stereotype.Service;

import com.psyssp.beans.SysUser;

/**
 * 系统用户逻辑操作接口
 * @author newNet
 *
 */
@Service
public interface Sys0001Service extends DmService<SysUser>{
	/***
	 * 登录
	 * @param m
	 * @return
	 * @throws Exception
	 */
	public SysUser findByUser(SysUser m)throws Exception;


}
