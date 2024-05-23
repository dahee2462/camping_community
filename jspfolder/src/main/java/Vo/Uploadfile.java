package Vo;

public class Uploadfile {

	//필드명
	private int fno;
	private String frealNm;
	private String foriginNm;
	private String frdate;	//Date->String
	private int bno;	//게시글번호 FK
	
	//게터세터
	public int getFno() {
		return fno;
	}
	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getFrealNm() {
		return frealNm;
	}
	public void setFrealNm(String frealNm) {
		this.frealNm = frealNm;
	}

	public String getForiginNm() {
		return foriginNm;
	}
	public void setForiginNm(String foriginNm) {
		this.foriginNm = foriginNm;
	}
	public String getFrdate() {
		return frdate;
	}
	public void setFrdate(String frdate) {
		this.frdate = frdate;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}

	
}
