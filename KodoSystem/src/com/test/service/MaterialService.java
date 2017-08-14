package com.test.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.mapper.MaterialMapper;
import com.test.po.Material;
import com.test.util.DataGridResult;

@Service
public class MaterialService implements MaterialServiceInf{
	//自动注入
	@Autowired
	private MaterialMapper materialDao;
	//获取所有原材料信息
	@Override
	public DataGridResult getMaterial() {
			List<Map<String,Object>> rows = materialDao.getMaterial();
			DataGridResult datagridresult = new DataGridResult(new Long(rows.size()), rows);
			return datagridresult;
		}
	//通过编号能够进行批量删除材料信息
	@Override
	public boolean deleteMaterial(String[] delIds) {
		// TODO Auto-generated method stub
		return materialDao.deleteMaterial(delIds);
	}
	//修改材料信息
	@Override
	public boolean modifyMaterial(Material Material) {
		// TODO Auto-generated method stub
		return materialDao.modifyMaterial(Material);
	}
	//添加一种新型材料
	@Override
	public boolean addMaterial(Material Material) {
		// TODO Auto-generated method stub
		return materialDao.addMaterial(Material);
	}
	//根据条件进行模糊查询
	@Override
	public DataGridResult searchMaterial(Material material) {
		// TODO Auto-generated method stub
		List<Map<String,Object>> rows = materialDao.searchMaterial(material);
		DataGridResult datagridresult = new DataGridResult(new Long(rows.size()), rows);
		return datagridresult;
	}
}
