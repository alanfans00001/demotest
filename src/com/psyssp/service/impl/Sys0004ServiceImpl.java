package com.psyssp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.SysRolesToPurview;
import com.psyssp.mapper.Sys0004Mapper;
import com.psyssp.service.Sys0004Service;
import com.psyssp.tool.PageInfo;

@Service
public class Sys0004ServiceImpl implements Sys0004Service {
	@Autowired
	private Sys0004Mapper sys0004Mapper;

	@Override
	public void delete(Integer id) throws Exception {
		sys0004Mapper.delete(id);

	}

	@Override
	public SysRolesToPurview find(Integer id) throws Exception {
		return sys0004Mapper.find(id);
	}

	@Override
	public List<SysRolesToPurview> findList(Map<String, Object> map) throws Exception {
		return sys0004Mapper.findList(map);
	}

	@Override
	public List<SysRolesToPurview> findListPage(Map<String, Object> map, PageInfo p) throws Exception {
		return sys0004Mapper.findListPage(map, p);
	}

	@Override
	public List<Object> findObjectList(Map<String, Object> map) throws Exception {
		return sys0004Mapper.findObjectList(map);
	}

	@Override
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p) throws Exception {
		return null;
	}

	@Override
	public SysRolesToPurview saveOrUpdate(SysRolesToPurview m) throws Exception {
		if (null == m.getId() || 0 == m.getId()) {
			sys0004Mapper.save(m);
			return sys0004Mapper.findLastSaved();
		}
		// 修改
		sys0004Mapper.update(m);
		return sys0004Mapper.find(m.getId());
	}

	public List<SysRolesToPurview> validateOnly(SysRolesToPurview m) throws Exception {
		return sys0004Mapper.validateOnly(m);
	}

	
}
