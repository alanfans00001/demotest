package com.psyssp.service.impl;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.SysFun;
import com.psyssp.mapper.Sys0006Mapper;
import com.psyssp.service.Sys0006Service;
import com.psyssp.tool.PageInfo;

/**
 * SysFun 系统按钮
 * @author mj
 *
 */
@Service
public class Sys0006serviceImpl implements Sys0006Service{
	@Autowired
	private Sys0006Mapper sys0006Mapper;


	@Override
	public SysFun find(Integer id) throws Exception {
		return sys0006Mapper.find(id);
	}

	@Override
	public List<SysFun> findList(Map<String, Object> map) throws Exception {
		return sys0006Mapper.findList(map);
	}

	@Override
	public List<Object> findObjectList(Map<String, Object> map)
			throws Exception {
		return sys0006Mapper.findObjectList(map);
	}

	@Override
	public List<SysFun> findListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		return sys0006Mapper.findListPage(map,p);
	}

	@Override
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		return sys0006Mapper.findObjectListPage(map,p);
	}

	@Override
	public void delete(Integer id) throws Exception {
		sys0006Mapper.delete(id);
	}

	@Override
	public SysFun saveOrUpdate(SysFun m) throws Exception {
		//新增
		if(null==m.getId() || 0==m.getId()){
			sys0006Mapper.save(m);
			return sys0006Mapper.findLastSaved();
		}
		//修改
		sys0006Mapper.update(m);
		return sys0006Mapper.find(m.getId());
	}

	@Override
	public List<SysFun> validateOnly(SysFun m) throws Exception {
		return sys0006Mapper.validateOnly(m);
	}
	
}
