<%@ include file="../../common/declarations.jspf" %>

<jcr:nodeProperty node="${currentNode}" name="errorMessage" var="errorMessage"/>

<c:if test="${not empty errorMessage}">
    <c:set var="errorMessage" value="${fn:escapeXml(errorMessage.string)}"/>
</c:if>

<c:if test="${empty errorMessage}">
    <c:set var="errorMessage" value="Please check your input."/>
</c:if>


$.validator.addMethod(
 "regexNode${fn:replace(currentNode.UUID,"-","")}",
 function(value, element, regexp) {
     var re = new RegExp('${currentNode.properties.regex.string}');
     return this.optional(element) || re.test(value);
 },"${errorMessage}");