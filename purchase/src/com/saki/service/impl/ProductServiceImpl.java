package com.saki.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.entity.Product;
import com.saki.entity.ProductType;
import com.saki.entity.TreeModel;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.service.ProductDetailServiceI;
import com.saki.service.ProductServiceI;
import com.saki.service.UserProductServiceI;
import com.saki.utils.TreeUntil;

@Service("productService")
public class ProductServiceImpl implements ProductServiceI{

	private static final Logger logger = Logger.getLogger(ProductServiceImpl.class);
	private BaseDaoI produceDao;
	public BaseDaoI getProduceDao() {
		return produceDao;
	}
	private UserProductServiceI userProductService;
	@Autowired
	public void setProduceDao(BaseDaoI produceDao) {
		this.produceDao = produceDao;
	}
	private ProductDetailServiceI productDetailService;
	
	public UserProductServiceI getUserProductService() {
		return userProductService;
	}
	@Autowired
	public void setUserProductService(UserProductServiceI userProductService) {
		this.userProductService = userProductService;
	}
	public ProductDetailServiceI getProductDetailService() {
		return productDetailService;
	}
	@Autowired
	public void setProductDetailService(ProductDetailServiceI productDetailService) {
		this.productDetailService = productDetailService;
	}
	@Override
	public void add(Object object) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Object object) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteByKey(String key) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Grid loadAll(String sort, String order, String page, String rows) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getByKey(String key) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Grid search(String row, String text, String sort, String order, String page, String rows) {	
		return null;
	}
	@Override
	public ArrayList<Product> listAll() {
		String hql = "from TProduct t";
		List<TProduct> ltp = produceDao.find(hql);
		ArrayList<Product> lp  = new ArrayList<Product>();		
		ArrayList<String> ls = new ArrayList<String>();
		
		for(int i=0;i<ltp.size();i++){		
			if(i > 0 && ls.indexOf(ltp.get(i).getProduct()) >= 0){
				Product product = lp.get(ls.indexOf(ltp.get(i).getProduct()));
				
				ProductType productType = new ProductType();
				ArrayList<TProductDetail> ltd = new ArrayList<TProductDetail>();
				productType.setBase(ltp.get(i).getBase());
				productType.setRemark(ltp.get(i).getRemark());
				productType.setType(ltp.get(i).getType());
				productType.setUnit(ltp.get(i).getUnit());
				
				ltd = (ArrayList<TProductDetail>) productDetailService.loadByProductId(ltp.get(i).getId());
				
				productType.setChildren(ltd);					
				product.getChildren().add(productType);
				
				
			}else {

				Product product = new Product();
				ProductType productType = new ProductType();
				ArrayList<TProductDetail> ltd = new ArrayList<TProductDetail>();
				
				product.setProduct(ltp.get(i).getProduct());
				
				productType.setBase(ltp.get(i).getBase());
				productType.setRemark(ltp.get(i).getRemark());
				productType.setType(ltp.get(i).getType());
				productType.setUnit(ltp.get(i).getUnit());
				
				ltd = (ArrayList<TProductDetail>) productDetailService.loadByProductId(ltp.get(i).getId());
				
				productType.setChildren(ltd);	
				
				ArrayList<ProductType> lpt = new ArrayList<ProductType>();
				lpt.add(productType);
				product.setChildren(lpt);
				lp.add(product);
				ls.add(product.getProduct());
				;
			}
		}
		return lp;
	}

	@Override
	public ArrayList<Product> listByCompany(int companyId) {
		
		String hql = "from TProduct t";
		List<TProduct> ltp = produceDao.find(hql);
		ArrayList<Product> lp  = new ArrayList<Product>();		
		ArrayList<String> ls = new ArrayList<String>();
		ArrayList<Integer> lup = userProductService.getIdByCompany(companyId);
		if(lup == null) {
			return listAll();
		}else{
			for(int i=0;i<ltp.size();i++){		
				if(i > 0 && ls.indexOf(ltp.get(i).getProduct()) >= 0){
					Product product = lp.get(ls.indexOf(ltp.get(i).getProduct()));
					
					ProductType productType = new ProductType();
					ArrayList<TProductDetail> ltd = new ArrayList<TProductDetail>();
					productType.setBase(ltp.get(i).getBase());
					productType.setRemark(ltp.get(i).getRemark());
					productType.setType(ltp.get(i).getType());
					productType.setUnit(ltp.get(i).getUnit());
					
					ltd = (ArrayList<TProductDetail>) productDetailService.loadByProductId(ltp.get(i).getId());
					for(TProductDetail t : ltd){
						if(lup.indexOf(t.getId()) >= 0){
							t.setSelected(1);
						}else{
							t.setSelected(0);
						}
					}
					productType.setChildren(ltd);					
					product.getChildren().add(productType);
					
					
				}else {

					Product product = new Product();
					ProductType productType = new ProductType();
					ArrayList<TProductDetail> ltd = new ArrayList<TProductDetail>();
					
					product.setProduct(ltp.get(i).getProduct());
					
					productType.setBase(ltp.get(i).getBase());
					productType.setRemark(ltp.get(i).getRemark());
					productType.setType(ltp.get(i).getType());
					productType.setUnit(ltp.get(i).getUnit());
					
					ltd = (ArrayList<TProductDetail>) productDetailService.loadByProductId(ltp.get(i).getId());
					for(TProductDetail t : ltd){
						if(lup.indexOf(t.getId()) >= 0){
							t.setSelected(1);
						}else{
							t.setSelected(0);
						}
					}
					productType.setChildren(ltd);	
					
					ArrayList<ProductType> lpt = new ArrayList<ProductType>();
					lpt.add(productType);
					product.setChildren(lpt);
					lp.add(product);
					ls.add(product.getProduct());
					;
				}
			}
			return lp;
		}
		
	}
	
	public ArrayList<Product> listAll1()
	{
		ArrayList<Product> productList = new ArrayList<Product>();
		String hql = "from   TProduct t  where  t.parentId is null ";
		String hql1 = " from  TProduct t  where t.parentId =:parentId";
		Map<String,Object> map = new HashMap<String,Object>();
		
		List<TProduct> products = produceDao.find(hql);
		logger.info(products.size()+"products ");
		for (TProduct tProduct : products) {
			//创建新的 product  
			Product product = new Product();
			product.setUnit(tProduct.getUnit());
			product.setProduct(tProduct.getProduct());	
			product.setId(tProduct.getId());
			//查询product 的 二级类型
			map.put("parentId", tProduct.getId()+"");
			List<TProduct> productType =null;
			try {
				productType = produceDao.find(hql1,map);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//封装成 productType 对象
			ArrayList<ProductType> typeList = new ArrayList<ProductType>();
			for (TProduct tProduct2 : productType) {
				ProductType type = new ProductType();
				type.setBase(tProduct2.getBase());
				type.setProduct(tProduct2.getProduct());
				//type.setType(tProduct2.getProduct());
				type.setParentId(tProduct.getParentId());
				ArrayList<TProductDetail> children = (ArrayList<TProductDetail>)productDetailService.loadByProductId(tProduct2.getId());		
				/*for (TProductDetail tProductDetail : children) {
					tProductDetail.setSelected(0);
				}*/
				type.setChildren(children);
				typeList.add(type);
			}		
			
			product.setChildren(typeList);
			productList.add(product);			
		}		
		return productList;
	}
	
	public ArrayList<Product> listByCompany1(int companyId) {
			
			//取出产品 （焊丝）
			String hql = "from   TProduct t  where  t.parentId is null ";
			String hql1 = " from  TProduct t  where t.parentId =:parentId";
			ArrayList<Product> productList = new ArrayList<Product>();
			/*//用户选择的detail id
			ArrayList<Integer> detailIds = userProductService.getIdByCompany(companyId);		
			if(detailIds == null||detailIds.size() ==0)
			return  listAll1();*/
			//循环 
			List<TProduct> products = produceDao.find(hql);
			Map<String,Object> map = new HashMap<String,Object>();
			logger.info("products Size = "+products.size());
	
			for (TProduct tProduct : products) {
				//创建新的 product  
				Product product = new Product();
				product.setUnit(tProduct.getUnit());
				product.setProduct(tProduct.getProduct());
				product.setId(tProduct.getId());			
				//查询product 的 二级类型
				map.put("parentId", tProduct.getId()+"");
				List<TProduct> productType = produceDao.find(hql1,map);
				//封装成 productType 对象
				ArrayList<ProductType> typeList = new ArrayList<ProductType>();
				for (TProduct tProduct2 : productType) {
					ProductType type = new ProductType();
					type.setBase(tProduct2.getBase());
					type.setProduct(tProduct2.getProduct());
					//type.setType(tProduct2.getProduct());
					type.setParentId(tProduct2.getParentId());
					ArrayList<TProductDetail> children = (ArrayList<TProductDetail>)productDetailService.loadByProductId(tProduct2.getId());							
					/*for (TProductDetail tProductDetail : children) {
						tProductDetail.setSelected(0);
						for (int i = 0; i < detailIds.size(); i++) {
							if(detailIds.get(i).equals(tProductDetail.getId()))
							{
								tProductDetail.setSelected(1);
							}								
						}
					}*/
					
					type.setChildren(children);
					typeList.add(type);
				}		
			
				product.setChildren(typeList);
				productList.add(product);			
			}
			return productList;
		}
	
	
	
	
	
	@Override
	/**
	 * zTree 
	 */
	public List<TreeModel> listTreeByCompanyId(Integer companyId) {
		// TODO Auto-generated method stub
		ArrayList<Integer> detailIds = userProductService.getIdByCompany(companyId);	
				
		String hql ="from  TProduct ";
		//取出所有product
		List<TProduct> productList = produceDao.find(hql);
		//取出所有productDetail
		
		List<TProductDetail> detailList = productDetailService.searchAllProductDetail();
		
		logger.info(" productList.size = "+productList.size() + "detailList.size = "+detailList.size() );
		TreeUntil tUntil = new TreeUntil();
		
		List<TreeModel> productModel = tUntil.convertProductToList(productList);
		
		List<TreeModel> detailModel = tUntil.convertProductDetailToList(detailList,detailIds);
		
		List<TreeModel> treeList = new ArrayList<TreeModel>();
		treeList.addAll(productModel);
		treeList.addAll(detailModel);
		logger.info("treeLis.size = "+treeList.size());		
		
		return treeList;
	}
	/**
	 * 查询 父级产品类型 （产品大类）
	 */
	@Override
	public TProduct searchParentProduct(Integer id) {
		// TODO Auto-generated method stub
		String hql = "from TProduct t  where t.id =:id";
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("id", id);		
		TProduct product =null;
		ArrayList list = (ArrayList)produceDao.find(hql, params);
		if(list!= null &&list.size()!= 0)
		{
			product = (TProduct) list.get(0);
		}
		return product;
	}
	
	@Override
	public ArrayList<Product> searchProductAndChileProduct() {
		// TODO Auto-generated method stub
		//取出产品 （焊丝）
		String hql = "from   TProduct t  where  t.parentId is null ";
		String hql1 = " from  TProduct t  where t.parentId =:parentId";
		ArrayList<Product> productList = new ArrayList<Product>();
		/*//用户选择的detail id
		ArrayList<Integer> detailIds = userProductService.getIdByCompany(companyId);		
		if(detailIds == null||detailIds.size() ==0)
		return  listAll1();*/
		//循环 
		List<TProduct> products = produceDao.find(hql);
		Map<String,Object> map = new HashMap<String,Object>();
		logger.info("products Size = "+products.size());
		//循环2层 
		for (TProduct tProduct : products) {
			//创建新的 product  
			Product product = new Product();
			product.setUnit(tProduct.getUnit());
			product.setProduct(tProduct.getProduct());
			product.setId(tProduct.getId());
			//查询product 的 二级类型
			map.put("parentId", tProduct.getId()+"");
			List<TProduct> productType = produceDao.find(hql1,map);
			//封装成 productType 对象
			ArrayList<ProductType> typeList = new ArrayList<ProductType>();
			for (TProduct tProduct2 : productType) {
				ProductType type = new ProductType();
				type.setBase(tProduct2.getBase());
				type.setProduct(tProduct2.getProduct());
				type.setId(tProduct2.getId());
				//type.setType(tProduct2.getProduct());
				type.setParentId(tProduct2.getParentId());			
				typeList.add(type);
			}
			product.setChildren(typeList);
			productList.add(product);
		}	
		return productList;
	}
	
	@Override
	public ArrayList<ProductType>  searchSecProductAndChild()
	{
		String hql = "from   TProduct t  where  t.parentId is not null ";
		String hql1 = "from  TProductDetail t where t.productId = :productId";
		List<TProduct> products = produceDao.find(hql);
		Map<String,Object> map = new HashMap<String,Object>();
		ArrayList<ProductType> types = new ArrayList<ProductType>();
		for (TProduct tProduct : products) {
			//创建新的 product  
			ProductType product = new ProductType();
			product.setUnit(tProduct.getUnit());
			product.setProduct(tProduct.getProduct());
			product.setId(tProduct.getId());
			//查询product 的 二级类型
			map.put("productId", tProduct.getId());
			ArrayList<TProductDetail> detailList = (ArrayList)produceDao.find(hql1,map);
			product.setChildren(detailList);
			types.add(product);
		}
		
		
		return types;
	}
}
