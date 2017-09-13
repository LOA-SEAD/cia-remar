
<%@ page import="br.ufscar.sead.loa.detetive.remar.Caso" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'caso.label', default: 'Caso')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-caso" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-caso" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list caso">
			
				<g:if test="${casoInstance?.descricao}">
				<li class="fieldcontain">
					<span id="descricao-label" class="property-label"><g:message code="caso.descricao.label" default="Descricao" /></span>
					
						<span class="property-value" aria-labelledby="descricao-label"><g:fieldValue bean="${casoInstance}" field="descricao"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.pergunta1}">
				<li class="fieldcontain">
					<span id="pergunta1-label" class="property-label"><g:message code="caso.pergunta1.label" default="Pergunta1" /></span>
					
						<span class="property-value" aria-labelledby="pergunta1-label"><g:fieldValue bean="${casoInstance}" field="pergunta1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.pergunta2}">
				<li class="fieldcontain">
					<span id="pergunta2-label" class="property-label"><g:message code="caso.pergunta2.label" default="Pergunta2" /></span>
					
						<span class="property-value" aria-labelledby="pergunta2-label"><g:fieldValue bean="${casoInstance}" field="pergunta2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.pergunta3}">
				<li class="fieldcontain">
					<span id="pergunta3-label" class="property-label"><g:message code="caso.pergunta3.label" default="Pergunta3" /></span>
					
						<span class="property-value" aria-labelledby="pergunta3-label"><g:fieldValue bean="${casoInstance}" field="pergunta3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.pergunta4}">
				<li class="fieldcontain">
					<span id="pergunta4-label" class="property-label"><g:message code="caso.pergunta4.label" default="Pergunta4" /></span>
					
						<span class="property-value" aria-labelledby="pergunta4-label"><g:fieldValue bean="${casoInstance}" field="pergunta4"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.pergunta5}">
				<li class="fieldcontain">
					<span id="pergunta5-label" class="property-label"><g:message code="caso.pergunta5.label" default="Pergunta5" /></span>
					
						<span class="property-value" aria-labelledby="pergunta5-label"><g:fieldValue bean="${casoInstance}" field="pergunta5"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.pergunta6}">
				<li class="fieldcontain">
					<span id="pergunta6-label" class="property-label"><g:message code="caso.pergunta6.label" default="Pergunta6" /></span>
					
						<span class="property-value" aria-labelledby="pergunta6-label"><g:fieldValue bean="${casoInstance}" field="pergunta6"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.resposta1}">
				<li class="fieldcontain">
					<span id="resposta1-label" class="property-label"><g:message code="caso.resposta1.label" default="Resposta1" /></span>
					
						<span class="property-value" aria-labelledby="resposta1-label"><g:fieldValue bean="${casoInstance}" field="resposta1"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.resposta2}">
				<li class="fieldcontain">
					<span id="resposta2-label" class="property-label"><g:message code="caso.resposta2.label" default="Resposta2" /></span>
					
						<span class="property-value" aria-labelledby="resposta2-label"><g:fieldValue bean="${casoInstance}" field="resposta2"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.resposta3}">
				<li class="fieldcontain">
					<span id="resposta3-label" class="property-label"><g:message code="caso.resposta3.label" default="Resposta3" /></span>
					
						<span class="property-value" aria-labelledby="resposta3-label"><g:fieldValue bean="${casoInstance}" field="resposta3"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.resposta4}">
				<li class="fieldcontain">
					<span id="resposta4-label" class="property-label"><g:message code="caso.resposta4.label" default="Resposta4" /></span>
					
						<span class="property-value" aria-labelledby="resposta4-label"><g:fieldValue bean="${casoInstance}" field="resposta4"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.resposta5}">
				<li class="fieldcontain">
					<span id="resposta5-label" class="property-label"><g:message code="caso.resposta5.label" default="Resposta5" /></span>
					
						<span class="property-value" aria-labelledby="resposta5-label"><g:fieldValue bean="${casoInstance}" field="resposta5"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.pistafinal}">
				<li class="fieldcontain">
					<span id="pistafinal-label" class="property-label"><g:message code="caso.pistafinal.label" default="Pistafinal" /></span>
					
						<span class="property-value" aria-labelledby="pistafinal-label"><g:fieldValue bean="${casoInstance}" field="pistafinal"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.author}">
				<li class="fieldcontain">
					<span id="author-label" class="property-label"><g:message code="caso.author.label" default="Author" /></span>
					
						<span class="property-value" aria-labelledby="author-label"><g:fieldValue bean="${casoInstance}" field="author"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.ownerId}">
				<li class="fieldcontain">
					<span id="ownerId-label" class="property-label"><g:message code="caso.ownerId.label" default="Owner Id" /></span>
					
						<span class="property-value" aria-labelledby="ownerId-label"><g:fieldValue bean="${casoInstance}" field="ownerId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${casoInstance?.taskId}">
				<li class="fieldcontain">
					<span id="taskId-label" class="property-label"><g:message code="caso.taskId.label" default="Task Id" /></span>
					
						<span class="property-value" aria-labelledby="taskId-label"><g:fieldValue bean="${casoInstance}" field="taskId"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:casoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${casoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
