package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TSupllierOrderDetail entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_supllier_order_detail", catalog = "order")

public class TSupllierOrderDetail implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer conpanyId;
	private Integer supllierOrderId;
	private Integer productDetailId;
	private Integer num;
	private Integer initnum;
	private double price;
	private String status;
	private String remark;

	// Constructors

	/** default constructor */
	public TSupllierOrderDetail() {
	}

	/** full constructor */
	public TSupllierOrderDetail(Integer conpanyId, Integer supllierOrderId, Integer productDetailId, Integer num,Integer initnum,  
			double price,String status , String remark) {
		this.conpanyId = conpanyId;
		this.supllierOrderId = supllierOrderId;
		this.productDetailId = productDetailId;
		this.num = num;
		this.initnum = initnum;
		this.price = price;
		this.status = status;
		this.remark = remark;
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

	@Column(name = "conpany_id")

	public Integer getConpanyId() {
		return this.conpanyId;
	}

	public void setConpanyId(Integer conpanyId) {
		this.conpanyId = conpanyId;
	}

	@Column(name = "supllier_order_id")

	public Integer getSupllierOrderId() {
		return this.supllierOrderId;
	}

	public void setSupllierOrderId(Integer supllierOrderId) {
		this.supllierOrderId = supllierOrderId;
	}

	@Column(name = "product_detail_id")

	public Integer getProductDetailId() {
		return this.productDetailId;
	}

	public void setProductDetailId(Integer productDetailId) {
		this.productDetailId = productDetailId;
	}

	@Column(name = "num")

	public Integer getNum() {
		return this.num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Column(name = "initnum")
	public Integer getInitnum() {
		return initnum;
	}

	public void setInitnum(Integer initnum) {
		this.initnum = initnum;
	}

	@Column(name = "price", precision = 10, scale = 3)

	public double getPrice() {
		return this.price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
	
	@Column(name = "status")
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}