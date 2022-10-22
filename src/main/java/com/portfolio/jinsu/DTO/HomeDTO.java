package com.portfolio.jinsu.DTO;

public class HomeDTO {

	String seq;
	String table;	
	String title;
	String introduce;
	String filePath1;
	String filePath2;
	String filePath3;
	String link;
	String regdate;
		
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getFilePath1() {
		return filePath1;
	}
	public void setFilePath1(String filePath1) {
		this.filePath1 = filePath1;
	}
	public String getFilePath2() {
		return filePath2;
	}
	public void setFilePath2(String filePath2) {
		this.filePath2 = filePath2;
	}
	public String getFilePath3() {
		return filePath3;
	}
	public void setFilePath3(String filePath3) {
		this.filePath3 = filePath3;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "HomeDTO [seq=" + seq + ", table=" + table + ", title=" + title + ", introduce=" + introduce
				+ ", filePath1=" + filePath1 + ", filePath2=" + filePath2 + ", filePath3=" + filePath3 + ", link="
				+ link + ", regdate=" + regdate + "]";
	}
}
