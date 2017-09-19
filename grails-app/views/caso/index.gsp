<%@ page import="br.ufscar.sead.loa.cia.remar.Caso" %>
<!DOCTYPE html>
<html>
<head>
	<!--Import Google Icon Font-->
	<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<!--Import materialize.css-->
	<link type="text/css" rel="stylesheet" href="css/materialize.css" media="screen,projection"/>
	<link rel="stylesheet" type="text/css" href="css/caso.css">

	<!--Let browser know website is optimized for mobile-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<meta name="layout" content="main">
	<meta charset="utf-8">
	<g:javascript src="editableTable.js"/>
	<g:javascript src="scriptTable.js"/>
	<g:javascript src="validate.js"/>
	<g:javascript src="caso.js"/>

	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>

	<meta property="user-name" content="${userName}"/>
	<meta property="user-id" content="${userId}"/>

	<g:set var="entityName" value="${message(code: 'caso.label', default: 'Caso')}"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<g:javascript src="iframeResizer.contentWindow.min.js"/>

</head>

<body>
<div class="cluster-header">
	<p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
		CIA - Tabela de Casos
	</p>
</div>


<div class="row">
	<div class="col s3 offset-s9">
		<input type="text" id="SearchLabel" class="remar-input" placeholder="Buscar"/>
	</div>
</div>

<table class="highlight" id="table" style="margin-top: -30px;">
	<thead>
	<tr>
		<th>Selecionar
			<div class="row" style="margin-bottom: -10px;">

				<button style="margin-left: 3px; background-color: #795548;" class="btn-floating" id="BtnCheckAll"
						onclick="check_all()"><i class="material-icons">check_box_outline_blank</i></button>
				<button style="margin-left: 3px; background-color: #795548;" class="btn-floating" id="BtnUnCheckAll"
						onclick="uncheck_all()"><i class="material-icons">done</i></button>
			</div>
		</th>
		<th>Descrição <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
																			style="visibility: hidden"></button></div>
		</th>

		<!--<th>Tema <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
																		style="visibility: hidden"></button></div></th> -->

		<!-- <th>Ação <div class="row" style="margin-bottom: -10px;"><button class="btn-floating"
																		style="visibility: hidden"></button></div></th>
	</tr> -->
	</thead>

	<tbody>
	<g:each in="${casoInstanceList}" status="i" var="casoInstance">
		<tr id="tr${casoInstance.id}" class="selectable_tr ${(i % 2) == 0 ? 'even' : 'odd'} " style="cursor: pointer;"
			data-id="${fieldValue(bean: casoInstance, field: "id")}"
			data-owner-id="${fieldValue(bean: casoInstance, field: "ownerId")}"
			data-checked="false">
			<g:if test="${casoInstance.author == userName}">

				<td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

				<td name="caso_label">${fieldValue(bean: casoInstance, field: "descricao")}</td>


				<td><i onclick="_edit($(this.closest('tr')))" style="color: #7d8fff; margin-right:10px;"
					   class="fa fa-pencil"
				></i></td>


			</g:if>
			<g:else>
				<td class="_not_editable"><input class="filled-in" type="checkbox"> <label></label></td>

				<td name="caso_label"
					data-casoId="${casoInstance.id}">${fieldValue(bean: casoInstance, field: "descricao")}</td>

				<td><i style="color: gray; margin-right:10px;" class="fa fa-pencil"></i>
				</td>
			</g:else>
		</tr>
	</g:each>
	</tbody>
</table>

<input type="hidden" id="editCasoLabel" value=""> <label for="editCasoLabel"></label>

<div class="row">
	<div class="col s2">
		<button class="btn waves-effect waves-light my-orange" type="submit" name="save" id="save">Enviar
		</button>
	</div>

	<div class="col s1 offset-s6">
		<a data-target="createModal" name="create"
		   -           class="btn-floating btn-large waves-effect waves-light modal-trigger my-orange tooltipped" data-tooltip="Criar Caso"><i
				-                class="material-icons">add</i></a>
	</div>

	<div class="col s1 m1 l1">
		<a onclick="_delete()" class=" btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exluir Caso" ><i class="material-icons">delete</i></a>
	</div>

	<div class="col s1">
		<a data-target="uploadModal"  class="btn-floating btn-large waves-effect waves-light my-orange modal-trigger tooltipped" data-tooltip="Upload de arquivo .csv"><i
				class="material-icons">file_upload</i></a>
	</div>
	<div class="col s1">
		<a class="btn-floating btn-large waves-effect waves-light my-orange tooltipped" data-tooltip="Exportar questões para .csv"><i
				class="material-icons" onclick="exportCasos()">file_download</i></a>
	</div>
</div>



<!-- Modal Structure -->
<div id="createModal" class="modal remar-modal">
	<g:form url="[resource: casoInstance, action: 'newCaso']">
		<div class="modal-content">
			<h4>Criar Questão <i class="material-icons tooltipped" data-position="right" data-delay="30" data-tooltip="Respostas não devem possuir números nem caracteres especiais.">info</i> </h4>
			<div class="row">
				<g:render template="form"/>
			</div>
		</div>
		<div class="modal-footer">
			<a href="#!" class="save modal-action modal-close btn waves-effect waves-light remar-orange" action="create"
			   onclick="$(this).closest('form').submit()" name="create">Criar</a>
			<a href="#!" class="save modal-action modal-close btn waves-effect waves-light remar-orange">Cancelar</a>
		</div>
	</g:form>
</div>



<!-- Modal -->
<div id="editModal" class="modal remar-modal">
	<g:form url="[resource: casoInstance, action: 'update']" method="PUT">
		<div class="modal-content">
			<h4>Editar Caso</h4>
			<div class="row">
			<div class="input-field col s12">
				<input id="editDescricao" name="descricao" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="descricaoLabel" for="editDescricao">Descricao: </label>
			</div>

			<div class="input-field col s12">
				<input id="editPergunta1" name="pergunta1" required="" value="" type="text" class="validate remar-input" maxlength="150">
                    <label id="pergunta1Label" for="editPergunta1">Pergunta 1: </label>
			</div>

			<div class="input-field col s12">
				<input id="editResposta1" name="resposta1" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="resposta1Label" for="editResposta1">Resposta 1: </label>
			</div>

			<div class="input-field col s12">
				<input id="editPergunta2" name="pergunta2" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="pergunta2Label" for="editPergunta2">Pergunta 2: </label>
			</div>

			<div class="input-field col s12">
				<input id="editResposta2" name="resposta2" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="resposta2Label" for="editResposta2">Resposta 2: </label>
			</div>

			<div class="input-field col s12">
				<input id="editPergunta3" name="pergunta3" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="pergunta3Label" for="editPergunta3">Pergunta 3: </label>
			</div>

			<div class="input-field col s12">
				<input id="editResposta3" name="resposta3" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="resposta3Label" for="editResposta3">Resposta 3: </label>
			</div>

			<div class="input-field col s12">
				<input id="editPergunta4" name="pergunta4" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="pergunta4Label" for="editPergunta4">Pergunta 4: </label>
			</div>

			<div class="input-field col s12">
				<input id="editResposta4" name="resposta4" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="resposta4Label" for="editResposta4">Resposta 4: </label>
			</div>

			<div class="input-field col s12">
				<input id="editPergunta5" name="pergunta5" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="pergunta5Label" for="editPergunta5">Pergunta 5: </label>
			</div>

			<div class="input-field col s12">
				<input id="editResposta5" name="resposta5" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="resposta5Label" for="editResposta5">Resposta 5: </label>
			</div>

			<div class="input-field col s12">
				<input id="editPergunta6" name="pergunta6" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="pergunta6Label" for="editPergunta6">Pergunta 6: </label>
			</div>

			<div class="input-field col s12">
				<input id="editPistaFinal" name="pistafinal" required="" value="" type="text" class="validate remar-input" maxlength="150">
				<label id="editPistaFinalLabel" for="editPistaFinal">Pista final: </label>
			</div>

			<input type="hidden" id="editAuthor" name="authorID">
			<input type="hidden" id="casoID" name="casoID">
			<input type="hidden" id="editIndice" name="indice">


			<!-- Removido para testes!
			<input id="editVersion" name="version" required="" value="" type="hidden">

            <div class="input-field col s12">
                <input id="editStatement" name="statement" required="" value="" type="text" class="validate remar-input" maxlength="150">
                <label id="statementLabel" for="editStatement">Pergunta</label>
            </div>
            <div class="input-field col s12">
                <input id="editAnswer" name="answer" required="" value="" type="text" class="validate remar-input"  onkeypress="validate(event)" maxlength="48">
                <label id="answerLabel" for="editAnswer">Resposta</label>
            </div>
            <div class="input-field col s12">
                <input id="editCategory" name="category" required="" value="" type="text" class="validate remar-input">
                <label id="categoryLabel" for="editCategory">Tema</label>
            </div>

            <div class="input-field col s12" style="display: none;">
                <input id="editAuthor" name="author" required="" readonly="readonly" value="" type="text" class="validate remar-input">
                <label id="authorLabel" for="editAuthor">Autor</label>
            </div>
			-->

			</div>
		</div>
		<div class="modal-footer">
			<a href="#!" class="save modal-action modal-close btn waves-effect waves-light remar-orange" action="update"
			   onclick="$(this).closest('form').submit()" name="create">Atualizar</a>
			<a href="#!" class="modal-action modal-close btn waves-effect waves-light remar-orange">Cancelar</a>
		</div>
	</g:form>
</div>

<!-- Modal Structure -->
<div id="infoModal" class="modal">
	<div class="modal-content">
		<div id="totalCaso">

		</div>
	</div>

	<div class="modal-footer">
		<button class="btn waves-effect waves-light modal-close my-orange">Entendi</button>
	</div>
</div>

<div id="uploadModal" class="modal">
	<div class="modal-content">
		<h4>Enviar arquivo .csv</h4>
		<br>
		<div class="row">
			<g:uploadForm action="generateCasos">

				<div class="file-field input-field">
					<div class="btn my-orange">
						<span>Arquivo</span>
						<input type="file" accept="text/csv" id="csv" name="csv">
					</div>

					<div class="file-path-wrapper">
						<input class="file-path validate" type="text">
					</div>
				</div>
				<div class="row">
					<div class="col s1 offset-s10">
						<g:submitButton class="btn my-orange" name="csv" value="Enviar"/>
					</div>
				</div>
			</g:uploadForm>
		</div>

		<blockquote>Formatação do arquivo .csv</blockquote>
		<div class="row">
			<div class="col s6">
				<ol>
					<li>O separador do arquivo .csv deve ser <b> ';' (ponto e vírgula)</b>  </li>
					<li>O arquivo deve ser composto apenas por <b>dados</b></li>
					<li>O arquivo deve representar a estrutura da tabela ao lado</li>
				</ol>
				<ul>
					<li><a href="/cia/samples/exemploCIA.csv" >Download do arquivo exemplo</a></li>
				</ul>
			</div>
			<div class="col s6">
				<table class="center">
					<thead>
					<tr>
						<th>Descrição</th>
						<th>Etapa 1</th>
						<th>Etapa 2</th>
						<th>Etapa 3</th>
						<th>Etapa 4</th>
						<th>Etapa 5</th>
						<th>Etapa 6</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>Descrição</td>
						<td>Pergunta 1</td>
						<td>Pergunta 2</td>
						<td>Pergunta 3</td>
						<td>Pergunta 4</td>
						<td>Pergunta 5</td>
						<td>Pergunta 6</td>
					</tr>
					<tr>
						<td><td>
						<td>Resposta 1</td>
						<td>Resposta 2</td>
						<td>Resposta 3</td>
						<td>Resposta 4</td>
						<td>Resposta 5</td>
						<td>Pista final</td>
					</tr>
					</tbody>
				</table>

			</div>
		</div>
	</div>
</div>





<script type="text/javascript" src="/cia/js/materialize.min.js"></script>
<script type="text/javascript">

    function changeEditCaso(variable) {
        var editCaso = document.getElementById("editCasoLabel");
        editCaso.value = variable;

        console.log(editCaso.value);
        //console.log(variable);
    }

</script>

</body>
</html>
