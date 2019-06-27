package com.saki.service;

import java.util.List;

import com.saki.model.TProductDetail;

public interface ProductDetailServiceI extends BaseServiceI{
	/**
	 * 根据二级产品类型获取所有产品类型详情
	 * @param productId
	 * @return
	 */
	public List<TProductDetail> loadByProductId(int productId);

	public List<TProductDetail> searchAllProductDetail();

	public TProductDetail searchProductDetailById(int id);

	public void deleteById(int id);

	public void deleteByProductDetail(TProductDetail tProductDetail);

	List<TProductDetail> searchSelectDetailByCompanyId(String companyId);

}
