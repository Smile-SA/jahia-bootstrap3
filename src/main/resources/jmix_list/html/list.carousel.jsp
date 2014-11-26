<%@ include file="../../common/declarations.jspf" %>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="numberToDisplay" var="numberToDisplay"/>
<jcr:nodeProperty node="${currentNode}" name="displayControls" var="displayControls"/>
<jcr:nodeProperty node="${currentNode}" name="interval" var="interval"/>

<c:set var="resourceReadOnly" value="${currentResource.moduleParams.readOnly}"/>

<template:include view="hidden.header"/>

<c:set var="isEmpty" value="true"/>
<c:set var="nbTotalCols" value="12" />
<c:set var="carouselID" value="carousel-${currentNode.name}"/>
<c:set var="numberToDisplay" value="${numberToDisplay.long}"/>

<c:if test="${not empty title}">
    <c:set var="title" value="${title.string}"/>
</c:if>

<c:if test="${not empty interval}">
    <c:set var="interval"> data-interval="${interval.string}"</c:set>
</c:if>

<c:if test="${not empty title}">
	<h2 class="carousel-title">${title}</h2>
</c:if>
<div id="${carouselID}" class="carousel slide ${(not empty displayControls and displayControls.boolean) ? 'controls' : ''}" data-ride="carousel" ${interval}>

    <c:if test="${not empty numberToDisplay and numberToDisplay > 1}">
        <fmt:formatNumber var="listSize" value="${functions:length(moduleMap.currentList)}" maxFractionDigits="0"/>
        <fmt:formatNumber var="colXsFrac" value="${nbTotalCols / numberToDisplay}" maxFractionDigits="0"/>
    </c:if>

    <div class="carousel-inner">
        <c:set var="classes" value="item"/>
        <c:choose>
            <c:when test="${not empty numberToDisplay and numberToDisplay > 1}">
                <c:set var="htmlClasses"> class="${classes} active"</c:set>
                <c:set var="originalClasses"> class="${classes} active"</c:set>
                <div ${htmlClasses}>
                <div class="row">
                <c:set var="htmlClasses" value=""/>
                <c:if test="${isEditMode or isPreviewMode}">
                    <!-- object list size = ${listSize} -->
                    <!-- objects number to display per carousel item = ${numberToDisplay} -->
                    <!-- Bootstrap3 col-xs fraction = ${colXsFrac} -->
                    <!-- number of carousel items = ${nbPage} -->
                    <!-- Jahia moduleMap.begin = ${moduleMap.begin} -->
                    <!-- Jahia moduleMap.end = ${moduleMap.end} -->
                </c:if>
                <c:forEach items="${moduleMap.currentList}" var="subchild" begin="${moduleMap.begin}" end="${moduleMap.end}" varStatus="varStatus">
                    <c:if test="${varStatus.index gt 0 and varStatus.index % numberToDisplay eq 0}">
                        </div><!--/.row-->
                        </div><!--/.${classes}-->
                        <c:if test="${not empty classes}">
                            <c:set var="htmlClasses"> class="${classes}"</c:set>
                        </c:if>
                        <div ${htmlClasses}>
                        <div class="row">
                    </c:if>
                    <div class="col-xs-${colXsFrac}">
                        <template:module node="${subchild}" view="${moduleMap.subNodesView}" editable="${moduleMap.editable && !resourceReadOnly}">
                            <template:param name="classes" value="img-responsive"/>
                        </template:module>
                    </div>
                    <c:set var="isEmpty" value="false"/>
                </c:forEach>
                </div><!--/.row-->
                </div><!--/.${originalClasses}-->
            </c:when>
            <c:otherwise>
                <c:set var="htmlClasses" value=""/>
                <c:forEach items="${moduleMap.currentList}" var="subchild" begin="${moduleMap.begin}" end="${moduleMap.end}" varStatus="varStatus">
                    <c:set var="htmlClasses"> class="${classes} ${varStatus.first ? ' active' : ''}"</c:set>
                    <div ${htmlClasses}>
                        <template:module node="${subchild}" view="${moduleMap.subNodesView}" editable="${moduleMap.editable && !resourceReadOnly}">
                            <template:param name="classes" value="img-responsive"/>
                        </template:module>
                    </div><!--/.${classes}-->
                    <c:set var="isEmpty" value="false"/>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <ol class="carousel-indicators">
        <c:choose>
            <c:when test="${not empty numberToDisplay and numberToDisplay > 1}">
                <c:choose>
                    <c:when test="${listSize mod numberToDisplay eq 0}">
                        <fmt:formatNumber var="nbPage" value="${listSize / numberToDisplay}" maxFractionDigits="0"/>
                    </c:when>
                    <c:otherwise>
                    	<c:set var="nb" value="${listSize / numberToDisplay}"/>
						<%-- JSTL tips to do floor(number)+1 see http://blog.elzapp.com/2010/07/07/round-floor-and-ceiling-in-expression-language.html --%>
                    	<c:set var="nbPage" value="${(nb - ( nb % 1 ) )+1}"/>
                    </c:otherwise>
                </c:choose>
                <c:if test="${nbPage eq 0}">
                	<c:set var="nbPage" value="1"/>
                </c:if>
                <c:forEach begin="0" end="${nbPage-1}" varStatus="varStatus">
                    <c:set var="classes" value=""/>
                    <c:if test="${varStatus.first}">
                        <c:set var="classes" value="${classes} active"/>
                    </c:if>
                    <c:set var="htmlClasses" value=""/>
                    <c:if test="${not empty classes}">
                        <c:set var="htmlClasses"> class="${classes}"</c:set>
                    </c:if>
                    <li ${htmlClasses} data-target="#${carouselID}" data-slide-to="${varStatus.index}"></li>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:forEach begin="0" end="${moduleMap.end-moduleMap.begin-1}" varStatus="varStatus">
                    <c:set var="classes" value=""/>
                    <c:if test="${varStatus.first}">
                        <c:set var="classes" value="${classes} active"/>
                    </c:if>
                    <c:set var="htmlClasses" value=""/>
                    <c:if test="${not empty classes}">
                        <c:set var="htmlClasses"> class="${classes}"</c:set>
                    </c:if>
                    <li ${htmlClasses} data-target="#${carouselID}" data-slide-to="${varStatus.index}"></li>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ol>

    <c:if test="${displayControls.boolean and not isEmpty}">
        <a class="left carousel-control" href="#${carouselID}" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#${carouselID}" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </c:if>

    <c:if test="${not empty moduleMap.emptyListMessage and (renderContext.editMode or moduleMap.forceEmptyListMessageDisplay) and isEmpty}">
        ${moduleMap.emptyListMessage}
    </c:if>

    <c:if test="${moduleMap.editable and renderContext.editMode && !resourceReadOnly}">
        <template:module path="*"/>
    </c:if>
</div>

<template:include view="hidden.footer"/>