function showSubSelect(obj){
	if(document.getElementById("subSelectTh") !== null){
	document.getElementById("subSelectTh").remove();
	}
	if(document.getElementById("subSelectTd") !== null){
	document.getElementById("subSelectTd").remove();
	}
	if(obj.value ==="캠핑지역"){
		document.getElementById("writerTd").removeAttribute("colspan");
		let subTr = document.getElementById("subTr");
		let subSelectTh = document.createElement("th");
		let subSelectTd = document.createElement("td");
		subSelectTh.setAttribute("id","subSelectTh");
		subSelectTd.setAttribute("id","subSelectTd")
		subSelectTh.textContent='세부카테고리';
		subSelectTd.innerHTML=
		'<select name="btype" id="subSelect">'+
		'<option value="캠핑지역_서울">서울</option>'+
		'<option value="캠핑지역_경기권">경기권</option>'+
		'<option value="캠핑지역_강원권">강원권</option>'+
		'<option value="캠핑지역_충청권">충청권</option>'+
		'<option value="캠핑지역_영남권">영남권</option>'+
		'<option value="캠핑지역_호남권">호남권</option>'+
		'<option value="캠핑지역_제주">제주</option>'+
		'</select>';
		subTr.appendChild(subSelectTh);
		subTr.appendChild(subSelectTd);
		
	}else if(obj.value ==="캠핑장비"){
		document.getElementById("writerTd").removeAttribute("colspan");
		let subTr = document.getElementById("subTr");
		let subSelectTh = document.createElement("th");
		let subSelectTd = document.createElement("td");
		subSelectTh.setAttribute("id","subSelectTh");
		subSelectTd.setAttribute("id","subSelectTd")
		subSelectTh.textContent='세부카테고리';
		subSelectTd.innerHTML=
		'<select name="btype" id="subSelect">'+
		'<option value="캠핑장비_텐트">텐트/타프</option>'+
		'<option value="캠핑장비_침낭">침낭/매트</option>'+
		'<option value="캠핑장비_의자">의자/테이블</option>'+
		'<option value="캠핑장비_화기">화기/기타</option>'+
		'<option value="캠핑장비_차박">차박</option>'+
		'</select>';
		
		subTr.appendChild(subSelectTh);
		subTr.appendChild(subSelectTd);
	}else{
		document.getElementById("writerTd").setAttribute("colspan","3");
	}
}


					