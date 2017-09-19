
<%@ page import="br.ufscar.sead.loa.cia.remar.Caso" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'caso.label', default: 'Caso')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>

		<div id="list-caso" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="caso1descricao" title="${message(code: 'caso.caso1descricao.label', default: 'Caso1descricao')}" />
					
						<g:sortableColumn property="caso1perguntas" title="${message(code: 'caso.caso1perguntas.label', default: 'Caso1perguntas')}" />
					
						<g:sortableColumn property="caso1respostas" title="${message(code: 'caso.caso1respostas.label', default: 'Caso1respostas')}" />
					
						<g:sortableColumn property="caso1pistafinal" title="${message(code: 'caso.caso1pistafinal.label', default: 'Caso1pistafinal')}" />
					
						<g:sortableColumn property="caso2descricao" title="${message(code: 'caso.caso2descricao.label', default: 'Caso2descricao')}" />
					
						<g:sortableColumn property="caso2perguntas" title="${message(code: 'caso.caso2perguntas.label', default: 'Caso2perguntas')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${casoInstanceList}" status="i" var="casoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${casoInstance.id}">${fieldValue(bean: casoInstance, field: "caso1descricao")}</g:link></td>
					
						<td>${fieldValue(bean: casoInstance, field: "caso1perguntas")}</td>
					
						<td>${fieldValue(bean: casoInstance, field: "caso1respostas")}</td>
					
						<td>${fieldValue(bean: casoInstance, field: "caso1pistafinal")}</td>
					
						<td>${fieldValue(bean: casoInstance, field: "caso2descricao")}</td>
					
						<td>${fieldValue(bean: casoInstance, field: "caso2perguntas")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${casoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
