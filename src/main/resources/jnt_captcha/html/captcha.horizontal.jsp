<%@ include file="../../common/declarations.jspf" %>

<c:set var="required" value=""/>
<c:if test="${jcr:hasChildrenOfType(currentNode, 'jnt:required')}">
    <c:set var="required" value="required"/>
</c:if>

<div class="form-group">
	<div class="col-xs-2 col-xs-offset-2">
    	<template:captcha />
    </div>
    <div class="col-xs-8">   
	    <c:if test="${not empty sessionScope.formError}">
	    	<div class="form-group has-error">
				<label class="control-label" for="inputCaptcha">
					${sessionScope.formError}
				</label>
			  <input ${disabled} type="text" ${required} class="form-control" id="inputCaptcha" name="jcrCaptcha"/>
			</div>
	    </c:if>
	    
	    <c:if test="${empty sessionScope.formError}">
			  <input ${disabled} type="text" ${required} class="form-control" id="inputCaptcha" name="jcrCaptcha"/>
	    </c:if>
    </div> 
</div>