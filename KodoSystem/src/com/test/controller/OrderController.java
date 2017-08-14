package com.test.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.po.Client;
import com.test.po.Order;
import com.test.po.Product;
import com.test.service.ClientService;
import com.test.service.OrderService;
import com.test.util.GetRandom;
import com.test.util.Pager;

@Controller
@RequestMapping("/order")
public class OrderController {
	private OrderService orderService;
	public OrderService getOrderService() {
		return orderService;
	}
	@Autowired
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	@RequestMapping("/getOrders.do")
	public @ResponseBody Map getUser(HttpServletRequest request) throws Exception {
		Pager pager = new Pager(Integer.parseInt(request.getParameter("page")),
				Integer.parseInt(request.getParameter("rows")));
		Map<String, Object> hashMap = new HashMap<String, Object>();
		hashMap.put("ord_id", request.getParameter("ord_id"));
		hashMap.put("ord_stime", request.getParameter("ord_stime"));
		hashMap.put("ord_etime", request.getParameter("ord_etime"));
		hashMap.put("start", pager.startData());
		hashMap.put("end", pager.endData());
		System.out.println(hashMap);
		List<Order> orders = this.orderService.getOrders(hashMap);
		int total = this.orderService.orderCount(hashMap);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rows", orders);
		map.put("total", total);
		return map;
	}

	@RequestMapping("/orderDelete.do")
	public @ResponseBody Map OrderDelete(@RequestParam(value = "delNos") String[] delNos) {
		int delNums = this.orderService.deleteOrders(delNos);
		Map<String, Object> map = new HashMap<String, Object>();
		if (delNums > 0) {
			map.put("success", "true");
			map.put("delNums", delNums);
		} else {
			map.put("errorMsg", "删除失败");
		}
		return map;
	}

	@RequestMapping("/orderSave.do")
	public @ResponseBody Map OrderSave(Order order) {
		System.out.println(order);
		for(;;){
			//随机生成一个10位数的订单号
			order.setOrd_id(GetRandom.game(10));
			//验证该订单号是否已经存在
			Order ord = this.orderService.selectOrder(order.getOrd_id());
			//若不存在则跳出循环
			if(ord==null){
				break;
			}
		}
		//判断是否存在该客户
		Client client = this.orderService.selectClient(order.getOrd_client());
		int num=0;
		if(client!=null){
			//生成订单
			order.setOrd_address(client.getAddress());
			int num2 = this.orderService.orderSave(order);
	        num = num2;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		if (num > 0) {
			map.put("success", "true");
		} 
		else {
			map.put("errorMsg", "保存失败,可能是不存在该客户id");
		}
		return map;
	}

	@RequestMapping("/orderUpdate.do")
	public @ResponseBody Map OrderUpdate(@RequestParam("ord_no") int ord_no, Order order) {
		System.out.println(order);
		order.setOrd_no(ord_no);
		int num = this.orderService.orderUpdate(order);
		System.out.println(num);
		Map<String, Object> map = new HashMap<String, Object>();
		if (num > 0) {
			map.put("success", "true");
		} else {
			map.put("errorMsg", "保存失败");
		}
		return map;
	}
	
	@RequestMapping("/orderReceive.do")
	public @ResponseBody int OrderReceive(Order order){
		int i = this.orderService.orderReceive(order);
		return i;
	}
	
	@RequestMapping("/orderFinish.do")
	public @ResponseBody int OrderFinish(Order order){
		System.out.println(order);
		int i = this.orderService.orderFinish(order);
		return i;
	}
	@RequestMapping("/orderFind.do")
	@ResponseBody
	public Double OrderFind(Product product){
		return orderService.orderFind(product);
	}
}
