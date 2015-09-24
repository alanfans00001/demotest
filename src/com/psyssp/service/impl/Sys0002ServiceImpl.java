package com.psyssp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.SysMenu;
import com.psyssp.mapper.Sys0002Mapper;
import com.psyssp.service.Sys0002Service;
import com.psyssp.tool.PageInfo;

/**
 * 系统菜单逻辑操作类
 * @author cyb
 *
 */
@Service
public class Sys0002ServiceImpl implements Sys0002Service{
	@Autowired
	private Sys0002Mapper sys0002Mapper;

	/*
	 * 删除菜单
	 * @see com.ott.service.DmService#delete(java.lang.Integer)
	 */
	@Override
	public void delete(Integer id) throws Exception {
		sys0002Mapper.delete(id);
	}

	/*
	 * 查询一行菜单
	 * @see com.ott.service.DmService#find(java.lang.Integer)
	 */
	@Override
	public SysMenu find(Integer id) throws Exception {
		return sys0002Mapper.find(id);
	}

	/*
	 * 查询所有菜单
	 * @see com.ott.service.DmService#findList(java.util.Map)
	 */
	@Override
	public List<SysMenu> findList(Map<String, Object> map) throws Exception {
		return sys0002Mapper.findList(map);
	}

	/*
	 * 分页查询所有菜单
	 * @see com.ott.service.DmService#findListPage(java.util.Map, com.ott.tool.PageInfo)
	 */
	@Override
	public List<SysMenu> findListPage(Map<String, Object> map, PageInfo p) throws Exception {
		return sys0002Mapper.findListPage(map, p);
	}

	/*
	 * 多表查询
	 * @see com.ott.service.DmService#findListPage(java.util.Map, com.ott.tool.PageInfo)
	 */
	@Override
	public List<Object> findObjectList(Map<String, Object> map) throws Exception {
		return sys0002Mapper.findObjectList(map);
	}

	/*
	 * 分页多表查询
	 * @see com.ott.service.DmService#findListPage(java.util.Map, com.ott.tool.PageInfo)
	 */
	@Override
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p) throws Exception {
		return sys0002Mapper.findObjectListPage(map, p);
	}

	/*
	 * 新增和修改的方法
	 * @see com.ott.service.DmService#saveOrUpdate(com.ott.beans.DmModel)
	 */
	@Override
	public SysMenu saveOrUpdate(SysMenu m) throws Exception {
		//新增
		if(null==m.getId() || 0==m.getId()){
			sys0002Mapper.save(m);
			return sys0002Mapper.findLastSaved();
		}
		//修改
		sys0002Mapper.update(m);
		return sys0002Mapper.find(m.getId());
	}

	/*
	 * 检验唯一性
	 * @see com.ott.service.DmService#validateOnly(com.ott.beans.DmModel)
	 */
	
	@Override
	public List<SysMenu> validateOnly(SysMenu m) throws Exception {
		return sys0002Mapper.validateOnly(m);
	}
	

}
