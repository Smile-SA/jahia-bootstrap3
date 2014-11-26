<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<c:set var="nodeName" value="${currentNode.name}"/>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<jcr:propertyInitializers var="options" node="${currentNode}" initializers="${fn:split(currentNode.properties.type.string,';')[0]}" name="type"/>

<div class="form-group">
	<label class="control-label col-xs-2" for="${nodeName}">
		${title}
	</label>

	<div class="col-xs-10">
	    <select id="${nodeName}" name="${nodeName}" class="form-control" ${disabled} ${required} >
	        <c:forEach items="${options}" var="option">
	            <option value="${option.value.string}" <c:if test="${sessionScope.formDatas[nodeName][0] eq option.value.string}">selected="true"</c:if>>
	                    ${option.displayName}
	            </option>
	        </c:forEach>
	    </select>
    </div>
</div>