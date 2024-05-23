	//유효성 검사 개수제한 추가해야함 개수 정해지면 {} 붙이기
	
	let mid = document.frm.mid;
	let mpw = document.frm.mpw; 
	let mpwRe = document.frm.mpwRe; 
	let mnickNm = document.frm.mnickNm;
	let mname = document.frm.mname; 
	let mbirth = document.frm.mbirth; 
	let mphone1 = document.frm.mphone1; 
	let mphone2 = document.frm.mphone2; 
	let mphone3 = document.frm.mphone3; 
	let mgender = document.frm.mgender; 
	let memail = document.frm.memail;
	let checkIdFlag = false;
	let checkNickNmFlag = false;
	
	function checkId(obj){
		let regId = /^[a-z][a-z0-9]{3,20}$/g;
		let regRs = regId.test(obj.value); 
		let midTd = document.getElementById("midTd");
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			midTd.innerHTML = '아이디를 입력해주세요';
			midTd.style.color = 'red';
			return false;
		}else if(!regRs){
			midTd.innerHTML = '4자 이상, 20이하의 영문(소문자) 및 숫자만 사용가능합니다.';
			midTd.style.color = 'red';
			return false;
		}else{
			midTd.innerHTML = '사용가능합니다.';
			midTd.style.color = 'green';
			return true;
		}
	}

	function checkPw(obj){
		let regId = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,}$/g;
		let regRs = regId.test(obj.value); 
		let mpwTd = document.getElementById("mpwTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mpwTd.innerHTML = '비밀번호를 입력해주세요';
			mpwTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mpwTd.innerHTML ='비밀번호는 8자 이상 영문 소문자, 영문 대문자, 숫자, 특수문자를 사용해야합니다.<br>특수문자는 !,@,#,$,%,^,&,* 만 가능합니다.';
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
		}else if(confirmPw){
			mpwReTd.innerHTML = '비밀번호가 같습니다.';
			mpwReTd.style.color = 'green';
			return true;
		}else{
			return !confirmPw;
		}
	}
	
	function checkNickNm(obj){
		let regId = /^[a-zA-Z가-힣][a-zA-Z가-힣0-9]{3,14}$/g;
		let regRs = regId.test(obj.value); 
		let mnickNmTd = document.getElementById("mnickNmTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mnickNmTd.innerHTML = '닉네임을 입력해주세요';
			mnickNmTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mnickNmTd.innerHTML = '4자 이상 한글, 영문, 숫자만 사용가능합니다.';
			mnickNmTd.style.color = 'red';
			return false;
		}else{
			mnickNmTd.innerHTML = '사용가능합니다.';
			mnickNmTd.style.color = 'green';
			return true;
		}
	}
	
	function checkName(obj){
		let regId = /^[가-힣]{2,8}$/;
		let regRs = regId.test(obj.value); 
		let mnameTd = document.getElementById("mnameTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mnameTd.innerHTML = '이름을 입력해주세요';
			mnameTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mnameTd.innerHTML = '한글만 사용가능합니다.';
			mnameTd.style.color = 'red';
			return false;
		}else{
			mnameTd.innerHTML = '사용가능합니다.';
			mnameTd.style.color = 'green';
			return true;
		}
	}
	
	function checkBirth(obj){
		let regId = /^(19|20)\d\d(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/;
		let regRs = regId.test(obj.value); 
		let mbirthTd = document.getElementById("mbirthTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mbirthTd.innerHTML = '생년월일 8자리를 입력해주세요.';
			mbirthTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mbirthTd.innerHTML = '숫자만 사용가능하고 생년월일 8자리를 입력해주세요.';
			mbirthTd.style.color = 'red';
			return false;
		}else{
			mbirthTd.innerHTML = '사용가능합니다.';
			mbirthTd.style.color = 'green';
			return true;
		}
	}
	
	function checkPhone1(obj){
		let regId = /^\d{3}/g;
		let regRs = regId.test(obj.value); 
		let mphoneTd = document.getElementById("mphoneTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			check = false;
			mphoneTd.innerHTML = '전화번호를 입력해주세요.';
			mphoneTd.style.color = 'red';
			return false;
		}else if(!regRs){
			check = false;
			mphoneTd.innerHTML = '3자리 숫자를 입력해주세요.';
			mphoneTd.style.color = 'red';
			return false;
		}else{
			check = true;
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
			mphoneTd.innerHTML = '3~4자리 숫자를 입력해주세요.';
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
			mphoneTd.innerHTML = '4자리 숫자를 입력해주세요.';
			mphoneTd.style.color = 'red';
			return false;
		}else{
			mphoneTd.innerHTML = '사용가능합니다.';
			mphoneTd.style.color = 'green';
			return true;
		}
	}
	
	function checkGender(mgender){
		let mgenderTd = document.getElementById("mgenderTd"); 
		if(mgender.value == "" || mgender.value === null || mgender.value === undefined){
			check = false;
			mgenderTd.innerHTML = '성별을 선택해주세요.';
			mgenderTd.style.color = 'red';
			return false;
		}else{
			check = true;
			mgenderTd.innerHTML = '';
			return true;
		}
	}
	
	function checkEmail(obj){
		let regEmail = /^[a-zA-Z0-9+-_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
		let regRs = regEmail.test(obj.value); 
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
	
	
	
	function checkIdFn(){
		let id = document.frm.mid.value;
		let midTd = document.getElementById("midTd");
			
		$.ajax({
			url : "checkId.jsp",
			type : "post",
			data : {id : id},
			success : function(data){
				let result = data.trim();
				// 0 : 사용가능, 1 : 사용 불가능, -1: 빈문자열 또는 null -2: 유효성 탈락
				if(result == 0){
					checkIdFlag = true;
					midTd.innerHTML = '사용가능합니다.';
					midTd.style.color = 'green';
					alert("사용가능한 아이디입니다.");
				}else if(result == -1){
					checkIdFlag = false;
					midTd.innerHTML = '아이디를 입력해주세요.';
					midTd.style.color = 'red';
				}else if(result == -2){
					checkIdFlag = false;
					alert('4자 이상, 20이하의 영문(소문자) 및 숫자만 사용가능합니다.');
					midTd.innerHTML = '4자 이상, 20이하의 영문(소문자) 및 숫자만 사용가능합니다.';
					midTd.style.color = 'red';
				}else{
					checkIdFlag = false;
					alert("이미 존재하는 아이디입니다.");
					midTd.innerHTML = '다른 아이디를 입력해주세요.';
					midTd.style.color = 'red';
				}
			},error:function(){
				console.log("error");
				checkIdFlag = false;
			}
		});
	}
	
	function resetIdFn(){
		checkIdFlag = false;
	}
	
	
	function checkNickFn(){
		let nick = document.frm.mnickNm.value;
		let mnickNmTd = document.getElementById("mnickNmTd"); 
			
		$.ajax({
			url : "checkNickNm.jsp",
			type : "post",
			data : {nick : nick},
			success : function(data){
			let result = data.trim();
			// 0 : 사용가능, 1 : 사용 불가능, -1: 빈문자열 또는 null -2: 유효성 탈락
			if(result == 0){
				checkNickNmFlag = true;
				mnickNmTd.innerHTML = '사용가능합니다.';
				mnickNmTd.style.color = 'green';
				alert("사용가능한 닉네임입니다.");
			}else if(result == -1){
				checkNickNmFlag = false;
				mnickNmTd.innerHTML = '닉네임을 입력해주세요';
				mnickNmTd.style.color = 'red';
			}else if(result == -2){
				checkNickNmFlag = false;
				alert('한글과 영문,숫자만 사용가능합니다.');
				mnickNmTd.innerHTML = '한글과 영문,숫자만 사용가능합니다.';
				mnickNmTd.style.color = 'red';
			}else{
				checkNickNmFlag = false;
				alert("이미 존재하는 닉네임입니다.");
				mnickNmTd.innerHTML = '다른 닉네임을 입력해주세요';
				mnickNmTd.style.color = 'red';
			}
		},error:function(){
			console.log("error");
			checkNickNmFlag = false;
		}
			
		});
	}
	function resetNickFn(){
		checkNickNmFlag = false;
	}
	
	
	
	function validation(){
		if(checkId(mid) & checkPw(mpw) & checkPwRe(mpwRe) & checkNickNm(mnickNm)
				& checkName(mname) & checkBirth(mbirth) & checkPhone1(mphone1)
				& checkPhone2(mphone2) & checkPhone3(mphone3) & checkGender(mgender)
				& checkEmail(memail)){
			if(checkIdFlag){
				if(checkNickNmFlag){
					document.frm.submit();
				}else{
					alert("닉네임 중복확인을 해 주세요.");
					document.getElementById("mnickNmTd").innerHTML = '';
				}
			}else{
				alert("아이디 중복확인을 해 주세요.");
				document.getElementById("midTd").innerHTML = '';
			}
		}
	}
