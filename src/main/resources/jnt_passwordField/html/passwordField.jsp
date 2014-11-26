<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="maxLength" var="maxLength"/>
<jcr:nodeProperty node="${currentNode}" name="size" var="size"/>
<c:set var="nodeName" value="${currentNode.name}"/>


<c:set var="required" value=""/>
<c:if test="${jcr:hasChildrenOfType(currentNode, 'jnt:required')}">
    <c:set var="required" value="required"/>
</c:if>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<c:if test="${not empty maxLength}">
    <c:set var="maxLength" value="${maxLength.long}"/>
</c:if>

<c:if test="${not empty size}">
    <c:set var="size" value="${size.long}"/>
</c:if>

<div class="form-group">
	<label for="${nodeName}" class="control-label">
		${title}
	</label>
	<input type="password" id="${nodeName}" name="${nodeName}"  class="form-control" ${disabled} maxlength="${maxLength}" size="${size}" ${required}/>
</div>

