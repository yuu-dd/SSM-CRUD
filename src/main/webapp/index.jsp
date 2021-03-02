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

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>

</head>
<body>


<!-- 修改Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">编辑</h4>
      </div>
      <div class="modal-body">
      
        <!-- 内联表单 -->
<form class="form-horizontal">
  <div class="form-group">
    <label for="name_add" class="col-sm-2 control-label">姓名</label>
    <div class="col-sm-8">
      <p class="form-control-static" id="empName_update"></p>
      <span class="help-block"></span>
    </div>
  </div>
    
  <div class="form-group">
    <label for="email_add" class="col-sm-2 control-label">邮箱</label>
    <div class="col-sm-8">
      <input type="text" name="email" class="form-control" id="email_update" placeholder="xxx@email.com">
      <span class="help-block"></span>
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label">部门</label>
    <div class="col-sm-4">
    <!-- 部门只要提交部门id -->
     <select class="form-control" name="dId">
	 
	</select>
    </div>
  </div>
  
  
  <div class="form-group">
    <label for="radio-inline" class="col-sm-2 control-label">性别</label>
    <div class="col-sm-10">
     <label class="radio-inline">
  		<input type="radio" name="gender" id="inlineRadio1" value="M"> 男
	</label>
     <label class="radio-inline">
  		<input type="radio" name="gender" id="inlineRadio2" value="F"> 女
	</label>
    </div>
  </div>
  </form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update">更新</button>
      </div>
    </div>
  </div>
</div>



<!-- 添加Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
      </div>
      <div class="modal-body">
      
        <!-- 内联表单 -->
<form class="form-horizontal">
  <div class="form-group">
    <label for="name_add" class="col-sm-2 control-label">姓名</label>
    <div class="col-sm-8">
      <input type="text" name="empName" class="form-control" id="name_add" placeholder="k.k">
      <span class="help-block"></span>
    </div>
  </div>
    
  <div class="form-group">
    <label for="email_add" class="col-sm-2 control-label">邮箱</label>
    <div class="col-sm-8">
      <input type="text" name="email" class="form-control" id="email_add" placeholder="xxx@email.com">
      <span class="help-block"></span>
    </div>
  </div>
  
  <div class="form-group">
    <label class="col-sm-2 control-label">部门</label>
    <div class="col-sm-4">
    <!-- 部门只要提交部门id -->
     <select class="form-control" name="dId">
	 
	</select>
    </div>
  </div>
  
  
  <div class="form-group">
    <label for="radio-inline" class="col-sm-2 control-label">性别</label>
    <div class="col-sm-10">
     <label class="radio-inline">
  		<input type="radio" name="gender" id="gender1_add_input" value="M" > 男
	</label>
     <label class="radio-inline">
  		<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
	</label>
    </div>
  </div>
  </form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save">保存</button>
      </div>
    </div>
  </div>
</div>



	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>

		<!-- 按钮 -->
		<div class="row">
				<div class="col-md-4 col-md-offset-12">
					<button class="btn btn-primary" id="emp_add_modal_btn">新增员工</button>
					<button class="btn btn-danger" id="emp_del_all_btn">批量删除</button>
				</div>
		</div>

		<!-- 显示表格数据 -->
		<div class="row">
			<div calss="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th align="center">员工ID</th>
							<th align="center">姓名</th>
							<th align="center">性别</th>
							<th align="center">邮箱</th>
							<th align="center">部门</th>
							<th align="center">操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>


		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>

			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		//1.页面加载完成以后，直接发送Ajax请求，获取分页数据
		var totalRecord,currentPage;
		$(function(){
			to_page(1);
		})
		
		function to_page(pn){
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析显示分页数据
					build_page_nav(result);
				}
			});
		}

		function build_emps_table(result) {
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义属性，表示当前员工id
				editBtn.attr("edit-id",item.id);
				
				var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加自定义属性，表示当前要删除的员工id
				deleteBtn.attr("del-id",item.id);
				
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);

								
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.id);
				var empNameTd = $("<td></td>").append(item.empName);
				var empgenderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.dept.deptName);
				//append方法执行完成以后还是执行原来的元素
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						empgenderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#emps_table tbody");
			});
		}

		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前页数为:" + result.extend.pageInfo.pageNum + "<br>总页数为:"
							+ result.extend.pageInfo.pages + " <br>总记录数为: "
							+ result.extend.pageInfo.total);
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}

		//分页条
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var fristPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
			
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				fristPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				fristPageLi.click(function() {
				to_page(1);
			});
			
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum - 1);
			});
			}				

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
				
			}else{
				nextPageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum + 1);
			});
			
			lastPageLi.click(function() {
				to_page(result.extend.pageInfo.pages);
			});
			}
			
			
			ul.append(fristPageLi).append(prePageLi);

			//1.页码遍历
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页的提示
			ul.append(nextPageLi).append(lastPageLi);

			//吧ul加入到nav元素中
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//清空表单样式及内容
		function reset_form(ele){		
			
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
				
		}
		
		//新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//表单重置
			
			//$("#empAddmodal form")[0].reset();
			reset_form("#empAddModal form");
			
			getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查出部门信息并显示在下拉列表中
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.id);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		
		//格式校验
		function validate_add_form(){
			//1.获取需要校验的数据
			var empName = $("#name_add").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名需要2-5位中文或6-16位英文或数字（组合）");
				
				show_validate_msg("#name_add","error","用户名需要2-5位纯中文或6-16位英文及数字（组合）,不可使用除 _   - 之外的符号，包括空格");
				return false;
			}else{
				show_validate_msg("#name_add","success","");
				
			};
				
			var email = $("#email_add").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;			
				if(!regEmail.test(email)){
					//alert("邮箱格式错误（示例格式：xxxxxx@email.com）");
					show_validate_msg("#email_add","error","邮箱格式错误（示例格式：xxxxxx@email.com）");
					return false;
				}else{
					show_validate_msg("#email_add","success","");
				}
			return true;
		};
		
		
		function show_validate_msg(ele,status,msg){
			//应该清空该元素之前的样式
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		
		$("#name_add").change(function(){
			//发送Ajax请求校验用户名是否可用
			var empName = this.value;
			
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#name_add","success","用户名可用");
						$("#emp_save").attr("ajax-va","success");
					}else{
						show_validate_msg("#name_add","error",result.extend.va_msg);
						$("#emp_save").attr("ajax-va","error");
					}
				}
			});
		});
		
		$("#emp_save").click(function(){
			//1.静态框中填写的表单数据提交给服务器进行保存
			if(!validate_add_form()){
				return false;
			};
			
			//
			if($(this).attr("ajax-va") == "error"){
				return false;
			}
			
			//2.发送Ajax请求保存员工数据
			 $.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					if(result.code == 100){
						//alert(result.msg)
					//保存成功后的逻辑
					//1.关闭模态框
					$('#empAddModal').modal('hide');
					
					//2.返回最后一页显示新添加的数据
					
					to_page(totalRecord);
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个错误字段的信息就显示哪个字段的
						if(undefined != result.extend.errorFields.email){
							show_validate_msg("#email_add","error","邮箱格式错误（示例格式：xxxxxx@email.com）");
							
						}
						
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#name_add","error","邮箱格式错误（示例格式：xxxxxx@email.com）");
						}
					}
				}	
			});
		});
		
		
		
		
		
		
		//	编辑功能
		//1.按钮创建之前就绑定了click，所以绑定不上
		//	解决办法， 绑定.on()  旧版jQuery为.live()
		$(document).on("click",".edit_btn",function(){
			//alert("edit")
			//	查询并显示员工信息
			getEmp($(this).attr("edit-id"));
			
			//	把员工id传递给模态框的更新按钮
			$("#emp_update").attr("edit-id",$(this).attr("edit-id"));
			
			//查询部门信息，并显示部门列表
			getDepts("#updateModal select");
			$("#updateModal").modal({
				backdrop:"static"
			});
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"GET",
				success:function(result){
						//console.log(result);
						var empData = result.extend.emp;
						$("#empName_update").text(empData.empName);
						$("#email_update").val(empData.email);
						$("#updateModal input[name = gender]").val([empData.gender]);
						$("#updateModal select").val([empData.dId]);
				}
			});
		}
		
		
		//点击保存，更新员工信息
		$("#emp_update").click(function(){
			//验证邮箱是否合法
			var email = $("#email_update").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;			
				if(!regEmail.test(email)){
					//alert("邮箱格式错误（示例格式：xxxxxx@email.com）");
					show_validate_msg("#email_update","error","邮箱格式错误（示例格式：xxxxxx@email.com）");
					return false;
				}else{
					show_validate_msg("#email_update","success","");
				}
				
				
				//	发送Ajax请求保存更新的员工数据
				$.ajax({
					url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
					type:"PUT",
					data:$("#updateModal form").serialize(),
					success:function(result){
						//alert(result.msg);
						//	更新完成后关闭当前对话框回到本页面
						$("#updateModal").modal("hide");
						
						to_page(currentPage);
					}
				})
		});
		
		
		//单个删除功能
		$(document).on("click",".delete_btn",function(){
			//	弹出是否删除提示框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var id = $(this).attr("del-id");
			
			if(confirm("确认删除【" + empName + "】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/" + id,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						$("#deleteModal").modal("hide");
						to_page(currentPage);
					}
				});
			}
			
		});
		
		
		//全选/全不选功能
		$("#check_all").click(function(){
			// attr获取到checked为undefind；原生的属性推荐用prop获取，attr则用来获取自定义属性的值
			$(this).prop("checked");
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		
		//check_item
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否是五个
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
			
		});
		
		$("#emp_del_all_btn").click(function(){
			
			var empNames = "  ";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//alert($(this).parents("tr").find("td:eq(2)").text());
				empNames += $(this).parents("tr").find("td:eq(2)").text() + "  ";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-"
			});
			//去除拼接字符串多余的-
			del_idstr = del_idstr.substring(0,del_idstr.length - 1);
			
			
			if($(".check_item:checked").length != 0){		
				if(confirm("确认删除【" + empNames + "】吗？")){//发送Ajax请求
					$.ajax({
						url:"${APP_PATH}/emp/" + del_idstr,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							// 回到当前页面
							to_page(currentPage);
							}
						});
					}
			}else{
				alert("请选择至少一位员工");
			}
		});

	</script>
</body>
</html>