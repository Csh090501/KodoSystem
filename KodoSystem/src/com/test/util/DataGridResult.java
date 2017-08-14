package com.test.util;

import java.util.List;

/**
 * 封装为easyui-datagrid格式
 * @author caleb
 *
 */
public class DataGridResult {
	private long total; // ����
	private List<?> rows; //��¼
	
	public DataGridResult(Long total, List<?> rows) {
		this.total = total;
		this.rows = rows;
	}
	
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	public List<?> getRows() {
		return rows;
	}
	public void setRows(List<?> rows) {
		this.rows = rows;
	}
}
