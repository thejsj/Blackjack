class window.Game extends Backbone.Model
  initialize: (params) ->
    @set 'deck', new Deck()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @set 'betAmount', params.betAmount || 0

    @playerHand
      .on 'bust', @endGame, @
      .on 'stand', @dealerHand.hitUntil17(), @

    @dealerHand
      .on 'bust', @endGame, @
      .on 'stand', @decideWinner, @

  endGame: ->
    @trigger 'finish', @get('betAmount')

  decideWinner: ->
    @endGame()
