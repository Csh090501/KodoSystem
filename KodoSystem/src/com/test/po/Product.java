package com.test.po;

public class Product {
	private Integer pro_no;
	private String pro_id;
	private String pro_name;
	private Double pro_price;
	private Integer pro_number;
	private String pro_description;
	private String pro_material;
	
	
	public Integer getPro_no() {
		return pro_no;
	}
	public void setPro_no(Integer pro_no) {
		this.pro_no = pro_no;
	}
	public String getPro_id() {
		return pro_id;
	}
	public void setPro_id(String pro_id) {
		this.pro_id = pro_id;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public Double getPro_price() {
		return pro_price;
	}
	public void setPro_price(Double pro_price) {
		this.pro_price = pro_price;
	}
	public Integer getPro_number() {
		return pro_number;
	}
	public void setPro_number(Integer pro_number) {
		this.pro_number = pro_number;
	}
	public String getPro_description() {
		return pro_description;
	}
	public void setPro_description(String pro_description) {
		this.pro_description = pro_description;
	}
	public String getPro_material() {
		return pro_material;
	}
	public void setPro_material(String pro_material) {
		this.pro_material = pro_material;
	}
	public Product(Integer pro_no, String pro_id, String pro_name, Double pro_price, Integer pro_number,
			String pro_description, String pro_material) {
		super();
		this.pro_no = pro_no;
		this.pro_id = pro_id;
		this.pro_name = pro_name;
		this.pro_price = pro_price;
		this.pro_number = pro_number;
		this.pro_description = pro_description;
		this.pro_material = pro_material;
	}
	public Product() {
		super();
	}
	@Override
	public String toString() {
		return "Product [pro_no=" + pro_no + ", pro_id=" + pro_id + ", pro_name=" + pro_name + ", pro_price="
				+ pro_price + ", pro_number=" + pro_number + ", pro_description=" + pro_description + ", pro_material="
				+ pro_material + "]";
	}
	
}
