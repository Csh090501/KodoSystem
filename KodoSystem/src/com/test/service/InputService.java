package com.test.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.mapper.InputMapper;
import com.test.po.Input;
import com.test.util.DataGridResult;
import com.test.util.StringUtil;

@Service
public class InputService implements InputServiceInf {

	@Autowired
	private InputMapper inputDao;

	@Override
	public DataGridResult getInput() {
		List<Map<String, Object>> rows = inputDao.getInput();
		System.out.println(rows);
		DataGridResult datagridresult = new DataGridResult(
				new Long(rows.size()), rows);
		return datagridresult;
	}

	@Override
	public boolean deleteInput(String[] delIds) {
		return inputDao.deleteInput(delIds);
	}

	@Override
	public boolean addInput(Input input) {
		input.setInp_date(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		input.setInp_tot_price(input.getInp_price()*input.getInp_number());
		return inputDao.addInput(input);
	}

	@Override
	public DataGridResult searchInput(Map<String, Object> map) {
			List<Map<String, Object>> rows = inputDao.searchInput(map);
			DataGridResult datagridresult = new DataGridResult(
					new Long(rows.size()), rows);
			return datagridresult;
	}

	@Override
	public boolean modifyInput(Input input) {
		System.out.println(input);
		input.setInp_tot_price(input.getInp_price()*input.getInp_number());
		return inputDao.modifyInput(input);
	}
}
