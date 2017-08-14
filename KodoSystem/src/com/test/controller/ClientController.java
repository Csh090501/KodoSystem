package com.test.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.po.Client;
import com.test.service.ClientService;
import com.test.util.Pager;
import com.test.util.GetRandom;

@Controller
@RequestMapping("/client")
public class ClientController {
	private ClientService clientService;
	public ClientService getClientService() {
		return clientService;
	}
	@Autowired
	public void setClientService(ClientService clientService) {
		this.clientService = clientService;
	}
	/**
	 *通过前台传的当前页面值和每页显示的数据条数，进行分页查询
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getClients.do")
	public @ResponseBody Map getUser(HttpServletRequest request) throws Exception{	
		Pager pager = new Pager(Integer.parseInt(request.getParameter("page")),Integer.parseInt(request.getParameter("rows")));
		Map<String , Object> hashMap = new HashMap<String, Object>();
		hashMap.put("id", request.getParameter("id"));
		hashMap.put("name", request.getParameter("name"));
		hashMap.put("sex", request.getParameter("sex"));
		hashMap.put("start", pager.startData());
		hashMap.put("end", pager.endData());
		List<Client> clients = this.clientService.getClients(hashMap);
		int total = this.clientService.clientCount(hashMap);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("rows", clients);
		map.put("total", total);
		return map;
	}
	/**
	 * ͨ通过前台传的客户编号进行批量删除
	 * @param delNos
	 * @return
	 */
	@RequestMapping("/clientDelete.do")
	public @ResponseBody Map ClientDelete(@RequestParam(value="delNos")String[] delNos){
		System.out.println(delNos);
		int delNums = this.clientService.deleteClients(delNos);
		System.out.println(delNums);
		Map<String, Object> map = new HashMap<String, Object>();
		if(delNums>0){
			map.put("success", "true");
			map.put("delNums", delNums);
		}else{
			map.put("errorMsg", "ɾ��ʧ�ܣ�");
		}
		return map;
	}
	/**
	 *通过前台传过来的客户信息进行存储
	 * @param client
	 * @return
	 */
	@RequestMapping("/clientSave.do")
	public @ResponseBody Map ClientSave(Client client){
		for(;;){
			//随机生成一个8位数的id
			client.setId(GetRandom.game(8));
			Client cli = this.clientService.selectClient(client.getId());
			if(cli==null){
				break;
			}
		}
		int num = this.clientService.clientSave(client);
		System.out.println(num);
		Map<String, Object> map = new HashMap<String, Object>();
		if(num>0){
			map.put("success", "true");
			map.put("id", client.getId());
		}else{
			map.put("errorMsg", "����ʧ��");
		}
		return map;
	}
	/**
	 * 通过前台传过来的客户编号，对客户信息进行更新操作
	 * @param no
	 * @return
	 */
	@RequestMapping("/clientUpdate.do")
	public @ResponseBody Map ClientUpdate(@RequestParam("no")int no,Client client){
		System.out.println(client);
		client.setNo(no);
		int num = this.clientService.clientUpdate(client);
		System.out.println(num);
		Map<String, Object> map = new HashMap<String, Object>();
		if(num>0){
			map.put("success", "true");
		}else{
			map.put("errorMsg", "����ʧ��");
		}
		return map;
	}
}
