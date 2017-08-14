package com.test.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.test.po.Client;

public interface ClientMapper {
	//条件查询
	@Select("select * from client where id like concat('%',#{id},'%') and name like concat('%',#{name},'%') and sex like concat('%',#{sex},'%') order by no desc limit #{start},#{end} ")
    public List<Client> getClients(Map<String , Object> hashMap);
	//条件查询产生的数据量
	@Select("select count(*) from client where id like concat('%',#{id},'%') and name like concat('%',#{name},'%') and sex like concat('%',#{sex},'%')")
	public int clientCount(Map<String, Object> hashMap);
	//通过编号进行批量删除
	public int deleteClients(String[] delNos);
	//存入新客户信息
	@Insert("insert into client values(null,#{id},#{name},#{sex},#{phone},#{address})")
	public int clientSave(Client client);
	//更新客户信息 
	@Update("update client set name=#{name},sex=#{sex},phone=#{phone},address=#{address} where no=#{no}")
	public int clientUpdate(Client client);
	@Select("select * from client where id=#{id}")
	public Client selectClient(String id);
}