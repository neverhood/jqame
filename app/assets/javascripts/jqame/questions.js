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
            $.api.suffrage.init(); // Voting
            $.api.answers.questionShow.init(); // Answers related
            $.api.comments.questionShow.init(); // Comments related
        }
    });

}
