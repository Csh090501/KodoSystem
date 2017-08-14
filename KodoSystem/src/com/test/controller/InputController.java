package com.test.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.po.Input;
import com.test.service.InputServiceInf;
import com.test.util.DataGridResult;

@Controller
@RequestMapping("/input")
public class InputController {

	@Autowired
	private InputServiceInf inputServiceInf;
	
	@RequestMapping("getInput")
	@ResponseBody
	public DataGridResult getInput(){
		return inputServiceInf.getInput();
	}
	@RequestMapping("deleteInput")
	@ResponseBody
	public boolean deleteInput(String[] delIds){
		return inputServiceInf.deleteInput(delIds);
	}
	@RequestMapping("modifyInput")
	@ResponseBody
	public boolean modifyInput(Input input){
		System.out.println(input);
		return inputServiceInf.modifyInput(input);	
	}
	@RequestMapping("addInput")
	@ResponseBody
	public boolean addInput(Input input){
		System.out.println(input.getInp_id());
		return inputServiceInf.addInput(input);	
	}
	@RequestMapping("searchInput")
	@ResponseBody
	public DataGridResult searchInput(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("inp_id", request.getParameter("inp_id"));
		map.put("inp_name", request.getParameter("inp_name"));
		map.put("inp_stime", request.getParameter("inp_stime"));
		map.put("inp_etime", request.getParameter("inp_etime"));
		System.out.println(map);
		return inputServiceInf.searchInput(map);	
	}
}
