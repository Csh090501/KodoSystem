package com.test.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.test.po.Order;
import com.test.po.Product;;

public interface OrderMapper {
	public List<Order> getOrders(Map<String, Object> hashMap);

	@Select("select count(*) from order_1 where ord_id like concat('%',#{ord_id},'%')")
	public int orderCount(Map<String, Object> hashMap);

	public int deleteOrders(String[] delNos);

	@Insert("insert into order_1 values(null,#{ord_id},#{ord_client},#{ord_address},#{ord_date},#{ord_pro_name},#{ord_pro_price},#{ord_number},#{ord_tot_price},#{ord_status})")
	public int orderSave(Order Order);

	@Update("update order_1 set ord_pro_name=#{ord_pro_name},ord_pro_price=#{ord_pro_price},ord_number=#{ord_number},ord_tot_price=#{ord_tot_price} where ord_no=#{ord_no}")
	public int orderUpdate(Order Order);
	
	@Update("update order_1 set ord_status=#{ord_status} where ord_id=#{ord_id}")
	public int OrderReceiveOrFinish(Order order);
	//判断是否存在该订单号
	@Select("select * from order_1 where ord_id=#{ord_id}")
	public Order selectOrder(String ord_id);
	
	public Double orderFind(Product product);
}
