<html>
<head>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>


$(function(){
	
	var $header = $('header');
	 var $a =$header.find("a");
	 
	 $a.click(function(){
		 var url = $(this).attr("href");
		 if(url =="list.jsp"){
      	   $.ajax({
      		   url : "selectAll.do",
      		   method: 'GET', 
      		   data:{'pageno':1},
      		   success : function(responseData){
      			   $("article").empty();
      			   $("article").html(responseData.trim()); 
      			   console.log("하하 불러옴");
      		   }
      	   }); return false;
      	   
         }
		 
	       
	       $.ajax({url: url,
	           method: 'GET', 
	           success:function(responseData){
	        	   console.log("1차성공 ");
	             $("article").empty();
	             $("article").html(responseData.trim()); 
	         }
	       });return false;
	       
	       
	     });
     /* $a.click(function(){
       var url = $(this).attr("href");
       $.ajax({url: url,
           method: 'GET', 
           success:function(responseData){
        	   console.log("1차성공 ");
           if(url =="list.jsp"){
        	   $.ajax({
        		   url : "selectAll.do",
        		   method: 'GET', 
        		   data:{'pageno':1},
        		   success : function(responseData){
        			   $("article").empty();
        			   $("article").html(responseData.trim()); 
        			   console.log("하하 불러옴");
        		   }
        	   }); return false;
        	   
           }else{
             $("article").empty();
             $("article").html(responseData.trim()); 
           } 
         }
       
       
       }); // end ajax
       return false;
     }); */   //end click
     
	
	/* $('.menu').find('.insert').click(function(){
		var url = $(this).attr("href");
		$.ajax({
			url : url,
			success :function(responseDate){
				
				$("article").empty();
				$("article").html(responseDate); 
			}
		});return false;
	}); */
	
});



</script>



<body topmargin="0" leftmargin="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td align="center" valign="top"><table width="170" height="300" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="9"><img src="image/left_top.gif" width="170" height="9"></td>
        </tr>
        <tr> 
          <td align="center" valign="top" background="image/left_bg.gif">
          
          
		  <!----------------------  메뉴들 ----------------------------->
		  <table class="menu" width="150" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="17" height="20"><img src="image/left_icon.gif" width="11" height="11" align="absmiddle"></td>
                <td width="133"><a href="list.jsp">기본정보</a></td>
              </tr>
              <tr> 
                <td height="20">&nbsp;</td>
                <td class="insert"><a href="insert.jsp">- 등록</td>
              </tr>
              <tr> 
                <td height="20"><img src="image/left_icon.gif" width="11" height="11" align="absmiddle"></td>
                <td>직원명부</td>
              </tr>
              <tr> 
                <td height="20"><img src="image/left_icon.gif" width="11" height="11" align="absmiddle"></td>
                <td>퇴직자현황</td>
              </tr>
              <tr> 
                <td height="20"><img src="image/left_icon.gif" width="11" height="11" align="absmiddle"></td>
                <td>예비인력정보</td>
              </tr>
              <tr> 
                <td height="20"><img src="image/left_icon.gif" width="11" height="11" align="absmiddle"></td>
                <td>거래처정보</td>
              </tr>
              <tr> 
                <td height="20">&nbsp;</td>
                <td>- 등록</td>
              </tr>
            </table>
		  <!----------------------  메뉴들 ----------------------------->
		  
		  
			</td>
        </tr>
        <tr> 
          <td height="9"><img src="image/left_bottom.gif" width="170" height="9"></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td align="center"><table width="170" height="49" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td align="center" background="image/left_box.gif">
		  <!------------------------------ 경력검색 ---------------------------------->
		  <table width="155" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="17"><img src="image/left_icon.gif" width="11" height="11" align="absmiddle"></td>
                <td width="143" height="20"><strong>경력검색</strong></td>
              </tr>
              <tr align="right"> 
                <td colspan="2"><input name="textfield" type="text" class="flat" size="15" maxlength="14"> 
                  <img src="image/search.gif" width="49" height="18" align="absmiddle"></td>
              </tr>
            </table>
		  <!------------------------------ 경력검색 ---------------------------------->
			</td>
        </tr>
      </table></td>
  </tr>
</table>


</body>
</html>
