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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.test.po.Product;
import com.test.service.ProductService;
import com.test.util.Pager;

@Controller
@RequestMapping("/product")
public class ProductController {
	private ProductService productService;
	public ProductService getProductService() {
		return productService;
	}
	@Autowired
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}
	/**
	 * 閫氳繃鍓嶅彴浼犵殑褰撳墠椤甸潰鍊煎拰姣忛〉鏄剧ず鐨勬暟鎹潯鏁帮紝杩涜鍒嗛〉鏌ヨ
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getProducts")
	public @ResponseBody Map<String, Object> getUser(HttpServletRequest request) throws Exception{	
		Pager pager = new Pager(Integer.parseInt(request.getParameter("page")),Integer.parseInt(request.getParameter("rows")));
		Map<String , Object> hashMap = new HashMap<String, Object>();
		hashMap.put("pro_id", request.getParameter("pro_id"));
		hashMap.put("pro_name", request.getParameter("pro_name"));
		hashMap.put("start", pager.startData());
		hashMap.put("end", pager.endData());
		List<Product> products = this.productService.getProducts(hashMap);
		int total = this.productService.productCount(hashMap);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("rows", products);
		map.put("total", total);
		return map;
	}
	/**
	 * 閫氳繃鍓嶅彴浼犵殑瀹㈡埛缂栧彿杩涜鎵归噺鍒犻櫎
	 * @param delNos
	 * @return
	 */
	@RequestMapping("/productDelete.do")
	public @ResponseBody Map<String, Object> ProductDelete(@RequestParam(value="delNos")String[] delNos){
		System.out.println(delNos);
		int delNums = this.productService.deleteProducts(delNos);
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
	 * 閫氳繃鍓嶅彴浼犺繃鏉ョ殑瀹㈡埛淇℃伅杩涜瀛樺偍
	 * 
	 * @param product
	 * @return
	 */
	@RequestMapping("productSave")
	@ResponseBody
	public Map<String, Object> productSave(Product product) {
		int pro_number = this.productService.productSave(product);
		System.out.println(pro_number);
		Map<String, Object> map = new HashMap<String, Object>();
		if (pro_number > 0) {
			map.put("success", "true");
		}else{
			map.put("errorMsg", "保存失败");
		}
		return map;
	}
	/**
	 * 閫氳繃鍓嶅彴浼犺繃鏉ョ殑瀹㈡埛缂栧彿锛屽瀹㈡埛淇℃伅杩涜鏇存柊鎿嶄綔
	 * @param no
	 * @return
	 */
	@RequestMapping("/productUpdate.do")
	public @ResponseBody Map<String, Object> ProductUpdate(@RequestParam("pro_no")int pro_no,Product product){
		System.out.println(product);
		product.setPro_no(pro_no);
		int num = this.productService.productUpdate(product);
		System.out.println(num);
		Map<String, Object> map = new HashMap<String, Object>();
		if(num>0){
			map.put("success", "true");
		}else{
			map.put("errorMsg", "保存失败");
		}
		return map;
	}
	
	@RequestMapping("/getProductCombobox.do")
	public @ResponseBody JSONArray getProductCombobox(){
		Map<String, String> map = new HashMap<String, String>();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("ord_pro_name", "请选择...");
		JSONArray jsonArray = new JSONArray();
		jsonArray.add(jsonObject);
		List<String> list = this.productService.getProList();
		for(String s:list){
			JSONObject jsonObject2 = new JSONObject();
			jsonObject2.put("ord_pro_name", s);
			jsonArray.add(jsonObject2);
		}
		return jsonArray;
	}
}
