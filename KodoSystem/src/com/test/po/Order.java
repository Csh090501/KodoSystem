package com.test.po;

public class Order {
	private Integer ord_no;
	private String ord_id;
	private String ord_client;
	private String ord_address;
	private String ord_date;
	private String ord_pro_name;
	private Double ord_pro_price;
	private Integer ord_number;
	private Double ord_tot_price;
	private String ord_status;

	public Integer getOrd_no() {
		return ord_no;
	}

	public void setOrd_no(Integer ord_no) {
		this.ord_no = ord_no;
	}

	public String getOrd_id() {
		return ord_id;
	}

	public void setOrd_id(String ord_id) {
		this.ord_id = ord_id;
	}
	
	public String getOrd_client() {
		return ord_client;
	}

	public void setOrd_client(String ord_client) {
		this.ord_client = ord_client;
	}

	public String getOrd_address() {
		return ord_address;
	}

	public void setOrd_address(String ord_address) {
		this.ord_address = ord_address;
	}

	public String getOrd_date() {
		return ord_date;
	}

	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}

	public String getOrd_pro_name() {
		return ord_pro_name;
	}

	public void setOrd_pro_name(String ord_pro_name) {
		this.ord_pro_name = ord_pro_name;
	}

	public Double getOrd_pro_price() {
		return ord_pro_price;
	}

	public void setOrd_pro_price(Double ord_pro_price) {
		this.ord_pro_price = ord_pro_price;
	}

	public Integer getOrd_number() {
		return ord_number;
	}

	public void setOrd_number(Integer ord_number) {
		this.ord_number = ord_number;
	}

	public Double getOrd_tot_price() {
		return ord_tot_price;
	}

	public void setOrd_tot_price(Double ord_tot_price) {
		this.ord_tot_price = ord_tot_price;
	}

	public String getOrd_status() {
		return ord_status;
	}

	public void setOrd_status(String ord_status) {
		this.ord_status = ord_status;
	}

	@Override
	public String toString() {
		return "Order [ord_no=" + ord_no + ", ord_id=" + ord_id
				+ ", ord_client=" + ord_client + ", ord_address=" + ord_address
				+ ", ord_date=" + ord_date + ", ord_pro_name=" + ord_pro_name
				+ ", ord_pro_price=" + ord_pro_price + ", ord_number="
				+ ord_number + ", ord_tot_price=" + ord_tot_price
				+ ", ord_status=" + ord_status + "]";
	}
}