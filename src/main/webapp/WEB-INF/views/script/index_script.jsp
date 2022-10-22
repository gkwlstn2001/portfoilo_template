<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>

	// swiper.js 전역변수
	var mySwiper = "";
	var oEditors = [];
	
	function editorLoding(title, contents){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "contents", //저는 textarea의 id와 똑같이 적어줬습니다.
			sSkinURI : "/smartEditor/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
			fCreator : "createSEditor2",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,

				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : false,

				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : false
			}			
		});
    }	
	
	// 모달이 켜졌을때 swiper.js 를 동작시키기 위해 가져온 함수
	$(document).ready(function() {    			
		// 초기 스와이퍼 생성 이벤트
		$("#defaultModal").on("shown.bs.modal",function() {
			if(mySwiper!="") {
				// 스와이퍼 호출이 처음이 아니라면, 기존 스와이퍼를 파괴하고 새로 만든다.
				mySwiper.destroy();
			}
			create_swiper();
		})
		
		$("#defEditModal").on("shown.bs.modal",function() {
			if(oEditors.length==0) {
				editorLoding("", "");				
			}
		})
		$('.saveBtn').click(function() {
			// 에디터에 기록된 내용을 서버로 전달하려면 이부분이 필요함
			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
			// 최종적으로 submit
			$('form[name="editModalForm"]').submit();
    	})
	})
	
	// swiper.js 생성 함수
	function create_swiper() {		
		var selector = '.swiper-container';
		var option = {    		
	    		slidesPerView : 1,	// 한 슬라이드에 보여줄 갯수
	    		spaceBetween : 6, // 슬라이드 사이 여백
	    		loop : true, // 슬라이드 반복 여부    		
	    		loopAdditionalSlides : 1, // 슬라이드 반복 시 마지막 슬라이드에서 다음 슬라이드가 보여지지 않는 현상 수정
	    		/* autoplay : {  // 자동 슬라이드 설정 , 비 활성화 시 false
	    		  delay : 5000,   // 시간 설정
	    		  disableOnInteraction : false,  // false로 설정하면 스와이프 후 자동 재생이 비활성화 되지 않음
	    		}, */
	    		pagination : { // 페이징 설정
	    			el : '.swiper-pagination',
	    			clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
	    		},
		    	navigation : {
		    		nextEl : '.swiper-button-next', // 다음 버튼 클래스명
		    		prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
		    	}
	    	}		
		mySwiper = new Swiper(selector, option);
	}
	
	function getSeqList() {		
		var data = JSON.stringify({ "table" : $('select[name="table"]').val() });
		
		$.ajax({
			type: "POST",                             
		    url:  "${contextPath}/getSeqList", 
			data : data,
			contentType : "application/json; charset=utf-8;",
		    success: function(result) {		    	
		    	var html = '<select name="seq" onchange="getSeqData()" style="width:100%; text-align:center;">';
		    	for(var i=0; i<result.length; i++) {
	    			html += '<option value="'+result[i]+'">'+result[i]+'</option>';
	    		}		  
		    	html += '</select>';
		    	$('td[id="seq"]').html(html);
		    	
		    	getSeqData();
		    },
		    error: function(result) {		    	
		    	alert("실패");
		    }		  
		})
	}	
	
	// 선택된 seq의 row 정보를 가져오는 함수
	function getSeqData() {		
		var data = JSON.stringify({ 
			"table" : $('select[name="table"]').val(),
			"seq" : $('select[name="seq"]').val()
		});
		
		$.ajax({
			type: "POST",                             
		    url:  "${contextPath}/getSeqData", 
			data : data,
			contentType : "application/json; charset=utf-8;",
		    success: function(result) {
		    	$('input[name="title"]').val(result.title);
		    	$('textarea[name="introduce"]').val(result.introduce);
		    	$('input[name="link"]').val(result.link);
		    	
		    	oEditors.getById["contents"].exec("SET_IR", [""]);
		    	oEditors.getById["contents"].exec("PASTE_HTML", [result.introduce]); //로딩이 끝나면 contents를 txtContent에 넣습니다.
		    },
		    error: function(result) {
		    	alert("실패");
		    }		  
		})		
	}	
	
	// 가장 마지막에 등록한 seq 가져오기
	function getRecentSeq(table) {
		var data = JSON.stringify({ 
			"table" : table
		});
		
		$.ajax({
			type: "POST",                             
		    url:  "${contextPath}/getRecentSeq", 
			data : data,
			contentType : "application/json; charset=utf-8;",
		    success: function(result) {
		    	getModalData(table,result);
		    },
		    error: function(result) {
		    	alert("실패");
		    }		  
		})
	}
	
	// 모달 데이터 가져오기
	function getModalData(table,seq) {
		var data = JSON.stringify({ 
			"table" : table,
			"seq" : seq
		});
		
		$.ajax({
			type: "POST",                             
		    url:  "${contextPath}/getSeqData", 
			data : data,
			contentType : "application/json; charset=utf-8;",
		    success: function(result) {
		    	// 모달 초기화		    	
				$('#displayTitle').text("");		    		
		    	$('#displayImg').html("");
			    $('#displayIntroduce').text("");		    		
			    $('#displayLink').attr('href',"");
		    	
		    	if(result.title !=null) {
			    	$('#displayTitle').text(result.title);		    		
		    	} if(result.filePath1 != null) {
		    		$('#displayImg').prepend('<div class="swiper-slide"><img class="img-fluid rounded mb-5" src="${contextPath}/ImgDown?path='+result.filePath1+'" alt="..." onerror="this.src=\'assets/img/portfolio/safe.png\'" /></div>');
		    	} if(result.filePath2 != null) {
		    		$('#displayImg').prepend('<div class="swiper-slide"><img class="img-fluid rounded mb-5" src="${contextPath}/ImgDown?path='+result.filePath2+'" alt="..." onerror="this.src=\'assets/img/portfolio/safe.png\'" /></div>');
		    	} if(result.filePath3 != null) {
		    		$('#displayImg').prepend('<div class="swiper-slide"><img class="img-fluid rounded mb-5" src="${contextPath}/ImgDown?path='+result.filePath3+'" alt="..." onerror="this.src=\'assets/img/portfolio/safe.png\'" /></div>');
		    	} if(result.introduce != null) {
			    	$('#displayIntroduce').html(result.introduce);		    		
		    	} if(result.link != null) {
			    	$('#displayLink').attr('href',result.link);		    		
		    	}		    	
		    },
		    error: function(result) {
		    	alert("실패");
		    }		  
		})	
	}	
	
	// 게시글 추가모드
	function addMode() {
		$('select[name="seq"]').val("");
		$('input[name="title"]').val("");
		$('textarea[name="introduce"]').val("");
		oEditors.getById["contents"].exec("SET_IR", [""]);
		$('input[name="filePath1"]').val("");
		$('input[name="filePath2"]').val("");
		$('input[name="filePath3"]').val("");
		$('input[name="link"]').val("");
	}
	
	// 게시글 삭제기능
	function delData() {		
		if(confirm("정말 삭제하시겠습니까?")) {
			var data = JSON.stringify({ 
				"table" : $('select[name="table"]').val(),
				"seq" : $('select[name="seq"]').val()
			});
			
			$.ajax({
				type: "POST",                             
			    url:  "${contextPath}/delData", 
				data : data,
				contentType : "application/json; charset=utf-8;",
			    success: function(result) {
			    	alert("삭제되었습니다.");
			    	location.reload();
			    },
			    error: function(result) {
			    	alert("실패");
			    }		  
			})
		} else {
			alert("취소되었습니다.")
		}		
	}
</script>