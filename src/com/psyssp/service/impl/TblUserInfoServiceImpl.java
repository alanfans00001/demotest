package com.psyssp.service.impl;

import java.beans.PropertyDescriptor;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.beanutils.PropertyUtilsBean;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.psyssp.beans.TblUserInfo;
import com.psyssp.mapper.TblUserInfoMapper;
import com.psyssp.service.TblUserInfoService;
import com.psyssp.tool.DynamicBean;
import com.psyssp.tool.PageInfo;

@Service
public class TblUserInfoServiceImpl implements TblUserInfoService {
	
	@Autowired
	private TblUserInfoMapper tblUserInfoMapper; 

	@Override
	public TblUserInfo find(Integer id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TblUserInfo> findList(Map<String, Object> map) throws Exception {
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
	public List<Object> findObjectListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(Integer id) throws Exception {
		tblUserInfoMapper.delete(id);
	}

	@Override
	public List<TblUserInfo> validateOnly(TblUserInfo m) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TblUserInfo saveOrUpdate(TblUserInfo m) throws Exception {
		//新增
		if(m.getUser_card() == null){
			return null;
		}
		
		//更新
		//把对象转成map,用list装下起来
		List<Map<String,Object>> l_Map = new ArrayList<Map<String,Object>>();
		PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
		for(PropertyDescriptor pp : propertyUtilsBean.getPropertyDescriptors(m)){
			Map<String, Object> params = new HashMap<String, Object>(); 
			if(pp.getName().contains("variable_id_")){
				params.put(pp.getName().split("_")[2],propertyUtilsBean.getNestedProperty(m, pp.getName()));
				params.put("user_card",m.getUser_card());
			}
			l_Map.add(params);
		}
		//先得跟据user_card查询一下，得到这个卡号所有的信息，来判断下面是更新操作还是插入操作
		List<Map<String, String>> lists = tblUserInfoMapper.find_byCard(m.getUser_card());
		for(Map<String,Object> map : l_Map){
			Set<String> keySet = map.keySet();
			for(String key : keySet){
				List<String> list_variable_id = new ArrayList<String>();
				for(Map<String,String> maps : lists){
					list_variable_id.add(String.valueOf(maps.get("variable_id")));
					if (StringUtils.equals(key,String.valueOf(maps.get("variable_id")))){
						//判断值是否相等
						if(!StringUtils.equals(maps.get("variable_value"),map.get(key).toString())){
							//更新
							m.setVariable_id(key);
							m.setVariable_value(map.get(key).toString());
							tblUserInfoMapper.update(m);
						}
					}
				}
				if(!list_variable_id.contains(key) && !StringUtils.equals("user_card", key)){
					//新增
					m.setVariable_id(key);
					m.setVariable_value(String.valueOf(map.get(key)));
					if(StringUtils.isNotBlank(String.valueOf(map.get(key))) && !StringUtils.equals("null", String.valueOf(map.get(key)))){
						tblUserInfoMapper.save(m);	
					}
				}
			}
		}
		return null;
	}

	@Override
	public List<TblUserInfo> findListPage(Map<String, Object> map, PageInfo p)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> deyfindListPage(Map<String, Object> map, PageInfo p) throws Exception {
		// TODO Auto-generated method stub
				List<TblUserInfo> list = tblUserInfoMapper.ObjecetList(map, p);
				List<Object> dynamicBean = new ArrayList<Object>();
				if(list != null && list.size() > 0){
					//跟据返回的数据动态生成对象
					for(TblUserInfo ti : list){
						Map<String,Object> propertyMap = new HashMap<String,Object>();
						Map<String,Object> k_v = new HashMap<String,Object>();
						if(StringUtils.isNotBlank(ti.get_Object())){
							k_v.put("user_card", ti.getUser_card());
							String _Object = ti.get_Object();
							if(_Object.contains(",")){
								String[] nodes = _Object.split(",");
								for(String node : nodes){
									if(node.contains(":")){
										String[] _key_value = node.split(":");
										//取出的值可能有空的情况
										if(_key_value.length == 1){
											k_v.put(_key_value[0],"");
										}else{
											k_v.put(_key_value[0],_key_value[1]);
										}
									}
								}
							}
							if(k_v.size() > 0){
								Set<String> keySet = k_v.keySet();
								for(String key : keySet){
									propertyMap.put(key, Class.forName("java.lang.String"));
								}
								DynamicBean bean = new DynamicBean(propertyMap);
								for(String key : keySet){
									bean.setValue(key,k_v.get(key));
								}
								dynamicBean.add(bean.getObject());
							}
						}
					}
				}
				return dynamicBean;
	}

	@Override
	public Object findByCard(int id) throws Exception {
		List<Map<String,String>> list = tblUserInfoMapper.find_byCard(String.valueOf(id));
		if(list.size() > 0){
			Map<String,Object> propertyMap = new HashMap<String,Object>();
			propertyMap.put("user_card", "java.lang.String");
			Map<Object,Object> map = new HashMap<Object,Object>();
			 for(Map<String,String> maps : list){
				 map.put("user_card", maps.get("user_card"));
				 map.put("create_date", maps.get("create_date"));
				 map.put("modifie_date", maps.get("modifie_date"));
				 map.put("creater_userid", maps.get("creater_userid"));
				 map.put("modifier_userid", maps.get("modifier_userid"));
				 map.put("record_status", maps.get("record_status"));
				 map.put("variable_id_"+String.valueOf(maps.get("variable_id")),maps.get("variable_value"));
			 }
			 //因为对象属性前台接收不到，在后台先给60个默认属性
			 for(int i = 1;i<=60;i++){
				 if(!map.containsKey("variable_id_"+i)){
					 map.put("variable_id_"+i,"");
				 }
			 }
			 Set<Object> keySet = map.keySet();
				for(Object key : keySet){
					if(key.toString().contains("date")){
						propertyMap.put(key.toString(), Class.forName("java.sql.Timestamp"));
					}else{
						if(key.toString().contains("_userid") || key.toString().equals("record_status")){
							propertyMap.put(key.toString(), Class.forName("java.lang.Integer"));
						}else{
							propertyMap.put(key.toString(), Class.forName("java.lang.String"));
							}
					}
				}
				DynamicBean bean = new DynamicBean(propertyMap);
				for(Object key : keySet){
					//System.out.println(key.getClass().getClass() +"--------"+ key);
					bean.setValue(key.toString(),map.get(key));
				}
				return bean.getObject();
		}
		return null;
	}

}
