package com.test.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.mapper.SupplierMapper;
import com.test.po.Supplier;

@Service
public class SupplierService implements SupplierServiceInf{
	private SupplierMapper supplierMapper;
	public SupplierMapper getSupplierMapper() {
		return supplierMapper;
	}
    @Autowired
	public void setSupplierMapper(SupplierMapper supplierMapper) {
		this.supplierMapper = supplierMapper;
	}
    @Override
	public List<Supplier> getSuppliers(Map<String,Object> hashMap) {
		return this.supplierMapper.getSuppliers(hashMap);
	}
	@Override
	public int supplierCount(Map<String,Object> hashMap) {
		return this.supplierMapper.supplierCount(hashMap);
	}
	@Override
	public int deleteSuppliers(String[] delNos) {
		return this.supplierMapper.deleteSuppliers(delNos);
	}
	@Override
	public int supplierSave(Supplier supplier) {
		return this.supplierMapper.supplierSave(supplier);
	}
	@Override
	public int supplierUpdate(Supplier supplier) {
		return this.supplierMapper.supplierUpdate(supplier);
	}
}
