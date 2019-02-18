package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TUserProduct entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_user_product", catalog = "order")

public class TUserProduct implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer companyId;
	private Integer productDetailId;
	private String status;
	private Integer roleId;
	private Double price ;
	private Double markup;
	private Double supMarkup;
	private Double percent;
	private Integer productId;
	private String imgUrl;
	//private Double taxrate; 

	// Constructors

	/** default constructor */
	public TUserProduct() {
	}

	/** full constructor */
	public TUserProduct(Integer companyId, Integer productDetailId, String status
			, Integer roleId , Double price , Double percent ,Integer productId , Double supMarkup ) {
		this.companyId = companyId;
		this.productDetailId = productDetailId;
		this.status = status;
		this.roleId = roleId;
		this.price = price ;
		this.percent = percent;
		this.productId = productId;
		this.supMarkup = supMarkup;
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

	@Column(name = "product_detail_id")

	public Integer getProductDetailId() {
		return this.productDetailId;
	}

	public void setProductDetailId(Integer productDetailId) {
		this.productDetailId = productDetailId;
	}

	@Column(name = "status", length = 10)

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "role_id")

	public Integer getRoleId() {
		return this.roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	@Column(name = "price")
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	@Column(name = "markup")
	public Double getMarkup() {
		return markup;
	}

	public void setMarkup(Double markup) {
		this.markup = markup;
	}
	@Column(name = "percent")
	public Double getPercent() {
		return percent;
	}

	public void setPercent(Double percent) {
		this.percent = percent;
	}
	@Column(name = "product_id")
	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getImgUrl() {
		return imgUrl;
	}
	@Column(name = "imgUrl")
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	@Column(name = "sup_markup")
	public Double getSupMarkup() {
		return supMarkup;
	}
	public void setSupMarkup(Double supMarkup) {
		this.supMarkup = supMarkup;
	}
	
	
	
//	@Column(name="taxrate")
//	public Double getTaxrate() {
//		return taxrate;
//	}
//
//	public void setTaxrate(Double taxrate) {
//		this.taxrate = taxrate;
//	}
	
}