<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
<title>list.jsp</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>


$(function(){
	
	
	//$('.list').find('a').click(function(){
		//paging
		$('.paging').click(function(){
		var pageno = $(this).attr('id')
		console.log(pageno);
		$.ajax({
			url:'selectAll.do',
            method: 'GET', 
            data:{
            	'pageno': pageno
			},
            success:function(responseData){
            	
            	$("article").empty();
                $("article").html(responseData.trim()); 
          }
        });  // end ajax
		return false; 
	});
	
	
	/* 검색하기 */
	<% String item = request.getParameter("searchItem");
	  if(item == null){
		item="all";  
	  }
	  
	%>
	
	    $("option[value=name]").attr("selected","true");
		/* $("input[name=searchvalue]").val('${param.searchvalue}')
		$("form").submit(function(){
			return false;
		}); */
		
		
		$(".btSearch").click(function(){
			var searchItem = $('.searchItem').val();
			var searchValue = $('.searchValue').val();
			
			console.log("searchItem : "+searchItem+", searchValue : "+searchValue);
			$.ajax({ url:"selectAll.do",
					method:"GET",
					data:{'searchItem' : searchItem,
						  'searchValue' : searchValue,
						  'pageno': 1},
					success:function(responseData){
						
					var $parentObj = $("article");		
					if($("article").length == 0){
						$parentObj ==  $("body");
					}
					
					$parentObj.empty();
					$parentObj.html(responseData.trim());
				}
			});
			return false;
		});  // end button
	
		
		
		
		var arrayParam = null;  
		$("input:checkbox[name='checkbox']").click(function(){
			
			//중복체크박지
			arrayParam = new Array(); 
	    	$("input:checkbox[name='checkbox']:checked").each(function(){
	        	arrayParam.push($(this).val());
	    	}); 
	    	if(arrayParam.length>1){
				$("input:checkbox[name='checkbox']").prop('checked', false);
				this.checked = true;
		   }
	    	
	    	
	    	//삭제액션
	    	var checkedId = $(this).attr("value");
		      console.log(checkedId);
		      
		      $('.delete').click (function(){
				console.log("삭제클릭");
				 //개별체크액션 = 각 체크된 아이디값 가져오기
				 $.ajax({
					 
					url : 'delete.do',
					data : {'checkedId' : checkedId},
					method : 'GET',
					success : function(responseData){
						
					var result = responseData.trim();
					if(result=="1"){
						alert("성공");
						
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
						alert("실패");
					
					}
					
					}
				 }); return false;
					
			 });
		      
		      
		      
		      //수정
		      $('.modify').click (function(){
					console.log("수정클릭");
					
					$.ajax({url: 'selectByNo.do',
				           method: 'GET', 
				           data : {'checkedId' : checkedId},
				           success:function(responseData){
				        	   console.log("1차성공 ");
				             $("article").empty();
				             $("article").html(responseData.trim()); 
				         }
				       });return false;
				       
					 //개별체크액션 = 각 체크된 아이디값 가져오기
					/*  $.ajax({
						 
						url : 'modify.do',
						data : {'checkedId' : checkedId},
						method : 'GET',
						success : function(responseData){
							
						var result = responseData.trim();
						if(result=="1"){
							alert("성공");
							
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
							alert("실패");
						
						}
						
						}
					 }); return false; */
						
				 });
		      
		      
		      
		      
		      
		      
	    	
	    	
	    });
			
		
		
		
	
		
	
	
	
});



</script>

<style>

</style>

<body topmargin="0" leftmargin="0">
<table class ="list" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td height="25"><img src="image/icon.gif" width="9" height="9" align="absmiddle"> 
      <strong>사원조회</strong></td>
  </tr>
  <tr> 
    <td><table width="640" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="30" align="right">
          
          
          
          <select name="select" class="searchItem">
         	<option selected value="name">이름</option>
              <option selected value="sex">성별</option>
              <option selected value="teclev">기술등급</option>
         	  <option selected value="" name="all">::::전체::::</option>
            </select> 
            
            <input name="textfield" type="text" class="searchValue"> 
            
            <a href=""><img src="image/search.gif" width="49" height="18" border="0" align="absmiddle" class="btSearch"></a></td>
        </tr>
        <tr> 
          <td><table width="640" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="3" background="image/bar_bg1.gif"></td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="26" align="right" bgcolor="F8F8F8" style="padding-right:10"><img src="image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="" class="modify" >수정</a> <img src="image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">인사기록카드</a> <img src="image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">경력정보</a> <img src="image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">근무정보</a> </td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="1" align="right" bgcolor="B1B1B1"></td>
              </tr>
              <tr> 
                <td>
				<!-------------------------  리스트 ------------------------------>
				<table width="640" border="0" cellspacing="0" cellpadding="0">
				
				<c:set var="list" value="${requestScope.list}"/>
				<c:set var="listSize"  value="${requestScope.listSize}"/> 
				
				
				
				<tr> 
                      <td width="35" height="20" align="center"><input type="checkbox" name="checkbox" value="checkbox"></td>
                      <td width="153" align="center">no</td>
                      <td width="85" align="center">한국이름</td>
                      <td width="153" align="center">주민번호</td>
                      <td width="91" align="center">성별</td>
                      <td width="91" align="center">날짜</td>
                      <td width="91" align="center">업무</td>
                      <td width="94" align="center">등급</td>
                    </tr>
                    
                    <tr> 
                      <td colspan="7" background="image/line_bg.gif"></td>
                    </tr>
				
				
				<c:forEach var="ismater"  items="${list}" >
				
				
					<tr> 
                      <td width="35" height="20" align="center"><input type="checkbox" name="checkbox" value="${ismater.no}"></td>
                     	<td width="153" align="center">${ismater.no}</td>
                      <td width="85" align="center">${ismater.kor_name}</td>
                      <td width="153"align="center">${ismater.jumin_no}</td>
                      
                      <c:if test="${ismater.sex eq 'w'}">
                      <td width="91" align="center">여성<%-- ${ismater.sex} --%></td>
                      </c:if>
                      <c:if test="${ismater.sex eq 'm'}">
                      <td width="91" align="center">남성<%-- ${ismater.sex} --%></td>
                      </c:if>
                      
                      
                      <td width="91" align="center">${ismater.work_date}</td>
                      <td width="91" align="center">${ismater.work_flag}</td>
                      <td width="94" align="center">${ismater.tech_lev}</td>
                    </tr>
                    
                    <tr> 
                      <td colspan="7" background="image/line_bg.gif"></td>
                    </tr>
				
				
				</c:forEach>
                    
                    <tr> 
                      <td height="35" colspan="7" align="center" style="padding-bottom:3">
                      
					<%
						int pageno = Integer.parseInt(request.getParameter("pageno"));
						/* 전체리스트 길이 구해오기 시작 */
						Integer objTotal_record = (Integer)request.getAttribute("listSize");
						int total_record=objTotal_record;
						/* 전체리스트 길이 구해오기 끝 */
						
						int page_per_record_cnt = 10; 
						int group_per_page_cnt =5;     
						int record_end_no = pageno*page_per_record_cnt;				
						int record_start_no = record_end_no-(page_per_record_cnt-1);
						if(record_end_no>total_record){
							record_end_no = total_record;
						}
						int total_page = total_record / page_per_record_cnt + (total_record % page_per_record_cnt>0 ? 1 : 0);
						if(pageno>total_page){
							pageno = total_page;
						}
						int group_no = pageno/group_per_page_cnt+( pageno%5 >0 ? 1:0);
						int page_eno = group_no*group_per_page_cnt;		
						int page_sno = page_eno-(group_per_page_cnt-1);	
						if(page_eno>total_page){
							page_eno=total_page;
						}
						int prev_pageno = pageno-1;
						int next_pageno = pageno+1;
						if(prev_pageno<1){
							prev_pageno=1;
						}
						if(next_pageno>total_page){
							next_pageno=total_page/group_per_page_cnt*group_per_page_cnt+1;
							System.out.println(" 최대페이지보다 큰 next_pageno : " +next_pageno);
						}
					%>

				<a href="" id="1" class="paging"><img src="image/prev.gif" width="22" height="15" border="0" align="absmiddle"></a>&nbsp;
                <a href="" id="<%=prev_pageno%>" class="paging"><img src="image/pre.gif" width="42" height="15" border="0" align="absmiddle"></a>&nbsp; 
                                            
					
					<%for(int i =page_sno;i<=page_eno;i++){%>
						<a href="" class="paging" id="<%=i%>">
							<%if(pageno == i){ %>
								[<%=i %>]
							<%}else{ %>
								<%=i %>
							<%} %>
						</a> 
					<%--	콤마	 --%>	
						<%if(i<page_eno){ %>
							|
						<%} %>
					<%} %>
					 
                        
                  <a href="" id="<%=next_pageno%>" class="paging"><img src="image/next.gif" width="42" height="15" border="0" align="absmiddle"></a>&nbsp
				  <a href="" id="<%=total_page%>" class="paging"><img src="image/next_.gif" width="22" height="15" border="0" align="absmiddle"></a>
					
                    
                    </td>
                    
                    </tr>
                  </table>
 				<!-------------------------  리스트 ------------------------------>
				  </td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="1" align="right" bgcolor="B1B1B1"></td>
              </tr>
              <tr align="center" bgcolor="F8F8F8"> 
                <td height="26" align="right" bgcolor="F8F8F8" style="padding-right:10"><img src="image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="" class="delete">삭제</a> <img src="image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">인사기록카드</a> <img src="image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">경력정보</a> <img src="image/all_icon.gif" width="11" height="11" align="absmiddle"> 
                  <a href="#">근무정보</a> </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="3" background="image/bar_bg1.gif"></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>

</html>
