package com.psyssp.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.psyssp.beans.TblModel;
import com.psyssp.tool.PageInfo;

/**
 * 逻辑操作基本接口
 * @author newNet
 *
 * @param <M>
 */
public interface TblService<M extends TblModel> {
	
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

	/**
	 * 新增或修改实体
	 * @param m
	 * @return
	 * @throws Exception
	 */
	public M saveOrUpdate(M m) throws Exception;

	public List<Object> deyfindListPage(Map<String, Object> map,PageInfo pageInfo) throws Exception;

}
