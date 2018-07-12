package com.saki.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Notice;
import com.saki.model.TUserProduct;
import com.saki.service.UserProductServiceI;
@Service("userProductService")
public class UserProductServiceImpl implements UserProductServiceI{

	private BaseDaoI userProductDao;
	
	public BaseDaoI getUserProductDao() {
		return userProductDao;
	}

	@Autowired
	public void setUserProductDao(BaseDaoI userProductDao) {
		this.userProductDao = userProductDao;
	}


	@Override
	public ArrayList<Integer> getIdByCompany(int companyId) {
		ArrayList<Integer> lp = new ArrayList<Integer>();
		List<TUserProduct> l = listByCompanyId(companyId);
		if(l.size() > 0){
			for(TUserProduct t : l){
				lp.add(t.getProductDetailId());
			}
			return lp;
		}else{
			return null;
		}		
		
	}


	@Override
	public void save(int companyId, String productlist , int roleId) {
		//delete(companyId);
		String[] ap = productlist.split(",");
		for(int i=0;i<ap.length;i++){
			updatePrice(companyId , Integer.valueOf(ap[i]) , 0  , roleId);
		}
	}

	@Override
	public void delete(int companyId) {
		List<TUserProduct> l = listByCompanyId(companyId);
		for(TUserProduct t : l){
			userProductDao.delete(t);
		}
	}

	@Override
	public List<TUserProduct> listByCompanyId(int companyId) {
		Map<String, Object> params = new HashMap<String, Object>();	
		System.out.println("------------------- " + companyId);
		params.put("companyId", companyId);
		List<TUserProduct> l = userProductDao.find("from TUserProduct t where t.companyId = :companyId", params);
		return l;
	}

	/**
	 *  updatePrice方法被两处两用
	 *   一处为更新企业产品类型（price=0，sql中每次更新是保留原有的price  即为：‘price=price’）
	 *   一处为企业更新产品报价（price》0）sql中更新新的price，即为price=传入的double值
	 */
	@Override
	public void updatePrice(int companyId, int detailId , double price, int roleId) {
		String tempPrice = price + "";
		if(price == 0.0){
			tempPrice = "price";
		}
		String sql = " INSERT INTO t_user_product  (company_id , product_detail_id ,  price  , role_id ) "
				+ " VALUES (" + companyId + " , " + detailId + " , " + price + " , " + roleId + " )"
				+ " ON DUPLICATE KEY UPDATE price = " + tempPrice + " ";
		userProductDao.executeUpdate(sql);
	}
	
	@Override
	public void deleteByList(Integer companyId, String productDetailIds) {
		 String sql = "delete from TUserProduct  t where  t.companyId = " + companyId
				 	+ " and t.productDetailId not in (" + productDetailIds + ")";
		 userProductDao.updateHql(sql);
		
	}
	
	@Override
	public void updateStatus(int id ) {
		String sql = " update t_user_product  set status = 1  where id =" + id ;
		userProductDao.executeUpdate(sql);
	}
	
	@Override
	public void updateStatusReset(int detailId ,String companyId ) {
		String sql = " update t_user_product  set status = 0  where product_detail_id =" + detailId ;
		userProductDao.executeUpdate(sql);
	}

	@Override
	public void updateMarkupPrice(Integer mapid, Double markup) {
		String sql = " update t_user_product  set markup = " + markup + "  where id =" + mapid ;
		userProductDao.executeUpdate(sql);
	}

	public int countNoMarkupCount() {
		String sql = "select 1 from t_user_product where price > 0 and (  markup = 0  or markup is  null ) ";
		return userProductDao.executeSQLquery(sql).size();
	}

	public int countNoDefaultPrice() {
		String sql = "select 1 from t_product_detail where id not in ( "
				+ "			select DISTINCT(product_detail_id) from t_user_product m , t_product_detail d"
				+ "			 where m.product_detail_id = d.id   )  ";
		return userProductDao.executeSQLquery(sql).size();
	}
	
	public  int countInvoiceSet() {
		String sql = "select 1 from t_order where status = 3  and invoice  is null ";
		return userProductDao.executeSQLquery(sql).size();
	}
	

	private int countInvoiceGet() {
		String sql = "select 1 from t_supllier_order where invoice = 1";
		return userProductDao.executeSQLquery(sql).size();
	}

	@Override
	public List<Notice> initAdminData() {
		Notice notice = new Notice();
		Map<String , Object> map = new HashMap<>();
		int noMarkupCount = countNoMarkupCount();
		int noDefaultPrice = countNoDefaultPrice();
		notice.setKey("first");
		notice.setMsg(noMarkupCount+noDefaultPrice+"");
		map.put("markupMsg", noMarkupCount + "种产品需要加价处理");
		map.put("priceMsg", noDefaultPrice + "种产品未选择默认报价");
		notice.setObj(map);
		
		Map<String , Object> map2 = new HashMap<>();
		Notice notice2 = new Notice();
		int invoice = countInvoiceSet();
		int invoiceGet = countInvoiceGet();
		notice2.setKey("second");
		notice2.setMsg(invoice + invoiceGet+"");
		map2.put("invoiceMsg", invoice + "客户订单可以开发票");
		map2.put("invoiceGetMsg",  invoiceGet + "供应商订单已开发票");
		notice2.setObj(map2);
		
		Map<String , Object> map3 = new HashMap<>();
		Notice notice3 = new Notice();
		int supplierInit = countInitSupplier();
		int supplierCheck = countCheckSupplier();
		notice3.setKey("third");
		notice3.setMsg(supplierInit + supplierCheck + "");
		map3.put("supplierInit", supplierInit + "订单尚未分配采购");
		map3.put("supplierCheck",  supplierCheck + "订单尚未审核");
		notice3.setObj(map3);
		
		List<Notice> list= new ArrayList<>();
		list.add(notice);
		list.add(notice2);
		list.add(notice3);
		return list;
	}



	private int countCheckSupplier() {
		String sql = "select 1 from t_supllier_order where status = 1";
		return userProductDao.executeSQLquery(sql).size();
	}

	private int countInitSupplier() {
		String sql = "select 1 from  t_order where status = 5   and id not in ( "
						+ "	 select distinct(order_id) from t_order_mapping m , t_order  o where"
						+ "  m.order_id = o.id  and o.status = 5  ) ";
		return userProductDao.executeSQLquery(sql).size();
	}

	@Override
	public List<Notice> initCustomerData() {
		Notice notice = new Notice();
		Map<String , Object> map = new HashMap<>();
		int noMarkupCount = countNoMarkupCount();
		int noDefaultPrice = countNoDefaultPrice();
		map.put("first", noMarkupCount+noDefaultPrice );
		notice.setKey("first");
		notice.setMsg(noMarkupCount+noDefaultPrice + "");
		map.put("markupMsg", noMarkupCount + "种产品需要加价处理");
		map.put("priceMsg", noDefaultPrice + "种产品未选择默认报价");
		notice.setObj(map);
		
		Notice notice2 = new Notice();
		Map<String , Object> map2 = new HashMap<>();
		int invoice = countInvoiceSet();
		int invoiceGet = countInvoiceGet();
		map.put("second", invoice + invoiceGet );
		notice2.setKey("second");
		notice2.setMsg(invoice + invoiceGet +"");
		map2.put("invoiceMsg", invoice + "客户订单可以开发票");
		map2.put("invoiceGetMsg",  invoiceGet + "供应商订单已开发票");
		notice2.setObj(map2);
		
		Notice notice3 = new Notice();
		Map<String , Object> map3 = new HashMap<>();
		int supplierInit = countInitSupplier();
		int supplierCheck = countCheckSupplier();
		notice3.setKey("third");
		notice3.setMsg(supplierInit + supplierCheck  + "");
		map3.put("supplierInit", supplierInit + "订单尚未分配采购");
		map3.put("supplierCheck",  supplierCheck + "订单尚未审核");
		notice3.setObj(map3);
		List<Notice> list= new ArrayList<>();
		list.add(notice);
		list.add(notice2);
		list.add(notice3);
		return list;
	}

	@Override
	public List<Notice> initSupplierData() {
		
		return null;
	}


}
