<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>场馆用户角色管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/reserve/reserveRole/">场馆用户角色列表</a></li>
		<li class="active"><a href="${ctx}/reserve/reserveRole/form?id=${reserveRole.id}">场馆用户角色<shiro:hasPermission name="reserve:reserveRole:edit">${not empty reserveRole.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="reserve:reserveRole:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="reserveRole" action="${ctx}/reserve/reserveRole/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">对应用户ID：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${reserveRole.user.id}" labelName="user.name" labelValue="${reserveRole.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">对应用户权限(json字符串)：</label>
			<div class="controls">
				<form:input path="authority" htmlEscape="false" maxlength="500" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户类型(1:管理员;2:场馆管理员;3:财务;4:收银)：</label>
			<div class="controls">
				<form:input path="userType" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">对应场馆的id(json字符串)：</label>
			<div class="controls">
				<form:input path="venueJson" htmlEscape="false" maxlength="300" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="reserve:reserveRole:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>