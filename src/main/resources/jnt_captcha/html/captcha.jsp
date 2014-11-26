<%@ include file="../../common/declarations.jspf" %>

<c:set var="required" value=""/>
<c:if test="${jcr:hasChildrenOfType(currentNode, 'jnt:required')}">
    <c:set var="required" value="required"/>
</c:if>

<div class="form-group">
    <template:captcha />
    <input ${disabled} type="text" ${required} class="form-control" id="inputCaptcha" name="jcrCaptcha"/>
    <c:if test="${not empty sessionScope.formError}">
        <label class="error">${sessionScope.formError}</label>
    </c:if>
</div>