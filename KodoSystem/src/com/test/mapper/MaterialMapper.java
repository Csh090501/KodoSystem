package com.test.mapper;

import java.util.List;
import java.util.Map;

import com.test.po.Material;

public interface MaterialMapper {
	//获取原材料信息
	List<Map<String, Object>> getMaterial();
	//通过编号能够进行批量删除材料信息
	Boolean deleteMaterial(String[] delIds);
	//修改材料信息
	Boolean modifyMaterial(Material Material);
	//添加一种新型材料
	Boolean addMaterial(Material Material);
	//根据条件进行模糊查询
	List<Map<String, Object>> searchMaterial(Material Material);
}
