package com.psyssp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.SysRole;
import com.psyssp.mapper.Sys0003Mapper;
import com.psyssp.service.Sys0003Service;
import com.psyssp.tool.PageInfo;

/**
 * SysRole 系统角色
 * @author mj
 *
 */
@Service
public class Sys0003ServiceImpl implements Sys0003Service{
	@Autowired
	private Sys0003Mapper sys0003Mapper;
	
	@Override
	public void delete(Integer id) throws Exception {
		sys0003Mapper.delete(id);
	}

	@Override
	public SysRole find(Integer id) throws Exception {
		return sys0003Mapper.find(id);
	}

	@Override
	public List<SysRole> findList(Map<String, Object> map) throws Exception {
		return sys0003Mapper.findList(map);
	}

	@Override
	public List<SysRole> findListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		return sys0003Mapper.findListPage(map, p);
	}

	@Override
	public List<Object> findObjectList(Map<String, Object> map)
			throws Exception {
		return sys0003Mapper.findObjectList(map);
	}

	@Override
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		return sys0003Mapper.findObjectListPage(map, p);
	}

	@Override
	public SysRole saveOrUpdate(SysRole m) throws Exception {
		//新增
		if(null==m.getId() || 0==m.getId()){
			sys0003Mapper.save(m);
			return sys0003Mapper.findLastSaved();
		}
		//修改
		sys0003Mapper.update(m);
		return sys0003Mapper.find(m.getId());
	}

	@Override
	public List<SysRole> validateOnly(SysRole m) throws Exception {
		return sys0003Mapper.validateOnly(m);
	}

}
