package com.test.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

import com.test.po.Product;

public interface ProductMapper {
	@Select("select * from product where pro_id like concat('%',#{pro_id},'%') and pro_name like concat('%',#{pro_name},'%') order by pro_no desc limit #{start},#{end} ")
	public List<Product> getProducts(Map<String, Object> hashMap);

	@Select("select count(*) from product where pro_id like concat('%',#{pro_id},'%') and pro_name like concat('%',#{pro_name},'%') and pro_material like concat('%',#{pro_material},'%')")
	public int productCount(Map<String, Object> hashMap);

	public int deleteProducts(String[] delNos);

	@Insert("insert into product values(null,#{pro_id},#{pro_name},#{pro_price},#{pro_number},#{pro_description},#{pro_material})")
	public int productSave(Product product);

	@Update("update product set pro_id=#{pro_id},pro_name=#{pro_name},pro_price=#{pro_price},pro_number=#{pro_number},pro_description=#{pro_description},pro_material=#{pro_material} where pro_no=#{pro_no}")
	public int productUpdate(Product product);

	@Select("select pro_name from product")
	public List<String> getProList();

	@Select("select pro_number from product where pro_name=#{pro_name}")
	public int getProNumber(String pro_name);

	@Update("update product set pro_number=#{pro_number} where pro_name=#{pro_name}")
	public int updateNum(Product product);
}
