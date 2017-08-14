package com.test.service;

import java.util.Map;

import com.test.po.Input;
import com.test.util.DataGridResult;

public interface InputServiceInf {
	public DataGridResult getInput();
	public boolean deleteInput(String[] delIds);
	public boolean modifyInput(Input Input);
	public boolean addInput(Input Input);
	public DataGridResult searchInput(Map<String, Object> map);
}
