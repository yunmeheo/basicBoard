<%@page import="com.test.vo.IsMater"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%!String realPath;%>
<%!String newFileName;%>
<!DOCTYPE HTML>


<html>
<head>

<link href="css/style.css" rel="stylesheet" type="text/css" padding :50px;>
</head>
<style>
.fileUpLoad {display: none; border: 1px solid ; position: absolute; top :200px ; left: 200px; background-color: white; padding : 30px}
.fileDrop { width:600px;  height: 50px;  }
 small {margin-left: 3px; font-weight: bold; color: gray;}
 .uploadedList{width: 100px; height: 100px}
</style>






<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

/* 이미지 업로드펑션 */
function fileInfo(f){
	var files = f.files; // files 를 사용하면 파일의 정보를 알 수 있음
	// file 은 배열이므로 file[0] 으로 접근해야 함
	
	if(files[0].size > 1024 * 1024){
		// 큰 파일을 올리니까 브라우저가 다운되었음 -_-;;
		alert('1MB 이상의 파일은 안되용! (진지)');
		return;
	}
	else if(files[0].type.indexOf('image') < 0){ // 선택한 파일이 이미지인지 확인
		alert('이미지 파일만 선택하세요. ㅂㄷㅂㄷ');
		return;
	}
	
    var file = files[0];
    console.log(file);
    var formData = new FormData();
    
    // 폼 객체에 파일추가, append("변수명", 값)
    formData.append("file", file);
    $.ajax({
        type: "post",
        url: "uploadAjax.do",
        data: formData,
        dataType: "text",
        processData: false,
        contentType: false,
        success: function(data){
          //파일명 채워넣기
          alert(data);
          
        //이미지넣기
        var reader = new FileReader(); // FileReader 객체 사용
  		reader.onload = function(rst){
  	    $('.uploadedList').append('<img class = "resultImd"  id='+data+'  style="width : 100px;" src="' + rst.target.result + '">'); // append 메소드를 사용해서 이미지 추가
  			// 이미지는 base64 문자열로 추가
  			// 이 방법을 응용하면 선택한 이미지를 미리보기 할 수 있음
  		}
  		reader.readAsDataURL(files[0]); // 파일을 읽는다
          
        }
    });return false;
}
<%IsMater im = (IsMater)session.getAttribute("im");%>
$(function(){

	var $kor_name= $("input[name=textfield4]");  //한글이름
	var $eng_name= $("input[name=textfield22]");   //영문이름
	var $chn_name  = $("input[name=textfield34]");  //*** 한문이름
	var $jumin_no1= $("input[name=textfield323]");  //앞 주민번호
	var $jumin_no2= $("input[name=textfield3222]"); //뒤 주민번호
	
	/* 이미지올리기 재료들 */  // <input type="file" id="fileUp" name="fileUp" />&nbsp;&nbsp;
	//var $image_name= $("input[name=fileUp]");   //파일명
	var $btSearchFile = $("img[name=btSearchFile]");  // img인데...  파일검색버튼
	
	/* 모든 라디오버튼 */
	var radiobutton= $("radiobutton[name=radiobutton]");// 양력  
	
	
	/* 생년월일 재료들 */
	var $year= $("input[name=textfield332]"); // 년
	var $month= $("input[name=textfield3322]"); // 월
	var $day= $("input[name=textfield33222]");  //일
	
	/* 라디오 */
	var $bir = $('input:radio[name=bir]:checked');
	var $sex=$(":input:radio[name=sex]:checked");
	var $marital_status =$('input[name=marital_status]:checked');
	
	var $work_date= $("input[name=textfield3323]");   //년차
	var $pay_type  = $("select[name=select]"); //***급여지금유형
	var $work_flag= $("select[name=select2]");  // 희망직무
	var $join_type  = $("select[name=select4]"); //***입사유형
	
	/* 주소재료들 */
	var $address1= $("input[name=textfield3324]");
	var $address2= $("input[name=textfield333]");
	
	/* 연락처재료들 */
	var $phone1= $("input[name=textfield33242]");
	var $phone2= $("input[name=textfield332422]");
	var $phone3= $("input[name=textfield332423]");
	
	var $email= $("input[name=textfield332424]");  // 이메일
	var $tech_lev= $("input[name=textfield3324242]");
	var $drink_capacity = $("input[name=textfield33242422]");  //***주량
	
	

      
	//버튼으로 파일업로드하기
	  /* $('#fileForm').submit(function fileSubmit() {
	    event.preventDefault(); // 기본효과를 막음
	    $(".viewMyImg").remove();
	  //파일명 셋팅하기
        var id = $(".uploadedList").attr('id');
        console.log("파일명 : "+id);
	    
	    
	    var str ="";
	     var formData = new FormData($("#fileForm")[0]);
	     console.log(formData);
	     $.ajax({
	         type : 'post',
	         url : 'fileUpload.do',
	         data : formData,
	         processData : false,
	         contentType : false,
	         success : function(responseData) {
	            
	            

	            // 성공시 이미지출력
	            str = "<div><a href='displayFile.do?fileName="+id+"'>";
	            str += "<img style='max-width: 100%;  height: auto;' src='displayFile.do?fileName="+id+"'></a>";
	            str += "<span  class='deleteIMG' data-src=uploadImg/"+id+">[삭제]</span></div>";
	            $(".uploadedList").append(str);
	             
	            //alert(str);
	             
	            //alert("파일 업로드하였습니다.");
	            //$(".fileUpLoad").hide();
	             
	         } ,
	         error : function(error) {
	             alert("파일 업로드에 실패하였습니다.");
	             console.log(error);
	             console.log(error.status);
	         } 
	     }); return false;
	  });  */
	
	
	  //파일 드래그로 파일 업로드
	  $(".fileDrop").on("dragenter dragover", function(event){
	        event.preventDefault(); // 기본효과를 막음
	    });
	  
	  //드래그로 업로드 시키기
	  $(".fileDrop").on("drop", function(event){
	        event.preventDefault(); // 기본효과를 막음
	        var imageName= $("input[name=textfield33]"); 
	        // 드래그된 파일의 정보
	        var files = event.originalEvent.dataTransfer.files;
	        // 첫번째 파일
	        var file = files[0];
	        // 콘솔에서 파일정보 확인
	        console.log(file);
	        // ajax로 전달할 폼 객체
	        var formData = new FormData();
	        
	        // 폼 객체에 파일추가, append("변수명", 값)
	        formData.append("file", file);
	        $.ajax({
	            type: "post",
	            url: "uploadAjax.do",
	            data: formData,
	            dataType: "text",
	            processData: false,
	            contentType: false,
	            success: function(data){
	              
	              //파일명 채워넣기
	              imageName.val(getImageLink(data));
	              
	              alert(data);
	                var str = "";
	                
	                // 이미지 파일이면 썸네일 이미지 출력
	                if(checkImageType(data)){ 
	                    str = "<div><a href='displayFile.do?fileName="+getImageLink(data)+"'>";
	                    str += "<img src='displayFile.do?fileName="+data+"'></a>";
	                // 일반파일이면 다운로드링크
	                } else { 
	                    str = "<div><a href='displayFile.do?fileName="+data+"'>"+getOriginalName(data)+"</a>";
	                }
	                
	                // 삭제 버튼
	                str += "<span class='deleteIMG' data-src="+data+">[삭제]</span></div>";
	                
	                
	                $(".uploadedList").append(str);
	                
	            }
	        });return false;
	    });
	
	
	
	
	
	
	//최종 수정버튼 	
	$('#modify').click(function(){
		console.log("수정클릭!");
		
		  /* 라디오버튼들 밸류 가져오기 */
	    var $bir = $("input:radio[name=bir]:checked");
	    var $sex=$(":input:radio[name=sex]:checked");
	    var $marital_status =$('input:radio[name=marital_status]:checked'); 
	    
	    console.log($bir.val());
	    console.log($sex.val());
	    console.log($marital_status.val());
	    

		$.ajax({
			url : "modify.do",
			data : {
				'no' : <%=im.getNo()%>,
				'kor_name' : $kor_name.val(),
				'eng_name':$eng_name.val(),
				'chn_name':$chn_name.val(),
				'jumin_no1':$jumin_no1.val(),
				'jumin_no2':$jumin_no2.val(),
				'image_name': $(".resultImd").attr('id'),  //파일명
				'year':$year.val(),
				'month':$month.val(),
				'day':$day.val(),
				'bir_type':$bir.val(),
				'sex' : $sex.val(),
				'marital_status' : $marital_status.val(),
				'work_date':$work_date.val(),
				'pay_type':$pay_type.val(),
				'work_flag':$work_flag.val(),
				'join_type':$join_type.val(),
				'address1':$address1.val(),
				'address2':$address2.val(),
				'phone1':$phone1.val(),
				'phone2':$phone2.val(),
				'phone3':$phone3.val(),
				'email':$email.val(),
				'tech_lev':$tech_lev.val(),
				'drink_capacity':$drink_capacity.val()

				},
				success : function(responseData) {
				
					var result = responseData.trim();
					console.log(result);
					if(result == "1"){
						alert("입력되었습니다.");
						
						//완료 후 리스트로 보내기
						$.ajax({
				      		   url : "selectAll.do",
				      		   method: 'GET', 
				      		   data:{'pageno':1},
				      		   success : function(responseData){
				      			   $("article").empty();
				      			   $("article").html(responseData.trim()); 
				      		   }
				      	   }); return false;
					}else{
						alert("입력실패, 다시 시도해주세요.");
					}
      			}
      		});
      	});
	
	


	
	
});  // end for all function


</script>

<c:set var="ismater" value="${requestScope.im}"/>

<body topmargin="0" leftmargin="0">

<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="640">&nbsp;</td>
  </tr>
  <tr> 
    <td height="25"><img src="image/icon.gif" width="9" height="9" align="absmiddle"> 
      <strong>사원 기본 정보 수정</strong></td>
  </tr>
  <tr> 
    <td><table width="640" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="15" align="left"><table width="640" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><table width="640" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td height="2" background="image/bar_bg1.gif"></td>
                    </tr>
                    <tr align="center" bgcolor="F8F8F8"> 
                      <td height="26" align="center" bgcolor="#E4EBF1" style="padding-right:10"><table width="600" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td align="center"><strong>교육정보 | 자격증. 보유기술정보 | 프로젝트 
                              정보 |경력정보 | 근무정보</strong></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr align="center" bgcolor="F8F8F8"> 
                      <td height="3" align="right" background="image/bar_bg1.gif"></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="6" align="center" valign="top">&nbsp;</td>
        </tr>
        <tr>
          <td height="7" align="center" valign="top"><table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#CCCCCC"><table width="600" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td height="135" align="center" bgcolor="#E4EBF1"><table width="600" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="144" height="119" align="center"><table width="100" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              
                             
                              <td height="112" bgcolor="#CCCCCC">
                               <!--사진출력 테이블 -->
	                              <table width="100" border="0" cellspacing="1" cellpadding="0" id="uploadedImg">
	                                  <tr>
	                                    <td height="110" bgcolor="#FFFFFF">&nbsp;
                                     
                                    <%--  <!-- 새로 변경될 이미지를 보여주는 div -->
                                     <div class="uploadedList" id="${newFileName}"></div>
                                      --%>
                                     <!-- 등록해둔 이미지를 보여주기 위한 div -->
                                      <div class="viewMyImg" >
                                         <%-- <a href='displayFile.do?fileName=${ismater.image_name}'> --%>
                                         <img   style='max-width: 100%; height: auto;'   src='displayFile.do?fileName=${ismater.image_name}'>
                                         <!-- </a> -->
                                      </div>
                                      
                                      
                                     </td>
	                                </tr>
	                              </table>
	                              
                              </td>
                              
                              
                             
                              
                              
                            </tr>
                          </table></td>
                          <td width="456"><table width="423" border="0" cellspacing="2" cellpadding="0">
                            <tr>
                              <td height="2" colspan="2"></td>
                              </tr>
                            <tr>
                              <td width="107" height="26" align="right"><strong>한글이름 :</strong>&nbsp;</td>
                              <td width="310" height="26">
                                <%-- <input type="text" name="textfield4" placeholder="${ismater.kor_name}"> --%>
                                ${ismater.kor_name}
                              </td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>영문이름 :&nbsp;</strong></td>
                              <td height="26">
                              
                              <!-- <input type="text" name="textfield22" > -->
                              ${ismater.eng_name}
                              
                              </td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>한문이름:</strong>&nbsp;</td>
                              <td height="26">
                              <!-- <input type="text" name="textfield34"> -->
                              ${ismater.chn_name}
                              </td>
                            </tr>
                            <tr>
                            
                              <c:set var = "jumin_noArr"  value="${requestScope.jumin_noArr}" />
                              <td height="26" align="right"><strong>주민등록번호 :</strong>&nbsp;</td>
                              
                              <td height="26">
                              
                               
                              
                               <input name="textfield323" type="text" size="15" value="${jumin_noArr[0]}"> 
							      -
							   <input name="textfield3222" type="text" size="15" value ="${jumin_noArr[1]}"></td>
                            </tr>
                          </table></td>
                        </tr>
                      </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="7" align="center" valign="top">&nbsp;</td>
        </tr>
        <tr> 
          <td height="13" align="center"><table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td bgcolor="#CCCCCC"><table width="600" border="0" cellspacing="1" cellpadding="0">
                    <tr> 
                      <td bgcolor="#E4EBF1">
                      
                      <!-- 사진 업뎃 시작 -->
                      	<table class="fileDrop" width="526" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>사진파일명 :&nbsp;</strong></td>
                            <td width="268">
                            
                            
                            
                            
                            <form id="fileForm" method="post" enctype="multipart/form-data"  >
							    <input type="file" id="fileUp" name="fileUp" onchange="fileInfo(this)"/>&nbsp;&nbsp;
							  <!--   <input type="submit" value="미리보기" > -->
							</form>
                            
                            
                            <%-- <input name="textfield33" type="text" size="40" value="${ismater.image_name}">
                             --%>
                            </td>
                            <td width="146">
                            
                            
                            
	                            <!-- <font color="#FF0000">
	                         	   <img src="image/bt_search.gif" width="49" height="18"  name="btSearchFile" >
	                            </font> -->
	                            
	                            
	                            
                            </td>
                          </tr>
                        </table>
                        <!-- 사진 업뎃 종료 -->
                        
                        </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1">
                      
                      <table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>생년월일 :&nbsp;</strong></td>
                            <td width="391">
                           
                           
                           <!-- model.addAttribute("birArr",birArr);
		model.addAttribute("phoneArr",phoneArr); -->
                           
                            <c:set var = "birArr"  value="${requestScope.birArr}" />
                            <c:set var ="phoneArr"  value="${requestScope.phoneArr}" />
                           <%--  <c:set var ="addressArr"  value="${requestScope.addressArr}" /> --%>
                            
                          <%--  ${birArr[0]}
                           ${birArr[1]}
                           ${birArr[2]} --%>
                           <%-- <c:forEach var="bir" items="${birArr}">
                           
                           ${birArr}
                         
                           
                           </c:forEach>
                           
                           <c:forEach var="phone" items="${phoneArr}">
                           
                            ${phone}
                           
                           </c:forEach>
                            --%>
                           
                           
                           
                            
                            <input name="textfield332" type="text" size="10" value="${birArr[0]}">
                              년 
                              <input name="textfield3322" type="text" size="7"  value="${birArr[1]}">
                              월 
                              <input name="textfield33222" type="text" size="7" value="${birArr[2]}">
                              일 ( 
                              <input type="radio" name="bir" value="solarCalendar"
                              <c:if test="${birArr[3] eq '양력'}">
                              
                               checked="checked"
                              
                              </c:if>
                              
                              >
                              양력                               
                              <input type="radio" name="bir" value="lunarCalendar"
                              <c:if test="${birArr[3] eq '음력'}">
                              
                              checked="checked"
                              
                              </c:if>>
                              음력 )</td>
                              
                              
                              
                          </tr>
                        </table>
                        
                        </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>성별 :&nbsp; </strong></td>
                            <td width="391"> 
                            
                           	  <input type="radio" name="sex" value="m"
                           	  
                           	  <c:if test="${ismater.sex eq 'm'}">
                              
                              checked="checked"
                              
                              </c:if>
                           	  
                           	  >
                           	  남자
                              <input type="radio" name="sex" value="w"
                              
                              <c:if test="${ismater.sex eq 'w'}">
                              
                              checked="checked"
                              
                              </c:if>
                              
                              
                              >
                              여자</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>결혼유무 :${ismater.marital_status}&nbsp;</strong></td>
                            <td width="391"> 
                            
                            <input type="radio" name="marital_status" value="married"
                            <c:if test="${ismater.marital_status eq 'y'}">
                              checked="checked"
                              </c:if>
                            >
                              기혼 
                              <input type="radio" name="marital_status" value="single"
                              <c:if test="${ismater.marital_status eq 'n'}">
                              checked="checked"
                              </c:if>
                              >
                              미혼  <input type="button" value="라디오테스트" class="testBt">  </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>년차 :&nbsp;</strong></td>
                            <td width="392"><input name="textfield3323" type="text" size="10"  value="${ismater.work_date}"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>급여 지급유형 :&nbsp;</strong></td>
                            <td width="392"> 
                            ${ismater.pay_type}
                              <select name="select"  >
                                <option 
                                
                                <c:if test="${ismater.pay_type eq '월급'}">
                              
                               selected="selected"  
                              
                               </c:if>
                                
                                >월급</option>
                                <option
                                <c:if test="${ismater.pay_type eq '주급'}">
                              
                               selected="selected"  
                              
                               </c:if>
                                
                                >주급</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>희망직무 :&nbsp;</strong></td>
                            <td width="392"> ${ismater.work_flag}<select name="select2" value="${ismater.work_flag}" >
                                 <option  
                                 <c:if test="${ismater.work_flag eq 'SI'}">
                              
                               selected="selected"  
                              
                               </c:if>
                                 
                                 >SI</option>
                                <option
                                
                                 <c:if test="${ismater.work_flag eq 'SM'}">
                              
                               selected="selected"  
                              
                               </c:if>
                                
                                >SM</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <!-- <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>급여 지급 유형:&nbsp;</strong></td>
                            <td width="392"> <select name="select3">
                                <option>월급</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr> -->
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>입사유형:&nbsp;</strong></td>
                            <td width="392"> ${ismater.join_type}<select name="select4" value="${ismater.join_type}" >
                               
                               
                                <option
                                <c:if test="${'정규직' eq ismater.join_type }">
                               selected="selected"  
                               </c:if>
                               >정규직</option>
                               
                                <option
                                <c:if test="${'계약직' eq  ismater.join_type}">
                               selected="selected"  
                               </c:if>
                                >계약직</option>
                                
                                
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                          
                          <c:set var = "addressArr"  value="${requestScope.addressArr}" />
                          
                            <td width="101" align="right"><strong>주소:&nbsp;</strong></td>
                            <td width="392">
                              <input name="textfield3324" type="text" size="10" value="${addressArr[0]}" > 
                              <input name="textfield333" type="text" size="40" value="${addressArr[1]}" > 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>연락처:&nbsp;</strong></td>
                            <td width="392">
                              <input name="textfield33242" type="text" size="10" value="${phoneArr[0]}">
                              - 
                              <input name="textfield332422" type="text" size="10"  value="${phoneArr[1]}">
                              - 
                              <input name="textfield332423" type="text" size="10"  value="${phoneArr[2]}"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>이메일:&nbsp;</strong></td>
                            <td width="392"><input name="textfield332424" type="text" size="20"  value="${ismater.email}"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>기술등급:&nbsp;</strong></td>
                            <td width="392"><input name="textfield3324242" type="text" size="20"  value="${ismater.tech_lev}"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주량:&nbsp;</strong></td>
                            <td width="392">
                            <input name="textfield33242422" type="text" size="20"  value="${ismater.drink_Capacity}"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="3" align="center">&nbsp;</td>
        </tr>
        <tr>
          <td height="3" align="center"><table width="107" border="0" cellpadding="1" cellspacing="1">
            <tr>
              <td width="49"><img src="image/bt_remove.gif" width="49" height="18" id="modify"></td>
              <td width="51"><img src="image/bt_cancel.gif" width="49" height="18" id ="cancel" ></td>
            </tr>
          </table>            </td>
        </tr>
        <tr> 
          <td height="7" align="right">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>


<!-- 파일업뎃 div -->

<!-- <div class = "fileUpLoad" >

<form id="fileForm"  method="post"  enctype="multipart/form-data">
    <input type="file" id="fileUp" name="fileUp"/><br/><br/>
    <input type="submit" value="전송하기" >
</form>


</div> -->







</body>
</html>
