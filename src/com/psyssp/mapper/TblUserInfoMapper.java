package com.psyssp.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.psyssp.beans.TblUserInfo;
import com.psyssp.tool.PageInfo;

@Service
public interface TblUserInfoMapper extends TblMapper<TblUserInfo> {

	List<TblUserInfo> ObjecetList(Map<String, Object> map, PageInfo p);

	List<Map<String, String>> find_byCard(String string);

}
