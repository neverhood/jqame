//= require jqame/wmd
//= require jqame/showdown
//= require jqame/prettify
//

'use strict';

if ( document.body.id == 'jqame-questions' ) {

    $.api.questions = {
        page: 1,
        indexUrl: '/jqame/questions',
        init: function() {
            if ( $.api.action == 'index' ) this._bindEndlessPagination();
            if ( $.api.action == 'new' || $.api.action == 'edit' ) this._bindWmd();
        },

        _bindEndlessPagination: function() {
            var $window = $(window),
                $document = $(document);

            $window.scroll(function () {
                if ( $.api.loading ) return false;

                if ($window.scrollTop() >= $document.height() - $window.height() - 100) {
                    var questionsContainer = $('div#questions'),
                        page = parseInt( questionsContainer.attr('data-page') ) + 1;

                    if ( questionsContainer.attr('data-last-page') === 'true' ) return false;

                    $.api.loading = true;
                    $.getJSON( $.api.questions.indexUrl + '?page=' + page, function(data) {
                        questionsContainer.append( data.questions ).
                            attr('data-page', page);

                        if ( data.last_page ) questionsContainer.attr('data-last-page', true);

                        $.api.loading = false;
                    });
                }
            });
        },

        _bindWmd: function() {
            new WMDEditor({
                input: 'question_body',
                button_bar: 'question-buttons',
                preview: 'question-preview',
                helpLink: ''
            });

            $('pre').addClass('prettyprint');
            prettyPrint();
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
