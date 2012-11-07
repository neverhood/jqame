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
            $.api.favoritedQuestions.init(); // Favorites
            $.api.answers.questionShow.init(); // Answers related
            $.api.comments.questionShow.init(); // Comments related
        }
    });

}
