package com.psyssp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.SysUser;
import com.psyssp.mapper.Sys0001Mapper;
import com.psyssp.service.Sys0001Service;
import com.psyssp.tool.PageInfo;

/**
 * 系统用户逻辑操作类
 * @author zj
 *
 */
@Service
public class Sys0001ServiceImpl implements Sys0001Service{
	/**
	 * 用户数据操作层
	 */
	@Autowired
	private Sys0001Mapper sys0001Mapper;

	/**
	 * 登录
	 */
	@Override
	public SysUser findByUser(SysUser m) throws Exception {
		return sys0001Mapper.findByUser(m);
	}

	/**
	 * 删除
	 */
	@Override
	public void delete(Integer id) throws Exception {
		sys0001Mapper.delete(id);
	}

	/**
	 * 根据主键查找实体
	 */
	@Override
	public SysUser find(Integer id) throws Exception {
		return sys0001Mapper.find(id);
	}

	/**
	 * 查找单表的实体集合
	 */
	@Override
	public List<SysUser> findList(Map<String, Object> map) throws Exception {
		return sys0001Mapper.findList(map);
	}

	/**
	 * 分页查找单表的实体集合
	 */
	@Override
	public List<SysUser> findListPage(Map<String, Object> map, PageInfo p) throws Exception {
		return sys0001Mapper.findListPage(map, p);
	}

	/**
	 * 多表查询
	 */
	@Override
	public List<Object> findObjectList(Map<String, Object> map) throws Exception {
		return sys0001Mapper.findObjectList(map);
	}

	/**
	 * 分页多表查询
	 */
	@Override
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p) throws Exception {
		return sys0001Mapper.findObjectListPage(map, p);
	}

	/**
	 * 新增或修改
	 */
	@Override
	public SysUser saveOrUpdate(SysUser m) throws Exception {
		//新增
		if(null==m.getId() || 0==m.getId()){
			sys0001Mapper.save(m);
			return sys0001Mapper.findLastSaved();
		}
		//修改
		sys0001Mapper.update(m);
		return sys0001Mapper.find(m.getId());
	}

	/**
	 * 验证唯一性
	 */
	@Override
	public List<SysUser> validateOnly(SysUser m) throws Exception {
		return sys0001Mapper.validateOnly(m);
	}
}
