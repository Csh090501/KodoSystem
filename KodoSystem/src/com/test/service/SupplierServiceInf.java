package com.test.service;

import java.util.List;
import java.util.Map;

import com.test.po.Supplier;

public interface SupplierServiceInf {
	public List<Supplier> getSuppliers(Map<String,Object> hashMap);

	public int supplierCount(Map<String,Object> hashMap);

	public int deleteSuppliers(String[] delNos);

	public int supplierSave(Supplier supplier);

	public int supplierUpdate(Supplier supplier);
}
