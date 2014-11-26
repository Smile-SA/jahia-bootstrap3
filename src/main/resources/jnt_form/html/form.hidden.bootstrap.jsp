<%@ include file="../../common/declarations.jspf" %>

<template:addResources type="javascript" resources="jquery.validate.js,vendor/maskedinput/jquery.maskedinput-min.js"/>
<template:addResources type="css" resources="formbuilder.css"/>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="j:intro" var="intro"/>
<jcr:node var="actionNode" path="${currentNode.path}/action"/>
<jcr:node var="fieldsetsNode" path="${currentNode.path}/fieldsets"/>
<jcr:node var="formButtonsNode" path="${currentNode.path}/formButtons"/>
<c:set var="nodeName" value="${currentNode.name}"/>


<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<c:if test="${not empty intro}">
    <c:set var="intro" value="${fn:escapeXml(intro.string)}"/>
</c:if>

<c:if test="${formView eq 'horizontal'}">
    <c:set var="classHTML" value="class=\"form-horizontal\""/>
</c:if>
<c:if test="${formView eq 'default'}">
    <c:set var="classHTML" value=""/>
</c:if>

<c:set var="writeable" value="${currentResource.workspace eq 'live'}" />
<c:if test='${not writeable}'>
    <c:set var="disabled" value='disabled="true"' scope="request" />
</c:if>

<c:if test="${not renderContext.editMode}">

	<template:addResources>
        <script type="text/javascript">
			<c:forEach items="${fieldsetsNode.nodes}" var="fieldset">
			<c:forEach items="${jcr:getNodes(fieldset,'jnt:formElement')}" var="formElement" varStatus="status">
			<c:set var="validations" value="${jcr:getNodes(formElement,'jnt:formElementValidation')}"/>
			<c:if test="${fn:length(validations) > 0}">
			    <c:forEach items="${jcr:getNodes(formElement,'jnt:regexValidation')}" var="formElementValidation" varStatus="val">
			    <template:module node="${formElementValidation}" view="validate" editable="false"/><c:if test="${not val.last}">,</c:if>
			    </c:forEach>
			</c:if>
			</c:forEach>
			</c:forEach>
		</script>
	</template:addResources>
	
    <template:addResources>
        <script type="text/javascript">
            $(document).ready(function() {
                $("\#${nodeName}").validate({
                    rules: {
                        <c:forEach items="${fieldsetsNode.nodes}" var="fieldset">
                        <c:forEach items="${jcr:getNodes(fieldset,'jnt:formElement')}" var="formElement" varStatus="status">
                        <c:set var="validations" value="${jcr:getNodes(formElement,'jnt:formElementValidation')}"/>
                        <c:if test="${fn:length(validations) > 0}">
						<c:if test="${not empty rulesAdded && not status.first }">
						,
						</c:if>
						<c:set var="rulesAdded" value="true"/>
                        '${formElement.name}' : {
                            <c:forEach items="${jcr:getNodes(formElement,'jnt:formElementValidation')}" var="formElementValidation" varStatus="val">
                            <template:module node="${formElementValidation}" view="default" editable="true"/>
                            <c:if test="${not val.last}">,</c:if>
                            </c:forEach>
                        }
                        </c:if>
                        </c:forEach>
                        </c:forEach>
                    },formId : "${nodeName}"
                });
            });
        </script>
        
        <link rel="stylesheet" href="${url.currentModule}/css/vendor/jquery-ui/jquery-ui.css">
		<script src="${url.currentModule}/javascript/vendor/jquery-ui/jquery-ui.js"></script>
    </template:addResources>
</c:if>

<c:set var="displayCSV" value="false"/>
<c:set var="action" value="${url.base}${currentNode.path}/responses/*"/>
<c:if test="${not empty actionNode.nodes}">
    <c:if test="${fn:length(actionNode.nodes) > 1}">
        <c:set var="action" value="${url.base}${currentNode.path}/responses.chain.do"/>
        <c:set var="chainActive" value=""/>
        <c:forEach items="${actionNode.nodes}" var="node" varStatus="stat">
            <c:if test="${jcr:isNodeType(node, 'jnt:defaultFormAction')}"><c:set var="displayCSV" value="true"/></c:if>
            <c:if test="${jcr:isNodeType(node, 'jnt:redirectFormAction')}"><c:set var="hasRedirect" value="true"/></c:if>
            <c:set var="chainActive" value="${chainActive}${node.properties['j:action'].string}"/>
            <c:if test="${not stat.last}"><c:set var="chainActive" value="${chainActive},"/></c:if>
        </c:forEach>
    </c:if>
    <c:if test="${fn:length(actionNode.nodes) eq 1}">
        <c:forEach items="${actionNode.nodes}" var="node">
            <c:if test="${jcr:isNodeType(node, 'jnt:defaultFormAction')}"><c:set var="displayCSV" value="true"/></c:if>
            <c:if test="${node.properties['j:action'].string != 'default'}">
                <c:set var="action" value="${url.base}${currentNode.path}/responses.${node.properties['j:action'].string}.do"/>
            </c:if>
        </c:forEach>
    </c:if>
</c:if>

<c:if test="${not empty title}">
    <h2>${title}</h2>
</c:if>

<c:if test="${not empty intro}">
    <div class="intro">
		${intro}
	</div>
</c:if>


<c:if test="${renderContext.editMode}">
    <c:forEach items="${actionNode.nodes}" var="formElement">
        <template:module node="${formElement}" editable="true"/>
    </c:forEach>
    <div class="addaction">
        <span><fmt:message key="label.form.addAction"/> : </span>
        <template:module node="${actionNode}" view="hidden.placeholder"/>
    </div>
</c:if>


<%-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Display Live and preview ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --%>
<c:if test="${not renderContext.editMode}">
    <template:tokenizedForm>
        <form ${classHTML} action="<c:url value='${action}'/>" method="post" id="${nodeName}">
            <input type="hidden" name="originUrl" value="${pageContext.request.requestURL}"/>
            <input type="hidden" name="jcrNodeType" value="jnt:responseToForm"/>
            <c:if test="${empty hasRedirect}">
            <input type="hidden" name="jcrRedirectTo" value="<c:url value='${url.base}${renderContext.mainResource.node.path}'/>"/>
            </c:if>
                <%-- Define the output format for the newly created node by default html or by jcrRedirectTo--%>
            <input type="hidden" name="jcrNewNodeOutputFormat" value="html"/>
            <c:if test="${not empty chainActive}">
                <input type="hidden" name="chainOfAction" value="${chainActive}"/>
            </c:if>
            <c:forEach items="${fieldsetsNode.nodes}" var="fieldset">
                <template:module node="${fieldset}" editable="true">
	                <template:param name="formView" value="${formView}"/>
			    </template:module>
            </c:forEach>

            <div class="form-group">
            	<div class="col-xs-10 col-xs-offset-2">
	                <c:forEach items="${formButtonsNode.nodes}" var="formButton">
	                    <template:module node="${formButton}" editable="true"/>
	                </c:forEach>
                </div>
            </div>
            <div class="validation"></div>
        </form>
    </template:tokenizedForm>
</c:if>
<%-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --%>


<%-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ Display Edit view +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --%>
<c:if test="${renderContext.editMode}">
	<form ${classHTML} role="form" <c:if test="${not empty formClass}"> class="${formClass}" </c:if> >
		<input type="hidden" name="jcrNodeType" value="jnt:responseToForm"/>
		<input type="hidden" name="jcrRedirectTo" value="<c:url value='${url.base}${renderContext.mainResource.node.path}'/>"/>
		<%-- Define the output format for the newly created node by default html or by jcrRedirectTo--%>
		<input type="hidden" name="jcrNewNodeOutputFormat" value="html"/>
		<c:if test="${not empty chainActive}">
		    <input type="hidden" name="chainOfAction" value="${chainActive}"/>
		</c:if>
		
		<c:forEach items="${fieldsetsNode.nodes}" var="fieldset">
		    <template:module node="${fieldset}" editable="true">
		    	<template:param name="formView" value="${formView}"/>
		    </template:module>
		</c:forEach>
		
		<div class="addfieldsets">
		    <span><fmt:message key="label.form.addFieldSet"/> : </span>
		    <template:module node="${fieldsetsNode}" view="hidden.placeholder"/>
		</div>
		
		<div class="form-group">
         	<div class="col-xs-10 col-xs-offset-2">
				<c:forEach items="${formButtonsNode.nodes}" var="formButton">
				    <template:module node="${formButton}" editable="true"/>
				</c:forEach>
			</div>
		</div>
		<div class="addbuttons">
		    <span><fmt:message key="label.form.addButtons"/> : </span>
		    <template:module node="${formButtonsNode}" view="hidden.placeholder"/>
		</div>
	</form>
</c:if>
<%-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --%>
    

<c:if test="${displayCSV eq 'true'}">
    <div>
        <h2><fmt:message key="form.responses"/> : <a href="<c:url value='${url.baseLive}${currentNode.path}/responses.csv'/>" target="_blank">CSV</a> - <a href="<c:url value='${url.baseLive}${currentNode.path}/responses.html'/>" target="_blank">HTML</a></h2>
        <%--<template:list path="responses" listType="jnt:responsesList" editable="true" />--%>
    </div>
</c:if>

