<%@ include file="../../common/declarations.jspf" %>

<jcr:nodeProperty node="${currentNode}" name="j:node" var="reference"/>
<jcr:nodeProperty node="${currentNode}" name="j:alternateText" var="title"/>

<c:set var="node" value="${reference.node}"/>

<c:if test="${not empty node}">
    <template:addCacheDependency node="${node}" />
    <c:url var="url" value="${node.url}" context="/"/>
    <c:set var="height" value=""/>
    <c:set var="width" value=""/>
    <c:choose>
        <c:when test="${not empty classes}">
            <c:set var="attr">class="${classes}"</c:set>
        </c:when>
        <c:otherwise>
            <c:if test="${not empty node.properties['j:height']}">
                <c:set var="height">height="${node.properties['j:height'].string}"</c:set>
            </c:if>
            <c:if test="${not empty node.properties['j:width']}">
                <c:set var="width">width="${node.properties['j:width'].string}"</c:set>
            </c:if>
            <c:set var="attr">${height} ${width}</c:set>
        </c:otherwise>
    </c:choose>
    <img src="${url}" alt="${fn:escapeXml(not empty title.string ? title.string : currentNode.name)}" <c:out value="${attr}" escapeXml="false"/> />
</c:if>
<c:if test="${empty node and isEditMode}">
    <fmt:message key="label.missing.image" />
</c:if>