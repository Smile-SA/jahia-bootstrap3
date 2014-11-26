<%@ include file="../../common/declarations.jspf" %>

<c:set var="resourceReadOnly" value="${currentResource.moduleParams.readOnly}"/>

<template:include view="hidden.header"/>

<c:set var="isEmpty" value="true"/>

<ul class="nav nav-tabs">
    <c:forEach items="${moduleMap.currentList}" var="subchild" begin="${moduleMap.begin}" end="${moduleMap.end}"
               varStatus="varStatus">
        <c:set var="currentNavMenuTextParent"
               value="${jcr:getMeAndParentsOfType(renderContext.mainResource.node, 'jnt:navMenuText')[0]}"/>
        <c:set var="itemNavMenuTextParent"
               value="${jcr:getMeAndParentsOfType(subchild.properties['j:node'].node, 'jnt:navMenuText')[0]}"/>
        <c:if test="${not empty currentNavMenuTextParent and not empty itemNavMenuTextParent}">
            <c:set var="isActive" value="${currentNavMenuTextParent.path eq itemNavMenuTextParent.path}"/>
            <c:if test="${isEditMode or isPreviewMode}">
                <!-- currentNavMenuTextParent = ${currentNavMenuTextParent} -->
                <!-- itemNavMenuTextParent = ${itemNavMenuTextParent} -->
                <!-- currentNavMenuTextParent.path eq itemNavMenuTextParent.path ? = ${isActive} -->
            </c:if>
        </c:if>
        <li class="${ isActive ? 'active' : ''}">
            <template:module node="${subchild}" view="${moduleMap.subNodesView}"
                             editable="${moduleMap.editable && !resourceReadOnly}"/>
        </li>
        <c:set var="isEmpty" value="false"/>
    </c:forEach>
</ul>

<c:if test="${not empty moduleMap.emptyListMessage and (renderContext.editMode or moduleMap.forceEmptyListMessageDisplay) and isEmpty}">
    ${moduleMap.emptyListMessage}
</c:if>

<c:if test="${moduleMap.editable and renderContext.editMode && !resourceReadOnly}">
    <template:module path="*"/>
</c:if>

<template:include view="hidden.footer"/>