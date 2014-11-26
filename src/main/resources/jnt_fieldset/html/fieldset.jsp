<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<c:set var="nodeName" value="${currentNode.name}"/>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<fieldset>
    <legend>
    	${title}
    </legend>
    
    <c:forEach items="${jcr:getNodes(currentNode,'jnt:formElement')}" var="formElement">
    	<c:set var="nodeview" value="${formElement.properties['j:view'].string}"/>
    	
    	<c:if test="${ empty nodeview}">
    		<template:module node="${formElement}" view="${formView}" editable="true"/>
    	</c:if>
    	<c:if test="${ not (empty nodeview)}">
    		<template:module node="${formElement}" view="${nodeview}" editable="true"/>
    	</c:if>
    		
    </c:forEach>
    
    <c:if test="${renderContext.editMode}">
        <div class="form-group">
            <span><fmt:message key="label.fieldSet.addElements"/> : </span>
            <template:module path="*"/>
        </div>
    </c:if>
</fieldset>
