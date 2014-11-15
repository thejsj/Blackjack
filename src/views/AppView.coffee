class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-bank-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      @model.get('currentGame').get('playerHand').hit()

    'click .stand-button': ->
      @model.get('currentGame').get('playerHand').stand()

  initialize: ->
    that = @
    $(window).on 'keydown', (e) ->
      if e.keyCode == 72
        that.model.get('currentGame').get('playerHand').hit()
        e.preventDefault()
        e.stopPropagation()
      if e.keyCode == 83
        that.model.get('currentGame').get('playerHand').stand()
        e.preventDefault()
        e.stopPropagation()

    @playerBankView = new PlayerBankView {model: @model.get('playerBank')}

    @model.on 'finish', @finish, @
    @model.createNewGame()
    @render()

  finish: (betAmount) ->
    alert('You Won ' + betAmount);
    @model.createNewGame()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-bank-container').html @playerBankView.$el
    @$('.player-hand-container').html new HandView({
        collection: @model.get('currentGame').get 'playerHand'
      }).el
    @$('.dealer-hand-container').html new HandView({
        collection: @model.get('currentGame').get 'dealerHand'
      }).el

