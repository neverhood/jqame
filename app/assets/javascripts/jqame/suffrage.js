'use strict';

if ( document.body.id == 'jqame-answers' || document.body.id == 'jqame-questions' ) {

    var _this = $.api.suffrage = {
        init: function() {

            if ( ! $.api.currentElector ) {
                $('div.suffrage a.upvote, div.suffrage a.downvote, div.suffrage a.cancel-vote').
                    bind('click', $.api.utils._requestSignIn);
            } else {
                $('div.suffrage a.upvote, div.suffrage a.downvote').bind('ajax:beforeSend', function() {
                    var voteKind = this.className,
                        $this    = $(this),
                        suffrage = $this.parents('div.suffrage');

                    if ( suffrage.data('votable-owner-id') == $.api.currentElector.id )
                        $.api.utils.cantVoteForOwnVotable();

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
                        action = $this.hasClass('accept-answer') ? 'accept' : 'unaccept';

                    _this._cancelAcceptedAnswer();

                    if ( action == 'accept' ) {
                        var suffrage = $this.parents('div.suffrage');

                        suffrage.parents('div.answer').addClass('accepted');
                        $this.toggleClass('accept-answer unaccept-answer').attr('href', this.href.replace('accept', 'unaccept'));

                        // User repo
                        if ( suffrage.data('votable-owner-id') != $.api.currentElector.id ) {
                            _this._updateElectorReputation( $.api.currentElector.id, $.api.suffrage.rates.actions.accept );
                            _this._updateElectorReputation( suffrage.data('votable-owner-id'), $.api.suffrage.rates.actions.accepted );
                        }
                    }
                });
            }

        },

        rates: {
            actions: { downvoted: -2, accept: 2, accepted: 15 },

            votes: {
                question: { upvote: 5,  downvote: -2 },
                answer:   { upvote: 10, downvote: -2 }
            }
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

            // User repo
            _this._updateElectorReputation( suffrage.data('votable-owner-id'), $.api.suffrage.rates.votes[suffrage.data('votable-type')][voteKind] );
            if ( voteKind == 'downvote' )
                _this._updateElectorReputation( $.api.currentElector.id, $.api.suffrage.rates.actions['downvoted'] );
        },

        _cancelVote: function(suffrage, voteKind) {
            var statsController = suffrage.find('div.stats'),
                currentRating   = suffrage.find('span.current-rating-value'),
                currentRatingValue = parseInt( currentRating.text() ) + ( voteKind == 'upvote' ? -1 : 1 );

            currentRating.text( currentRatingValue );

            suffrage.find('a.cancel-vote').addClass('hidden').attr('data-allowed', 'false');
            suffrage.find('a.upvote, a.downvote').attr('data-allowed', 'true').find('i').removeClass('active');

            // User repo
            _this._updateElectorReputation( suffrage.data('votable-owner-id'), -$.api.suffrage.rates.votes[suffrage.data('votable-type')][voteKind] );
            if ( voteKind == 'downvote' )
                _this._updateElectorReputation( $.api.currentElector.id, -$.api.suffrage.rates.actions['downvoted'] );
        },

        _cancelAcceptedAnswer: function() {
            var acceptedAnswer = $('div.answer.accepted').removeClass('accepted');

            if ( acceptedAnswer.length === 0 ) return false;

            var suffrage = acceptedAnswer.find('div.suffrage');
            $('a.unaccept-answer', suffrage).toggleClass('unaccept-answer accept-answer').each(function() {
                this.href = this.href.replace('unaccept', 'accept');
            });

            if ( suffrage.data('votable-owner-id') == $.api.currentElector.id ) return false;

            _this._updateElectorReputation( $.api.currentElector.id, -$.api.suffrage.rates.actions.accept );
            _this._updateElectorReputation( suffrage.data('votable-owner-id'), -$.api.suffrage.rates.actions.accepted );
        },

        _updateElectorReputation: function(electorId, reputationAmount) {
            var occurrences = $('div.elector[data-elector-id="' + electorId + '"]'),
                currentRepo = parseInt( occurrences.first().find('div.elector-reputation').text() );

            occurrences.find('div.elector-reputation').text( currentRepo + reputationAmount );
        }

    };

}
