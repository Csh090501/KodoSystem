package com.test.po;

public class Client {
	private Integer no; // 客户编号
	private String id; // 客户id
	private String name; // 客户名称
	private String sex; // 客户性别
	private String phone; // 客户联系方式
	private String address;  // 地址信息

	public Integer getNo() {
		return no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "Client [no=" + no + ", id=" + id + ", name=" + name + ", sex="
				+ sex + ", phone=" + phone + ", address=" + address + "]";
	}
}
