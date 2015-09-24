package com.psyssp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.Paa;
import com.psyssp.mapper.PaaMapper;
import com.psyssp.service.PaaService;
import com.psyssp.tool.PageInfo;

@Service
public class PaaServiceImpl implements PaaService{
	
	@Autowired
	private PaaMapper paaMapper;

	@Override
	public Paa find(Integer id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Paa> findList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> findObjectList(Map<String, Object> map)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Paa> findListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		// TODO Auto-generated method stub
				return null;
	}

	@Override
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(Integer id) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Paa> validateOnly(Paa m) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Paa saveOrUpdate(Paa m) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Paa> getAA() {
		List<List<?>> list = paaMapper.selectaa();
		return (List<Paa>) list.get(0);
	}

	@Override
	public List<Object> deyfindListPage(Map<String, Object> map,
			PageInfo pageInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
