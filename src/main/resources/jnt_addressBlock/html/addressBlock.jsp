<%@ include file="../../common/declarations.jspf" %>

<%-- Get node properties --%>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<c:set var="nodeName" value="${currentNode.name}"/>

<c:if test="${not empty title}">
    <c:set var="title" value="${fn:escapeXml(title.string)}"/>
</c:if>

<template:addResources type="inlinejavascript">
<script type='text/javascript'>
$(function() {
   $('input[name="street"],input[name="street2"],input[name="city"],input[name="state"],input[name="zip"],input[name="country"]').change(function() {
        var x = $('input[name="street"]').val()+' '
                +$('input[name="street2"]').val()+' '
                +$('input[name="city"]').val()+' '
                +$('input[name="state"]').val()+' '
                +$('input[name="zip"]').val()+' '
                +$('input[name="country"]').val();
        $('#${nodeName}').val(x);
    });
});
</script>

</template:addResources>

<div class="form-group">
	<label for="${nodeName}" class="control-label">
			${fn:escapeXml(title)}
	</label>
	<input type="text" id="${nodeName}" name="${nodeName}" class="form-control" value="${sessionScope.formDatas[nodeName][0]}" readonly="readonly" ${disabled} />
</div>

<div class="form-group">
	<label for="street" class="control-label">
		<fmt:message key="address.street"/>
	</label>
	<input id="street" name="street" class="form-control" type="text" ${disabled}>
</div>

<div class="form-group">
	<label for="street2" class="control-label">
		<fmt:message key="address.street2"/>
	</label>
	<input id="street2" name="street2" class="form-control" type="text" ${disabled}>
</div>

<div class="form-group">

	<div class="col-xs-10 col-xs-offset-2">
		<div class="row-fluid">
			<div class="col-xs-5">
				<div class="form-group">
					<label for="city" class="control-label">
						<fmt:message key="address.city"/>
					</label>
					<input id="city" name="city" class="form-control" type="text" ${disabled}>
				</div>
			</div>
			<div class="col-xs-5 col-xs-offset-1">
				<div class="form-group">
					<label for="state" class="control-label">
						<fmt:message key="address.state"/>
					</label>
					<input id="state" name="state" class="form-control" type="text" ${disabled}>
				</div>
			</div>
		</div>
		
		<div class="row-fluid">
			<div class="col-xs-5">
				<div class="form-group">
					<label for="zip" class="control-label">
						<fmt:message key="address.zip"/>
					</label>
					<input id="zip" name="zip" class="form-control" type="text" ${disabled}>
				</div>
			</div>
			<div class="col-xs-5 col-xs-offset-1">
				<div class="form-group">
					<label for="country" class="control-label">
						<fmt:message key="address.country"/>
					</label>
					<input id="country" name="country" class="form-control" type="text" ${disabled}>
				</div>
			</div>
		</div>
	</div>
	
</div>