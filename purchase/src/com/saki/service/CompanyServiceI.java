package com.saki.service;

import java.util.Map;

import com.saki.entity.Grid;

public interface CompanyServiceI extends BaseServiceI{

	Grid loadQuery(String sort, String order, String page, String rows,
			Map<String, Object> params);

	Grid loadColor(String sort, String order, String page, String rows,
			Map<String, Object> params);
	
	void updateColorDelete(String id);
	
	void addMapDataByUser(int companyId , int  role);
	
	void addMapDataByProDetail(int proDetailId , int  proId);
}
