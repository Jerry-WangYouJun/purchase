package com.saki.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.saki.entity.TreeModel;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.model.TUserProduct;

public class TreeUntil {

	private static final Logger logger = Logger.getLogger(TreeUntil.class);
	
	public List<TreeModel> convertProductToList(List<TProduct> productList )
	{
		List<TreeModel> list = new ArrayList<TreeModel>();		
		for (TProduct tProduct : productList) {
			TreeModel tree = new TreeModel();
			tree.setId(tProduct.getId()+"");
			if(tProduct.getParentId() == null)
			{
				tree.setPid(0+"");
			}
			else
			{
				tree.setPid(tProduct.getParentId()+"");
			}
			tree.setName(tProduct.getProduct());
			list.add(tree);
		}
		return list;
	}
	
	public List<TreeModel> convertProductDetailToList(
			List<TProductDetail> detailList,List<TUserProduct> detailIds){
		List<TreeModel> list = new ArrayList<TreeModel>();		
		for (TProductDetail detail : detailList) {
			TreeModel tree = new TreeModel();
			tree.setId("detail_"+detail.getId());
			tree.setPid(detail.getProductId()+"");
			tree.setName(detail.getSubProduct()+"-"
					+ (detail.getFormatNum()==null?"":detail.getFormatNum() )
					+detail.getFormat()+"-"+detail.getMaterial());
			
			if(detailIds != null&&detailIds.size() !=0)
			{
				for (TUserProduct detailId : detailIds) {
					if(detailId.getProductDetailId() == detail.getId())
					{
						tree.setChecked(true);
					}
				}
			}
			
			list.add(tree);
		}
		return list;
	}
	
	
	public List<TreeModel> convertProductDetailToList(List<TProductDetail> detailList)
	{
		List<TreeModel> list = new ArrayList<TreeModel>();		
		for (TProductDetail detail : detailList) {
			TreeModel tree = new TreeModel();
			tree.setId("detail_"+detail.getId());
			tree.setPid(detail.getProductId()+"");
			tree.setName(detail.getSubProduct()+"-"
					+ (detail.getFormatNum()==null?"":detail.getFormatNum() )
					+ detail.getFormat()+"-"+detail.getMaterial());		
			
			list.add(tree);
		}
		return list;
	}
	

}
