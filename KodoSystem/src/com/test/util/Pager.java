package com.test.util;
public class Pager {
	private int pageNow;						//��ǰҳ��
	private int pageSize;						//ÿҳ��ʾ��������¼
	private int totalPage;						//���ж���ҳ
	private int totalSize;						//һ�����ټ�¼
	private boolean hasFirst;					//�Ƿ�����ҳ
	private boolean hasPre;						//�Ƿ���ǰһҳ
	private boolean hasNext;					//�Ƿ�����һҳ
	private boolean hasLast;					//�Ƿ������һҳ
	public Pager(int pageNow,int pageSize){
		//���ù��췽��Ϊ������ֵ
		this.pageNow=pageNow;
		this.pageSize=pageSize;
	}
	public int getPageNow() {
		return pageNow;
	}
	public void setPageNow(int pageNow) {
		this.pageNow = pageNow;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalPage() {
		//һ������ҳ���㷨
		totalPage=getTotalSize()/getPageSize();
		if(totalSize%pageSize!=0)
			totalPage++;
		return totalPage;
	}
	public int startData() {
		return (this.getPageNow()-1)*this.getPageSize();
	}
	public int endData(){
		return this.getPageSize();
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalSize() {
		return totalSize;
	}
	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}
	public boolean isHasFirst() {
		//�����ǰΪ��һҳ��û����ҳ
		if(pageNow==1)
			return false;
		else return true;
	}
	public void setHasFirst(boolean hasFirst) {
		this.hasFirst = hasFirst;
	}
	public boolean isHasPre() {
		//�������ҳ����ǰһҳ����Ϊ����ҳ�Ͳ��ǵ�һҳ
		if(this.isHasFirst())
			return true;
		else return false;
	}
	public void setHasPre(boolean hasPre) {
		this.hasPre = hasPre;
	}
	public boolean isHasNext() {
		//�����βҳ������һҳ����Ϊ��βҳ�����������һҳ
		if(isHasLast())
			return true;
		else return false;
	}
	public void setHasNext(boolean hasNext) {
		this.hasNext = hasNext;
	}
	public boolean isHasLast() {
		//����������һҳ����βҳ
		if(pageNow==this.getTotalPage())
			return false;
		else return true;
	}
	public void setHasLast(boolean hasLast) {
		this.hasLast = hasLast;
	}
}
