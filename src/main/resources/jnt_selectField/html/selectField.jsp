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
	<label class="control-label" for="${nodeName}">
		${title}
	</label>
	
	<select id="${nodeName}" name="${nodeName}" class="form-control" ${disabled} ${required} >
	    <c:forEach items="${jcr:getNodes(currentNode,'jnt:formListElement')}" var="option">
	        <option value="${option.name}" <c:if test="${not empty sessionScope.formError and sessionScope.formDatas[nodeName][0] eq option.name}">selected="true"</c:if>>
	        	${option.properties['jcr:title'].string}
	        </option>
	    </c:forEach>
	</select>
	
	<c:if test="${renderContext.editMode}">
	    <div class="formMarginLeft">
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
	    </div>
	</c:if>
</div>