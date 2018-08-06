package com.saki.utils;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.saki.model.TOrder;

public class ExcelUtil {

	static HSSFWorkbook wb = new HSSFWorkbook();
	
    /**
     * 导出Excel
     * @param sheetName sheet名称
     * @param title 标题
     * @param values 内容
     * @param wb HSSFWorkbook对象
     * @return
     * @throws Exception 
     */
    public static HSSFWorkbook getHSSFWorkbook(Map<TOrder ,List<Map<String,Object>>> resultMap) throws Exception{
    	 wb = new HSSFWorkbook();
    	// 第一步，创建一个HSSFWorkbook，对应一个Excel文件
     	List<String> sheetNameList = new ArrayList<>();//判断sheet页是否存在
     	Iterator<TOrder> it = resultMap.keySet().iterator();
     	while(it.hasNext()) {
     		TOrder orderTemp = it.next();
     		 String sheetName = orderTemp.getCompanyName();
     		 HSSFSheet sheet = null;
     		 int rowIndex = 0 ;
     		 // 第二步，在workbook中添加一个sheet,对应不同企业，存在则获取该sheet，不存在则新建
     		 if(sheetNameList.contains(sheetName)) {
     			 sheet = wb.getSheet(sheetName);
     			 rowIndex =  sheet.getLastRowNum() + 1 ;
     		 }else {
     			 sheet = wb.createSheet(sheetName);
     			 sheetNameList.add(sheetName);
     		 }
     		 //将订单信息写入sheet页中
     		 writeOrderData(sheet ,rowIndex , orderTemp , resultMap.get(orderTemp));
     	}
        return wb;
    }

	private static void writeOrderData(HSSFSheet sheet, int rowIndex,TOrder order , List<Map<String, Object>> list) throws Exception {
		
     // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        
        for( int i = 0 ; i < 3 ; i ++ ) {
        	// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制
            HSSFRow row = sheet.createRow(rowIndex + i );
            for(int r = 0 ; r < 4 ; r++) {
            	 	 HSSFCell cell = null;
                 cell = row.createCell(r);
                 String value = OrderEnum.values()[i*4 + r].toString();
                 if(r % 2 == 0 ) {
	                	 cell.setCellValue(OrderEnum.values()[i*4 + r].toString());
                 }else {
                	 	 cell.setCellValue(getValue(order , value).toString());
                 }
                 cell.setCellStyle(style);
            }
        }
        
        HSSFRow rowColumn = sheet.createRow(rowIndex + 4 );
        String[] columnArr = {"产品大类","产品类型","产品名称","材质/标准"
        		,"品牌","数量","单位","单价","总价","备注"};
        String[] columnNameArr = {"product","type","sub_product","materail"
        		,"brand","acount","unit","price","amount","remark"}; 
        for (int i = 0; i < columnArr.length; i++) {
        		HSSFCell cell =  rowColumn.createCell(i);
        		cell.setCellValue(columnArr[i]);
        		cell.setCellStyle(style);
		}
        for (int i = 0; i < list.size(); i++) {
        		 Map<String , Object >  map = list.get(i);
        		 HSSFRow row = sheet.createRow(rowIndex +  5  + i);
        		 for(int j = 0; j < columnNameArr.length; j++) {
        			 HSSFCell cell =  row.createCell(j);
        			 if(map.get(columnNameArr[j]) != null) {
        				 cell.setCellValue(map.get(columnNameArr[j]).toString());
        			 }else {
        				 cell.setCellValue("");
        			 }
         		 cell.setCellStyle(style);
        		 }
		}
        
        
	}
	
	public static Object getValue(Object dto,String name) throws Exception{  
        Method[]  m = dto.getClass().getMethods();  
        for(int i=0;i<m.length;i++){  
        if(("get"+name).toLowerCase().equals(m[i].getName().toLowerCase())){  
            return  m[i].invoke(dto);  
         }  
       }
        return "" ;
	}
}
