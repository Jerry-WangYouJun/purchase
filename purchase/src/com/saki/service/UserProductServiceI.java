package com.saki.service;

import java.util.ArrayList;
import java.util.List;

import com.saki.model.TUserProduct;

public interface UserProductServiceI{
	public ArrayList<Integer> getIdByCompany(int companyId);
	public List<TUserProduct> listByCompanyId(int companyId);
	public void save(int companyId, String productlist);
	public void delete(int companyId);
	void updatePrice(int companyId, int detailId, double price);
}
