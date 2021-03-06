<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>储值卡管理</title>
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
		<li><a href="${ctx}/reserve/storedCardMemberSet/list">储值卡列表</a></li>
		<li class="active"><a href="${ctx}/reserve/storedCardMemberSet/form?id=${reserveStoredcardMemberSet.id}">储值卡<shiro:hasPermission name="reserve:reserveStoredcardMemberSet:edit">${not empty reserveStoredcardMemberSet.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="reserve:reserveStoredcardMemberSet:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="reserveStoredcardMemberSet" action="${ctx}/reserve/storedCardMemberSet/save" method="post" class="form-horizontal" onSubmit="return checkAll()">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="30" class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">项目:</label>
			<div class="controls">
			<sys:select cssClass="input-xlarge" name="reserveProject.id" items="${reserveProjectList}" defaultLabel="全部" defaultValue=""
						value="${reserveProject}" itemLabel="name" itemValue="id">

			</sys:select>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">截止日期:</label>
			<div class="controls">
				<input id="deadline" name="deadline" type="datetime" readonly="readonly" maxlength="20" class="input-mini Wdate"
					   value="<fmt:formatDate value="${deadline}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">起止金额:</label>
			<div class="controls">
				<form:input path="startPrice" htmlEscape="false" class="input-xlarge  number " />&nbsp;至
				<form:input path="endPrice" htmlEscape="false" class="input-xlarge  number " />&nbsp;元
			</div>

		</div>

		<div class="control-group">
			<label class="control-label">赠送金额:</label>
			<div class="controls">
				<form:input path="givePrice" htmlEscape="false" class="input-xlarge  number" />&nbsp;元
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">折扣比率:</label>
			<div class="controls">
				<form:input path="discountRate" htmlEscape="false" class="input-xlarge  number" />&nbsp;%
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="reserve:reservestoredCardMemberSet:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>