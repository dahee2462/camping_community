	//유효성 검사 개수제한 추가해야함 개수 정해지면 {} 붙이기
	let mname = document.frm.mname; 
	let mbirth = document.frm.mbirth; 
	let mphone1 = document.frm.mphone1; 
	let mphone2 = document.frm.mphone2; 
	let mphone3 = document.frm.mphone3; 
	
	function checkName(obj){
		let regId = /^[가-힣]{2,8}$/;
		let regRs = regId.test(obj.value); 
		let mnameTd = document.getElementById("mnameTd"); 
		if(obj.value == "" || obj.value === null || obj.value === undefined){
			mnameTd.innerHTML = '사용자 이름을 입력해주세요.';
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
			mbirthTd.innerHTML = '사용자 생년월일을 입력해주세요.';
			mbirthTd.style.color = 'red';
			return false;
		}else if(!regRs){
			mbirthTd.innerHTML = '숫자만 입력가능, 생년월일을 다시 입력해주세요.';
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
			mphoneTd.innerHTML = '숫자만 사용가능합니다.';
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
			mphoneTd.innerHTML = '숫자만 사용가능합니다.';
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
			mphoneTd.innerHTML = '숫자만 사용가능합니다.';
			mphoneTd.style.color = 'red';
			return false;
		}else{
			mphoneTd.innerHTML = '사용가능합니다.';
			mphoneTd.style.color = 'green';
			return true;
		}
	}
	
	function searchId(){
		if(checkName(mname) & checkBirth(mbirth) & 
		   checkPhone1(mphone1)	& checkPhone2(mphone2) & checkPhone3(mphone3)){
			document.frm.submit();
		}else{
			return checkName;
		}
	}