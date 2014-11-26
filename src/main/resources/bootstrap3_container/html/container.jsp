<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="id" var="id"/>
<jcr:nodeProperty node="${currentNode}" name="additionalClasses" var="additionalClasses"/>
<jcr:nodeProperty node="${currentNode}" name="fluid" var="fluid"/>

<c:if test="${not empty id.string}">
    <c:set var="htmlID">id="${id.string}" </c:set>
</c:if>

<c:set var="classes" value="container"/>
<c:if test="${fluid.boolean}">
    <c:set var="classes" value="${classes}-fluid"/>
</c:if>
<c:if test="${not empty additionalClasses.string}">
    <c:set var="classes" value="${classes} ${additionalClasses.string}"/>
</c:if>

<div ${htmlID} class="${classes}">
    <%@ include file="../../common/studioRenderHelper.jspf" %>
    <template:area path="${currentNode.name}" areaAsSubNode="true"/>
</div>