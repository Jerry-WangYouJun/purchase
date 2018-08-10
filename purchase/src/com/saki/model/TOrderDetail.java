package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TOrderDetail entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_order_detail", catalog = "order")

public class TOrderDetail implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private Integer productDetailId;
	private Integer num;
	private Double price;
	private String brand; 
	private Double amount;
	private String defaultFlag;
	private String remark;

	// Constructors

	/** default constructor */
	public TOrderDetail() {
	}

	/** full constructor */
	public TOrderDetail(Integer orderId, Integer productDetailId, Integer num, Double price,Double amount, String remark) {
		this.orderId = orderId;
		this.productDetailId = productDetailId;
		this.num = num;
		this.price = price;
		this.amount = amount;
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

	@Column(name = "order_id")

	public Integer getOrderId() {
		return this.orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
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

	@Column(name = "price", precision = 10, scale = 0)

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "brand")
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	@Column( name = "amount")
	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	@Column( name = "defaultFlag")
	public String getDefaultFlag() {
		return defaultFlag;
	}

	public void setDefaultFlag(String defaultFlag) {
		this.defaultFlag = defaultFlag;
	}
	

	
}