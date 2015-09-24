package com.psyssp.mapper;

import com.psyssp.beans.SysUser;

/**
 * 系统用户数据操作接口
 * @author zj
 *
 */
public interface Sys0001Mapper extends DmMapper<SysUser>{
	/**
	 * 登录
	 * @param m 
	 * @return
	 * @throws Exception
	 */
	public SysUser findByUser(SysUser m)throws Exception;
}
