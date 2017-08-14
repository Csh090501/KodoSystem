package com.test.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;

import com.test.po.Input;

public interface InputMapper {
	List<Map<String, Object>> getInput();

	Boolean deleteInput(String[] delIds);

	Boolean modifyInput(Input Input);
	@Insert("insert into input values(null,#{inp_id},#{inp_date},#{inp_mat_name},#{inp_price},#{inp_number},#{inp_tot_price})")
	Boolean addInput(Input Input);

	List<Map<String, Object>> searchInput(Map<String, Object> map);
}
