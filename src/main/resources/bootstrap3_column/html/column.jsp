<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="id" var="id"/>
<jcr:nodeProperty node="${currentNode}" name="additionalClasses" var="additionalClasses"/>
<jcr:nodeProperty node="${currentNode}" name="size" var="size"/>

<c:if test="${not empty id.string}">
    <c:set var="htmlID" value=" id=\"${id.string}\""/>
</c:if>
<c:if test="${not empty size.string}">
    <c:set var="classes" value="col-xs-${size.string}"/>
</c:if>
<c:if test="${not empty additionalClasses.string}">
    <c:set var="classes" value="${classes} ${additionalClasses.string}"/>
</c:if>
<c:if test="${not empty classes}">
    <c:set var="htmlClasses" value=" class=\"${classes}\"" />
</c:if>

<c:choose>
    <%-- Test if column size is between 0 and 12 --%>
    <c:when test="${empty size.string or ((size.string gt 0) and (size.string le 12))}">
        <%-- Column creation --%>
        <div ${htmlID} ${htmlClasses}>
            <%@ include file="../../common/studioRenderHelper.jspf" %>
            <template:area path="${currentNode.name}" areaAsSubNode="true" />
        </div>
    </c:when>
    <c:otherwise>
        <fmt:message key="label.tooLargeColumn"/>
    </c:otherwise>
</c:choose>