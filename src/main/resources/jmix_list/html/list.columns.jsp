<%@ include file="../../common/declarations.jspf" %>

<template:include view="hidden.header"/>

<jcr:nodeProperty node="${currentNode}" name="j:columns" var="nbCols" />

<c:set var="nbCols" value="${nbCols.long}" />
<c:set var="customIndex" value="0"/>
<c:set var="nbTotalCols" value="12" />
<c:set var="isEmpty" value="true"/>

<fmt:formatNumber var="colXsFrac" value="${nbTotalCols / nbCols}" maxFractionDigits="0"/>

<div class="list list-columns">
    <div class="row">
        <c:choose>
            <c:when test="${moduleMap.end gt 0}">
                <c:forEach items="${moduleMap.currentList}" var="subchild" begin="${moduleMap.begin}" end="${moduleMap.end}">
                    <c:if test="${customIndex mod nbCols eq 0}">
                        </div><!--/.row-->
                        <div class="row">
                    </c:if>
                    <div class="col-xs-${colXsFrac}" data-index="${customIndex}">
                        <template:module node="${subchild}" view="${moduleMap.subNodesView}" editable="${moduleMap.editable && !resourceReadOnly}" />
                    </div>
                    <c:set var="customIndex" value="${customIndex + 1}"/>
                    <c:set var="isEmpty" value="false"/>
                </c:forEach>
            </c:when>
            <c:otherwise>
                ${moduleMap.emptyListMessage}
            </c:otherwise>
        </c:choose>
        <c:if test="${not empty moduleMap.emptyListMessage and (renderContext.editMode or moduleMap.forceEmptyListMessageDisplay) and isEmpty}">
            ${moduleMap.emptyListMessage}
        </c:if>
    </div><!--/.row-->
    <c:if test="${moduleMap.editable and renderContext.editMode && !resourceReadOnly}">
    	<template:module path="*"/>
    </c:if>
</div><!--/.list.list-columns-->

<template:include view="hidden.footer"/>