package regular;

import java.util.regex.Pattern;

public class Regular {
	// 숫자
	public static boolean isNum(String str,int max) {
		return Pattern.matches("^[0-9]{0,"+max+"}$", str);
	}
	// 영어
	public static boolean isEng(String str,int max) {
		return Pattern.matches("^[a-zA-Z]{0,"+ max +"}$", str);
	}
	// 숫자 영어
	public static boolean isNumEng(String str,int max) {
		return Pattern.matches("^[a-zA-Z0-9]{0,"+max+"}$", str);
	}
	// 숫자영어한글
	public static boolean isNumEngKor(String str,int max) {
		return Pattern.matches("^[a-zA-Z0-9가-힣]{0,"+max+"}$", str);
	}
	// 한글
	public static boolean isKor(String str,int max) {
		return Pattern.matches("^[가-힣]{0,"+max+"}$", str);
	}
	
	// 사용자 패스워드에 대한 정규식 - 대소문자 + 숫자 + 특수문자 조합으로 8 ~ 24자리로 정의 한다.
    public static boolean isPass(String str) {
		return Pattern.matches("^(?=.*[a-zA-Z])((?=.*\\d)|(?=.*\\W)).{8,24}+$", str);
	}
    // 핸드폰 번호 - 3자리 숫자에 대한 정규식
	public static boolean isNum3(String str) {
		return Pattern.matches("^[0-9]{3}$", str);
	}
	// 핸드폰 번호 - 3_4자리 숫자에 대한 정규식
		public static boolean isNum3_4(String str) {
			return Pattern.matches("^[0-9]{3,4}$", str);
	}
	// 핸드폰 번호 - 4자리 숫자에 대한 정규식
	public static boolean isNum4(String str) {
		return Pattern.matches("^[0-9]{4}$", str);
	}
//	아이디 정규식
	public static boolean isId(String str) {
		return Pattern.matches("^[a-z][a-z0-9]{3,20}$", str);
	}
//	비밀번호 정규식
	public static boolean isPw(String str) {
		return Pattern.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*])[a-zA-Z\\d!@#$%^&*]{8,}$", str);
	}
//	닉네임 정규식
	public static boolean isNickNm(String str) {
		return Pattern.matches("^[a-zA-Z가-힣][a-zA-Z가-힣0-9]{3,14}$", str);
	}
//	사용자 이름 정규식
	public static boolean isName(String str) {
		return Pattern.matches("^[가-힣]{2,8}$", str);
	}
//	생년월일 정규식
	public static boolean isBirth(String str) {
		return Pattern.matches("^(19|20)\\d\\d(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$", str);
	}
//	이메일 정규식
	public static boolean isEmail(String str) {
		return Pattern.matches("^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$", str);
	}
	
}
