package com.saki.service;

import java.util.List;

import com.saki.entity.Notice;
import com.saki.model.TColor;
import com.saki.model.TUserProduct;

public interface UserProductServiceI{
	public List<TUserProduct> getIdByCompany(int companyId);
	public List<TUserProduct> listByCompanyId(int companyId);
	public void save(int companyId, String productlist, int roleId);
	public void delete(int companyId);
	void updatePrice(int companyId, int detailId, double price, int roleId);
	void updateStatus(int id);
	void updateStatusReset(int detailId, String companyId);
	void updateImg(int  productId , String companyId , String img);
	public void updateMarkupPrice(Integer mapid, String column,  Double markup);
	public List<Notice> initAdminData();
	public List<Notice> initCustomerData(Integer cid);
	public List<Notice> initSupplierData(Integer cid);
	public void deleteByList(Integer valueOf, String parameter);
	public void updateMarkupPriceByPercent(Integer mapid, Double markup);
	public void updateMarkupPriceWhenPriceUpdate(Integer mapid, Double price);
	public void updateColorImg(TColor color);
	public TColor getByKey(String id);
}
