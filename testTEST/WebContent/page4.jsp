<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>


<html>
<head>

<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<style>
.fileUpLoad {display: none;}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>


$(function(){
	
	//var no = $("input[name=]");
	var $korName= $("input[name=textfield4]");  //한글이름
	var $engName= $("input[name=textfield22]");   //영문이름
	var $lastSchool  = $("input[name=textfield34]");  //*** 한문이름
	
	var $juminNo= $("input[name=textfield323]");  //앞 주민번호
	var $juminNo= $("input[name=textfield3222]"); //뒤 주민번호
	
	/* 이미지올리기 재료들 */
	//var $image= $("input[name=textfield33]");   //파일명
	var $btSearchFile = $("img[name=btSearchFile]");  // img인데...  파일검색버튼
	
	/* 생년월일 재료들 */
	//var major  = $("input[name=]");  //***생년월일
	var $textfield332= $("input[name=textfield332]"); // 년
	var $textfield3322= $("input[name=textfield3322]"); // 월
	var $textfield33222= $("input[name=textfield33222]");  //일
	var $solarCalendar= $("radiobutton [name=solarCalendar]");// 양력  
	var $lunarCalendar= $("radiobutton [name=lunarCalendar]");  //음력  
	
	/* 성별재료들*/
	//var sex
	var $man= $("radiobutton[name=man]");
	var $woman= $("radiobutton[name=woman]");
	
	/* 결혼유무 재료들 */
	//var graduDate= $("input[name=]");    //***결혼유무od
	var $single= $("radiobutton[name=single]")
	var $married= $("radiobutton[name=married]")
	
	var $workDate= $("input[name=textfield3323]");   //년차
	//var comLag= $("input[name=]");  null예정
	var $licence1  = $("select[name=select]"); //***급여지금유형
	var $workFlag= $("input[name=select2]");  // 희망직무
	var $licence2  = $("select[name=select4]"); //***입사유형
	
	/* 주소재료들 */
	var $address1= $("input[name=textfield3324]");
	var $address2= $("input[name=textfield333]");
	
	
	/* 연락처재료들 */
	var $phone1= $("input[name=textfield33242]");
	var $phone2= $("input[name=textfield332422]");
	var $phone3= $("input[name=textfield332423]");
	
	var $email= $("input[name=textfield332424]");  // 이메일
	
	var $techLev= $("input[name=textfield3324242]");
	
	
	//var state= $("input[name=]");  null예정
	
	
	var $licence3 = $("input[name=textfield33242422]");  //***주량
	
	
	
	
	
	//파일검색 클릭시 파일 업로드창 띄우기
	$btSearchFile.click(function(){
		console.log("파일검색 클릭됨");
		$(".fileUpLoad").show();
	});  //end for click
	
	
	/* $image.focus(function(){
		
		
	}); */
	
	
	
	 
	
	
	$('#fileForm').submit(function fileSubmit() {
	    var formData = new FormData($("#fileForm")[0]);
	    var $image= $("input[name=textfield33]");   //파일명
	    //$image.val('이름을 입력하세요');
	    
	    $.ajax({
	        type : 'post',
	        url : 'fileUpload.do',
	        data : formData,
	        processData : false,
	        contentType : false,
	        success : function(responseData) {
	        	
	            alert("파일 업로드하였습니다.");
	            $(".fileUpLoad").hide();
	            
	            var fileValue = $("#fileUp").val().split("\\");
	            var fileName = fileValue[fileValue.length-1]; // 파일명
	            
	            //파일명 넣기  -  구현중
	            $image.val(fileName);
	            console.log("파일명 : "+fileName);
	            
	            
	        },
	        error : function(error) {
	            alert("파일 업로드에 실패하였습니다.");
	            console.log(error);
	            console.log(error.status);
	        }
	    });
	});
	
	
	
	
	//전체데이터 입력보내긱
	
	
	
	
	
	
	
	
});  // end for all function


/* function fileSubmit() {
    var formData = new FormData($("#fileForm")[0]);
    var $image= $("input[name=textfield33]"); 
    $.ajax({
        type : 'post',
        url : 'fileUpload.do',
        data : formData,
        processData : false,
        contentType : false,
        success : function(html) {
            alert("파일 업로드하였습니다.");
            
            //파일 업로드 성공시 $('#uploadedList'); 에 이미지 띄우기 해야함
            $(".fileUpLoad").hide();
            var fileUp = $('#fileUp').val();
            console.log(fileUp);
            $image.val("파일명");
        },
        error : function(error) {
            alert("파일 업로드에 실패하였습니다.");
            console.log(error);
            console.log(error.status);
        }
    });
}
 */









/* textfield4  // 한글이름
textfield22   //영문이름
textfield34  // 한문이름

textfield323 - textfield3222  // 주민번호


textfield33  // 파일명
btSearchFile  // 파일검색버튼

textfield332  //년
textfield3322  //월
textfield33222  //일

//radiobutton 

solarCalendar  // 양력 
lunarCalendar  //음력 
man  //남자  
woman  // 여자 
single  //미혼  
married  //기혼  


 textfield3323  //년차  

 select//급여지급유형  


 select2//희망직무  

  //select3   // 중복항목  급여지급유형 

 select4//입사유형  

//주소 
textfield3324  //주소   
textfield333  //주소  

//전화번호  
textfield33242   // 
textfield332422      //
textfield332423//

textfield332424  //이메일   
textfield3324242  //기술등급 
textfield33242422  //주량    


 */
</script>




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
	                              <table width="100" border="0" cellspacing="1" cellpadding="0" id="uploadedList">
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
                                <input type="text" name="textfield4">
                              </td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>영문이름 :&nbsp;</strong></td>
                              <td height="26"><input type="text" name="textfield22"></td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>한문이름:</strong>&nbsp;</td>
                              <td height="26"><input type="text" name="textfield34"></td>
                            </tr>
                            <tr>
                              <td height="26" align="right"><strong>주민등록번호 :</strong>&nbsp;</td>
                              <td height="26"><input name="textfield323" type="text" size="15">
      -
        <input name="textfield3222" type="text" size="15"></td>
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
	                         	   <img src="image/bt_search.gif" width="49" height="18"  name="btSearchFile">
	                            </font>
                            </td>
                          </tr>
                        </table>
                        <!-- 사진 업뎃 종료 -->
                        
                        </td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>생년월일 :&nbsp;</strong></td>
                            <td width="391"><input name="textfield332" type="text" size="10">
                              년 
                              <input name="textfield3322" type="text" size="7">
                              월 
                              <input name="textfield33222" type="text" size="7">
                              일 ( 
                              <input type="radio" name="radiobutton" value="solarCalendar">
                              양력 
                              <input type="radio" name="radiobutton" value="lunarCalendar">
                              음력 )</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>성별 :&nbsp; </strong></td>
                            <td width="391"> 
                            
                           	  <input type="radio" name="radiobutton" value="man">
                           	  남자
                              <input type="radio" name="radiobutton" value="woman">
                              여자</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td bgcolor="#E4EBF1"><table width="500" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td width="102" align="right"><strong>결혼유무 :&nbsp;</strong></td>
                            <td width="391"> <input type="radio" name="radiobutton" value="married">
                              기혼 
                              <input type="radio" name="radiobutton" value="single">
                              미혼</td>
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
              <td width="49"><img src="image/bt_remove.gif" width="49" height="18"></td>
              <td width="51"><img src="image/bt_cancel.gif" width="49" height="18"></td>
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
