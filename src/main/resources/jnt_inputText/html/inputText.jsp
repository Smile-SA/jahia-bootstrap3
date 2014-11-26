<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="maxLength" var="maxLength"/>
<jcr:nodeProperty node="${currentNode}" name="size" var="size"/>
<c:set var="nodeName" value="${currentNode.name}"/>

<c:if test="${not empty props.mask}">
    <template:addResources>
        <script type="text/javascript">
            $(document).ready(function() {
                $("\#${currentNode.name}").mask("${currentNode.properties.mask.string}");
            });
        </script>
    </template:addResources>
</c:if>

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
	<input ${disabled} id="${nodeName}" name="${nodeName}" type="text"  class="form-control"
	maxlength="${maxLength}" size="${size}" ${required} 
	value="<c:if test="${not empty sessionScope.formError}">${sessionScope.formDatas[nodeName][0]}</c:if>
	       <c:if test="${empty currentNode.properties.mask and empty sessionScope.formError}">${currentNode.properties.defaultValue.string}</c:if>"/> 
	
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