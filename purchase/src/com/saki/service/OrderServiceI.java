package com.saki.service;

import java.util.List;
import java.util.Map;

import com.saki.entity.Grid;
import com.saki.model.TOrderDetail;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.model.TUserProduct;

public interface OrderServiceI extends BaseServiceI{
	
	/**
	 * 
	 * @param sort 排序字段
	 * @param order 排序方向
	 * @param page 页码
	 * @param rows 每页行数
	 * @param urgent  是否为加急订单
	 * @return
	 */
	public Grid loadAll(String sort, String order, String page, String rows , String urgent );
	
	/**
	 * 
	 * @param params 查询参数
	 * @param sort 排序字段
	 * @param order 排序方向
	 * @param page 页码
	 * @param rows 每页行数
	 * @param urgent 是否为加急订单
	 * @return
	 */
	public Grid search(Map params, String sort, String order, String page, String rows, String urgent);
	
	List<Map<String, Object>> searchDetail(String id);

	List<TProduct> searchProduct();

	List<TProduct> searchProductType(String product);

	List<TProductDetail> searchDetailByProductId(String productId, String companyId);

	TOrderDetail getByDetailId(String detailId);

	void delete(TOrderDetail detail);

	List<TOrderDetail> getOrderDetailsForSupplierOrder();
	
//	void updateOrderLocked(String locked, String id);
//	
//	void updateOrderLockedTask();

	String getOrderCode(String dayOfOrderNo);
	
	List<TProduct> searchProductByCompanyId(String companyId);

	//List<TProductDetail> searchDetailByCompanyId(String companyId);

	List<TProduct> searchProductByProductIds(String productIds);

	List<TProduct> searchProductTypeByParentId(String parentId);

	/**
	 * 查询企业关联的全部产品类型
	 */
	List<TUserProduct> searchUserProductByCompanyId(String companyId);

	List<TProductDetail> searchDetailByIds(String ids);

	TProduct searchProductByProductId(Integer productId);

	List<TProduct> searchProductByproductIds(String productIds);

	List<TProduct> searchProductByProductIdsAndParentId(String productIds, String parentId);

	List<TProduct> searchFirstProduct();

	List<Map<String, Object>> searchBrandByProductDetailId(String detailId);

	public void deleteOrderDetailByOrderId(String id);

	public void updateBase(Integer base);

	public void updateTrans(Integer valueOf);
	
}
