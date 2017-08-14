package com.test.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.mapper.ClientMapper;
import com.test.mapper.OrderMapper;
import com.test.mapper.ProductMapper;
import com.test.po.Client;
import com.test.po.Order;
import com.test.po.Product;

@Service
public class OrderService implements OrderServiceInf {
	@Autowired
	private ProductMapper productMapper;
	@Autowired
	private ClientMapper clientMapper;
	private OrderMapper orderMapper;
	public OrderMapper getOrderMapper() {
		return orderMapper;
	}
	@Autowired
	public void setOrderMapper(OrderMapper orderMapper) {
		this.orderMapper = orderMapper;
	}

	// 根据需要分页显示订单信息
	@Override
	public List<Order> getOrders(Map<String,Object> hashMap) {
		return this.orderMapper.getOrders(hashMap);
	}

	// 获取订单的总数
	@Override
	public int orderCount(Map<String, Object> hashMap) {
		return this.orderMapper.orderCount(hashMap);
	}

	// 通过订单编号进行批量删除信息
	@Override
	public int deleteOrders(String[] delNos) {
		return this.orderMapper.deleteOrders(delNos);
	}

	// 保存订单信息
	@Override
	public int orderSave(Order order) {
		order.setOrd_status("未接收");
		order.setOrd_date(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		order.setOrd_tot_price(order.getOrd_pro_price() * order.getOrd_number());
		return this.orderMapper.orderSave(order);
	}

	// 更新订单信息
	@Override
	public int orderUpdate(Order order) {
		order.setOrd_tot_price(order.getOrd_pro_price()*order.getOrd_number());
		return this.orderMapper.orderUpdate(order);
	}

	@Override
	public int orderReceive(Order order) {
		if(order.getOrd_status().equals("未接收")){
			order.setOrd_status("已接收");
			int i = this.orderMapper.OrderReceiveOrFinish(order);
			return i;
		}else{
			return 0;
		}
	}
	@Override
	public int orderFinish(Order order) {
		if(order.getOrd_status().equals("已接收")){
			int proNum = this.productMapper.getProNumber(order.getOrd_pro_name());
			if(order.getOrd_number()<=proNum){
				order.setOrd_status("已完成");
				int i = this.orderMapper.OrderReceiveOrFinish(order);
				Product product = new Product();
				product.setPro_number(proNum-order.getOrd_number());
				product.setPro_name(order.getOrd_pro_name());
				this.productMapper.updateNum(product);
				return i;
			}else{
				return 0;
			}
		}else{
			return 0;
		}
	}
	@Override
	public Client selectClient(String ord_client) {
		return this.clientMapper.selectClient(ord_client);
	}
	@Override
	public Order selectOrder(String ord_id) {
		return this.orderMapper.selectOrder(ord_id);
	}
	@Override
	public Double orderFind(Product product) {
		// TODO Auto-generated method stub
		return orderMapper.orderFind(product);
	}
}
