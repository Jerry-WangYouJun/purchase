package com.saki.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * TProduct entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_product", catalog = "order")

public class TProduct implements java.io.Serializable {

	// Fields

	private Integer id;
	private String product;
	private String type;
	private String unit;
	private Integer base;
	private String remark;

	private Integer parentId;
	private String childProName;
	List<TProductDetail> detailList  ;
	// Constructors
	
	/** default constructor */
	public TProduct() {
	}

	/** minimal constructor */
	public TProduct(String product) {
		this.product = product;
	}
	
	public TProduct(Integer id, String product) {
		this.id = id;
		this.product = product;
	}

	/** full constructor */
	public TProduct(Integer parentId,String product, String type, String unit, Integer base, String remark) {
		this.parentId = parentId;
		this.product = product;
		this.type = type;
		this.unit = unit;
		this.base = base;
		this.remark = remark;
	}
	public TProduct(Integer id,Integer parentId, String product, String type, String unit, Integer base, String remark) {
		this.parentId = parentId;
		this.id = id;
		this.product = product;
		this.type = type;
		this.unit = unit;
		this.base = base;
		this.remark = remark;
	}
	 /**
     * distinct constructor 
     * @param produnct
     */
	public TProduct(String produnct , String  unit) {
		 this.product = produnct;
		 this.unit = unit ;
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

	@Column(name="parent_id")
	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	@Column(name = "product", nullable = false, length = 50)

	public String getProduct() {
		return this.product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	@Column(name = "type", length = 50)

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "unit", length = 10)

	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	@Column(name = "base", length = 10)

	public Integer getBase() {
		return this.base;
	}

	public void setBase(Integer base) {
		this.base = base;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Transient
	public List<TProductDetail> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<TProductDetail> detailList) {
		this.detailList = detailList;
	}

	public String getChildProName() {
		return childProName;
	}

	public void setChildProName(String childProName) {
		this.childProName = childProName;
	}
	
	

}