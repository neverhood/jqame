'use strict';

if ( document.body.id == 'jqame-answers' || document.body.id == 'jqame-questions' ) {

    var _this = $.api.suffrage = {
        init: function() {
            $('div.suffrage a.upvote, div.suffrage a.downvote').bind('ajax:beforeSend', function() {
                var voteKind = this.className,
                    $this    = $(this),
                    suffrage = $this.parents('div.suffrage');

                if ( $this.attr('data-allowed') === 'false' ) return false;

                _this.vote( suffrage, voteKind );
            });

            $('div.suffrage a.cancel-vote').bind('ajax:beforeSend', function() {
                var $this      = $(this).addClass('hidden'),
                    suffrage = $this.parents('div.suffrage');

                if ( $this.attr('data-allowed') === 'false' ) return false;

                _this._cancelVote(suffrage, suffrage.find('i.active').parent().attr('class'));
            });

            $('div.suffrage a.accept-answer, div.suffrage a.unaccept-answer').bind('ajax:beforeSend', function() {
                var $this = $(this),
                    action = $this.hasClass('accept-answer') ? 'accept' : 'unaccept',
                    invertAction = action == 'accept' ? 'unaccept' : 'accept';

                $this.toggleClass('accept-answer unaccept-answer').
                    attr('href', this.href.replace(action, invertAction));
            });
        },

        vote: function(suffrage, voteKind) {
            var invertVote = voteKind == 'upvote' ? 'downvote' : 'upvote';

            if ( suffrage.find('a.' + invertVote + ' i.active').length ) _this._cancelVote(suffrage, invertVote);

            var statsContainer = suffrage.find('div.stats'),
                currentRating  = suffrage.find('span.current-rating-value'),
                currentRatingValue = parseInt( currentRating.text() ) + ( voteKind == 'upvote' ? 1 : -1 );

            suffrage.find('a.' + voteKind).attr('data-allowed', 'false').
                find('i').addClass('active');
            statsContainer.find('a.cancel-vote').removeClass('hidden').attr('data-allowed', 'true');

            currentRating.text( currentRatingValue );
        },

        accept: function(suffrage) {
        },

        unaccept: function(suffrage) {
        },

        _cancelVote: function(suffrage, voteKind) {
            var statsController = suffrage.find('div.stats'),
                currentRating   = suffrage.find('span.current-rating-value'),
                currentRatingValue = parseInt( currentRating.text() ) + ( voteKind == 'upvote' ? -1 : 1 );

            currentRating.text( currentRatingValue );

            suffrage.find('a.cancel-vote').addClass('hidden').attr('data-allowed', 'false');
            suffrage.find('a.upvote, a.downvote').attr('data-allowed', 'true').find('i').removeClass('active');
        },

    };

}
