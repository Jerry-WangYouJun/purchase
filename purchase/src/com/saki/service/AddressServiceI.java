package com.saki.service;

import java.util.List;
import java.util.Map;

import com.saki.entity.Grid;
import com.saki.model.TAddress;

public interface AddressServiceI{
	public List<TAddress> list();
	public void save(TAddress record);
	public void delete(int id);
	public void update(TAddress confirm);
	Grid loadQuery(String sort, String order, String page, String rows,
			Map<String, Object> params);
}
