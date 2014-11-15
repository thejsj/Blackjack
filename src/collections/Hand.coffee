class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @on 'hit', @isBusted
    return @

  isBusted: ->
    busted = @minScore() > 21
    if busted
      @trigger 'bust'
    busted

  isBlackJack: ->
    if @score() == 21 and @length == 2
      return true
    false

  hit: ->
    @trigger 'hit'
    @add(@deck.pop())

  stand: ->
    @trigger 'stand'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0

  score: ->
    if @hasAce() and @scores()[1] < 22
      return @scores()[1]
    @minScore()


  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]
