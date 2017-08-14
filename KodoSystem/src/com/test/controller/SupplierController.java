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

import com.test.po.Supplier;
import com.test.service.SupplierService;
import com.test.util.Pager;

@Controller
@RequestMapping("/supplier")
public class SupplierController {
	private SupplierService supplierService;
	public SupplierService getSupplierService() {
		return supplierService;
	}
	@Autowired
	public void setSupplierService(SupplierService supplierService) {
		this.supplierService = supplierService;
	}
	/**
	 *通过前台传的当前页面值和每页显示的数据条数，进行分页查询
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getSuppliers.do")
	public @ResponseBody Map getUser(HttpServletRequest request) throws Exception{	
		Pager pager = new Pager(Integer.parseInt(request.getParameter("page")),Integer.parseInt(request.getParameter("rows")));
		Map<String , Object> hashMap = new HashMap<String, Object>();
		hashMap.put("sup_id", request.getParameter("sup_id"));
		hashMap.put("sup_name", request.getParameter("sup_name"));
		hashMap.put("start", pager.startData());
		hashMap.put("end", pager.endData());
		List<Supplier> suppliers = this.supplierService.getSuppliers(hashMap);
		int total = this.supplierService.supplierCount(hashMap);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("rows", suppliers);
		map.put("total", total);
		return map;
	}
	/**
	 *通过前台传的客户编号进行批量删除
	 * @param delNos
	 * @return
	 */
	@RequestMapping("/supplierDelete.do")
	public @ResponseBody Map SupplierDelete(@RequestParam(value="delNos")String[] delNos){
		System.out.println(delNos);
		int delNums = this.supplierService.deleteSuppliers(delNos);
		System.out.println(delNums);
		Map<String, Object> map = new HashMap<String, Object>();
		if(delNums>0){
			map.put("success", "true");
			map.put("delNums", delNums);
		}else{
			map.put("errorMsg", "删除失败！");
		}
		return map;
	}
	/**
	 * 通过前台传过来的客户信息进行存储
	 * @param client
	 * @return
	 */
	@RequestMapping("/supplierSave.do")
	public @ResponseBody Map SupplierSave(Supplier supplier){
		System.out.println(supplier);
		int num = this.supplierService.supplierSave(supplier);
		System.out.println(num);
		Map<String, Object> map = new HashMap<String, Object>();
		if(num>0){
			map.put("success", "true");
		}else{
			map.put("errorMsg", "保存失败");
		}
		return map;
	}
	/**
	 * 通过前台传过来的客户编号，对客户信息进行更新操作
	 * @param no
	 * @return
	 */
	@RequestMapping("/supplierUpdate.do")
	public @ResponseBody Map SupplierUpdate(@RequestParam("sup_no")int sup_no,Supplier supplier){
		System.out.println(supplier);
		System.out.println(sup_no);
		supplier.setSup_no(sup_no);
		int num = this.supplierService.supplierUpdate(supplier);
		System.out.println(num);
		Map<String, Object> map = new HashMap<String, Object>();
		if(num>0){
			map.put("success", "true");
		}else{
			map.put("errorMsg", "保存失败");
		}
		return map;
	}
}
