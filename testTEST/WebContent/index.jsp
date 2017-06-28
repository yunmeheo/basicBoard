<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>


$(function(){
	

	
});



</script>

<style>

.left{
display: inline-block;
float: left;


}


.main{

display: inline-block;
float: left;

}

article{
float: left;
}

</style>

<header>

<div class="left">
<jsp:include page = "left.jsp"></jsp:include>
</div>



</header>

<article>




<div class="main">
<jsp:include page = "main.jsp"></jsp:include>
</div>







</article>

<footer></footer>




<!-- <frameset cols="180,*" frameborder="NO" border="0" framespacing="0">
  <frame src="left.jsp" name="leftFrame" scrolling="NO" noresize>
  <frame src="main.htm" name="mainFrame">
</frameset>
 -->
<noframes>



</body>
</noframes>
</html>
