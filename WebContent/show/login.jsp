<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery-1.9.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style> 
	a{ text-decoration:none;}
	/* css注释： 鼠标经过热点文字被加下划线 */ 
	a:hover{ text-decoration:underline;}
	a{color:#000}
</style> 
</head>
<body onload="err();" >
	<center>
		<form action="<%=request.getContextPath()%>/login_ssj">
			<h5>请输入用户名:<input type="text" id="account" name="account"/></h5><form:errors path="account"></form:errors>
			<h5>请输入密码:<input type="password" id="password" name="password"/></h5><form:errors path="password"></form:errors>
			<input type="submit" value="登录	" />  &nbsp;&nbsp;&nbsp;
			<input type="reset" value=" 重置 " />
			
			<input type="hidden" name="err" id="errId" value="${err}" /> 
			
			<div align="center" style="display: none;" id="code"> <!-- 第一次进来隐藏验证码 -->
		        <input type="text" name="randomCode" />  <!-- 要输入的验证码 -->
				<img id="vimg" title="点击更换" onclick="changeCode();" src="<%=request.getContextPath()%>/authlmageServlet"><br /> <!-- 获取图片（里面有验证码） -->
			</div>
		</form>
	</center>
</body>
<script type="text/javascript">

	function changeCode() {
		var imgNode = document.getElementById("vimg");
		//Math.random(); 随机数，只是为了每次都请求sevlet，如果每次请求的都是同一个值，那么只会请求一次servlet
		imgNode.src = "<%=request.getContextPath()%>/authlmageServlet?t=" + Math.random();
	}
	
	function err() {
		var hiddenCodeId = document.getElementById("code").value;/* 得到隐藏验证码输入框的值 */
		var err = document.getElementById("errId").value;//得到错误的值
		if ("" == hiddenCodeId) {//如果值等于空，就说明是第一次登录
			document.getElementById("code").style.display = "none";//将验证码输入框隐藏起来
		} else if ("1" == hiddenCodeId) {//如果等于1 说明不是第一次

			document.getElementById("code").style.display = "";//将验证码输入框 
		}

		if ("0" == err) {//如果err等于1，表示验证码输入错误
			alert("用户名或密码输入错误");
			$("#span").html("请输入用户名或密码").css("color", "green");
		} else if ("0" == err) {//如果err等于1，表示验证码输入错误
			alert("请输入用户名或密码");
			$("#span").html("请输入用户名或密码").css("color", "green");
		} else if ("2" == err) {//如果err等于1，表示验证码输入错误
			//alert("验证码输入错误");
			$("#span").html("验证码输入错误").css("color", "green");
		}
	}
</script>
</html>