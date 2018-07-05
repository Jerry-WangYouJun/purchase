package com.saki.service;

import java.util.ArrayList;
import java.util.List;

import com.saki.model.TUserProduct;

public interface UserProductServiceI{
	public ArrayList<Integer> getIdByCompany(int companyId);
	public List<TUserProduct> listByCompanyId(int companyId);
	public void save(int companyId, String productlist, int roleId);
	public void delete(int companyId);
	void updatePrice(int companyId, int detailId, double price, int roleId);
	void updateStatus(int id);
	void updateStatusReset(int detailId, String companyId);
	public void updateMarkupPrice(Integer mapid, Double markup);
}
