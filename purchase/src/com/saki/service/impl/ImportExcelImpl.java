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

import org.apache.commons.lang.xwork.StringUtils;
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
import com.saki.service.ImportExcelI;
import com.saki.service.ProductDetailServiceI;
import com.saki.service.ProductServiceI;

@Service("importExcelImpl")
public class ImportExcelImpl  implements ImportExcelI{
	
	private final static String excel2003L =".xls";    //2003- �汾��excel
	private final static String excel2007U =".xlsx";   //2007+ �汾��excel
	
	/**
	 * @param in,fileName
	 * @return
	 * @throws IOException 
	 */
	@Override
	public  void getListByExcel(InputStream in,String fileName) throws Exception{
		Workbook work = this.getWorkbook(in,fileName);
		if(null == work){
			throw new Exception("Excel文件中内容为空");
		}
		Sheet sheet = null;
		Row row = null;
		Cell cell = null;
		
		List<List<Object>> list = new ArrayList<List<Object>>();
		for (int i = 0; i < work.getNumberOfSheets(); i++) {
			sheet = work.getSheetAt(i);
			if(sheet==null){continue;}
			
			for (int j = sheet.getFirstRowNum(); j <= sheet.getLastRowNum(); j++) {
				row = sheet.getRow(j);
				if(row==null||sheet.getFirstRowNum()==j){continue;}
				
				List<Object> li = new ArrayList<Object>();
				for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
					cell = row.getCell(y);
					li.add(this.getCellValue(cell));
				}
				list.add(li);
			}
		}
		work.close();
		saveProducts( list);
	}
	
	public void saveProducts(List<List<Object>> list ){
		Map<String , Map<String , TProduct>> resultMap = new HashMap<>();
		for (List<Object> list2 : list) {
				TProduct  product =  getProductByList(list2);//一条数据
				Map<String , TProduct> tempMap = new HashMap<>();
				tempMap.put( product.getChildProName(), product);
				if(resultMap.containsKey(product.getProduct())) {
					resultMap.get(product.getProduct()).put(product.getChildProName(), product);
				}else {
					resultMap.put(product.getProduct(), tempMap);
				}
		}
		Map<Integer , List<TProduct> >  productChildMap = new HashMap<>();
		Map<String , TProduct >  productMap = new HashMap<>();
		List<TProduct> productParentList = productService.searchFirstProductType();
		for(TProduct parent : productParentList ){
			List<TProduct> productChildList = productService.searchChildProductType(parent.getId());
			for(TProduct child : productChildList){
				child.setDetailList(detailService.loadByProductId(child.getId()));
			}
			productChildMap.put(parent.getId(), productChildList);
			productMap.put(parent.getProduct(), parent);
		}
		Iterator<String> it = resultMap.keySet().iterator();
		while(it.hasNext()) {
			String parent = it.next(); 
			TProduct parentProductForSave = new TProduct();
			parentProductForSave.setProduct(parent);
			productDao.save(parentProductForSave);
			Iterator<String> child = resultMap.get(parent).keySet().iterator();
			while(child.hasNext()) {
				TProduct childProductForSave = new TProduct();
				String  pro = child.next();
				childProductForSave.setProduct(pro);
				childProductForSave.setParentId(parentProductForSave.getId());
				TProduct product =  resultMap.get(parent).get(pro);
				childProductForSave.setBase(product.getBase());
				productDao.save(childProductForSave);
				if(StringUtils.isEmpty(parentProductForSave.getUnit())) {
					parentProductForSave.setUnit(product.getUnit());
				}
				for(TProductDetail detail : product.getDetailList()) {
					detail.setProductId(childProductForSave.getId());
					productDao.save(detail);
				}
				productDao.update(parentProductForSave);
			}
		}
	}
	
	private TProduct getProductByList(List<Object> list) {
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
						product.setUnit(value);
						break;
					case 3 :
						proDetailNameList = Arrays.asList(value.split(" "));
						break;
					case 4 :
						proDetailFormatList = Arrays.asList(value.split(" "));
						break;
					case 5 :
						proDetailMaterialList = Arrays.asList(value.split(" "));
						break;
					}
				  
			 }
		}
		List<TProductDetail> detailListFirst = new ArrayList<>();
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
		List<TProductDetail> detailListSecond = new ArrayList<>();
		if(proDetailFormatList.size() > 0) {
			for(int i = 0 ; i < proDetailFormatList.size() ; i++) {
				for (TProductDetail detail : detailListFirst) {
					if(i==0) {
						detail.setFormat(proDetailFormatList.get(i));
					}else {
						TProductDetail detailTemp = new TProductDetail();
						detailTemp.setFormat(proDetailFormatList.get(i));
						detailTemp.setSubProduct(detail.getSubProduct());
						detailListSecond.add(detailTemp);
					}
				}
			}
		}
		detailListFirst.addAll(detailListSecond);
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
						detailTemp.setFormat(detail.getFormat());
						detailListThird.add(detailTemp);
					}
				}
			}
		}
		detailListFirst.addAll(detailListThird);
		product.setDetailList(detailListFirst);
		return product;
	}

	public static void main(String[] args) {
		 String s = "a  b";
		 System.out.println(s.split(" ").length);
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

}
