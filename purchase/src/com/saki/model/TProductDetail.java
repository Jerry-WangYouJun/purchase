package com.saki.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.StringUtils;
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
	private Integer formatNum;
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
	
	
	public TProductDetail(Integer id,Integer productId, String subProduct, String format, Integer formatNum, String material, String remark) {
		this.id = id;
		this.productId = productId;
		this.subProduct = subProduct;
		this.format = format;
		this.formatNum = formatNum;
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
		this.subProduct = subProduct == null ? "" : subProduct;
	}

	
	@Column(name = "format_num" )
	public Integer getFormatNum() {
		return formatNum;
	}

	public void setFormatNum(Integer formatNum) {
		this.formatNum = formatNum;
	}

	@Column(name = "format", length = 50)

	public String getFormat() {
		return this.format;
	}

	public void setFormat(String format) {
		this.format = format == null ? "" : format;
	}

	@Column(name = "material", length = 20)

	public String getMaterial() {
		return this.material;
	}

	public void setMaterial(String material) {
		this.material = material == null ? "" : material;
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
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TProductDetail other = (TProductDetail) obj;
		if (StringUtils.isBlank(format)) {
			if (StringUtils.isNotBlank(other.format))
				return false;
		} else if (!format.equals(other.format))
			return false;
		if (formatNum == null) {
			if (other.formatNum != null)
				return false;
		} else if (!formatNum.equals(other.formatNum))
			return false;
		if (StringUtils.isBlank(material )) {
			if (StringUtils.isNotBlank(other.material ))
				return false;
		} else if (!material.equals(other.material))
			return false;
		if (StringUtils.isBlank(subProduct)) {
			if (StringUtils.isNotBlank(other.subProduct ))
				return false;
		} else if (!subProduct.equals(other.subProduct))
			return false;
		return true;
	}
}