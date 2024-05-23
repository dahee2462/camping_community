package Vo;


public class Board extends Member {	//Member 부모지정

	//필드
	private int bno;
	private String btitle;
	private String bcontent;
	private String brdate;	//Date -> String
	private Integer bhit;
	private String btype;
	private int mno;	//회원번호 FK
	private int blike;
	
	public int getBlike() {
		return blike;
	}
	public void setBlike(int blike) {
		this.blike = blike;
	}
	//게터세터
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getBrdate() {
		return brdate;
	}
	public void setBrdate(String brdate) {
		this.brdate = brdate;
	}
	public Integer getBhit() {
		return bhit;
	}
	public void setBhit(Integer bhit) {
		this.bhit = bhit;
	}
	public String getBtype() {
		return btype;
	}
	public void setBtype(String btype) {
		this.btype = btype;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	
	
	
}
