package com.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.po.Material;
import com.test.service.MaterialServiceInf;
import com.test.util.DataGridResult;

@Controller
@RequestMapping("/material")
public class MaterialController {
	//自动注入
	@Autowired
	private MaterialServiceInf MaterialServiceInf;
	
	//获取所有当前原材料信息
	@RequestMapping("getMaterial")
	@ResponseBody
	public DataGridResult getMaterial(){
		return MaterialServiceInf.getMaterial();	
	}
	//ͨ通过前台传来的编号来删除原材料信息
	@RequestMapping("deleteMaterial")
	@ResponseBody
	public boolean deleteMaterial(String[] delIds){
		System.out.println("��Ӧ�ɹ�");
		return MaterialServiceInf.deleteMaterial(delIds);	
	}
	//修改材料信息
	@RequestMapping("modifyMaterial")
	@ResponseBody
	public boolean modifyMaterial(Material Material){
		return MaterialServiceInf.modifyMaterial(Material);	
	}
	//添加一种新型材料
	@RequestMapping("addMaterial")
	@ResponseBody
	public boolean addMaterial(Material Material){
		System.out.println(Material.getMat_id());
		return MaterialServiceInf.addMaterial(Material);	
	}
	//根据前台传的条件进行模糊查询
	@RequestMapping("searchMaterial")
	@ResponseBody
	public DataGridResult searchMaterial(Material material){
		return MaterialServiceInf.searchMaterial(material);	
	}
	
}
