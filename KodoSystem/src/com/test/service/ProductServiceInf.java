package com.test.service;

import java.util.List;
import java.util.Map;

import com.test.po.Product;

public interface ProductServiceInf {
	public List<Product> getProducts(Map<String, Object> hashMap);

	public int productCount(Map<String, Object> hashMap);

	public int deleteProducts(String[] delNos);

	public int productSave(Product product);

	public int productUpdate(Product product);

	public List<String> getProList();
	
	public int getProNumber(String pro_name);
}
