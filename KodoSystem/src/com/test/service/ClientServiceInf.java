package com.test.service;

import java.util.List;
import java.util.Map;

import com.test.po.Client;

public interface ClientServiceInf {
	// 根据需要分页显示客户信息
	public List<Client> getClients(Map<String, Object> hashMap);
	//获取客户的总数
	public int clientCount(Map<String, Object> hashMap);
	//通过客户编号进行批量删除信息
	public int deleteClients(String[] delNos);
	//保存客户信息
	public int clientSave(Client client);
	//更新客户信息
	public int clientUpdate(Client client);
	//通过客户id判断是否存在该客户
	public Client selectClient(String id);
}
