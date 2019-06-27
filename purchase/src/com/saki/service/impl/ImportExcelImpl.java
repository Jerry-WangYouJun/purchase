package com.saki.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saki.dao.BaseDaoI;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.service.CompanyServiceI;
import com.saki.service.ImportExcelI;
import com.saki.service.ProductDetailServiceI;
import com.saki.service.ProductServiceI;
import com.saki.utils.SystemUtil;

@Service("importExcelImpl")
public class ImportExcelImpl  implements ImportExcelI{
	
	private final static String excel2003L =".xls";    //2003- �汾��excel
	private final static String excel2007U =".xlsx";   //2007+ �汾��excel
	
	/**
	 *  "old"代表最早的导入文件类型， 表中的每一行是一种产品大类
	 */
	private final static String ROW_PRODUCT_OLD = "old" ;
	
	/**
	 *  "new"代表新的导入文件类型， 每一行是一种产品小类（大类中的属性会出现重复的情况）
	 */
	private final static String ROW_PRODUCT_NEW = "new" ;
	
	/**
	 * @param in,fileName , fileType(一种代表每行一个大类“new”， 一种代表每行一个小类“old”)
	 * @return
	 * @throws IOException 
	 */
	@Override
	public  void getListByExcel(InputStream in,String fileName , String fileType) throws Exception{
		Workbook work = this.getWorkbook(in,fileName);
		if(null == work){
			throw new Exception("Excel文件中内容为空");
		}
		Sheet sheet = null;
		Row row = null;
		Cell cell = null;
		
		List<List<Object>> list = new ArrayList<List<Object>>();
		//遍历excel中的内容，存放在objectlist中 等待后续解析 
		for (int i = 0; i < work.getNumberOfSheets(); i++) {
			sheet = work.getSheetAt(i);
			if(sheet==null){
				continue;
			}
			//从第一行开始处理数据， 防止出现空行
			for (int j = sheet.getFirstRowNum(); j <= sheet.getLastRowNum(); j++) {
				row = sheet.getRow(j);
				//空行或者 行数为第一行时该行为表头，不取数据
				if(row==null||sheet.getFirstRowNum()==j){
					continue;
				}
				
				List<Object> li = new ArrayList<Object>();
				for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
					cell = row.getCell(y);
					li.add(this.getCellValue(cell));
				}
				list.add(li);
			}
		}
		work.close();
		if(ROW_PRODUCT_OLD.equals(fileType)){
			saveProducts( list);
		}else{
			saveProductsNew(list);
		}
	}
	
	@SuppressWarnings("unchecked")
	public void saveProductsNew(List<List<Object>> list ) throws Exception{
		Map<String , Map<String , List<TProductDetail>>> resultMap = new HashMap<>();
		resultMap = getProductByListNew(list);
		
		
		Map<String , TProduct >  productChildMap = new HashMap<>();
		Map<String , TProduct >  productMap = new HashMap<>();
		List<TProduct> productParentList = productService.searchFirstProductType();
		for(TProduct parent : productParentList ){
			List<TProduct> productChildList = productService.searchChildProductType(parent.getId());
			for(TProduct child : productChildList){
				child.setDetailList(detailService.loadByProductId(child.getId()));
				productChildMap.put(child.getProduct(), child);
			}
			productMap.put(parent.getProduct(), parent);
		}
		Iterator<String> it = resultMap.keySet().iterator();
		while(it.hasNext()) {
			String parent = it.next(); 
			TProduct parentProductForSave = new TProduct();
			if(productMap.containsKey(parent)) {
				parentProductForSave  = productMap.get(parent);
			}
			parentProductForSave.setProduct(parent);
			productDao.saveOrUpdate(parentProductForSave);
			Iterator<String> child = resultMap.get(parent).keySet().iterator();
			while(child.hasNext()) {
				TProduct childProductForSave = new TProduct();
				String  childPro = child.next();
				if(productChildMap.containsKey(childPro)) {
					childProductForSave = productChildMap.get(childPro);
				}
				childProductForSave.setProduct(childPro);
				childProductForSave.setParentId(parentProductForSave.getId());
				TProduct product =  resultMap.get(parent).get(childPro);
				childProductForSave.setBase(product.getBase());
				productDao.saveOrUpdate(childProductForSave);
				continueOut:
				for(TProductDetail detail : product.getDetailList()) {
					if(productChildMap.containsKey(childPro)){
						for(TProductDetail detailOld :childProductForSave.getDetailList() ) {
							if(detailOld.equals(detail)) {
								 continue continueOut;
							}
						}
					}
					detail.setProductId(childProductForSave.getId());
					productDao.saveOrUpdate(detail);
					companyService.addMapDataByProDetail(detail.getId(), detail.getProductId());
				}
				productDao.update(parentProductForSave);
			}
		}
	}

	@SuppressWarnings("unchecked")
	public void saveProducts(List<List<Object>> list ) throws Exception{
		Map<String , Map<String , TProduct>> resultMap = new HashMap<>();
		/**此处遍历excel中的行数据转换为map数据 便于以下作对比**/
		for (int i= 0 ; i < list.size() ; i ++) {
			 List<Object> list2 = list.get(i);
				TProduct product;
				try {
					// 把每一行数据放到一个product对象中
					product = getProductByList(list2);
				} catch (Exception e) {
					throw new Exception("第"+ (i +2) + "行出错:" + e.getMessage());
				}
				//二级产品   key:产品名  value:对应产品实体对象     
				Map<String , TProduct> tempMap = new HashMap<>();
				tempMap.put( product.getChildProName(), product);
				if(resultMap.containsKey(product.getProduct())) {
					resultMap.get(product.getProduct()).put(product.getChildProName(), product);
				}else {
					resultMap.put(product.getProduct(), tempMap);
				}
		}
		
		/**
		 * 此处代码是从数据库中取出已存在的代码，便于与excel中数据进行对比
		 */
		//key:二级产品名 value:二级产品对象 
		Map<String , TProduct >  productChildMap = new HashMap<>();
		//key:一级产品名 value：一级产品对象
		Map<String , TProduct >  productMap = new HashMap<>();
		//查询一级产品大类
		List<TProduct> productParentList = productService.searchFirstProductType();
		for(TProduct parent : productParentList ){
			List<TProduct> productChildList = productService.searchChildProductType(parent.getId());
			for(TProduct child : productChildList){
				child.setDetailList(detailService.loadByProductId(child.getId()));
				productChildMap.put(child.getProduct(), child);
			}
			productMap.put(parent.getProduct(), parent);
		}
		
		
		//遍历excel中的数据，取出
		Iterator<String> it = resultMap.keySet().iterator();
		while(it.hasNext()) {
			String parent = it.next(); 
			//最终存入数据库的一级产品
			TProduct parentProductForSave = new TProduct();
			if(productMap.containsKey(parent)) {
				parentProductForSave  = productMap.get(parent);
			}
			parentProductForSave.setProduct(parent);
			//一级产品存在则更新 不存在则新增
			productDao.saveOrUpdate(parentProductForSave);
			//根据一级产品名取出 所有对应的二级产品名
			Iterator<String> child = resultMap.get(parent).keySet().iterator();
			while(child.hasNext()) {
				TProduct childProductForSave = new TProduct();
				String  childPro = child.next();
				if(productChildMap.containsKey(childPro)) {
					childProductForSave = productChildMap.get(childPro);
				}
				childProductForSave.setProduct(childPro);
				childProductForSave.setParentId(parentProductForSave.getId());
				TProduct product =  resultMap.get(parent).get(childPro);
				childProductForSave.setBase(product.getBase());
				//更新或保存二级产品
				productDao.saveOrUpdate(childProductForSave);
				continueOut:
				for(TProductDetail detail : product.getDetailList()) {//遍历二级产品对应的产品详情
					if(productChildMap.containsKey(childPro)){
						for(TProductDetail detailOld :childProductForSave.getDetailList() ) {
							if(detailOld.equals(detail)) {//重新产品详情equals方法，已存在产品不做保存更新
								 continue continueOut;
							}
						}
					}
					detail.setProductId(childProductForSave.getId());
					productDao.saveOrUpdate(detail);
					companyService.addMapDataByProDetail(detail.getId(), detail.getProductId());
				}
				productDao.update(parentProductForSave);
			}
		}
	}
	
	
	/**
	 * 把每一行数据放到一个product对象中
	 * @param list
	 * @return
	 * @throws Exception
	 */
	private Map<String , Map<String , List<TProductDetail>>>  getProductByListNew(List<List<Object>> list) throws Exception {
		TProduct product = new TProduct();
		Map<String  , Map<String , List<TProductDetail>>>  parentProductMap = new HashMap<>();
		Map<String , List<TProductDetail>>  childProductMap = new HashMap<>();
		
   		for(List<Object>  temp : list){
   			TProductDetail detailTemp = new TProductDetail();
   			String childProName = temp.get(1).toString();
   			if(!childProductMap.containsKey(temp.get(1).toString())){
   				List<TProductDetail> listTemp = new ArrayList<>();
   				listTemp.add(detailTemp);
   				childProductMap.put(childProName, listTemp);
   			}else{
   				childProductMap.get(childProName).add(detailTemp);
   			}
   			String parentProName = temp.get(0).toString() ; 
   			if(!parentProductMap.containsKey(parentProName)){
   				Map<String , List<TProductDetail>>  childProductMapTemp = new HashMap<>();
   				parentProductMap.put(parentProName, null);
   			}
   			String baseNum =temp.get(3).toString().trim() ; 
   			if(StringUtils.isNotEmpty(baseNum)){
				try {
					product.setBase(Integer.parseInt(baseNum));
				} catch (Exception e) {
					product.setBase(1);
				}
			}else{
				product.setBase(1);
			}
			detailTemp.setSubProduct(temp.get(4).toString()); 
			splitFormat(detailTemp, temp.get(5).toString());
   			String  material = temp.get(6).toString();
   			detailTemp.setMaterial(material);
   		}
		
		return parentProductMap;
	}
	
	/**
	 * 把每一行数据放到一个product对象中
	 * @param list
	 * @return
	 * @throws Exception
	 */
	private TProduct getProductByList(List<Object> list) throws Exception {
		TProduct product = new TProduct();
		List<String>  proDetailNameList = new ArrayList<>(); 
		List<String>  proDetailFormatList = new ArrayList<>(); 
		List<String>  proDetailMaterialList = new ArrayList<>(); 
		for (int i = 0; i < list.size(); i++) {
			 if(list.get(i) != null){
				 String value = list.get(i).toString();
				  switch (i) {
					case 0:
						product.setProduct(value);
						break;
					case 1:
						product.setChildProName(value);
						break;
					case 2:
						break;
					case 3 :
						if(StringUtils.isNotEmpty(value.trim())){
							try {
								product.setBase(Integer.parseInt(value));
							} catch (Exception e) {
								product.setBase(1);
							}
						}else{
							product.setBase(1);
						}
						break;
					case 4 :
						proDetailNameList = Arrays.asList(value.split(" "));
						break;
					case 5 :
						proDetailFormatList = Arrays.asList(value.split(" "));
						break;
					case 6 :
						proDetailMaterialList = Arrays.asList(value.split(" "));
						break;
					}
				  
			 }
		}
		List<TProductDetail> detailListFirst = new ArrayList<>();
		//根据产品型号  生成详情列表集合
		setFirstDetailList(proDetailNameList , detailListFirst);
		//判断 型号和规格是一对一(map)还是多对多(matrix)关系
		if(list.size()  > 7  &&  "是".equals(list.get(7))){
			setSecondDetailListAsMap( proDetailFormatList, detailListFirst);
		}else{
			setSecondDetailListAsMatrix(proDetailFormatList, detailListFirst);
		}
		//根据材料 生成详情列表集合
		setThirdDetailList(proDetailMaterialList , detailListFirst);
		product.setDetailList(detailListFirst);
		return product;
	}
	
	/**
	 *   获得 型号*规格*材质  一对一的详情信息集合
	 * @throws Exception 
	 */
	private void setSecondDetailListAsMap(
			List<String> proDetailFormatList,
			List<TProductDetail> detailListFirst) throws Exception {
		if(detailListFirst.size() == proDetailFormatList.size()) {
				for(int i = 0 ; i < proDetailFormatList.size() ; i++) {
					String format = proDetailFormatList.get(i);
					Integer formatNum = SystemUtil.getNumFromString(format);
					detailListFirst.get(i).setFormatNum(formatNum);
					String formatAndUnit = format.replace(formatNum+"", "");
					if(formatAndUnit.indexOf("/") >= 0) {
						detailListFirst.get(i).setUnit(formatAndUnit.split("/")[0]);
						detailListFirst.get(i).setFormat(formatAndUnit.split("/")[1]);
					}else {
						detailListFirst.get(i).setUnit(formatAndUnit);
					}
				}
		}else {
			throw new Exception("型号规格不匹配，型号与规格中的数量应一致！");
		}
	}


	/**
	 *   获得 型号*规格*材质  多对多的详情信息集合
	 * @throws Exception 
	 */
	private void setSecondDetailListAsMatrix(
			List<String> proDetailFormatList,
			List<TProductDetail> detailListFirst) throws Exception {
		List<TProductDetail> detailListSecond = new ArrayList<>();
		for(int i = 0 ; i < proDetailFormatList.size() ; i++) {
			String format = proDetailFormatList.get(i);
			Integer formatNum = SystemUtil.getNumFromString(format);
			if(StringUtils.isNotEmpty(format)) {
				for (TProductDetail detail : detailListFirst) {
					if(i==0) {
						detail.setFormatNum(formatNum);
						String formatAndUnit = format.replace(formatNum+"", "");
						if(formatAndUnit.indexOf("/") >= 0) {
							detail.setUnit(formatAndUnit.split("/")[0]);
							detail.setFormat(formatAndUnit.split("/")[1]);
						}else {
							detail.setUnit(formatAndUnit);
						}
					}else {
						TProductDetail detailTemp = new TProductDetail();
						detailTemp.setFormatNum(formatNum);
						String formatAndUnit = format.replace(formatNum+"", "");
						if(formatAndUnit.indexOf("/") >= 0) {
							detailTemp.setUnit(formatAndUnit.split("/")[0]);
							detailTemp.setFormat(formatAndUnit.split("/")[1]);
						}else {
							detailTemp.setUnit(formatAndUnit);
						}
						detailTemp.setSubProduct(detail.getSubProduct());
						detailListSecond.add(detailTemp);
					}
				}
			}
		}
		detailListFirst.addAll(detailListSecond);
	}
	
	/**
	 * 
	 * @param proDetailNameList  不同型号集合（产品详情名字）
	 * @param detailListFirst    根据型号获取的详情集合（后面会在此基础上添加 规格和材料对应的详情集合）
	 */
	private void setFirstDetailList(List<String> proDetailNameList,
			List<TProductDetail> detailListFirst) {
		//如果有规格（类型名）添加对应数据到list中，没有则添加一条空的，方便后面处理其他数据
		if(proDetailNameList.size() > 0) {
			for(String detailName :proDetailNameList) {
				TProductDetail detailTemp = new TProductDetail();
				detailTemp.setSubProduct(detailName);
				detailListFirst.add(detailTemp);
			}
		}else {
			TProductDetail detailTemp = new TProductDetail();
			detailListFirst.add(detailTemp);
		}
		
	}
	
	/**
	 * 添加材料对象的detailList
	 * @param proDetailMaterialList （不同材料集合）
	 * @param detailListFirst   添加了材料种类之后扩充的详情信息集合
	 */
	private void setThirdDetailList(List<String> proDetailMaterialList,
			List<TProductDetail> detailListFirst) {
		List<TProductDetail> detailListThird = new ArrayList<>();
		if(proDetailMaterialList.size() > 0) {
			for(int i = 0 ; i < proDetailMaterialList.size() ; i++) {
				for (TProductDetail detail : detailListFirst) {
					if(i==0) {
						detail.setMaterial(proDetailMaterialList.get(i));
					}else {
						TProductDetail detailTemp = new TProductDetail();
						detailTemp.setMaterial(proDetailMaterialList.get(i));
						detailTemp.setSubProduct(detail.getSubProduct());
						detailTemp.setFormatNum(detail.getFormatNum());
						detailTemp.setFormat(detail.getFormat());
						detailTemp.setUnit(detail.getUnit());
						detailListThird.add(detailTemp);
					}
				}
			}
		}
		detailListFirst.addAll(detailListThird);
	}

	public static void main(String[] args) {
		 String s = "";
		 System.out.println(StringUtils.isNotBlank(s));
	}
	
	/**
	 * �����������ļ���׺������Ӧ�ϴ��ļ��İ汾 
	 * @param inStr,fileName
	 * @return
	 * @throws Exception
	 */
	public  Workbook getWorkbook(InputStream inStr,String fileName) throws Exception{
		Workbook wb = null;
		String fileType = fileName.substring(fileName.lastIndexOf("."));
		if(excel2003L.equals(fileType)){
			wb = new HSSFWorkbook(inStr);  //2003-
		}else if(excel2007U.equals(fileType)){
			wb = new XSSFWorkbook(inStr);  //2007+
		}else{
			throw new Exception("�������ļ���ʽ����");
		}
		return wb;
	}

	/**
	 * �������Ա������ֵ���и�ʽ��
	 * @param cell
	 * @return
	 */
	public  Object getCellValue(Cell cell){
		Object value = null;
		DecimalFormat df = new DecimalFormat("0");  //��ʽ��number String�ַ�
		SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");  //���ڸ�ʽ��
		DecimalFormat df2 = new DecimalFormat("0.00");  //��ʽ������
		if(cell == null){
			  return "";
		}
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_STRING:
			value = cell.getRichStringCellValue().getString();
			break;
		case Cell.CELL_TYPE_NUMERIC:
			if("General".equals(cell.getCellStyle().getDataFormatString())){
				value = df.format(cell.getNumericCellValue());
			}else if("m/d/yy".equals(cell.getCellStyle().getDataFormatString())){
				value = sdf.format(cell.getDateCellValue());
			}else{
				value = df2.format(cell.getNumericCellValue());
			}
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			value = cell.getBooleanCellValue();
			break;
		case Cell.CELL_TYPE_BLANK:
			value = "";
			break;
		default:
			break;
		}
		return value;
	}

	@Override
	public void updateFormat() {
		List<TProductDetail> detailList = productDetailService.searchAllProductDetail();
		for(TProductDetail proDetail : detailList){
			 if(proDetail.getFormat().length() > 0){
				Integer  tempNum = SystemUtil.getNumFromString(proDetail.getFormat());
				if(tempNum != null){
					proDetail.setFormatNum(Integer.valueOf(tempNum));
					proDetail.setFormat(proDetail.getFormat().replace(tempNum+"", ""));
					String formatAndUnit = proDetail.getFormat().replace(tempNum+"", "");
					if(formatAndUnit.indexOf("/") >= 0) {
						proDetail.setUnit(formatAndUnit.split("/")[0]);
						proDetail.setFormat(formatAndUnit.split("/")[1]);
					}else {
						proDetail.setUnit(formatAndUnit);
					}
				}else{
					continue;
				}
			 }
		}
		
	}
	
	private void splitFormat(TProductDetail detail , String format ){
		Integer formatNum = SystemUtil.getNumFromString(format);
		detail.setFormatNum(formatNum);
		String formatAndUnit = format.replace(formatNum+"", "");
		if(formatAndUnit.indexOf("/") >= 0) {
			detail.setUnit(formatAndUnit.split("/")[0]);
			detail.setFormat(formatAndUnit.split("/")[1]);
		}else {
			detail.setUnit(formatAndUnit);
		}
	}

	private BaseDaoI productDao;

	public BaseDaoI getProductDao() {
		return productDao;
	}

	@Autowired
	public void setProductDao(BaseDaoI productDao) {
		this.productDao = productDao;
	}
	
	private ProductServiceI productService;
	
	
	public ProductServiceI getProductService() {
		return productService;
	}
	@Autowired
	public void setProductService(ProductServiceI productService) {
		this.productService = productService;
	}
	
	private ProductDetailServiceI detailService ;
	
	public ProductDetailServiceI getDetailService() {
		return detailService;
	}
	@Autowired
	public void setDetailService(ProductDetailServiceI detailService) {
		this.detailService = detailService;
	}

	private ProductDetailServiceI productDetailService;
	public ProductDetailServiceI getProductDetailService() {
		return productDetailService;
	}
	@Autowired
	public void setProductDetailService(ProductDetailServiceI productDetailService) {
		this.productDetailService = productDetailService;
	}
	
	private CompanyServiceI companyService;

	public CompanyServiceI getCompanyService() {
		return companyService;
	}
	@Autowired
	public void setCompanyService(CompanyServiceI companyService) {
		this.companyService = companyService;
	}
	
	
}
