package com.saki.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import com.saki.entity.Grid;
import com.saki.model.TProduct;
import com.saki.model.TProductDetail;
import com.saki.service.BaseServiceI;

@Service("importExcelUtil")
public class ImportExcelUtil  implements BaseServiceI{
	
	private final static String excel2003L =".xls";    //2003- �汾��excel
	private final static String excel2007U =".xlsx";   //2007+ �汾��excel
	
	/**
	 * ��������ȡIO���е����ݣ���װ��List<List<Object>>����
	 * @param in,fileName
	 * @return
	 * @throws IOException 
	 */
	public  void getBankListByExcel(InputStream in,String fileName) throws Exception{
		List<List<Object>> list = null;
		
		//����Excel������
		Workbook work = this.getWorkbook(in,fileName);
		if(null == work){
			throw new Exception("����Excel������Ϊ�գ�");
		}
		Sheet sheet = null;
		Row row = null;
		Cell cell = null;
		
		list = new ArrayList<List<Object>>();
		//����Excel�����е�sheet
		for (int i = 0; i < work.getNumberOfSheets(); i++) {
			sheet = work.getSheetAt(i);
			if(sheet==null){continue;}
			
			//������ǰsheet�е�������
			for (int j = sheet.getFirstRowNum(); j <= sheet.getLastRowNum(); j++) {
				row = sheet.getRow(j);
				if(row==null||row.getFirstCellNum()==j){continue;}
				
				//�������е���
				List<Object> li = new ArrayList<Object>();
				for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
					cell = row.getCell(y);
					li.add(this.getCellValue(cell));
				}
				list.add(li);
			}
		}
		work.close();
		batchInsertProduct( list);
	}
	
	public void batchInsertProduct(List<List<Object>> list ){
		Map<String , TProduct> parentProMap = new HashMap<>();
		Map<String , TProduct> childProMap = new HashMap<>();
		Map<String , TProductDetail> detailProMap = new HashMap<>();
		for (List<Object> list2 : list) {
			
		}
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
		// TODO Auto-generated method stub
		return null;
	}
	

}
