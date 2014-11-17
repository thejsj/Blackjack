class window.Game extends Backbone.Model
  initialize: (params) ->
    @set 'deck', new Deck()
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @set 'betAmount', params.betAmount || 0
    @set 'originalBetAmount', @get 'betAmount'

    @get('playerHand')
      .on 'bust', @dealerWin, @
      .on 'stand', @get('dealerHand').hitUntil17, @get('dealerHand')

    @get('dealerHand')
      .on 'bust', @playerWin, @
      .on 'stand', @decideWinner, @

  playerWin: ->
    if @get('playerHand').isBlackJack()
      @set('betAmount', @get('betAmount')*2.5)
    else
      @set('betAmount', @get('betAmount')*2)
    @endGame()

  dealerWin: ->
    @set('betAmount', 0)
    @endGame()

  endGame: ->
    @trigger 'finish', @get('betAmount')
    @get('playerHand')
      .off 'bust', @dealerWin, @
      .off 'stand', @get('dealerHand').hitUntil17, @get('dealerHand')

    @get('dealerHand')
      .off 'bust', @playerWin, @
      .off 'stand', @decideWinner, @

  decideWinner: ->
    # Get scores for both players
    playerScore = @get('playerHand').score()
    dealerScore = @get('dealerHand').score()

    if playerScore == dealerScore
      @endGame()
    else if playerScore > dealerScore
      @playerWin()
    else
      @dealerWin()
