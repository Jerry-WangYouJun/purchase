package com.saki.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TOrder entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_order", catalog = "order")

public class TOrder implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer companyId;
	private String orderNo;
	private Date startDate;
	private Date confirmDate;
	private Date pillDate;
	private Date endDate;
	private String status;
	private double amount;
	private String remark;
	private String companyName;
	private String locked;
	private String invoice;
	private Date invoiceDate;
	private Date invoiceGet;
	private String percent;

	// Constructors

	/** default constructor */
	public TOrder() {
	}

	/** full constructor */
	public TOrder(Integer companyId, String orderNo, Date startDate, Date confirmDate, Date pillDate, Date endDate,
			String status, double amount, String remark ,String invoice,Date invoiceDate,Date invoiceGet,String percent) {
		this.companyId = companyId;
		this.orderNo = orderNo;
		this.startDate = startDate;
		this.confirmDate = confirmDate;
		this.pillDate = pillDate;
		this.endDate = endDate;
		this.status = status;
		this.amount = amount;
		this.remark = remark;
		this.invoice =invoice;
		this.invoiceDate = invoiceDate;
		this.invoiceGet =invoiceGet;
		this.percent = percent;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "increment")
	@Id
	@GeneratedValue(generator = "generator")

	@Column(name = "id", unique = true, nullable = false)

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "company_id")

	public Integer getCompanyId() {
		return this.companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	@Column(name = "order_no", length = 50)

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	

	@Column(name = "start_date", length = 19)

	public Date getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@Column(name = "confirm_date", length = 19)

	public Date getConfirmDate() {
		return this.confirmDate;
	}

	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}

	@Column(name = "pill_date", length = 19)

	public Date getPillDate() {
		return this.pillDate;
	}

	public void setPillDate(Date pillDate) {
		this.pillDate = pillDate;
	}

	@Column(name = "end_date", length = 19)

	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Column(name = "status", length = 5)

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "amount", precision = 10, scale = 5)

	public double getAmount() {
		return this.amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	@Column(name="locked")
	public String getLocked() {
		return locked;
	}

	public void setLocked(String locked) {
		this.locked = locked;
	}

	@Column(name ="invoice")
	public String getInvoice() {
		return invoice;
	}

	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}

	@Column(name="invoice_date",length = 19 )
	public Date getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(Date invoiceDate) {
		this.invoiceDate = invoiceDate;
	}

	@Column(name="invoice_get",length = 19 )
	public Date getInvoiceGet() {
		return invoiceGet;
	}

	public void setInvoiceGet(Date invoiceGet) {
		this.invoiceGet = invoiceGet;
	}

	
	@Column(name="percent")
	public String getPercent() {
		return percent;
	}

	public void setPercent(String percent) {
		this.percent = percent;
	}
	
	
	
}