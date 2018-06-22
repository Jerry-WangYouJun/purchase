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

	// Constructors

	/** default constructor */
	public TUserProduct() {
	}

	/** full constructor */
	public TUserProduct(Integer companyId, Integer productDetailId, String status, Integer roleId) {
		this.companyId = companyId;
		this.productDetailId = productDetailId;
		this.status = status;
		this.roleId = roleId;
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

}