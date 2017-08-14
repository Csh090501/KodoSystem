package com.test.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.mapper.ProductMapper;
import com.test.po.Product;


@Service
public class ProductService implements ProductServiceInf{
	private ProductMapper productMapper;
	public ProductMapper getProductMapper() {
		return productMapper;
	}
    @Autowired
	public void setProductMapper(ProductMapper productMapper) {
		this.productMapper = productMapper;
	}
    @Override
	public List<Product> getProducts(Map<String,Object> hashMap) {
		return this.productMapper.getProducts(hashMap);
	}
	@Override
	public int productCount(Map<String, Object> hashMap) {
		return this.productMapper.productCount(hashMap);
	}
	@Override
	public int deleteProducts(String[] delNos) {
		return this.productMapper.deleteProducts(delNos);
	}
	@Override
	public int productSave(Product product) {
		return this.productMapper.productSave(product);
	}
	@Override
	public int productUpdate(Product product) {
		return this.productMapper.productUpdate(product);
	}
	@Override
	public List<String> getProList() {
		return this.productMapper.getProList();
	}
	@Override
	public int getProNumber(String pro_name) {
		return 0;
	}

}
