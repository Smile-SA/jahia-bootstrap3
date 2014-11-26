<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="id" var="id"/>
<jcr:nodeProperty node="${currentNode}" name="additionalClasses" var="additionalClasses"/>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<c:if test="${not empty id}">
    <c:set var="htmlID" value=" id=\"${id.string}\""/>
</c:if>

<c:if test="${not empty additionalClasses}">
    <c:set var="classes" value=" ${additionalClasses.string}"/>
</c:if>
<c:set var="htmlClasses"> class="btn btn-primary ${classes}"</c:set>

<button ${htmlID} ${htmlClasses} type="submit">
	${title}
</button>