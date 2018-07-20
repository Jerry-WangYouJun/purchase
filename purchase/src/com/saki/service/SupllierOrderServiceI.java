package com.saki.service;

import java.util.List;
import java.util.Map;

import com.saki.model.TCompany;
import com.saki.model.TProduct;
import com.saki.model.TSupllierOrderDetail;

public interface SupllierOrderServiceI  extends BaseServiceI{


	List<Map<String, Object>> searchDetail(String id , String   companyId);

	List<TProduct> searchProduct();

	TSupllierOrderDetail getByDetailId(String string);

	void deleteByKey(String key);

	void getOrderDetail();

	int getSupllierOrder(int confirmId);

	void splitOrder(String id);

	int deleteDetailById(String orderId, String detailId);

	List<TCompany> searchCompany(String detailId);
	
	public String updateDetail(String update) ;

	Object searchBycompanyId(String string, String companyId, String sort,
			String orderColumn, String page, String rows);

	String updateSupllierPrice(String update);

	String getOrderCode(String dayOfOrderNo);
}
