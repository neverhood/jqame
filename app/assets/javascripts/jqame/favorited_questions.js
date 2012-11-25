// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

if ( document.body.id == 'jqame-questions' ) {

    $.api.favoritedQuestions = {

        init: function() {
            $('div#toggle-favorited a.remove-from-favorites, div#toggle-favorited a.add-to-favorites').bind('ajax:beforeSend', function() {
                if ( $.api.loading ) return false; // not so fast

                var $this = $(this),
                    action = $this.hasClass('add-to-favorites') ? 'add' : 'remove',
                    container = $(this).parents('div#toggle-favorited'),
                    currentCount = container.find('div.times-favorited'),
                    newCount = parseInt( currentCount.text() ) + ( action == 'add' ? 1 : -1 ),
                    requestType = $this.attr('data-method');

                currentCount.text( newCount );
                $this.attr('data-method', ( action == 'add' ? 'delete' : 'post' ));
                $this.toggleClass('remove-from-favorites add-to-favorites').
                    find('i').toggleClass('icon-star icon-star-empty');

                $.api.loading = true;
                $.ajax({
                    type: requestType,
                    url:  this.href,
                    complete: function() { $.api.loading = false }
                });

                return false;
            });
        }

    }

}
