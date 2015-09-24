package com.psyssp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.SysWordbook;
import com.psyssp.mapper.Sys0005Mapper;
import com.psyssp.service.Sys0005Service;
import com.psyssp.tool.PageInfo;
/**
 * 数据字典ServiceImpl
 * @author zhuqiang
 * */
@Service
public class Sys0005ServiceImpl implements Sys0005Service {
	@Autowired
	private Sys0005Mapper sys0005Mapper;

	@Override
	public void delete(Integer id) throws Exception {
		sys0005Mapper.delete(id);
	}
	
	@Override
	public SysWordbook find(Integer id) throws Exception {
		return sys0005Mapper.find(id);
	}

	@Override
	public List<SysWordbook> findList(Map<String, Object> map) throws Exception {
		return sys0005Mapper.findList(map);
	}

	@Override
	public List<SysWordbook> findListPage(Map<String, Object> map, PageInfo p) throws Exception {
		return sys0005Mapper.findListPage(map, p);
	}

	@Override
	public List<Object> findObjectList(Map<String, Object> map) throws Exception {
		return sys0005Mapper.findObjectList(map);
	}

	@Override
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p) throws Exception {
		return sys0005Mapper.findObjectListPage(map, p);
	}

	@Override
	public SysWordbook saveOrUpdate(SysWordbook m) throws Exception {
		// 新增
		if (null == m.getId() || 0 == m.getId()) {
			sys0005Mapper.save(m);
			return sys0005Mapper.findLastSaved();
		}
		// 修改
		sys0005Mapper.update(m);
		return sys0005Mapper.find(m.getId());
	}

	public SysWordbook findByWordbook(SysWordbook m) throws Exception {
		return sys0005Mapper.findByWordbook(m);
	}

	@Override
	public List<SysWordbook> validateOnly(SysWordbook m) throws Exception {
		return sys0005Mapper.validateOnly(m);
	}
}
