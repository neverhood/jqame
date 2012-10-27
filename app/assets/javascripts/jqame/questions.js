// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//

'use strict';

if ( document.body.id == 'jqame-questions' ) {

    $.api.questions = {
        init: function() {
        }
    };

    $(function() {
        $.api.questions.init();

        if ( $.api.action == 'show' ) {
            $.api.answers.questionShow.init();
            $.api.comments.questionShow.init();
        }
    });

}
