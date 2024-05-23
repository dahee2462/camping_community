	//유효성 검사 개수제한 추가해야함 개수 정해지면 {} 붙이기
	
	
	
	let mpw = document.frm.mpw;
	let mpwRe = document.frm.mpwRe; 
	
	
	let mphone1 = document.frm.mphone1; 
	let mphone2 = document.frm.mphone2; 
	let mphone3 = document.frm.mphone3; 
	
	let memail = document.frm.memail;
	
	
	
	
	
	function checkPw(obj){
		let regId = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,}$/g;
		let regRs = regId.test(obj.value); 
		let mpwTd = document.getElementById("mpwTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mpwTd.innerHTML = '비밀번호를 입력해주세요';
			mpwTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mpwTd.innerHTML ='영문소문자, 영문대문자, 숫자, 특수문자를<br> 사용해야합니다.<br>특수문자는 !,@,#,$,%,^,&,* 만 가능합니다.';
			mpwTd.style.color = 'red';
			return false;
		}else{
			mpwTd.innerHTML = '사용가능합니다.';
			mpwTd.style.color = 'green';
			return true;
		}
	}
	
	function checkPwRe(){
		let confirmPw = mpw.value == mpwRe.value;
		let mpwReTd = document.getElementById("mpwReTd"); 
		if(mpwRe.value == "" || mpwRe.value === null || mpwRe.value === undefined){
			mpwReTd.innerHTML = '비밀번호를 입력해주세요';
			mpwReTd.style.color = 'red';
			return false;
		}else if(!confirmPw){
			mpwReTd.innerHTML = '비밀번호가 같지 않습니다.';
			mpwReTd.style.color = 'red';
			return false;
		}else{
			mpwReTd.innerHTML = '사용가능합니다.';
			mpwReTd.style.color = 'green';
			return true;
		}
	}
	
	
	
	
	
	function checkPhone1(obj){
		let regId = /^\d{3}/g;
		let regRs = regId.test(obj.value); 
		let mphoneTd = document.getElementById("mphoneTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mphoneTd.innerHTML = '전화번호를 입력해주세요.';
			mphoneTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mphoneTd.innerHTML = '3자리숫자만 사용가능합니다.';
			mphoneTd.style.color = 'red';
			return false;
		}else{
			mphoneTd.innerHTML = '사용가능합니다.';
			mphoneTd.style.color = 'green';
			return true;
		}
	}
	
	function checkPhone2(obj){
		let regId = /^\d{3,4}/g;
		let regRs = regId.test(obj.value); 
		let mphoneTd = document.getElementById("mphoneTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mphoneTd.innerHTML = '전화번호를 입력해주세요.';
			mphoneTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mphoneTd.innerHTML = '3,4자리 숫자만 사용가능합니다.';
			mphoneTd.style.color = 'red';
			return false;
		}else{
			mphoneTd.innerHTML = '사용가능합니다.';
			mphoneTd.style.color = 'green';
			return true;
		}
	}
	
	function checkPhone3(obj){
		let regId = /^\d{4}/g;
		let regRs = regId.test(obj.value); 
		let mphoneTd = document.getElementById("mphoneTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mphoneTd.innerHTML = '전화번호를 입력해주세요.';
			mphoneTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mphoneTd.innerHTML = '4자리 숫자만 사용가능합니다.';
			mphoneTd.style.color = 'red';
			return false;
		}else{
			mphoneTd.innerHTML = '사용가능합니다.';
			mphoneTd.style.color = 'green';
			return true;
		}
	}
	
	
	
	function checkEmail(obj){
		let regId = /^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
		let regRs = regId.test(obj.value); 
		let memailTd = document.getElementById("memailTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			memailTd.innerHTML = '이메일을 입력해주세요.';
			memailTd.style.color = 'red';
			return false;
		}else if(!regRs){
			memailTd.innerHTML = '이메일 형식에 맞춰 입력해주쉐요.';
			memailTd.style.color = 'red';
			return false;
		}else{
			memailTd.innerHTML = '사용가능합니다.';
			memailTd.style.color = 'green';
			return true;
		}
	}
	
	function validation(){
		if(checkPw(mpw) & checkPwRe(mpwRe)
			& checkPhone1(mphone1)
			& checkPhone2(mphone2) & checkPhone3(mphone3) 
			& checkEmail(memail)){
				document.frm.submit();	
			}
	}











