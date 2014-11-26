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
	<label for="${nodeName}" class="control-label col-xs-2">
		${title}
	</label>
	<div class="col-xs-10">
		<input type="email" id="${nodeName}" name="${nodeName}"  class="form-control" ${disabled} maxlength="${maxLength}" size="${size}" ${required}/>
	</div>
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

