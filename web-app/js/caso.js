/**
 * Last Update: 17/10/17.
 * Created by:  Pedro Garcia on 24/07/17.
 * Authors:     Pedro Garcia,
 *              Lucas Yuji Suguinoshita.
**/

// Server URLs used by this script;
var SEND_URL     = "/cia/caso/send";
var DELETE_URL   = "/cia/caso/delete";
var UPDATE_URL   = "/cia/caso/update"
var INSTANCE_URL = "/cia/caso/returnInstance"

// Interface messages used as feedback to user.
var ERROR_MSG               = "Ocorreu um erro! Tente novamente.";
var SELECT_CASE_MSG         = "Por favor selecione pelo menos três casos.";
var REMOVE_SUCCESS_MSG      = "Caso removido com sucesso.";
var MAX_CASE_REACHED_MSG    = "Por favor selecione menos casos!";

// Constants used by this script.
var MIN_CASE_COUNT = 3;
var MAX_CASE_COUNT = 3;
var TOAST_LIFESPAN_MILLI = 4000;

$(document).ready(function () {
    $(".modal-trigger").leanModal();
    $('.sortable')
        .on('click', 'li', function() {
            $(this).toggleClass('active');

            // Specific behaviour of available cases list
            if ($(this).closest('ul').attr('id') == 'available-cases') {
                var $button = $('#' + $(this).parent().data('button'));

                // If any available cases are selected, enable the delete button
                if ($('#available-cases li.active').length >= 1) {
                    $button.removeClass('disabled');
                } else {
                    $button.addClass('disabled');
                }
            }
        })
        .sortable({
            connectWith: '.sortable',
            delay: 150, // needed to prevent accidental drag when trying to select

            helper: function (e, item) {
                // If you grab an unhighlighted item to drag, it will deselect (unhighlight) everything else
                if (!item.hasClass('active')) {
                    item.addClass('active').siblings().removeClass('active');
                }

                // Passing the selected items to the stop() function
                // Clone the selected items into an array
                var elements = item.parent().children('.active').clone().removeClass('active');

                // Add a property to 'item' called 'multidrag' that contains the selected items
                // Then remove the selected items from source list
                item.data('multidrag', elements).siblings('.active').remove();

                // Now the selected items exist in memory, attached to the 'item'
                // We can access them later when we get the stop() callback

                item.unbind('mouseenter mouseleave');

                // Create the helper
                var helper = $('<div/>');
                return helper.append(elements);
            },
            start: function (e, ui) {
                // Resize placeholder to the size of the objects being dragged
                var height = ui.item.outerHeight();
                var length = ui.item.data('multidrag').length;
                ui.placeholder.outerHeight((height - 0.5) * length);

                // To avoid bugs regarding the remove button, we disable it after dropping the element
                $('#deleteButton').addClass('disabled');
            },
            stop: function (e, ui) {
                // Now we access those items that we stored in items data
                var elements = ui.item.data('multidrag');

                // 'elements' now contains the originally selected items from the source list

                // Finally, insert the selected items after the 'item', then remove the 'item'
                //      since item is a duplicate of one of the selected items
                ui.item.after(elements).remove();

                // Initialize tooltip of dinamically generated tooltips
                $('.tooltipped').tooltip();
            },
            update: function() {
                var button = '#' + $(this).data('button');
                // Specific behaviour for each of the sortable lists
                if($(this).attr('id') == 'available-cases') {
                    // Disable the remove button for the available cases list because user could have
                    // only one case in the list and, if it were selected, the button would be enabled
                    if ($(this).children().length <= 0) {
                        $(button).addClass('disabled');
                    }
                } else if ($(this).attr('id') == 'selected-cases') {
                    // If the list has the minimum or maximum number of childs after the end of the drag-and-drop event, it means
                    // that the user has reached the possible number of cases to send. So we enable the button.
                    if ($(this).children().length >= MIN_CASE_COUNT && $(this).children().length <= MAX_CASE_COUNT) {
                        $(button).removeClass('disabled');
                    // If the number of selected cases is less than the minimum or more than the maximum, disable the send button
                    // thus preventing the user from finishing the task
                    } else {
                        $(button).addClass('disabled');
                    }
                }
            }
        });

    // Case edit button function
    $("li .editButton").click(function(){
        // Extract selected case ID;
        var caseId = $(this).data('case-id');

        // Request selected case information;
        $.ajax({
            type: 'GET',
            url:  INSTANCE_URL + "/" + caseId,
            data: {'_method': 'GET'},
            success: function(response) {
                var caseInstance = response.split("%@!");

                // Populate edit form with selected case information
                $("#editForm #descricao").val(caseInstance[0]);
                $("#editForm #pergunta1").val(caseInstance[1]);
                $("#editForm #pergunta2").val(caseInstance[2]);
                $("#editForm #pergunta3").val(caseInstance[3]);
                $("#editForm #pergunta4").val(caseInstance[4]);
                $("#editForm #pergunta5").val(caseInstance[5]);
                $("#editForm #pergunta6").val(caseInstance[6]);
                $("#editForm #resposta1").attr("value", caseInstance[7]);
                $("#editForm #resposta2").attr("value", caseInstance[8]);
                $("#editForm #resposta3").attr("value", caseInstance[9]);
                $("#editForm #resposta4").attr("value", caseInstance[10]);
                $("#editForm #resposta5").attr("value", caseInstance[11]);
                $("#editForm #pistafinal").attr("value", caseInstance[12]);
                $("#editForm #editCasoID").attr("value", caseInstance[14]);
                $("#editModal").openModal();

                // Update form labels to minimize after we updated the edit form
                Materialize.updateTextFields();

                // Update edit form with correct URL
                document.editForm.action = UPDATE_URL + "/" + caseId
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                Materialize.toast(ERROR_MSG, TOAST_LIFESPAN_MILLI);
                console.log(textStatus);
            }
        })
    });

    $("#saveCaseButton").click(function() {
        if (document.createForm.resposta1.value.length > 0 &&
        document.createForm.resposta2.value.length > 0 &&
        document.createForm.resposta3.value.length > 0 &&
        document.createForm.resposta4.value.length > 0 &&
        document.createForm.resposta5.value.length > 0 &&
        document.createForm.pistafinal.value.length > 0 &&
        document.createForm.pergunta1.value.length > 0 &&
        document.createForm.pergunta2.value.length > 0 &&
        document.createForm.pergunta3.value.length > 0 &&
        document.createForm.pergunta4.value.length > 0 &&
        document.createForm.pergunta5.value.length > 0 &&
        document.createForm.pergunta6.value.length > 0) {
            document.createForm.submit();
            $("#createForm").closeModal();
        } else {
            $("#errorDiv").html("Um dos campos está incorreto. Verifique e tente novamente.")
        }



    });

    // Finish case selection button click function
    $("#sendButton").click(function() {
        // Capture all cases dragged to the selected cases list and extract the case id
        var selectedCases = $("#selected-cases li").map(function() {
            return $(this).data("caseId");
        });

        if (!($(this).hasClass('disabled'))) {
            // Setup the id list as a JSON object to be sent
            // Grails receives the list in a single parameter that'll be called "id[]"
            var data = { "id": selectedCases.toArray() };

            // Perform an AJAX request sending the case id list
            $.ajax({
                type: 'POST',
                url: SEND_URL,
                data: data,
                success: function(response) {
                    // The server returns a URL to redirect the user to.
                    // This page is supposed to be running in an iframe, so we use window.top to redirect the top/parent frame instead of the iframe.
                    window.top.location.href = response;
                },
                error: function(xhr, error, exThrown) {
                    // Use a toast to inform that an error has ocurred to the user.
                    Materialize.toast(ERROR_MSG, TOAST_LIFESPAN_MILLI);
                    console.log("Response object: " + xhr);
                    console.log("Error message: " + error);
                    console.log("Exception: " + exThrown);
                }
            })
        } else {
            // User hasn't selected an acceptable number of cases.
            // Check how many cases were selected and feedback the user accordingly.
            if (selectedCases.size() < MIN_CASE_COUNT) {
                Materialize.toast(SELECT_CASE_MSG, TOAST_LIFESPAN_MILLI);
            } else if (selectedCases.size() > MAX_CASE_COUNT) {
                Materialize.toast(MAX_CASE_REACHED_MSG, TOAST_LIFESPAN_MILLI);
            }
        }
    });

    // Delete button click function
    $("#deleteButton").click(function() {
        if (!($(this).hasClass('disabled'))) {
            // Capture each selected case item and run the following code using each one of them inside the "this" variable.
            $(".case-list-box li.active").each(function(){
                // Setup all the necessary content in a JSON to be sent to the server.
                var deleteData = {};
                deleteData.id = $(this).data("caseId");
                deleteData.ownerId = $(this).data("ownerId");
                deleteData._method = "DELETE";

                $.ajax({
                    type:"DELETE",
                    // Call the especific delete URL, which basically overrides the necessity of sending any extra data to the server.
                    url: DELETE_URL + "/" + deleteData.id,
                    // We send it anyway in case of server-side version changes.
                    data: deleteData,
                    success: function(response) {
                        // Alert the user that the case has been successfully removed.
                        Materialize.toast(REMOVE_SUCCESS_MSG);
                        // Refresh the page to show the updated case list.
                        window.location.reload(true);
                    },
                    error: function(xhr, error, exThrown) {
                        // Use a toast to inform that an error has ocurred to the user.
                        Materialize.toast(ERROR_MSG);
                        console.log("Response object: " + xhr);
                        console.log("Error message: " + error);
                        console.log("Exception: " + exThrown);
                    }
                });
            });
        }
    });
});


