package com.psyssp.mapper;
  
import com.psyssp.beans.SysWordbook;

/**
 * 数据字典Mapper
 * @author zhuqiang 
 * */
public interface Sys0005Mapper extends DmMapper<SysWordbook>{
	//详情查询
	public SysWordbook findByWordbook(SysWordbook m)throws Exception;
	
}
