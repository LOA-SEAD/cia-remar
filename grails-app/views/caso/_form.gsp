<%@ page import="br.ufscar.sead.loa.detetive.remar.Caso" %>


<!--Import Google Icon Font-->
<link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet" href="css/materialize.css" media="screen,projection"/>
<link rel="stylesheet" type="text/css" href="css/caso.css">
<script type="text/javascript" src="js/materialize.min.js"></script>


<div id="principal">
	<div class="row">
		<div class="col s12">
			<div class="row">
				<div class="input-field col s12">
					<textarea id="descricao" name="descricao" class="materialize-textarea" data-length="200" name="descricao" required="" value="aaaaaaaaaa${casoInstance?.descricao}bbbbb"></textarea>
					<label id="descricao1_text" for="descricao" >Descrição: </label>
				</div>
			</div>
		</div>
	</div>


	<ul class="collapsible" data-collapsible="accordion">
		<li>
			<div class="collapsible-header" id="etapa1"><i class="material-icons">mode_edit</i>Primeira Etapa</div>
			<div class="collapsible-body">
				<p id='pergunta1_text'>Entre com a pergunta: <p>
				<input type="text" name="pergunta1" id="pergunta1" size="50" data-length="50" required="" value="aaaa${casoInstance?.pergunta1}"></p>

				<p id='resposta1_text'>Entre com a resposta: <p>
				<input type="text" name="resposta1" id="resposta1" size="50" data-length="15 "required="" value="aaaaa${casoInstance?.resposta1}"></p>
			</div>
		</li>

		<li>
			<div class="collapsible-header" id="etapa2"><i class="material-icons">mode_edit</i>Segunda Etapa</div>
			<div class="collapsible-body">
				<p id='pergunta2_text'>Entre com a pergunta: <p>
				<input type="text" name="pergunta2" id="pergunta2" size="50" data-length="50" required="" value="aaaaa${casoInstance?.pergunta2}"></p>

				<p id='resposta2_text'>Entre com a resposta: <p>
				<input type="text" name="resposta2" id="resposta2" size="50" data-length="15" required="" value="aaaaa${casoInstance?.resposta2}"></p>
			</div>
		</li>

		<li>
			<div class="collapsible-header" id="etapa3"><i class="material-icons">mode_edit</i>Terceira Etapa</div>
			<div class="collapsible-body">
				<p id='pergunta3_text'>Entre com a pergunta: <p>
				<input type="text" name="pergunta3" id="pergunta3" size="50" data-length="50" required="" value="aaaa${casoInstance?.pergunta3}"></p>

				<p id='resposta3_text'>Entre com a resposta: <p>
				<input type="text" name="resposta3" id="resposta3" size="50" data-length="15" required="" value="aaaa${casoInstance?.resposta3}"></p>
			</div>
		</li>

		<li>
			<div class="collapsible-header" id="etapa4"><i class="material-icons">mode_edit</i>Quarta Etapa</div>
			<div class="collapsible-body">
				<p id='pergunta4_text'>Entre com a pergunta: <p>
				<input type="text" name="pergunta4" id="pergunta4" size="50" data-length="50" required="" value="aaaaa${casoInstance?.pergunta4}"></p>

				<p id='resposta4_text'>Entre com a resposta: <p>
				<input type="text" name="resposta4" id="resposta4" size="50" data-length="15" required="" value="aaaaa${casoInstance?.resposta4}"></p>
			</div>
		</li>

		<li>
			<div class="collapsible-header" id="etapa5"><i class="material-icons">mode_edit</i>Quinta Etapa</div>
			<div class="collapsible-body">
				<p id='pergunta5_text'>Entre com a pergunta: <p>
				<input type="text" name="pergunta5" id="pergunta5" size="50" data-length="50" required="" value="aaaa${casoInstance?.pergunta5}"></p>

				<p id='resposta5_text'>Entre com a resposta: <p>
				<input type="text" name="resposta5" id="resposta5" size="50" data-length="15" required="" value="aaaaa${casoInstance?.resposta5}"></p>
			</div>
		</li>

		<li>
			<div class="collapsible-header" id="etapa6"><i class="material-icons">mode_edit</i>Última Etapa</div>
			<div class="collapsible-body">
				<p id='pergunta6_text'>Entre com a pergunta: <p>
				<input type="text" name="pergunta6" id="pergunta6" size="50" data-length="50" required="" value="aaaa${casoInstance?.pergunta6}"></p>

				<p id='resposta6_text'>Entre pista final: <p><p>
				<input type="text" name="pistafinal" id="resposta6" size="50" data-length="15" required="" value="aaaaa${casoInstance?.pistafinal}"></p>
			</div>
		</li>

		<div class="input-field col s12" style="display: none;">
			<input id="author" name="author" required="" readonly="readonly" value="${casoInstance?.author}" type="text" class="validate remar-input">
			<label for="author">Autor</label>
		</div>
		<div class="input-field col s12" style="display: none;">
			<input id="indice" name="indice" required="" readonly="readonly" value="" type="number" class="validate remar-input">
			<label for="indice">Indice</label>
		</div>

	</ul>

</div>