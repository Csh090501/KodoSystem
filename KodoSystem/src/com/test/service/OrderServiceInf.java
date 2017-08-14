package com.test.service;

import java.util.List;
import java.util.Map;

import com.test.po.Client;
import com.test.po.Order;
import com.test.po.Product;

;

public interface OrderServiceInf {
	public List<Order> getOrders(Map<String, Object> hashMap);

	public int orderCount(Map<String, Object> hashMap);

	public int orderSave(Order order);

	public int orderUpdate(Order order);

	public int deleteOrders(String[] delNos);

	public int orderReceive(Order order);

	public int orderFinish(Order order);
	
	public Client selectClient(String ord_client);
	
	public Order selectOrder(String ord_id);
	
	public Double orderFind(Product product);
}
