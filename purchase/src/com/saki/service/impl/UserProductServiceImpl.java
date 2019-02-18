package com.saki.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.entity.Notice;
import com.saki.model.TColor;
import com.saki.model.TProductDetail;
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
	public List<TUserProduct> getIdByCompany(int companyId) {
		ArrayList<Integer> lp = new ArrayList<Integer>();
		List<TUserProduct> l = listByCompanyId(companyId);
		if(l.size() > 0){
			return l;
		}else{
			return null; 
		}		
		
	}

	/*public TUserProduct getById(int ){
		
	}*/
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
	public TColor getByKey(String id) {
		
		return (TColor)userProductDao.get("from TColor t where t.id = " + id);
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
		String hql = "from TProductDetail where id = " + detailId ;
		List<TProductDetail> list  = userProductDao.find(hql);
		int productId = 0 ;
		if(list != null && list.size() > 0) {
			productId = list.get(0).getProductId();
		}
		String sql = " INSERT INTO t_user_product  (company_id , product_detail_id ,  price   , role_id  ,product_id) "
				+ " VALUES (" + companyId + " , " + detailId + " , " + price + " , " + roleId + " , " + productId +" )"
				+ " ON DUPLICATE KEY UPDATE price = " + tempPrice + " , product_id = " + productId ;
		userProductDao.executeUpdate(sql);
	}
	
	@Override
	public void updateImg(int productId, String companyId, String img) {
		String sql = " update t_user_product set imgUrl =  '" + img + "' where product_id=" + productId + " and  company_id =" + companyId ;
		userProductDao.executeUpdate(sql);
	}
	
	@Override
	public void updateColorImg(TColor color) {
		userProductDao.saveOrUpdate(color);
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
	public void updateMarkupPrice(Integer mapid, String column,Double markup) {
		String sql = " update t_user_product  set "+ column+" = " + markup + "  where id =" + mapid ;
		userProductDao.executeUpdate(sql);
	}
	
	@Override
	public void updateMarkupPriceByPercent(Integer mapid, Double markup) {
		String sql = " update t_user_product  set  percent = " + markup + "  where price > 0 and  id =  " + mapid ;
		userProductDao.executeUpdate(sql);
	}
	
	@Override
	public void updateMarkupPriceWhenPriceUpdate(Integer mapid, Double price) {
		String sql = " update t_user_product  set markup =  " + price+ " * (percent/100)   where percent > 0 and  id =  " + mapid ;
		userProductDao.executeUpdate(sql);
	}

	@Override
	public List<Notice> initAdminData() {
		Notice notice = new Notice();
		Map<String , Object> map = new HashMap<>();
		String noMarkupCountsql = "select 1 from t_user_product where price > 0 and (  markup = 0  or markup is  null ) ";
		int noMarkupCount = countNum(noMarkupCountsql);
		String noDefaultPricesql = "select 1 from t_product_detail where id not in ( "
				+ "			select DISTINCT(product_detail_id) from t_user_product m , t_product_detail d"
				+ "			 where m.product_detail_id = d.id   )  ";
		int noDefaultPrice = countNum(noDefaultPricesql);
		notice.setKey("first");
		notice.setMsg(noMarkupCount+noDefaultPrice+"");
		if(noMarkupCount > 0) {
			map.put("markupMsg", noMarkupCount + "种产品需要加价处理");
		}
		if(noDefaultPrice > 0) {
			map.put("priceMsg", noDefaultPrice + "种产品未选择默认报价");
		}
		notice.setObj(map);
		
		Map<String , Object> map2 = new HashMap<>();
		Notice notice2 = new Notice();
		String invoicesql = "select 1 from t_order where status = 3  and invoice  is null ";
		int invoice = countNum(invoicesql);
		String invoiceGetsql = "select 1 from t_supllier_order where invoice = 1";
		int invoiceGet = countNum(invoiceGetsql);
		notice2.setKey("second");
		notice2.setMsg(invoice + invoiceGet+"");
		if(invoice > 0) {
			map2.put("invoiceMsg", invoice + "客户订单可以开发票");
		}
		if(invoiceGet > 0) {
			map2.put("invoiceGetMsg",  invoiceGet + "供应商订单已开发票");
		}
		notice2.setObj(map2);
		
		Map<String , Object> map3 = new HashMap<>();
		Notice notice3 = new Notice();
		String urgentPurchasesql = "select 1 from  t_order where urgent = '1' and status = '3'  and percent = '100'";
		int urgentPurchase = countNum(urgentPurchasesql);
		String urgentPaysql = "select 1 from  t_order where urgent = '1' and status = '1'";
		int urgentPay = countNum(urgentPaysql);
		notice3.setKey("third");
		notice3.setMsg(urgentPurchase + urgentPay + "");
		if(urgentPurchase > 0) {
			map3.put("supplierInit", urgentPurchase + "加急订单尚未采购");
		}
		if(urgentPay > 0) {
			map3.put("supplierCheck",  urgentPay + "加急订单尚未付款");
		}
		notice3.setObj(map3);
		
		List<Notice> list= new ArrayList<>();
		list.add(notice);
		list.add(notice2);
		list.add(notice3);
		return list;
	}

	private int countNum(String sql) {
		return userProductDao.executeSQLquery(sql).size();
	}

	@Override
	public List<Notice> initCustomerData(Integer companyId) {
		Notice notice = new Notice();
		Map<String , Object> map = new HashMap<>();
		String noProductCountsql = "select 1 from  t_user_product where company_id =   " + companyId;
		int noProductCount = countNum(noProductCountsql);
		notice.setKey("first");
		notice.setMsg(noProductCount + "");
		if(noProductCount == 0 ) {
			map.put("priceMsg", "未选择公司需要采购的产品类型");
			notice.setObj(map);
		}else {
			notice.setMsg(0 + "");
		}
		
		Map<String , Object> map2 = new HashMap<>();
		Notice notice2 = new Notice();
		String invoicesql = "select 1 from t_order where status = 1  and urgent  is null"
				+ " and company_id =  " + companyId;
		int invoice = countNum(invoicesql);
		String invoiceGetsql = "select 1 from t_order where status = 1  and urgent  = '1'"
				+ "  and company_id =  " + companyId;
		int invoiceGet = countNum(invoiceGetsql);
		notice2.setKey("second");
		notice2.setMsg(invoice + invoiceGet+"");
		if(invoice>0) {
			map2.put("invoiceMsg", invoice + "订单未付款或未全部付款");
		}
		if(invoiceGet > 0) {
			map2.put("invoiceGetMsg",  invoiceGet + "加急订单未付款或未全部付款");
		}
		notice2.setObj(map2);
		
		Map<String , Object> map3 = new HashMap<>();
		Notice notice3 = new Notice();
		String urgentPurchasesql = "select 1 from t_order where status != '1'  and invoice  is null"
				+ " and company_id =  " + companyId;
		int urgentPurchase = countNum(urgentPurchasesql);
		String urgentPaysql = "select 1 from  t_order where status != '1' and invoice = '1'"
				+ " and company_id =  " + companyId;
		int urgentPay = countNum(urgentPaysql);
		notice3.setKey("third");
		notice3.setMsg(urgentPurchase + urgentPay + "");
		if(urgentPurchase > 0) {
			map3.put("supplierInit", urgentPurchase + "订单发票未开");
		}
		if(urgentPay > 0) {
			map3.put("supplierCheck",  urgentPay + "订单发票待收");
		}
		notice3.setObj(map3);
		
		List<Notice> list= new ArrayList<>();
		list.add(notice);
		list.add(notice2);
		list.add(notice3);
		return list;
	}

	
	
	
	
	
	@Override
	public List<Notice> initSupplierData(Integer companyId) {
		Notice notice = new Notice();
		Map<String , Object> map = new HashMap<>();
		String noProductCountsql = "select 1 from  t_user_product where company_id =   " + companyId;
		int noProductCount = countNum(noProductCountsql);
		String noMarkupCountsql = "select 1 from t_user_product where ( price = 0 or price is null)"
				+ " and company_id = " + companyId;
		int noMarkupCount = countNum(noMarkupCountsql);
		notice.setMsg(  noMarkupCount + "");
		notice.setKey("first");
		if(noProductCount == 0 ) {
			notice.setMsg( "1");
			map.put("priceMsg", "未选择公司需要采购的产品类型");
		}else {
			if(noMarkupCount > 0 ) {
				map.put("markupMsg", noMarkupCount + "种产品未报价");
			}
		}
		notice.setObj(map);
		
		Map<String , Object> map2 = new HashMap<>();
		Notice notice2 = new Notice();
		String invoicesql = "select  1 from  t_supllier_order where status = 1"
				+ "  and t_supllier_order.id in "
				+ " (select supllier_order_id from  t_supllier_order_detail  "
				+ " where conpany_id =  " + companyId  + ")";
		int invoice = countNum(invoicesql);
		notice2.setKey("second");
		notice2.setMsg(invoice +"");
		if(invoice>0) {
			map2.put("invoiceMsg", invoice + "条新订单信息");
		}
		notice2.setObj(map2);
		
		Map<String , Object> map3 = new HashMap<>();
		Notice notice3 = new Notice();
		String urgentPurchasesql = "select 1 from t_supllier_order where status != '1'  and invoice  is null "
				+ "  and t_supllier_order.id in "
				+ " (select supllier_order_id from  t_supllier_order_detail  "
				+ " where conpany_id =  " + companyId  + ")";
		int urgentPurchase = countNum(urgentPurchasesql);
		String urgentPaysql = "select 1 from  t_supllier_order where status != '1' and invoice = '1'"
				+ "  and t_supllier_order.id in "
				+ " (select supllier_order_id from  t_supllier_order_detail  "
				+ " where conpany_id =  " + companyId  + ")";
		int urgentPay = countNum(urgentPaysql);
		notice3.setKey("third");
		notice3.setMsg(urgentPurchase + urgentPay + "");
		if(urgentPurchase > 0) {
			map3.put("supplierInit", urgentPurchase + "订单发票未开");
		}
		if(urgentPay > 0) {
			map3.put("supplierCheck",  urgentPay + "订单发票待收");
		}
		notice3.setObj(map3);
		
		List<Notice> list= new ArrayList<>();
		list.add(notice);
		list.add(notice2);
		list.add(notice3);
		return list;
	}

	


}
