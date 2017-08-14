package com.test.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.test.po.Supplier;

public interface SupplierMapper {
	@Select("select * from supplier where sup_id like concat('%',#{sup_id},'%') and sup_name like concat('%',#{sup_name},'%')  order by sup_no desc limit #{start},#{end} ")
	public List<Supplier> getSuppliers(Map<String,Object> hashMap);

	// @Select("select count(*) from supplier")
	@Select("select count(*) from supplier where sup_id like concat('%',#{sup_id},'%') and sup_name like concat('%',#{sup_name},'%')")
	public int supplierCount(Map<String,Object> hashMap);

	public int deleteSuppliers(String[] delNos);

	@Insert("insert into supplier values(null,#{sup_id},#{sup_name},#{sup_phone},#{sup_address},#{sup_description})")
	public int supplierSave(Supplier supplier);

	@Update("update supplier set sup_id=#{sup_id},sup_name=#{sup_name},sup_phone=#{sup_phone},sup_address=#{sup_address},sup_description=#{sup_description} where sup_no=#{sup_no}")
	public int supplierUpdate(Supplier supplier);
}
