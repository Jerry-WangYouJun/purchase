package com.saki.service;

import java.util.Map;

import com.saki.entity.Grid;

public interface TransportServiceI extends BaseServiceI{
	Grid loadQuery(String sort, String order, String page, String rows,
			Map<String, Object> params);

	int checkOrderNo(String orderNo);
}
