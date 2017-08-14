package com.test.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.mapper.ClientMapper;
import com.test.po.Client;
import com.test.util.GetRandom;

@Service
public class ClientService implements ClientServiceInf{
	private ClientMapper clientMapper;
	public ClientMapper getClientMapper() {
		return clientMapper;
	}
	//自动注入
    @Autowired
	public void setClientMapper(ClientMapper clientMapper) {
		this.clientMapper = clientMapper;
	}
    //根据需要分页显示客户信息
    @Override
	public List<Client> getClients(Map<String,Object> hashMap) {
		return this.clientMapper.getClients(hashMap);
	}
    //获取客户的总数
	@Override
	public int clientCount(Map<String, Object> hashMap) {
		return this.clientMapper.clientCount(hashMap);
	}
	//通过客户编号进行批量删除信息
	@Override
	public int deleteClients(String[] delNos) {
		return this.clientMapper.deleteClients(delNos);
	}
	//保存客户信息
	@Override
	public int clientSave(Client client) {
		return this.clientMapper.clientSave(client);
	}
	//更新客户信息
	@Override
	public int clientUpdate(Client client) {
		//通过前台传过来的客户编号获取客户信息
		return this.clientMapper.clientUpdate(client);
	}
	@Override
	public Client selectClient(String id) {
		return this.clientMapper.selectClient(id);
	}

}
