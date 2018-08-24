package com.saki.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.saki.entity.Grid;
import com.saki.model.TOrder;
import com.saki.service.ImportExcelI;
import com.saki.service.OrderServiceI;
import com.saki.utils.DateUtil;
import com.saki.utils.ExcelUtil;

@Namespace("/")
@Action(value = "report")
public class ReportFormAction extends BaseAction {
	
	private File uploadFile;
	private String filename;
	
	private OrderServiceI orderService;
	public OrderServiceI getOrderService() {
		return orderService;
	}
	@Autowired
	public void setOrderService(OrderServiceI orderService) {
		this.orderService = orderService;
	}
	private ImportExcelI importExcelUtil;
	

	public ImportExcelI getImportExcelUtil() {
		return importExcelUtil;
	}
	@Autowired
	public void setImportExcelUtil(ImportExcelI importExcelUtil) {
		this.importExcelUtil = importExcelUtil;
	}
	/**
	 * 导出报表
	 * 
	 * @return
	 */
	public void exportExcel() {
		Map<String ,Object> params  = new HashMap<>();
		getParams(params);
		Grid grid = orderService.search(params,"companyId", "desc", page, rows ,null);
		List<TOrder> list = grid.getRows();
		Map<TOrder ,List<Map<String,Object>> > resultMap = new HashMap<>();
		if(list!= null && list.size() > 0 ) {
			for(TOrder order : list) {
				List<Map<String,Object>>  detailList = orderService.searchDetail(order.getId()+"");
				resultMap.put(order, detailList);
			}
			// excel文件名
			String fileName = "订单信息表_" + DateUtil.getStringDateShort() + ".xls";
			try {
				// 创建HSSFWorkbook
				HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(resultMap);
				// 响应到客户端
				this.setResponseHeader(getResponse(), fileName);
				OutputStream os = getResponse().getOutputStream();
				wb.write(os);
				os.flush();
				os.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void importExcel() {
			String fileName = ExcelUtil.copyFile(filename, uploadFile);
			FileInputStream in;
			try {
				in = new FileInputStream(fileName);
				importExcelUtil.getListByExcel(in, filename);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
	}

	// 发送响应流方法
	public void setResponseHeader(HttpServletResponse response, String fileName) {
		try {
			try {
				fileName = new String(fileName.getBytes(), "ISO8859-1");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.setContentType("application/octet-stream;charset=ISO8859-1");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
			response.addHeader("Pargam", "no-cache");
			response.addHeader("Cache-Control", "no-cache");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	public File getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
}
