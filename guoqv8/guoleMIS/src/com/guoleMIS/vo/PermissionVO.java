package com.guoleMIS.vo;
/**
 * 权限vo
 * @author ken
 * @version 1.0
 * @createtime 2013-6-3
 *		版本		修改者	时间		修改内容
 *
 */
public class PermissionVO {
	private int id;
	private int pid;
	private int tid;
	private String tdetail;
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getTdetail() {
		return tdetail;
	}
	public void setTdetail(String tdetail) {
		this.tdetail = tdetail;
	}
	private String paddr;
	private String addr;
	private String pdetail;
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getPaddr() {
		return paddr;
	}
	public void setPaddr(String paddr) {
		this.paddr = paddr;
	}
	public String getPdetail() {
		return pdetail;
	}
	public void setPdetail(String pdetail) {
		this.pdetail = pdetail;
	}
	private String detail;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	
	
}
