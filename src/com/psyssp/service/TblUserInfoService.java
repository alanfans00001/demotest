package com.psyssp.service;

import com.psyssp.beans.TblUserInfo;

public interface TblUserInfoService extends TblService<TblUserInfo> {

	Object findByCard(int parseInt) throws Exception;
}

