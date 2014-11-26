<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="id" var="id"/>
<jcr:nodeProperty node="${currentNode}" name="additionalClasses" var="additionalClasses"/>
<jcr:nodeProperty node="${currentNode}" name="fluid" var="fluid"/>

<c:set var="isEmpty" value="true"/>

<c:if test="${not empty id.string}">
    <c:set var="htmlID">id="${id.string}" </c:set>
</c:if>

<c:set var="classes" value="row"/>
<c:if test="${fluid.boolean}">
    <c:set var="classes" value="${classes}-fluid"/>
</c:if>
<c:if test="${not empty additionalClasses.string}">
    <c:set var="classes" value="${classes} ${additionalClasses.string}"/>
</c:if>

<%-- Row creation --%>
<div ${htmlID} class="${classes}">
    <%@ include file="../../common/studioRenderHelper.jspf" %>
    <c:forEach items="${jcr:getChildrenOfType(currentNode, 'bootstrap3:column')}" var="column" varStatus="status">
        <template:module node="${column}" editable="true"/>
        <c:set var="isEmpty" value="false"/>
    </c:forEach>
    <c:if test="${isEmpty}">
        ${moduleMap.emptyListMessage}
    </c:if>
</div>
<c:if test="${renderContext.editMode}">
    <template:module path="*"/>
</c:if>