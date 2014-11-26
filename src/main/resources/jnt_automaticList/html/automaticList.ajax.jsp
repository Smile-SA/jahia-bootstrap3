<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<c:set var="nodeName" value="${currentNode.name}"/>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<template:addResources type="css" resources="jquery.autocomplete.css"/>
<template:addResources type="css" resources="thickbox.css"/>
<template:addResources type="javascript" resources="jquery.autocomplete.js"/>
<template:addResources type="javascript" resources="jquery.bgiframe.min.js"/>
<template:addResources type="javascript" resources="thickbox-compressed.js"/>

<template:addResources>

<script type="text/javascript">
    $(document).ready(function() {

        $("\#${nodeName}").autocomplete("<c:url value='${url.initializers}'/>", {
            parse: function parse(data) {
                return $.map(data, function(row) {
                    return {
                        data: row,
                        value: "" + row["value"],
                        result: "" + row["name"]
                    }
                });
            },
            formatItem: function(item) {
                return "" + item["name"][0];
            },
            extraParams: {
                initializers : "${fn:split(currentNode.properties.type.string,';')[0]}",
                path : "${currentNode.path}",
                name : "type"
            },
            maxCacheLength : 1,
            matchSubset : 0
        });
    });
</script>

</template:addResources>

<div class="form-group">
    <label class="control-label" for="${nodeName}">
    	${title}
    </label>
    <input type="text" id="${nodeName}" name="${nodeName}" class="form-control"  value="${not empty sessionScope.formDatas[nodeName][0] ? sessionScope.formDatas[nodeName][0] : ''}"/>
</div>