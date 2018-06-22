package com.saki.service;

import java.util.ArrayList;
import java.util.List;

import com.saki.model.TProductDetail;

public interface ProductDetailServiceI extends BaseServiceI{
	public List<TProductDetail> loadByProductId(int productId);

	public List<TProductDetail> searchAllProductDetail();
}
