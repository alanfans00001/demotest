package com.psyssp.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.psyssp.beans.TblModel;
import com.psyssp.tool.PageInfo;


public interface TblMapper<M extends TblModel> {
	/**
	 * 搜索条件Key：实体对象
	 */
	public static final String MAP_KEY_M = "m";
	/**
	 * 搜索条件Key：排序字段
	 */
	public static final String MAP_KEY_ORDERBY = "orderby";
	/**
	 * 搜索条件Key：排序方式-asc,desc
	 */
	public static final String MAP_KEY_ORDER = "order";
	
	/**
	 * 查找上一条的插入数据
	 * @return
	 * @throws Exception
	 */
	public M findLastSaved()throws Exception;

	/**
	 * 根据主键查找实体
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public M find(Integer id) throws Exception;

	/**
	 * 根据查询条件查找实体集合
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<M> findList(Map<String, Object> map) throws Exception;

	/**
	 * 根据查询条件联合查找对象集合
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public List<Object> findObjectList(Map<String, Object> map) throws Exception;

	/**
	 * 根据查询条件查找实体集合，分页
	 * @param map
	 * @param p
	 * @return
	 * @throws Exception
	 */
	public List<M> findListPage(@Param("filter")Map<String, Object> map, @Param("page")PageInfo p) throws Exception;

	/**
	 * 根据查询条件联合查找对象集合，分页
	 * @param map
	 * @param p
	 * @return
	 * @throws Exception
	 */
	public List<Object> findObjectListPage(@Param("filter")Map<String, Object> map, @Param("page")PageInfo p) throws Exception;

	/**
	 * 新增实体
	 * @param m
	 * @return
	 * @throws Exception
	 */
	public void save(M m) throws Exception;

	/**
	 * 修改实体
	 * @param m
	 * @return
	 * @throws Exception
	 */
	public void update(M m) throws Exception;

	/**
	 * 删除实体
	 * @param id
	 * @throws Exception
	 */
	public void delete(Integer id) throws Exception;
	
	/**
	 * 唯一验证
	 * @param m
	 * @return
	 * @throws Exception
	 */
	public List<M> validateOnly(M m) throws Exception;

}
