package Vo;

public class Reply{

	//필드
	private int rno;
	private String rcontent;
	private String rrdate; //Date->String
	private int mno;	//회원번호(FK)
	private int bno;	//게시글번호(FK)
	//필요한 필드 추가
	private String mnickNm;
	private int rgroup;
	private int rorder;
	private int rdepth;
	private int rdelyn;
	private int parentrno;
	private int isAllChildDelyn;
	
	public int getRdelyn() {
		return rdelyn;
	}
	public int getParentrno() {
		return parentrno;
	}
	public void setParentrno(int parentrno) {
		this.parentrno = parentrno;
	}
	public int getIsAllChildDelyn() {
		return isAllChildDelyn;
	}
	public void setIsAllChildDelyn(int isAllChildDelyn) {
		this.isAllChildDelyn = isAllChildDelyn;
	}
	public void setRdelyn(int rdelyn) {
		this.rdelyn = rdelyn;
	}
	public int getRgroup() {
		return rgroup;
	}
	public void setRgroup(int rgroup) {
		this.rgroup = rgroup;
	}
	public int getRorder() {
		return rorder;
	}
	public void setRorder(int rorder) {
		this.rorder = rorder;
	}
	public int getRdepth() {
		return rdepth;
	}
	public void setRdepth(int rdepth) {
		this.rdepth = rdepth;
	}
	//게터세터
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public String getRrdate() {
		return rrdate;
	}
	public void setRrdate(String rrdate) {
		this.rrdate = rrdate;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getMnickNm() {
		return mnickNm;
	}
	public void setMnickNm(String mnickNm) {
		this.mnickNm = mnickNm;
	}
	
}
