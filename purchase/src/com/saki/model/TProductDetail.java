package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * TProductDetail entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_product_detail", catalog = "order")

public class TProductDetail implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer productId;
	private String subProduct;
	private String format;
	private String material;
	private String remark;
	
	private TUserProduct mapper;
	
	private int selected = 0;

	// Constructors

	/** default constructor */
	public TProductDetail() {
	}

	/** full constructor */
	public TProductDetail(Integer productId, String subProduct, String format, String material, String remark) {
		this.productId = productId;
		this.subProduct = subProduct;
		this.format = format;
		this.material = material;
		this.remark = remark;
	}
	
	
	public TProductDetail(Integer id,Integer productId, String subProduct, String format, String material, String remark) {
		this.id = id;
		this.productId = productId;
		this.subProduct = subProduct;
		this.format = format;
		this.material = material;
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

	@Column(name = "product_id")

	public Integer getProductId() {
		return this.productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	@Column(name = "sub_product", length = 50)

	public String getSubProduct() {
		return this.subProduct;
	}

	public void setSubProduct(String subProduct) {
		this.subProduct = subProduct;
	}

	@Column(name = "format", length = 50)

	public String getFormat() {
		return this.format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	@Column(name = "material", length = 20)

	public String getMaterial() {
		return this.material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getSelected() {
		return selected;
	}

	public void setSelected(int selected) {
		this.selected = selected;
	}

/*	public TProduct getProduct() {
		if(product ==null){
			product = new TProduct();
		}
		return product;
	}

	public void setProduct(TProduct product) {
		this.product = product;
	}*/

	public TUserProduct getMapper() {
		return mapper;
	}

	public void setMapper(TUserProduct mapper) {
		this.mapper = mapper;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((format == null) ? 0 : format.hashCode());
		result = prime * result + ((material == null) ? 0 : material.hashCode());
		result = prime * result + ((subProduct == null) ? 0 : subProduct.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TProductDetail other = (TProductDetail) obj;
		if (format == null) {
			if (other.format != null)
				return false;
		} else if (!format.equals(other.format))
			return false;
		if (material == null) {
			if (other.material != null)
				return false;
		} else if (!material.equals(other.material))
			return false;
		if (subProduct == null) {
			if (other.subProduct != null)
				return false;
		} else if (!subProduct.equals(other.subProduct))
			return false;
		return true;
	}
	
	

}