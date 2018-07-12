package com.saki.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.saki.entity.Notice;
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
	public int countNoMarkupCount();
	public int countNoDefaultPrice();
	public List<Notice> initAdminData();
	public List<Notice> initCustomerData();
	public List<Notice> initSupplierData();
	public void deleteByList(Integer valueOf, String parameter);
}
