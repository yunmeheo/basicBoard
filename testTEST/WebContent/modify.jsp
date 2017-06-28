<%@page import="com.test.vo.IsMater"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>


<html>
<head>

<link href="css/style.css" rel="stylesheet" type="text/css" padding :50px;>
</head>
<style>
.fileUpLoad {display: none; border: 1px solid; position: absolute; top :200px ; left: 200px; background-color: white;}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>


<%IsMater im = (IsMater)session.getAttribute("im");%>



$(function(){

	var $kor_name= $("input[name=textfield4]");  //한글이름
	var $eng_name= $("input[name=textfield22]");   //영문이름
	var $chn_name  = $("input[name=textfield34]");  //*** 한문이름
	var $jumin_no1= $("input[name=textfield323]");  //앞 주민번호
	var $jumin_no2= $("input[name=textfield3222]"); //뒤 주민번호
	
	/* 이미지올리기 재료들 */
	var $image_name= $("input[name=textfield33]");   //파일명
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
	
	
	
	//파일검색 클릭시 파일 업로드창 띄우기
	$btSearchFile.click(function(){
		console.log("파일검색 클릭됨");
		$(".fileUpLoad").show();
	});  //end for click
	
	
	//파일업로드하기
	$('#fileForm').submit(function fileSubmit() {
	    var formData = new FormData($("#fileForm")[0]);
	    var $image= $("input[name=textfield33]");   //파일명
	    event.preventDefault();

	    $.ajax({
	        type : 'post',
	        url : 'fileUpload.do',
	        data : formData,
	        processData : false,
	        contentType : false,
	        success : function(responseData) {
	            alert("파일 업로드하였습니다.");
	            $(".fileUpLoad").hide();
	            
	         	// 파일명
	            var fileValue = $("#fileUp").val().split("\\");
	            var fileName = fileValue[fileValue.length-1]; 
	            
	            //파일명 넣기  
	            $image.val(fileName);
	            console.log("파일명 : "+fileName);
	            console.log("responseData : "+responseData);
	            
	        } ,
	        error : function(error) {
	            alert("파일 업로드에 실패하였습니다.");
	            console.log(error);
	            console.log(error.status);
	        } 
	    });
	});
	
	
	//등록버튼 	
	$('#modify').click(function(){
		console.log("등록클릭");
		$.ajax({
			url : "modify.do",
			data : {
				'no' : <%=im.getNo()%>,
				'kor_name' : $kor_name.val(),
				'eng_name':$eng_name.val(),
				'chn_name':$chn_name.val(),
				'jumin_no1':$jumin_no1.val(),
				'jumin_no2':$jumin_no2.val(),
				'image_name':$image_name.val(),
				
				'year':$year.val(),
				'month':$month.val(),
				'day':$day.val(),
				'bir':$bir.val(),
				
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
	
	
	//전체데이터 입력보내긱
	
	
	
	
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
	                                    <td height="110" bgcolor="#FFFFFF">&nbsp;</td>
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
                              <td height="26" align="right"><strong>주민등록번호 :</strong>&nbsp;</td>
                              
                              <td height="26">
                              ${ismater.jumin_no}
                              <!-- <input name="textfield323" type="text" size="15" > 
							      -
							        <input name="textfield3222" type="text" size="15">--></td>
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
                            
                            <input name="textfield33" type="text" size="40">
                            
                            </td>
                            <td width="146">
	                            <font color="#FF0000">
	                         	   <img src="image/bt_search.gif" width="49" height="18"  name="btSearchFile" >
	                            </font>
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
                            <td width="391"><input name="textfield332" type="text" size="10" >
                              년 
                              <input name="textfield3322" type="text" size="7">
                              월 
                              <input name="textfield33222" type="text" size="7">
                              일 ( 
                              <input type="radio" name="bir" value="solarCalendar">
                              양력 
                              <input type="radio" name="bir" value="lunarCalendar">
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
                            
                           	  <input type="radio" name="sex" value="m">
                           	  남자
                              <input type="radio" name="sex" value="w">
                              여자</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>결혼유무 :&nbsp;</strong></td>
                            <td width="391"> 
                            
                            <input type="radio" name="marital_status" value="married">
                              기혼 
                              <input type="radio" name="marital_status" value="single">
                              미혼    </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>년차 :&nbsp;</strong></td>
                            <td width="392"><input name="textfield3323" type="text" size="10"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>급여 지급유형 :&nbsp;</strong></td>
                            <td width="392"> 
                              <select name="select">
                                <option>월급</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>희망직무 :&nbsp;</strong></td>
                            <td width="392"> <select name="select2">
                                <option>SI</option>
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
                            <td width="392"> <select name="select4">
                                <option>정규직</option>
                              </select> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주소:&nbsp;</strong></td>
                            <td width="392">
                              <input name="textfield3324" type="text" size="10"> 
                              <input name="textfield333" type="text" size="40"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>연락처:&nbsp;</strong></td>
                            <td width="392">
                              <input name="textfield33242" type="text" size="10">
                              - 
                              <input name="textfield332422" type="text" size="10">
                              - 
                              <input name="textfield332423" type="text" size="10"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>이메일:&nbsp;</strong></td>
                            <td width="392"><input name="textfield332424" type="text" size="20"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>기술등급:&nbsp;</strong></td>
                            <td width="392"><input name="textfield3324242" type="text" size="20"> 
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="101" align="right"><strong>주량:&nbsp;</strong></td>
                            <td width="392"><input name="textfield33242422" type="text" size="20"> 
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

<div class = "fileUpLoad" style="border: 1px">

<form id="fileForm"  method="post"
        enctype="multipart/form-data">
        <input type="file" id="fileUp" name="fileUp"/><br/><br/>
        <!-- <input type="file" id="fileUp2" name="fileUp2"/><br/><br/>
        아이디 : <input type="text" name="id" />
        비밀번호 : <input type="password" name="pw" /><br/><br/> -->
        <input type="submit" value="전송하기" >
        <!-- <input type="button" value="전송하기" onClick="fileSubmit();"> -->
    </form>


</div>







</body>
</html>
