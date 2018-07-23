package com.saki.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Grid;
import com.saki.model.TCompany;
import com.saki.model.TOrder;
import com.saki.model.TOrderDetail;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.model.TUserProduct;
import com.saki.service.OrderServiceI;
import com.saki.service.ProductServiceI;
import com.saki.utils.SystemUtil;

@SuppressWarnings("unchecked" )
@Service("orderService")
public class OrderServiceImpl implements OrderServiceI{
	
	private SessionFactory sessionFactory;
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	private BaseDaoI confirmDao ;
	
	public BaseDaoI getConfirmDao() {
		return confirmDao;
	}
	@Autowired
	public void setConfirmDao(BaseDaoI confirmDao) {
		this.confirmDao = confirmDao;
	}
	

	private BaseDaoI orderDao;
	public BaseDaoI getOrderDao() {
		return orderDao;
	}
	@Autowired
	public void setOrderDao(BaseDaoI orderDao) {
		this.orderDao = orderDao;
	}
	
	@Override
	public void add(Object object) {
		orderDao.save(object);
	}

	@Override
	public void update(Object object) {
		orderDao.update(object);
	}

	@Override
	public void deleteByKey(String key) {
		orderDao.delete(getByKey(key));
	}
	
	public ProductServiceI getProductService() {
		return productService;
	}
	@Autowired
	public void setProductService(ProductServiceI productService) {
		this.productService = productService;
	}
	private ProductServiceI productService;

	@Override
	public Grid loadAll(String sort, String order, String page, String rows , String urgent) {
		Grid grid = new Grid();
		String hql = "from TOrder t  ";
		if(urgent != null){
			 hql += " where t.urgent = '1'" ; 
		}else{
			hql += " where t.urgent is null" ; 
		}
		if(sort!=null && order!=null){
			hql += "  order by " + sort + " " + order;
		}
		String companyHql = "from TCompany t" ;
		List<TCompany> companyList = orderDao.find(companyHql);
		List<TOrder> l = orderDao.find(hql);
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TOrder> lp = orderDao.find(hql, Integer.valueOf(page),  Integer.valueOf(rows));
			getCompanyName(companyList , lp);
			grid.setRows(lp);
		}else{
			getCompanyName(companyList , l);
			grid.setRows(l);
      }	
		return grid;
	}
	
	@Override
	public Grid search(Map params, String sort, String order, String page, String rows , String urgent) {
		Grid grid = new Grid();
		String hql = "from TOrder t where 1=1 ";
		if(urgent != null){
			hql += "  and  t.urgent = '1'" ; 
		}else{
			hql += " and t.urgent is null " ; 
		}
		Iterator<Map.Entry<String, Object>> it = params.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry<String, Object> entry = it.next() ;
				hql +=  " and " +  entry.getKey() + " like '" + entry.getValue()  +"'";
		}
		if(sort!=null && order!=null){
			hql = hql + " order by " + sort + " " + order;
		}
		String companyHql = "from TCompany t" ;
		List<TCompany> companyList = orderDao.find(companyHql);
		List<TOrder> l = orderDao.find(hql );
		grid.setTotal(l.size());
		if(page!=null && rows !=null){
			List<TOrder> lp = orderDao.find(hql, Integer.valueOf(page),  Integer.valueOf(rows));
			getCompanyName(companyList , lp);
			grid.setRows(lp);
		}else{
			getCompanyName(companyList , l);
			grid.setRows(l);
		}	
		return grid;
	}
	
	public void getCompanyName(List<TCompany> companyList , List<TOrder> orderList){
		   for(TOrder order : orderList) {
			      for(TCompany company : companyList) {
			    	        if(order.getCompanyId().equals(company.getId())) {
			    	        		  order.setCompanyName(company.getName());
			    	        		  continue;
			    	        }
			      }
		   }
	}

	@Override
	public Object getByKey(String key) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", Integer.valueOf(key));
		TOrder t = (TOrder) orderDao.get("from TOrder t where t.id = :id", params);
		return t;
	}

	
	@Override
	public List<Map<String, Object>> searchDetail(String id ) {
		/*int  num = orderDao.count("from  TOrder o , TOrderMapping m  where o.id = m.orderId and o.id= " + id );
		//如果生成了供应商订单 则关联供应商订单查询返回结果（有供应商报价就带出报价），如果没有只关联查询订单信息
		if(num <= 0 ){
			  return searchDetailNullPrice(id);
		}else{
			return searchDetailPrice(id);
		}*/
		 return searchDetailNullPrice(id);
	}
	
	private List<Map<String, Object>> searchDetailNullPrice(String id) {
		List<Map<String , Object>>  mapList = new ArrayList<Map<String , Object>>();
		String hql = "from TProduct t , TProductDetail d, TOrder o , TOrderDetail od"
				+ " ,TProduct product , TCompany c "
				+ " where t.id = d.productId  and o.id = od.orderId"
				+ " and od.productDetailId = d.id  and od.brand = c.id"
				+ " and  o.id = " + id +"and t.parentId = product.id " ;
		
		
		List<Object[]> list = orderDao.find(hql);
		//Map<Integer , Map<String,Object>> detailMap = new HashMap<Integer , Map<String,Object>>();
		for (int i = 0; i < list.size(); i++) {
			Object[] objs = list.get(i);
			//主表数据
			TProduct product = (TProduct) objs[0];
			TProductDetail detail = (TProductDetail) objs[1];
			TOrderDetail orderDetail = (TOrderDetail) objs[3];
			TProduct parentProduct = (TProduct)objs[4];
			TCompany company = (TCompany)objs[5];
			Map<String , Object >  map = new HashMap<String,Object>();
			map.put("id", orderDetail.getId());
			map.put("product",parentProduct.getProduct() );
			//前台没改  所以 这个地方 对应的是type
			map.put("type",  product.getProduct());
			map.put("sub_product", detail.getSubProduct());
			map.put("materail", detail.getMaterial());
			map.put("acount",  orderDetail.getNum());
			map.put("unit", parentProduct.getUnit());
			if(orderDetail.getPrice() != null && orderDetail.getPrice() > 0 ) {
				map.put("price", orderDetail.getPrice());
			}
			map.put("base", product.getBase());
			map.put("detailId", detail.getId());
			map.put("productId", product.getId());
			map.put("brand", company.getBrand());
			map.put("remark", orderDetail.getRemark());
			//detailMap.put(orderDetail.getId(), map);
			mapList.add(map);
		}
		
		return mapList ;
	}
	
	
	@Override
	public List<TProduct> searchProduct() {
		  String hql = "select distinct  new TProduct(product , unit) from TProduct  " ;
		  List<TProduct> list = orderDao.find(hql);
		  return list;
		
	}
	@Override
	public List<TProduct> searchProductType(String product) {
		String  hql = "from TProduct t where t.product = '" + product + "'";
		List<TProduct> list = orderDao.find(hql);
		return list;
	}
	public List<TProductDetail> searchDetailByProductId(String productId , String companyId) {
		String  hql = "from TProductDetail t where t.productId = '" + productId + "' and t.id in ("
				+  " select m.productDetailId from TUserProduct m where m.companyId = '" + companyId +"' ) ";
		List<TProductDetail> list = orderDao.find(hql);
		return list;
	}
	@Override
	public TOrderDetail getByDetailId(String detailId) {
		String  hql = "from TOrderDetail t where t.id = '" + detailId + "'";
		List<TOrderDetail> list = orderDao.find(hql);
		if(list!= null  && list.size()>0) {
			  
			return list.get(0);
		}
		return null ;
	}
	@Override
	public void delete(TOrderDetail detail) {
		orderDao.delete(detail);
	}
	@Override
	public List<TOrderDetail> getOrderDetailsForSupplierOrder() {
		String  hql = "from TOrderDetail t ";
		List<TOrderDetail> list = orderDao.find(hql);
		return list;
	}
//	@Override
//	public void updateOrderLocked(String locked , String id ) {
//		orderDao.updateHql("update TOrder t set t.locked = " + locked 
//				+ "where t.id = " + id);
//	}
//	@Override
//	public void updateOrderLockedTask() {
//		Calendar day =Calendar.getInstance();
//		int s = day.get(Calendar.DAY_OF_MONTH);
//		List<TConfirm> confirm =confirmDao.find("from TConfirm t where t.confirmDate = " + s);
//		if(confirm.size() > 0) {
//			orderDao.updateHql("update TOrder t set t.locked = 1 where t.status = '3'");
//			orderDao.updateHql("update TOrder t set t.remark='未付款，不予采购' where t.status < 3");
//		}
//	}
	@Override
	public String getOrderCode(String dayOfOrderNo) {
		String hql = "select  SUBSTR(max(t.orderNo) ,LENGTH(max(t.orderNo))-2 ,3) + 1  "
				+ " from TOrder  t  where t.orderNo like '%" + dayOfOrderNo +  "%'";
		List<Integer> list =orderDao.find(hql);
		return SystemUtil.getOrderResult(list);
	}
	
	@Override
	public List<TProduct> searchProductByCompanyId(String companyId) {
		StringBuffer sb  = new StringBuffer();
		sb.append(" select  t.id,t.product,t.unit  from  TProduct  t ,TProduct t1 ");	
		sb.append("  where t.id  in  (  ");
		sb.append(" select detail.productId from  TProductDetail  detail ,TUserProduct user   ");
		sb.append(" where user.companyId = :companyId    ");
		sb.append("  and     user.productDetailId = detail.productId        )   ");
		sb.append(" and  t1.id =  t.parentId    ");
		Map<String , Object >  map = new HashMap<String,Object>();
		map.put("companyId", Integer.parseInt(companyId));
		List<TProduct> list = null;
		try {
			list = orderDao.find(sb.toString(), map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
//	@Override
//	public List<TProductDetail> searchDetailByCompanyId(String companyId) {
//		String hql = "from  TUserProduct user  where user.companyId = "+companyId;
//		List<TUserProduct> userList = orderDao.find(hql);
//		String detailIds = "";
//		for (TUserProduct tUserProduct : userList) {
//			detailIds += tUserProduct.getProductDetailId()+",";
//		}
//		detailIds = detailIds.substring(0, detailIds.length()-1);
//		String hql1 = " from  TProductDetail detail where  detail.id in  ("+detailIds+")  ";
//		
//		
//		List<TProductDetail> list = orderDao.find(hql1);
//		String parentId ="";
//		/*for (TProductDetail tProductDetail : list) {
//			parentId += tProductDetail.getProduct().getParentProduct().getId()+"";
//		}	*/
//		return list;
//	}
//	
	
	
	@Override
	public List<TProduct> searchProductByProductIds(String productIds) {
		StringBuffer sb  = new StringBuffer();
		sb.append("  from  TProduct  product where  product.id in  ( "+ productIds+")");
		List<TProduct> list = orderDao.find(sb.toString());
		
		return list;
	}
	
	@Override
	public List<TProduct> searchProductTypeByParentId(String parentId) {
		String hql = " from TProduct t where  t.parentId = "+parentId;
		List<TProduct> list= orderDao.find(hql);		
		return list;
	}
	//查询所有已选产品
	/**
	 * 查询企业关联的全部产品类型
	 */
	@Override
	public List<TUserProduct> searchUserProductByCompanyId(String companyId) {
		String hql = "from  TUserProduct  t  where t.companyId = :companyId";
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("companyId", Integer.parseInt(companyId));
		List<TUserProduct> userProduct = orderDao.find(hql,map);		
		return userProduct;
	}
	@Override
	public List<TProductDetail> searchDetailByIds(String ids) {
		String hql = "from  TProductDetail  detail  where  detail.id in ("+ids+") ";
		return orderDao.find(hql);
	}
	@Override
	public TProduct searchProductByProductId(Integer productId) {
		String hql = "from TProduct  product  where  product.id =:id ";
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("id", productId);
		TProduct product = (TProduct)orderDao.get(hql, params);
		return product;
	}
	@Override
	public List<TProduct> searchProductByproductIds(String productIds) {
		String hql ="from  TProduct product where product.id  in ("+productIds+")";
		return orderDao.find(hql);
	}
	@Override
	public List<TProduct> searchProductByProductIdsAndParentId(String productIds, String parentId) {
		StringBuffer sb  = new StringBuffer();
		sb.append("  from  TProduct  product where  product.id in  ( "+ productIds+")  and parent_id =:parentId");
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("parentId", parentId);
		List<TProduct> list = orderDao.find(sb.toString(),params);	
		return list;
	}
	
	
	@Override
	public List<TProduct> searchFirstProduct() {
		String hql ="from  TProduct product where parent_id is null ";
		return orderDao.find(hql);
	}
	@Override
	public List<Map<String, Object>> searchBrandByProductDetailId(
			String detailId) {
		List<Map<String , Object>>  mapListTemp = new ArrayList<Map<String , Object>>();
		List<Map<String , Object>>  mapList = new ArrayList<Map<String , Object>>();
		String hql = "from  TUserProduct  m  , TCompany c  where m.companyId = c.id "
				+ " and m.roleId = 2  and m.productDetailId = " +  detailId  ;
		List<Object[]> list = orderDao.find(hql);
		for (int i = 0; i < list.size(); i++) {
			Object[] objs = list.get(i);
			TUserProduct mapper = (TUserProduct)objs[0];
			TCompany company = (TCompany)objs[1];
			Map<String , Object >  map = new HashMap<String,Object>();
			map.put("mapid", mapper.getId());
			map.put("price", isNull(mapper.getPrice()) + isNull(mapper.getMarkup()));
			map.put("brand", company.getBrand());
			map.put("status", mapper.getStatus());
			map.put("supplierCompanyId", company.getId());
			mapListTemp.add(map);
		}
		for(Map<String , Object> map : mapListTemp){
			  if("1".equals(map.get("status"))){
				  mapList.add(map);
				  mapListTemp.remove(map);
					  break;
			  }
		}
		mapList.addAll(mapListTemp);
		return mapList;
	}
	
	public Double isNull(Double val){
		 if(val == null){
			  return 0.0;
		 }else{
			 return val;
		 }
	}
	
	
	
	/**
	 * 因设计原因修改了原有的接口
	 */
	@Override
	public Grid loadAll(String sort, String order, String page, String rows) {
		
		return null;
	}
	/**
	 * 因设计原因修改了原有的接口
	 */
	@Override
	public Grid search(String row, String text, String sort, String order,
			String page, String rows) {
		
		return null;
	}
}
