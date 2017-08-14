package com.test.service;

import com.test.po.Material;
import com.test.util.DataGridResult;

public interface MaterialServiceInf {
	//获取所有原材料信息
	public DataGridResult getMaterial();
	//通过编号能够进行批量删除材料信息
	public boolean deleteMaterial(String[] delIds);
	//修改材料信息
	public boolean modifyMaterial(Material Material);
	//添加一种新型材料
	public boolean addMaterial(Material Material);
	//根据条件进行模糊查询
	public DataGridResult searchMaterial(Material Material);
}
