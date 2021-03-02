<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>员工列表</title>
<!-- Bootstrap -->
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container"></div>
	<!-- 标题 -->
	<div class="row">
		<div class="col-md-12">
			<h1>SSM-CRUD</h1>
		</div>
	</div>

	<!-- 按钮 -->
	<div class="row">
		<div>
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
	</div>

	<!-- 显示表格数据 -->
	<div class="row">
		<div calss="col-md-12">
			<table class="table table-hover">
				<tr>
					<th>#占位</th>
					<th>#empName</th>
					<th>#gender</th>
					<th>#email</th>
					<th>#deptName</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${pageInfo.list}" var="emp">
					<tr>
						<th>${emp.id}</th>
						<th>${emp.empName}</th>
						<th>${emp.gender=="M"?"男" : "女" }</th>
						<th>${emp.email}</th>
						<th>${emp.dept.deptName}</th>
						<th>
							<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								编辑
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
							</button>
						</th>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<!-- 显示分页信息 -->
	<div class="row">
		<!-- 分页文字信息 -->
		<div class="col-md-6">
			当前页数为:${pageInfo.pageNum}<br>总页数为:${pageInfo.pages}<br>总记录数为:${pageInfo.total}
		</div>

		<!-- 分页条信息 -->
		<div class="col-md-6">
			<nav aria-label="Page navigation">
			<ul class="pagination">
				<li><a href="${APP_PATH }/emps?pn= 1"> 首页 </a></li>
				<c:if test="${ pageInfo.hasPreviousPage}">
					<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum - 1}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
				</c:if>


				<c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
					<c:if test="${page_Num == pageInfo.pageNum }">
						<li class="active"><a href="#">${page_Num}</a></li>
					</c:if>
					<c:if test="${page_Num != pageInfo.pageNum }">
						<li><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num}</a></li>
					</c:if>
				</c:forEach>
				
				<c:if test="${ pageInfo.hasNextPage}">
				<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum + 1}" aria-label="Next"> 
				<span aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
				
				<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}"> 末页 </a></li>
			</ul>
			</nav>
		</div>
	</div>

</body>
</html>