package com.saki.entity;

import java.util.ArrayList;
import com.saki.model.TProductDetail;

public class Product {
	private int id;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	private String imgUrl  ;
	
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	private String product;
	private String unit;
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	private ArrayList<ProductType> children;

	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public ArrayList<ProductType> getChildren() {
		return children;
	}
	public void setChildren(ArrayList<ProductType> children) {
		this.children = children;
	}	
}
