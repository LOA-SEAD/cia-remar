<%@ page import="br.ufscar.sead.loa.cia.remar.Caso" %>
<div id="principal">
    <div class="row">
        <div class="col s12">
            <div class="row">
                <div class="input-field col s12">
                    <textarea id="descricao" name="descricao" class="materialize-textarea" maxlength="200" length="200" name="descricao" required="" value="${casoInstance?.descricao}"></textarea>
                    <label for="descricao" >Descrição: </label>
                </div>
                <input id="author" name="author" type="hidden" required readonly="readonly" value="${userName}" class="validate remar-input">
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col s12">
            <div class="row">               
                <div class="input-field col s12">
                    <select id="dificuldade" name="dificuldade" value="${casoInstance?.dificuldade}">
                        <g:if test="${casoInstance?.dificuldade == 1}">
                            <option value="1" selected>Fácil</option>
                        </g:if>
                        <g:else>
                            <option value="1">Fácil</option>
                        </g:else>
                        <g:if test="${casoInstance?.dificuldade == 2}">
                            <option value="2" selected>Médio</option>
                        </g:if>
                        <g:else>
                            <option value="2">Médio</option>
                        </g:else>
                        <g:if test="${casoInstance?.dificuldade == 3}">
                            <option value="3" selected>Díficil</option>
                        </g:if>
                        <g:else>
                            <option value="3">Díficil</option>
                        </g:else>
                    </select>
                    <label for="dificuldade">Modo do Caça-Palavras:</label>
                </div>
            </div>
        </div>
    </div>

    <ul class="collapsible" data-collapsible="accordion">
        <li>
            <div class="collapsible-header" id="etapa1"><i class="material-icons">mode_edit</i>Primeira Etapa<span class="required-indicator">*</span></div>
            <div class="collapsible-body">
                <div class="row">
                    <div class="input-field col s12 required">
                        <textarea id="pergunta1" class="materialize-textarea" name="pergunta1" maxlength="70" length="70" value="${casoInstance?.pergunta1}"></textarea>
                        <label for="pergunta1">Primeira Pergunta<span class="required-indicator">*</span></label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6 required">
                        <input id="resposta1"  name="resposta1" type="text" maxlength="15" length="15" value="${casoInstance?.resposta1}"></p>
                        <label for="resposta1">Primeira Resposta<span class="required-indicator">*</span></label>
                    </div>
                </div>
            </div>
        </li>

        <li>
            <div class="collapsible-header" id="etapa2"><i class="material-icons">mode_edit</i>Segunda Etapa<span class="required-indicator">*</span></div>
            <div class="collapsible-body">
                <div class="row">
                    <div class="input-field col s12 required">
                        <textarea id="pergunta2" class="materialize-textarea" name="pergunta2" maxlength="70" length="70" value="${casoInstance?.pergunta2}"></textarea>
                        <label for="pergunta2">Segunda Pergunta<span class="required-indicator">*</span></label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6 required">
                        <input id="resposta2"  name="resposta2" type="text" maxlength="15" length="15" value="${casoInstance?.resposta2}"></p>
                        <label for="resposta2">Segunda Resposta<span class="required-indicator">*</span></label>
                    </div>
                </div>
            </div>
        </li>

        <li>
            <div class="collapsible-header" id="etapa3"><i class="material-icons">mode_edit</i>Terceira Etapa<span class="required-indicator">*</span></div>
            <div class="collapsible-body">
                <div class="row">
                    <div class="input-field col s12 required">
                        <textarea id="pergunta3" class="materialize-textarea" name="pergunta3" maxlength="70" length="70" value="${casoInstance?.pergunta3}"></textarea>
                        <label for="pergunta3">Terceira Pergunta<span class="required-indicator">*</span></label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6 required">
                        <input id="resposta3"  name="resposta3" type="text" maxlength="15" length="15" value="${casoInstance?.resposta3}"></p>
                        <label for="resposta3">Terceira Resposta<span class="required-indicator">*</span></label>
                    </div>
                </div>
            </div>
        </li>

        <li>
            <div class="collapsible-header" id="etapa4"><i class="material-icons">mode_edit</i>Quarta Etapa<span class="required-indicator">*</span></div>
            <div class="collapsible-body">
                <div class="row">
                    <div class="input-field col s12 required">
                        <textarea id="pergunta4" class="materialize-textarea" name="pergunta4" maxlength="70" length="70" value="${casoInstance?.pergunta4}"></textarea>
                        <label for="pergunta4">Quarta Pergunta<span class="required-indicator">*</span></label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6 required">
                        <input id="resposta4"  name="resposta4" type="text" maxlength="15" length="15" value="${casoInstance?.resposta4}"></p>
                        <label for="resposta4">Quarta Resposta<span class="required-indicator">*</span></label>
                    </div>
                </div>
            </div>
        </li>

        <li>
            <div class="collapsible-header" id="etapa5"><i class="material-icons">mode_edit</i>Quinta Etapa<span class="required-indicator">*</span></div>
            <div class="collapsible-body">
                <div class="row">
                    <div class="input-field col s12 required">
                        <textarea id="pergunta5" class="materialize-textarea" name="pergunta5" maxlength="70" length="70" value="${casoInstance?.pergunta5}"></textarea>
                        <label for="pergunta5">Quinta Pergunta<span class="required-indicator">*</span></label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6 required">
                        <input id="resposta5"  name="resposta5" type="text" maxlength="15" length="15" value="${casoInstance?.resposta5}"></p>
                        <label for="resposta5">Quinta Resposta<span class="required-indicator">*</span></label>
                    </div>
                </div>
            </div>
        </li>

        <li>
            <div class="collapsible-header" id="etapa6"><i class="material-icons">mode_edit</i>Última Etapa<span class="required-indicator">*</span></div>
            <div class="collapsible-body">
                <div class="row">
                    <div class="input-field col s12 required">
                        <textarea id="pergunta6" class="materialize-textarea" name="pergunta6" maxlength="70" length="70" value="${casoInstance?.pergunta6}"></textarea>
                        <label for="pergunta6">Última Pergunta<span class="required-indicator">*</span></label>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s6 required">
                        <input id="pistafinal"  name="pistafinal" type="text" maxlength="15" length="15" value="${casoInstance?.pistafinal}"></p>
                        <label for="pistafinal">Última Resposta<span class="required-indicator">*</span></label>
                    </div>
                </div>

                <div id="errorDiv"></div>
            </div>
        </li>
    </ul>
</div>
