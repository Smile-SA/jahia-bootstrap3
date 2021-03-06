<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<c:set var="nodeName" value="${currentNode.name}"/>


<c:set var="required" value=""/>
<c:if test="${jcr:hasChildrenOfType(currentNode, 'jnt:required')}">
    <c:set var="required" value="required"/>
</c:if>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<div class="form-group">
	
	<c:if test="${not empty title}">
		<label class="control-label col-xs-2" for="${nodeName}">
			${title}
		</label>
	</c:if>
	
	<template:addResources type="inlinejavascript">
		<script type='text/javascript'>
		$(function() {
		   $('input[name="${currentNode.name}box"]').change(function() {
		       var values = $("input[name='${currentNode.name}box']:checked").map(function() {
		           return this.value;
		       }).get();
		        $('#${currentNode.name}').val(values.join(" "));
		    });
		});
		</script>
	</template:addResources>
	
	<input type="text" id="${nodeName}" name="${nodeName}" class="hidden" value="${sessionScope.formDatas[nodeName][0]}" readonly="readonly" ${disabled}/>
	
	<div class="col-xs-10">
		<c:forEach items="${jcr:getNodes(currentNode,'jnt:formListElement')}" var="option">
		    <c:set var="isChecked" value="false"/>
		    <c:forEach items="${fn:split(sessionScope.formDatas[currentNode.name][0], ' ')}" var="checked">
		        <c:if test="${option.name eq checked}">
		            <c:set var="isChecked" value="true"/>
		        </c:if>
		        </c:forEach>
				<label class="checkbox-inline">
		        		<input ${disabled} type="checkbox" ${required} class="${required}" name="${nodeName}box" value="${option.name}" <c:if test="${isChecked eq 'true'}">checked="true"</c:if>
		                           <c:if test="${required eq 'required'}">onclick='$("input:checkbox[name=${nodeName}box]:checked").size()==0?$("input:checkbox[name=${nodeName}box]").prop("required", true):$("input:checkbox[name=${nodeName}box]").removeAttr("required")'</c:if> />
		        ${option.properties['jcr:title'].string}
		        </label>
		</c:forEach>
	</div>
	
	<c:if test="${renderContext.editMode}">
	    <p><fmt:message key="label.listOfOptions"/> </p>
	    <ol>
	        <c:forEach items="${jcr:getNodes(currentNode,'jnt:formListElement')}" var="option">
	            <li><template:module node="${option}" view="default" editable="true"/></li>
	        </c:forEach>
	    </ol>
	    <div class="addvalidation">
	        <span><fmt:message key="label.addListOption"/> </span>
	        <template:module path="*" nodeTypes="jnt:formListElement"/>
	    </div>
	
	    <p><fmt:message key="label.listOfValidation"/> </p>
	    <ol>
	    <c:forEach items="${jcr:getNodes(currentNode,'jnt:formElementValidation')}" var="formElement" varStatus="status">
	        <li><template:module node="${formElement}" view="edit"/></li>
	    </c:forEach>
	    </ol>
	    <div class="addvalidation">
	        <span><fmt:message key="label.addValidation"/> </span>
	        <template:module path="*" nodeTypes="jnt:formElementValidation"/>
	    </div>
	</c:if>
</div>
