package com.psyssp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.TblVariable;
import com.psyssp.mapper.TblVariableMapper;
import com.psyssp.service.TblVariableService;
import com.psyssp.tool.PageInfo;

@Service
public class TblVariableServiceImpl implements TblVariableService{
	
	@Autowired
	private TblVariableMapper tblVariableMapper;

	@Override
	public TblVariable find(Integer id) throws Exception {
		// TODO Auto-generated method stub
		return tblVariableMapper.find(id);
	}

	@Override
	public List<TblVariable> findList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return tblVariableMapper.findList(map);
	}

	@Override
	public List<Object> findObjectList(Map<String, Object> map)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TblVariable> findListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		// TODO Auto-generated method stub
		return tblVariableMapper.findListPage(map, p);
	}

	@Override
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(Integer id) throws Exception {
		tblVariableMapper.delete(id);
	}

	@Override
	public List<TblVariable> validateOnly(TblVariable m) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TblVariable saveOrUpdate(TblVariable m) throws Exception {
		        //新增
				if(null==m.getVariable_id() || 0==m.getVariable_id()){
					tblVariableMapper.save(m);
					return tblVariableMapper.findLastSaved();
				}
				//修改
				tblVariableMapper.update(m);
				return tblVariableMapper.find(m.getVariable_id());
	}

	@Override
	public List<Object> deyfindListPage(Map<String, Object> map,
			PageInfo pageInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
