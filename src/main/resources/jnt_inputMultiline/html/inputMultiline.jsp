<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<c:set var="nodeName" value="${currentNode.name}"/>

<c:if test="${jcr:hasChildrenOfType(currentNode, 'jnt:required')}">
    <c:set var="required" value="required"/>
</c:if>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<div class="form-group">
    <label class="control-label" for="${nodeName}">
    	${title}
    </label>
	<textarea id="${nodeName}" name="${nodeName}" class="form-control" ${disabled} ${required} cols="${currentNode.properties['cols'].string}" rows="${currentNode.properties['rows'].string}"><c:if test="${not empty sessionScope.formError}">${sessionScope.formDatas[nodeName][0]}</c:if><c:if test="${empty sessionScope.formError}">${currentNode.properties['defaultValue'].string}</c:if>
    </textarea>
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
