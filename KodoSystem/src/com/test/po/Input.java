package com.test.po;

/*
 * ������ⵥ
 */
public class Input {
	private int inp_no; // 入库单编号
	private String inp_id; // 入库单id
	private String inp_date;  // 入库单日期
	private String inp_mat_name; // 入库单材料名
	private float inp_price;     //入库材料单价
	private int inp_number; // 入库单材料数量
	private float inp_tot_price;// 入库单所花费用

	public int getInp_no() {
		return inp_no;
	}

	public void setInp_no(int inp_no) {
		this.inp_no = inp_no;
	}

	public String getInp_id() {
		return inp_id;
	}

	public String getInp_date() {
		return inp_date;
	}

	public void setInp_date(String inp_date) {
		this.inp_date = inp_date;
	}

	public String getInp_mat_name() {
		return inp_mat_name;
	}

	public void setInp_mat_name(String inp_mat_name) {
		this.inp_mat_name = inp_mat_name;
	}
    
	public float getInp_price() {
		return inp_price;
	}

	public void setInp_price(float inp_price) {
		this.inp_price = inp_price;
	}

	public int getInp_number() {
		return inp_number;
	}

	public void setInp_number(int inp_number) {
		this.inp_number = inp_number;
	}

	public float getInp_tot_price() {
		return inp_tot_price;
	}

	public void setInp_tot_price(float inp_tot_price) {
		this.inp_tot_price = inp_tot_price;
	}

	public void setInp_id(String inp_id) {
		this.inp_id = inp_id;
	}

	@Override
	public String toString() {
		return "Input [inp_no=" + inp_no + ", inp_id=" + inp_id + ", inp_date="
				+ inp_date + ", inp_mat_name=" + inp_mat_name + ", inp_price="
				+ inp_price + ", inp_number=" + inp_number + ", inp_tot_price="
				+ inp_tot_price + "]";
	}
}
