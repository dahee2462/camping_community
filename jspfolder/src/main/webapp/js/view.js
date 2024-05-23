	//[대댓글 입력란 생성]
	
	let isrereplyModify= false;
	function rereplyInput(obj,parentRno,bno){
		if(!isModify){	//수정중이라면
			$(".rereplyInput").remove();
			
			let html ='<div class="rereplyInput">'
					+'<form class="rereplyfrm" >'
					+'<input type="hidden" name="rno" value="'+parentRno+'">'
					+'<input type="hidden" name="bno" value="'+bno+'">'
					+'<input type="text" name="rcontent">'
					+'<button type="button" onclick="rereplyInsert(this)">대댓글 작성</button>'
					+'<button type="button" onclick="rereplyInsertCancel()">취소</button>'
					+'</form>'
					+'</div>';
			$(obj).parent().after(html);
			isrereplyModify= true;
		}else{
			alert("수정중인 댓글을 저장하세요");
		}
	}
	//[대댓글 작성버튼]
	function rereplyInsert(obj){
		
			let params = $(obj).parent().serialize();
			$.ajax({
				url: "rereplyWriteOk.jsp",
				type: "post",
				data: params,
				success:function(data){
					if(data.trim() != "FAIL" && data.trim() != "FAILFAIL"){
						let origindata = JSON.parse(data.trim());
						let _data = origindata[0];
						let html = '<div class="rereplyInsert" style="margin-left:'+_data.rdepth*40+'px">'
						+_data.mnickNm+' : <span>'+_data.rcontent+' </span>'
						+'<span><button onclick="modifyFn(this,'+_data.rno+')">수정 </button>'
						+'<button onclick="replyDelFn('+_data.rno+', this)">삭제 </button></span>'
						+'<span>'+_data.rrdate+' </span>'
						+'<span><button onclick="rereplyInput(this,'+_data.rno+','+_data.bno+')">대댓글</button></span></div>'
						$(obj).parent().parent().parent().after(html);
						$(".rereplyInput").remove(); //비동기라서 ajax밖에있으면 안됨
					}else{
						alert("대댓글이 입력되지 않았습니다123.");
					}
				},error:function(){
					alert("대댓글이 입력되지 않았습니다.");
				}
			});
		isrereplyModify= false;
		
	}
	//[대댓글 작성취소버튼]
	function rereplyInsertCancel(){
		$(".rereplyInput").remove();
		isrereplyModify= false;
	}
	
	
	//[좋아요]
	function likeInsertFn(obj){
		// form태그 데이터를 파라미터값으로 가져오기
		let params = $("form[name=likefrm]").serialize();
		$.ajax({
			url: "likeInsertOk.jsp",
			type: "post",
			data: params,
			success:function(data){
				if(data.trim() != "FAIL" && data.trim() != "FAILFAIL"){
					$("#likeCount").html(data.trim());
					obj.src = "/jspfolder/images/likeOk.png";
					obj.nextElementSibling.style.color="white";
				}else if(data.trim() == "FAIL"){
					alert("이미 좋아요한 게시물입니다.")
				}else{
					alert("로그인을 하고 이용해 주세요.")
				}
			},error:function(){
			}
		});
	}

	
	//[댓글 등록]
	function replyInsertFn(){
		if(!isModify && !isrereplyModify){	//수정중이 아니라면
		// form태그 데이터를 파라미터값으로 가져오기
		let params = $("form[name=replyfrm]").serialize();
		$.ajax({
			url: "replyWriteOk.jsp",
			type: "post",
			data: params,
			success:function(data){
				if(data.trim() != "FAIL" && data.trim() != "FAILFAIL"){
					$(".replyArea").prepend(data.trim());	//첫번째 자식으로
					
				}else if(data.trim() == "FAIL"){
					alert("로그인 후 이용해 주세요.")
				}else{
					alert("댓글이 입력되지 않았습니다.")
				}
			},error:function(){
			}
		});
			//댓글 등록 후 댓글창 비우기
			$("input[name=rcontent]").val("");
			
		}else{
			alert("수정중인 댓글을 저장하세요");
		}
	}
	
	//[댓글 삭제]
	function replyDelFn(rno,obj){
		$.ajax({
			url: "deleteReplyOk.jsp",
			type: "post",
			data: "rno="+rno,	//키=값
			success:function(data){
				if(data.trim() == 'SUCCESS'){
					alert("댓글이 삭제되었습니다.");
					let target = $(obj).parent().parent();
					target.html("삭제된 댓글입니다.");
				}else{
					alert("댓글이 삭제되지 못했습니다.");
				}
			},error:function(){
				console.log("error");
			}
		});
	}
	
	//[댓글 수정]
	//수정중 -> 초기값을 false로 둠
	let isModify = false;
	
	function modifyFn(obj, rno){

		//동시다발적 수정하는것 방지(하나 수정중일때는 다른것 수정안됨)
		
		if(!isModify && !isrereplyModify){	//수정중이 아니라면
			//입력양식 초기값 얻어오기
			let value = $(obj).parent().prev("span").text().trim();	//부모의 형 span 기존 rcontent
			
			let html = "<input type='text' name = 'rcontent' value='"+value+"'>";
			html += "<input type='hidden' name='rno' value='"+rno+"'>";
			html += "<input type='hidden' name='oldRcontent' value='"+value+"'>";
			
			$(obj).parent().prev("span").html(html);
			
			html = "<button onclick='saveFn(this)'>저장</button>"
				 +"<button onclick='cancleFn(this)'>취소</button>";
			
			$(obj).parent().html(html);
			
			isModify=true;
		}else{
			alert("수정중인 댓글을 저장하세요");
		}
	}
	
	
	//[댓글 수정-저장]
	function saveFn(obj){
		//저장후 다른댓글 수정할 수 있도록 false로 만들어놓음
		isModify=false;
		
		//수정된 값
		let value = $(obj).parent().prev("span").find("input[name=rcontent]").val();
		
		let rno = $(obj).parent().prev("span").find("input[name=rno]").val();
		
		//원본
		let originalValue= $(obj).parent().prev("span").find("input[name=oldRcontent]").val();
		
		$.ajax({
			url: "replyModifyOk.jsp",
			type:"post",
			data:{rcontent: value, rno:rno},//키:값
			success : function(data){
				if(data.trim()=='SUCCESS'){
					$(obj).parent().prev("span").text(value);
					let html ='<button onclick="modifyFn(this,'+rno+')">수정</button>'
							+ '<button onclick="replyDelFn('+rno+', this)">삭제</button>';
					$(obj).parent().html(html);
				}else{	//수정취소
					$(obj).parent().prev("span").text(originalValue);	//원본값 넣어줌
					let html = '<button onclick="modifyFn(this,'+rno+')">수정</button>'
							+  '<button onclick="replyDelFn('+rno+',this)">삭제</button>';
					$(obj).parent().html(html);
				}
			},error:function(){
				console.log("error");
			}
			
		});
	}
	
	//[댓글 수정-취소]
	function cancleFn(obj){
		//원본
		let originValue = $(obj).parent().prev("span").find("input[name=oldRcontent]").val();
		
		let rno = $(obj).parent().prev("span").find("input[name=rno]").val();
		
		$(obj).parent().prev("span").text(originValue);
		
		let html = "<button onclick='modifyFn(this,"+rno+")'>수정</button>";
		html += "<button onclick='replyDelFn("+rno+", this)'>삭제</button>";
		
		$(obj).parent().html(html);
		
		isModify = false;
		
	}
	
	
	
	