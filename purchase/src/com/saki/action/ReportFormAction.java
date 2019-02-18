package com.saki.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.saki.entity.Grid;
import com.saki.entity.Message;
import com.saki.model.TColor;
import com.saki.model.TOrder;
import com.saki.model.TProduct;
import com.saki.service.ImportExcelI;
import com.saki.service.OrderServiceI;
import com.saki.service.ProductServiceI;
import com.saki.service.UserProductServiceI;
import com.saki.utils.DateUtil;
import com.saki.utils.ExcelUtil;

@Namespace("/")
@Action(value = "report" ,results = 
{@Result(name="image",location="/pages/image_import.jsp") ,
@Result(name="color",location="/pages/color_import.jsp")}

)
public class ReportFormAction extends BaseAction implements ModelDriven<TColor>{
	
	private File uploadFile;
	private String filename;
	private Integer proId;
	TColor tColor = new TColor();
	
	@Override
	public TColor getModel() {
		return tColor;
	}
	
	private UserProductServiceI upServicel;
	
	public UserProductServiceI getUpServicel() {
		return upServicel;
	}
	@Autowired
	public void setUpServicel(UserProductServiceI upServicel) {
		this.upServicel = upServicel;
	}
	private ProductServiceI  proService;
	
	public ProductServiceI getProService() {
		return proService;
	}
	@Autowired
	public void setProService(ProductServiceI proService) {
		this.proService = proService;
	}
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
	@SuppressWarnings("unchecked")
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
			Message j = new Message();
			try {
				in = new FileInputStream(fileName);
				importExcelUtil.getListByExcel(in, filename);
				j.setSuccess(true);
				j.setMsg("导入成功");
			} catch (Exception e) {
				e.printStackTrace();
				j.setSuccess(false);
				j.setMsg(e.getMessage());
			}
			super.writeJson(j);
	}
	
	
	public void importImage() {
		String roleId = getSession().getAttribute("roleId").toString();
		String companyId = "";
		
		Message j = new Message();
		try {
			
			filename = DateUtil.getUserDate("yyyyMMddhhmm") + "_" + filename.trim() ;
			 long len =uploadFile.length();
			 if(len > 1024*1024){
				 j.setSuccess(false);
				 j.setMsg("图片大小需限制在1M之内");
				 super.writeJson(j);
			 }
			ExcelUtil.copyFile(filename, uploadFile);
			if(!"1".equals(roleId)){
				companyId = getSession().getAttribute("companyId").toString();
				upServicel.updateImg(proId , companyId, filename);
			}else{
				TProduct pro = (TProduct) proService.getByKey(proId + "");
				pro.setChildProName(filename );
				proService.update(pro);
			}
			j.setSuccess(true);
			j.setMsg("导入成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg(e.getMessage());
		}
		super.writeJson(j);
	}
	
	public void importColorImage() {
		String roleId = getSession().getAttribute("roleId").toString();
		String companyId = "";
		
		Message j = new Message();
		try {
			
			filename = DateUtil.getUserDate("yyyyMMddhhmm") + "_" + filename.trim() ;
			 long len =uploadFile.length();
			 if(len > 1024*1024*10){
				 j.setSuccess(false);
				 j.setMsg("图片大小需限制在10M之内");
				 super.writeJson(j);
			 }
			 ExcelUtil.copyFile(filename, uploadFile);
			 tColor.setImgUrl(filename);
			 upServicel.updateColorImg(tColor );
			j.setSuccess(true);
			j.setMsg("导入成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg(e.getMessage());
		}
		super.writeJson(j);
	}
	
	public String  importInit(){
			this.getRequest().setAttribute("proId", proId);
		 return "image";
	}
	
	public String importColorInit(){
		String id = getParameter("id");
		if(StringUtils.isNotBlank(id)){
		 TColor color=	upServicel.getByKey(id);
		 getRequest().setAttribute("color", color);
		}
		 return "color";
	}
	
	public void updateFormat(){
		importExcelUtil.updateFormat();
	}

	// 发送响应流方法
	public void setResponseHeader(HttpServletResponse response, String fileName) {
		try {
			try {
				fileName = new String(fileName.getBytes(), "ISO8859-1");
			} catch (UnsupportedEncodingException e) {
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
	public Integer getProId() {
		return proId;
	}
	public void setProId(Integer proId) {
		this.proId = proId;
	}
	
}
