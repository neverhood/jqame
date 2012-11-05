$.api = {
    loading: false,
    currentElector: null,

    places: {
        mainContent: $('div#main-content')
    },

    templates: {
        signIn: $('div#please-sign-in').detach(),
        cantVoteForOwnVotable: $('div#cant-vote-for-own-votable').detach()
    },

    utils: {
        requestSignIn: function() {
            if ( $('div#please-sign-in', $.api.places.mainContent).length === 0 )
                $.api.utils._showNotification( $.api.templates.signIn.clone() );
        },

        cantVoteForOwnVotable: function() {
            if ( $('div#cant-vote-for-own-votable', $.api.places.mainContent).length === 0 )
                $.api.utils._showNotification( $.api.templates.cantVoteForOwnVotable.clone() );
        },

        loader: function() {
          return "<img src='/assets/loader.gif'></img";
        },

        _showNotification: function( notification ) {
            var bottomNotification = $('div.fixed-notification').last(),
                top = null;

            if ( bottomNotification.length )
                top = 10 + parseInt( bottomNotification.offset().top + bottomNotification.outerHeight() );

            if ( top ) notification.css({ top: top });
            notification.appendTo( 'div#main-content' ).slideDown();
        }
    }
}

