package com.test.po;

public class Supplier {

	private Integer sup_no;
	private String sup_id;
	private String sup_name;
	private String sup_phone;
	private String sup_address;
	private String sup_description;
	public Integer getSup_no() {
		return sup_no;
	}
	public void setSup_no(Integer sup_no) {
		this.sup_no = sup_no;
	}
	public String getSup_id() {
		return sup_id;
	}
	public void setSup_id(String sup_id) {
		this.sup_id = sup_id;
	}
	public String getSup_name() {
		return sup_name;
	}
	public void setSup_name(String sup_name) {
		this.sup_name = sup_name;
	}
	public String getSup_phone() {
		return sup_phone;
	}
	public void setSup_phone(String sup_phone) {
		this.sup_phone = sup_phone;
	}
	public String getSup_address() {
		return sup_address;
	}
	public void setSup_address(String sup_address) {
		this.sup_address = sup_address;
	}
	public String getSup_description() {
		return sup_description;
	}
	public void setSup_description(String sup_description) {
		this.sup_description = sup_description;
	}
	public Supplier(Integer sup_no, String sup_id, String sup_name, String sup_phone, String sup_address,
			String sup_description) {
		super();
		this.sup_no = sup_no;
		this.sup_id = sup_id;
		this.sup_name = sup_name;
		this.sup_phone = sup_phone;
		this.sup_address = sup_address;
		this.sup_description = sup_description;
	}
	@Override
	public String toString() {
		return "Supplier [sup_no=" + sup_no + ", sup_id=" + sup_id + ", sup_name=" + sup_name + ", sup_phone="
				+ sup_phone + ", sup_address=" + sup_address + ", sup_description=" + sup_description + "]";
	}
	public Supplier() {
	}
}
