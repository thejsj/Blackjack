class window.Game extends Backbone.Model
  initialize: (params) ->
    @set 'deck', new Deck()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @set 'betAmount', params.betAmount || 0

    @get('playerHand')
      .on 'bust', @endGame, @
      .on 'stand', @get('dealerHand').hitUntil17, @get('dealerHand')

    @get('dealerHand')
      .on 'bust', @endGame, @
      .on 'stand', @decideWinner, @

  endGame: ->
    @trigger 'finish', @get('betAmount')
    @get('playerHand')
      .off 'bust', @endGame, @
      .off 'stand', @get('dealerHand').hitUntil17, @get('dealerHand')

    @get('dealerHand')
      .off 'bust', @endGame, @
      .off 'stand', @decideWinner, @

  decideWinner: ->
    @endGame()
