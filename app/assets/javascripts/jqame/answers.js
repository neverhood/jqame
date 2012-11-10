// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//

'use strict';

if ( document.body.id == 'jqame-answers' || document.body.id == 'jqame-questions' ) {

    $.api.answers = {

       questionShow: {
          init: function() {
              $.api.answers._bindWmd();
          }
       },

       answerEdit: {
           init: function() {
               $.api.answers._bindWmd();
           }
       },

       _bindWmd: function() {
           new WMDEditor({
               input: 'answer_body',
               button_bar: 'answer-buttons',
               preview: 'answer-preview',
               helpLink: ''
           });

           $('pre').addClass('prettyprint');
           prettyPrint();
       }

    };

    $(function() {
        if ( $.api.controller == 'jqame-answers' && $.api.action == 'edit' ) $.api.answers.answerEdit.init();
    });

}

