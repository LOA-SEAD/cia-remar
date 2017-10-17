<%@ page import="br.ufscar.sead.loa.cia.remar.Caso" %>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font, Font Awesome and Page CSS-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <g:external dir="css" file="caso.css"/>

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="layout" content="main"/>
    <meta charset="utf-8"/>
    <meta property="user-name" content="${userName}"/>
    <meta property="user-id" content="${userId}"/>

    <g:set var="entityName" value="${message(code: 'caso.label', default: 'Caso')}"/>

</head>

<body>
    <div class="cluster-header">
        <p class="text-teal text-darken-3 left-align margin-bottom" style="font-size: 28px;">
            CIA - Tabela de Casos
        </p>
    </div>

    <div class="row">
        <section class="case-management">
            <div class="case-list-box-container">
                <div class="case-list-box-title">
                    <p>Banco de Casos</p>
                </div>

                <ul id="available-cases" class="row case-list-box sortable" data-button="deleteButton">
                    <g:each in="${CaseInstanceList}" status="i" var="CaseInstance">
                        <li class="row" data-case-id="${fieldValue(bean: CaseInstance, field: "id")}" data-owner-id="${fieldValue(bean: CaseInstance, field: "ownerId")}">
                            <div class="col s2">
                                <i class="material-icons">drag_handle</i>
                            </div>
                            <div class="col s5">
                                <span>${fieldValue(bean: CaseInstance, field: "descricao")}</span>
                            </div>
                            <div class="col s3">
                                <span class="case-structure">${fieldValue(bean: CaseInstance, field: "pergunta1")}</span>
                            </div>
                            <div class="col s2">
                                <i class="fa fa-info tooltipped"
                                   data-position="bottom" data-delay="50" data-tooltip="${fieldValue(bean: CaseInstance, field: "pistafinal")}"></i>
                            </div>
                        </li>
                    </g:each>
                </ul>

                <div class="case-list-box-button">
                    <div class="row">
                        <div class="col s6">
                            <a id="createButton" class="waves-effect waves-light btn remar-orange">
                                <span>
                                    <p>Adicionar</p>
                                </span>
                            </a>
                        </div>
                        <div class="col s6">
                            <a id="deleteButton" class="waves-effect waves-light btn remar-orange disabled">
                                <span>
                                    <p>Remover</p>
                                </span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="case-list-box-container">
                <div class="case-list-box-title">
                    <p>Casos Selecionadas</p>
                </div>

                <ul id="selected-cases" class="row case-list-box sortable" data-button="sendButton">

                </ul>

                <div class="case-list-box-button">
                    <div class="row">
                        <div class="col s8">
                            <a id="sendButton" class="waves-effect waves-light btn remar-orange disabled">
                                <span>
                                    <p>Enviar</p>
                                </span>
                            </a>
                        </div>
                        <div class="col s2">
                            <a id="importButton" class="btn-floating waves-effect waves-light my-orange tooltipped" data-tooltip="Upload de arquivo .csv"><i
                                    class="material-icons">file_upload</i></a>
                        </div>
                        <div class="col s2">
                            <a id="exportButton" class="btn-floating waves-effect waves-light my-orange tooltipped" data-tooltip="Exportar questões para .csv"><i
                                    class="material-icons">file_download</i></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Modal Structure -->
    <div id="createModal" class="modal remar-modal">
        <g:form name="createForm" url="[resource: casoInstance, action: 'save']">
            <div class="modal-content">
                <h4>Criar Caso <i class="material-icons tooltipped" data-position="right" data-delay="30" data-tooltip="Respostas não devem possuir números nem caracteres especiais.">info</i> </h4>
                <g:render template="form"/>
            </div>
            <div class="modal-footer">
                <a id="saveCaseButton" href="#!" class="save modal-action modal-close btn waves-effect waves-light remar-orange">Enviar</a>
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

    <g:javascript src="caso.js"/>
</body>
</html>
