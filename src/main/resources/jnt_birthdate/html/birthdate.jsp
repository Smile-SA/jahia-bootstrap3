<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<c:set var="nodeId" value="${currentNode.identifier}"/>
<c:set var="nodeName" value="${currentNode.name}"/>

<c:set var="required" value=""/>
<c:if test="${jcr:hasChildrenOfType(currentNode, 'jnt:required')}">
    <c:set var="required" value="required"/>
</c:if>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<c:set var="previousDate" value="${sessionScope.formDatas[currentNode.name][0]}"/>
<c:if test="${not empty previousDate}">
    <c:set var="splittedDate" value="${fn:split(sessionScope.formDatas[currentNode.name][0], '-')}"/>
    <c:set var="previousYear" value="${splittedDate[0]}"/>
    <c:set var="previousMonth" value="${splittedDate[1]}"/>
    <c:set var="previousDay" value="${splittedDate[2]}"/>
</c:if>

<template:addResources>
	<script type="text/javascript">
	$(function() {
	    $('#birthdate-${nodeId} select[name="year"],#birthdate-${nodeId} select[name="month"],#birthdate-${nodeId} select[name="day"]').change(function() {
	        var x = $('#birthdate-${nodeId} select[name="year"]').val()+'-'+$('#birthdate-${nodeId} select[name="month"]').val()+'-'+$('#birthdate-${nodeId} select[name="day"]').val();
	        $('#birthdate-value-${nodeId}').val(x);
	    });
	});
	</script>
</template:addResources>


<div id="birthdate-${nodeId}" class="form-group">
	<input type="text" id="birthdate-value-${nodeId}" name="${nodeName}" class="form-control hidden" ${required} ${disabled} value="${date}" readonly="readonly"/>
	<label class="control-label">
		${title}
	</label>
	
	  <jsp:useBean id="now" class="java.util.Date" />
	  <fmt:formatDate var="year" value="${now}" pattern="yyyy" />
	  
	  <div class="row-fluid clearfix">
		<div class="col-xs-4">
			<select class="form-control" name="year" ${disabled}>
				<option><fmt:message key="label.year"/></option>
					<c:forEach var="i" begin="0" end="${year - 1900}" step="1">
						<option <c:if test="${not empty previousYear && previousYear eq year - i}">selected="selected"</c:if>>${year - i}</option>
					</c:forEach>
			</select>
		</div>
		
		<div class="col-xs-4">
			<select class="form-control" name="month" ${disabled}>
				<option><fmt:message key="label.month" /></option>
				<c:forEach var="i" begin="1" end="12" step="1">
					<option
						<c:if test="${not empty previousMonth && previousMonth eq i}">selected="selected"</c:if>>${i}</option>
				</c:forEach>
			</select>
		</div>
		
		<div class="col-xs-4">
			<select class="form-control" name="day" ${disabled}>
				<option><fmt:message key="label.day" /></option>
				<c:forEach var="i" begin="1" end="31" step="1">
					<option
						<c:if test="${not empty previousDay && previousDay eq i}">selected="selected"</c:if>>${i}</option>
				</c:forEach>
			</select>
		</div>
	</div>
</div>