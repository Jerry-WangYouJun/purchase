package com.saki.service;

import java.util.List;
import java.util.Map;

import com.saki.model.TOrderDetail;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.model.TUserProduct;

public interface OrderServiceI extends BaseServiceI{

	
	List<Map<String, Object>> searchDetail(String id);

	List<TProduct> searchProduct();

	List<TProduct> searchProductType(String product);

	List<TProductDetail> searchDetailByProductId(String productId);

	TOrderDetail getByDetailId(String detailId);

	void delete(TOrderDetail detail);

	List<TOrderDetail> getOrderDetailsForSupplierOrder();
	
	void updateOrderLocked(String locked, String id);
	
	void updateOrderLockedTask();

	String getOrderCode(String dayOfOrderNo);
	
	List<TProduct> searchProductByCompanyId(String companyId);

	List<TProductDetail> searchDetailByCompanyId(String companyId);

	List<TProduct> searchProductByProductIds(String productIds);

	List<TProduct> searchProductTypeByParentId(String parentId);

	List<TUserProduct> searchUserProductByCompanyId(String companyId);

	List<TProductDetail> searchDetailByIds(String ids);

	TProduct searchProductByProductId(Integer productId);

	List<TProduct> searchProductByproductIds(String productIds);

	List<TProduct> searchProductByProductIdsAndParentId(String productIds, String parentId);

	List<TProduct> searchFirstProduct();
	
}
