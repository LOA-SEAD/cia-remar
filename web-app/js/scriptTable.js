/**
 * Created by loa on 19/03/15.
 */
$(document).ready(function () {


});

window.onload = function(){
   // $('#table').editableTableWidget();

   // addListeners();

    $('#table tr td:not(:last-child)').click(function (event) {
        var tr = this.closest('tr');
        if($(tr).attr('data-checked') == "true") {
            $(tr).attr('data-checked', "false");
            $(':checkbox', this.closest('tr')).prop('checked', false);
        }
        else {
            $(tr).attr('data-checked', "true");
            $(':checkbox', this.closest('tr')).prop('checked', 'checked');
        }

    });


    $('#delete').click(function() {
        if (confirm("Você tem certeza?")) {

        var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        console.log(trs.length);
        for (var i = 0; i < trs.length; i++) {
            if ($(trs[i]).attr('data-checked') == "true") {
                $(trs[i]).addClass('disabled');
                _delete(trs[i]);
            }
        }
    }


    });

    $('#save').click(function () {
        var params = "";
        var i = 0;
        var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
        for (i = 0; i < trs.length; i++) {
            if ($(trs[i]).attr('data-checked') == "true") {
                params += $(trs[i]).attr('data-id') + ',';
            }
        }
        if(params.length) {

            params = params.substr(0, params.length -1);

            window.top.location.href = "/cia/caso/toJson/" + params;
        }
        else{
            $('#totalCaso').empty();
            $("#totalCaso").append("<div> <p> Selecione ao menos dois casos antes de enviar. </p> </div>");
            $('#infoModal').openModal();
        }

    });

};

function addListeners() {
    var tds = $('td');
    var input = $('input');

    $(tds).on('click', function() {
        if ($(this).hasClass('_not_editable')) {
            return;
        }

        $(this).addClass('_selected');
        if($(this).hasClass('_error')) { // cell is empty
            $(this).removeClass('_error').addClass('_had-error'); // remove error class to prevent shadow overlap
        }
    });

    $(input).on('input', function() {
        if($(this)[0].value == "") { // input is empty
            $(this).addClass('_error'); // red shadow
        } else {
            $(this).removeClass('_error'); // blue shadow (default)
        }
    });

    $(input).on('focusout', function() {
        if($(this).hasClass('_not_editable')) {
            return;
        }
        var el = document.getElementsByClassName('_selected')[0];
        $(el).removeClass('_selected');
        $(el).removeClass('_had-error');
        $(this).removeClass('_error'); // remove error from input (same input will be reused)

        if($(this)[0].value == "") {
            $(el).addClass('_error');
        } else {
            if($(el).parent().attr('data-new')) {
                if($(el).attr('data-save')) {
                    $(el).parent().removeAttr('data-new');
                    $(el).removeAttr('data-save');
                    $(el).textContent = 'test';
                    setTimeout(function() {
                        save($(el).parent());
                    }, 500);
                }
            } else {
                setTimeout(function() {
                    update($(el).parent());
                }, 500);
            }
        }
    });

}

function getUserName() {
    return $("meta[property='user-name']").attr('content');
}

function getUserId() {
    return $("meta[property='user-id']").attr('content');
}

function getIndice(){
    return $();
}

function save(tr) {
    var tds = $(tr).find("td");
    var url = location.origin + '/cia/caso/save/';
    var data = { descricao: $(tds)[1].textContent,
                 pergunta1: $(tds)[2].textContent, 
                 pergunta2: $(tds)[3].textContent,
                 pergunta3: $(tds)[4].textContent,
                 pergunta4: $(tds)[5].textContent,
                 pergunta5: $(tds)[6].textContent,
                 pergunta6: $(tds)[7].textContent,
                 resposta1: $(tds)[8].textContent,
                 resposta2: $(tds)[9].textContent,
                 resposta3: $(tds)[10].textContent,
                 resposta4: $(tds)[11].textContent,
                 resposta5: $(tds)[12].textContent,
                 pistaFinal: $(tds)[13].textContent,
                 author: $(tds)[14].textContent,
                 indice: $(tds)[15].textContent,
                 ownerId: $(tr).attr('data-owner-id')};

    
    console.log(data);

    $.ajax({
        type:'POST',
        data: data,
        url: url,
        success:function(data){
            $(tr).attr('data-id', data.id);
            console.log(data);
        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
}

function update(tr) {
    var tds = $(tr).find("td");
    var url = location.origin + '/cia/caso/update/' + $(tr).attr('data-id');
    var data = { descricao: $(tds)[0].textContent,
                 pergunta1: $(tds)[1].textContent,
                 resposta1: $(tds)[2].textContent,
                 pergunta2: $(tds)[3].textContent,
                 resposta2: $(tds)[4].textContent,
                 pergunta3: $(tds)[5].textContent,
                 resposta3: $(tds)[6].textContent,
                 pergunta4: $(tds)[7].textContent,
                 resposta4: $(tds)[8].textContent,
                 pergunta5: $(tds)[9].textContent,
                 resposta5: $(tds)[10].textContent,
                 pergunta6: $(tds)[11].textContent,
                 pistaFinal: $(tds)[12].textContent,
                 author: $(tds)[13].textContent,
                 indice: $(tds)[14].textContent,
                 ownerId: $(tr).attr('data-owner-id'),
                 _method: 'PUT' };
    $.ajax({
        type:'POST',
        data: data,
        url: url,
        success:function(data){
            console.log(data);

        },
        error:function(XMLHttpRequest,textStatus,errorThrown){}});
}


function _edit(tr){
    var url = location.origin + '/cia/caso/returnInstance/' + $(tr).attr('data-id');
    var data = {_method: 'GET'};
    $.ajax({
            type: 'GET',
            data: data,
            url: url,
            success: function (returndata) {
                var casoInstance = returndata.split("%@!");
                //casoInstance é um vetor com os atributos da classe Caso na seguinte ordem:
                //console.log("Sucesso?");
                //console.log(casoInstance);
                $("#editDescricao").attr("value",casoInstance[0]);
                $("#descricaoLabel").attr("class","active");
                $("#pergunta1Label").attr("class","active");
                $("#pergunta2Label").attr("class","active");
                $("#pergunta3Label").attr("class","active");
                $("#pergunta4Label").attr("class","active");
                $("#pergunta5Label").attr("class","active");
                $("#pergunta6Label").attr("class","active");

                $("#resposta1Label").attr("class","active");
                $("#resposta2Label").attr("class","active");
                $("#resposta3Label").attr("class","active");
                $("#resposta4Label").attr("class","active");
                $("#resposta5Label").attr("class","active");
                $("#pistafinalLabel").attr("class","active");

                $("#editPergunta1").attr("value",casoInstance[1]);
                $("#editResposta1").attr("value",casoInstance[7]);
                $("#editPergunta2").attr("value",casoInstance[2]);
                $("#editResposta2").attr("value",casoInstance[8]);
                $("#editPergunta3").attr("value",casoInstance[3]);
                $("#editResposta3").attr("value",casoInstance[9]);
                $("#editPergunta4").attr("value",casoInstance[4]);
                $("#editResposta4").attr("value",casoInstance[10]);
                $("#editPergunta5").attr("value",casoInstance[5]);
                $("#editResposta5").attr("value",casoInstance[11]);
                $("#editPergunta6").attr("value",casoInstance[6]);
                $("#editPistaFinal").attr("value",casoInstance[12]);

                $("#editAuthor").attr("value",casoInstance[13]);
                $("#casoID").attr("value",casoInstance[14]);
                $("#editIndice").attr("value",casoInstance[15]);


                $("#editModal").openModal(

                );

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                console.log("Error, não retornou a instância");
            }
        }
    );
}

function _delete() {

    var list_id = [];
    var url;
    var data;
    var trID;

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

    if(list_id.length<=0){
        alert("Você deve selecionar ao menos um caso para excluir");
    }
    else{
        if(list_id.length==1){
            if(confirm("Você tem certeza que deseja deletar esse caso?")){
                url = location.origin + '/cia/caso/delete/' + list_id[0];
                data = {_method: 'DELETE'};
                trID = "#tr"+list_id[0];
                $.ajax({
                        type: 'DELETE',
                        data: data,
                        url: url,
                        success: function (data) {
                            $(trID).remove();
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                        }
                    }
                );
            }
        }
        else{
            if(confirm("Você tem certeza que deseja deletar esses casos?")){
                for(var i=0;i<list_id.length;i++){
                    url = location.origin + '/cia/caso/delete/' + list_id[i];
                    data = {_method: 'DELETE'};
                    trID = "#tr"+list_id[i];
                    $(trID).remove();
                    $.ajax({
                            type: 'DELETE',
                            data: data,
                            url: url,
                            success: function (data) {
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                            }
                        }
                    );
                }
                $(trID).remove();

            }
        }

    }

}

$(function(){
    $("#SearchLabel").keyup(function(){
        _this = this;
        $.each($("#table tbody").find("tr"), function() {
            console.log($(this).text());
            if($(this).text().toLowerCase().indexOf($(_this).val().toLowerCase()) == -1)
                $(this).hide();
            else
                $(this).show();
        });
    });
});


var x = document.getElementsByName("caso_label");
$(document).on("click", ".selectable_tr", function () {
    //console.log("click event");
    var myNameId = $(this).data('id');
    //var myCheck = $(this).data('checked');
    console.log(myNameId);
    //console.log(myCheck);
    $("#casoInstance").val( myNameId );
    $('body').on('hidden.bs.modal', '#EditModal', function (e) {
        console.log("entrou aqui");
        $(e.target).removeData("bs.modal");
        $("#EditModal > div > div > div").empty();
    });


});


$( document ).ready(function() {
    $('#BtnUnCheckAll').hide();
    var author = document.getElementById("author");
    author.value = getUserName();
    $('.modal-trigger').leanModal();
});

function check_all(){
    console.log("selecionar todas");
    var CheckAll = document.getElementById("BtnCheckAll");
    var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    $(".filled-in:visible").prop('checked', 'checked');


    for (var i = 0; i < trs.length; i++) {
        if($(trs[i]).is(':visible')) {
            $(trs[i]).attr('data-checked', "true");
        }
    }

    $('#BtnCheckAll').hide();
    $('#BtnUnCheckAll').show();

}

function uncheck_all(){
    console.log("selecionar todas");
    var UnCheckAll = document.getElementById("BtnUnCheckAll");
    var trs = document.getElementById('table').getElementsByTagName("tbody")[0].getElementsByTagName('tr');
    $(".filled-in:visible").prop('checked', false);


    for (var i = 0; i < trs.length; i++) {
        if($(trs[i]).is(':visible')) {
            $(trs[i]).attr('data-checked', "false");
        }
    }

    $('#BtnUnCheckAll').hide();
    $('#BtnCheckAll').show();

}

function exportCasos(){
    var list_id = [];

    $.each($("input[type=checkbox]:checked"), function(ignored, el) {
        var tr = $(el).parents().eq(1);
        list_id.push($(tr).attr('data-id'));
    });

    if(list_id.length<=0){
        alert("Você deve selecionar ao menos um caso antes de exportar seu banco de questões");
    }
    else{
        $.ajax({
            type: "POST",
            traditional: true,
            url: "/cia/caso/exportCSV",
            data: { list_id: list_id },
            success: function(returndata) {
                console.log(returndata);
                window.open(location.origin+returndata, '_blank');
            },
            error: function(returndata) {
                alert("Error:\n" + returndata.responseText);


            }
        });
    }

}