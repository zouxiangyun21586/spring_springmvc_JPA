<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery-1.9.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>

	#resourceShow,#ashow {  
		display:none;  
		border:1em solid pink;
		height:50%;  
		width:24%;  
		position:absolute;/*让节点脱离文档流,我的理解就是,从页面上浮出来,不再按照文档其它内容布局*/  
		top:20%;/*节点脱离了文档流,如果设置位置需要用top和left,right,bottom定位*/  
		left:35%;  
		z-index:2;/*个人理解为层级关系,由于这个节点要在顶部显示,所以这个值比其余节点的都大*/  
		background: white;  
	} 
	
	#resourceOver,#aover {  
		width: 100%;  
		height: 100%;  
		opacity:0.3;/*设置背景色透明度,1为完全不透明,IE需要使用filter:alpha(opacity=80);*/  
		filter:alpha(opacity=80);  
		display: none;  
		position:absolute;  
		top:0;  
		left:0;  
		z-index:1;  
		background: silver;  
	}
	
	a{ text-decoration:none;}
	/* css注释： 鼠标经过热点文字被加下划线 */ 
	a:hover{ text-decoration:underline;}
	/* a 标签字体颜色为 黑色 */
	a{color:#000}
</style>
</head>
<body>

	<p align="center">
		<a href="javascript:window.location.href='<%=request.getContextPath() %>/show/login.jsp'">注销登录</a>
	</p>

	<div align="center">
		<table border="1">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
				<th>&nbsp;权限名&nbsp;</th>
				<th>&nbsp;权限Url&nbsp;</th>
				<th>&nbsp;操作&nbsp;</th>
			</tr>
			<tbody id="lo"></tbody>
		</table>
		<a href='javascript:add_show()' >添加权限</a>
	</div>
		
	<form action="" method="POST" id="resourceDel">
		<input type="hidden" name="_method" value="DELETE" />
	</form>
	
	<div id="resourceShow">
		<div align="right">
			<button>
				<a href="javascript:resource_hide()">&nbsp;X&nbsp;</a>
			</button>
		</div> 
		<div align="center">
			<form action="<%=request.getContextPath() %>/resource" method="post">
				<p align="left">修改权限</p>
				<input type="hidden" name="id" id="rid">
				权限名:<input name="resourceName" id="rname" type="text"/><br/>
				权限url:<input name="httpUrl" id="rurl" type="text"/><br/>
				<input name="sub" type="submit" id="sub"/>
				<input name="res" type="reset" id="res"/>
				<input type="hidden" name="_method" value="PUT" />
			</form>
		</div>
		</div>  
	<div id="resourceOver"></div>
	
	<form action="<%=request.getContextPath() %>/resource" method="post">
	<div id="ashow">
		<div align="right">
			<button>
				<a href="javascript:add_hide()">&nbsp;X&nbsp;</a>
			</button>
		</div> 
		<div align="center">
			
				<p align="left">添加权限</p>
				权限名:<input name="resourceName" id="aname" type="text"/><br/>
				权限url:<input name="httpUrl" id="aurl" type="text"/><br/>
				<input name="sub" type="submit" id="sub"/>
				<input name="res" type="reset" id="res"/>
			
		</div>
		</div>  
	<div id="aover"></div>
	</form>
</body>
<script type="text/javascript">

	/* 页面加载完出现 */
	$(document).ready(function(){
		$.ajax({
			type: "get",  // 请求方式(post或get)
			async:false,  //默认true(异步请求),设置为false(同步请求)
			url:"<%=request.getContextPath() %>/resource", // 发送请求的地址
			scriptCharset: 'utf-8',
			dataType:"json",
			success:function(a){
				$("#lo").empty();
				
				var resource = eval("("+a+")"); // 将传过来的值转为json格式
				var abc = "";
				
				for(var i in resource){
				 	abc +=  "<tr><td>"+resource[i].id+"</td>"+
				 			"<td>"+resource[i].resourceName+"</td>"+
				 			"<td>"+resource[i].httpUrl+"</td>"+
					 		"<td><a href='javascript:resource_show("+resource[i].id+")' >修改</a> &nbsp;"+
					 		"<a href='javascript:void(0)' class='del' id='<%=request.getContextPath() %>/resource/"+resource[i].id+"'>删除</a> &nbsp;"+
					 		"</td></tr>";
				}
				$("#lo").append(abc);
				loader();
			},
			error:function(XMLHttpRequest, textStatus, errorThrown){
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(textStatus);
	        }
		});
	});

	
	function loader(){
		$(".del").click(function() {
			if(confirm("确认删除吗?")){
				var dlt = $(this).attr("id");
				$("#resourceDel").attr("action", dlt).submit();
				return false;
			}
		});
	}
	
	var rs = document.getElementById('resourceShow');
	var ro = document.getElementById('resourceOver');
    function resource_show(id)
    {  
    	$.ajax({
			type: "get",  // 请求方式(post或get)
			async:false,  //默认true(异步请求),设置为false(同步请求)
			url:"<%=request.getContextPath() %>/getResource", // 发送请求的地址
			scriptCharset: 'utf-8',
			dataType:"json",
			data:{"id":id},
			success:function(re){
				var resource = eval("("+re+")"); // 将传过来的值转为json格式

				$("#rid").val(resource.id);
				$("#rname").val(resource.resourceName);
				$("#rurl").val(resource.httpUrl);
			}
		})
        rs.style.display = "block";
        ro.style.display = "block";
    }  
    function resource_hide()
    {  
        rs.style.display = "none";
        ro.style.display = "none";
    }

    
    var ars = document.getElementById('ashow');
	var aro = document.getElementById('aover');
    function add_show()
    {  
    	ars.style.display = "block";
        aro.style.display = "block";
    }  
    function add_hide()
    {  
        ars.style.display = "none";
        aro.style.display = "none";
    }
    
</script>
</html>