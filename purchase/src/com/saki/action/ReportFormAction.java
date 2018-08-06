package com.saki.action;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;

import com.saki.entity.Grid;
import com.saki.model.TOrder;
import com.saki.service.OrderServiceI;
import com.saki.utils.DateUtil;
import com.saki.utils.ExcelUtil;

@Namespace("/")
@Action(value = "report")
public class ReportFormAction extends BaseAction {

	
	private OrderServiceI orderService;
	public OrderServiceI getOrderService() {
		return orderService;
	}
	@Autowired
	public void setOrderService(OrderServiceI orderService) {
		this.orderService = orderService;
	}
	/**
	 * 导出报表
	 * 
	 * @return
	 */
	public void export() throws Exception {
		Map params = new HashMap<>();
		// 获取数据
		Grid grid = orderService.search(params,"startDate", "desc", page, rows ,null);
		List<TOrder>  list = grid.getRows();
		// excel标题
		String[] title = { "公司名称", "订单编号", "订单总价", "订单状态", "状态" };

		// excel文件名
		String fileName = "订单信息表" + DateUtil.getStringDateShort() + ".xls";

		// sheet名
		String sheetName = "订单信息表";
		// 创建HSSFWorkbook
				HSSFWorkbook wb = new HSSFWorkbook();
				HSSFSheet sheet = wb.createSheet(sheetName);	
				// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制
		        HSSFRow row = sheet.createRow(0);
		String[][] content = new String[list.size()][5];
		for (int i = 0; i < list.size(); i++) {
			content[i] = new String[title.length];
			TOrder obj = list.get(i);
			content[i][0] = obj.getCompanyName();
			content[i][1] = obj.getOrderNo();
			content[i][2] = obj.getAmount() + "";
			content[i][3] = obj.getStatus() + "";
 			content[i][4] = obj.getRemark();
		}

        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

        //声明列对象
        HSSFCell cell = null;

        //创建标题
        for(int i=0;i<title.length;i++){
            cell = row.createCell(i);
            cell.setCellValue(title[i]);
            cell.setCellStyle(style);
        }

        //创建内容
        for(int i=0;i<content.length;i++){
            row = sheet.createRow(i + 1);
            for(int j=0;j<content[i].length;j++){
                //将内容按顺序赋给对应的列对象
                row.createCell(j).setCellValue(content[i][j]);
            }
        }
			
		// 响应到客户端
		try {
			this.setResponseHeader(getResponse(), fileName);
			OutputStream os = getResponse().getOutputStream();
			wb.write(os);
			os.flush();
			os.close();
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
}
