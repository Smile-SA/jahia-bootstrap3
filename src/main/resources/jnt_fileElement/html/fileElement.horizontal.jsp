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

<template:addResources>
    <script type="text/javascript">
        $(document).ready(function() {
            var form = $("\#${currentNode.parent.parent.parent.name}");
            form.attr("enctype", "multipart/form-data");
        })
    </script>
</template:addResources>


<div class="form-group">

	<label class="control-label col-xs-2">
		${title}
	</label>
	<div class="col-xs-10">
		<input type="file" id="${nodeName}" name="${nodeName}" ${disabled} ${required} />
	</div>
	
	<c:if test="${renderContext.editMode}">
	    <div class="formMarginLeft">
	        <p><fmt:message key="label.listOfValidation"/></p>
	        <ol>
	            <c:forEach items="${jcr:getNodes(currentNode,'jnt:formElementValidation')}" var="formElement" varStatus="status">
	                <li><template:module node="${formElement}" view="edit"/></li>
	            </c:forEach>
	        </ol>
	        <div class="addvalidation">
	            <span><fmt:message key="label.addValidation"/></span>
	            <template:module path="*"/>
	        </div>
	    </div>
	</c:if>
	
</div>